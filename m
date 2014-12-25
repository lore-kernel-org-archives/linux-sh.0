From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Dec 2014 03:27:10 +0000
Subject: [PATCH 2/2 v3] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <87bnmswgr5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw6v9dwc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw6v9dwc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Old Renesas Audio DMAC Peri Peri driver was based on SH_DMAE_BASE
driver, and it had DMAEngine channel handling issue on DT if multiple
DT base DMAEngine drivers were probed.
But, now, it has been simply removed.
This patch adds new rcar-audmapp driver which can care DT handling.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - based on vinod/topic/rcar

 drivers/dma/sh/Kconfig        |    7 +
 drivers/dma/sh/Makefile       |    1 +
 drivers/dma/sh/rcar-audmapp.c |  348 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 drivers/dma/sh/rcar-audmapp.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 725f6b4..e84b7e1 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -58,3 +58,10 @@ config RCAR_DMAC
 	help
 	  This driver supports the general purpose DMA controller found in the
 	  Renesas R-Car second generation SoCs.
+
+config RCAR_AUDMAC_PP
+	tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select RENESAS_DMA
+	help
+	  Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 489609b..6491d4f 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SH_DMAE) += shdma.o
 obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_RCAR_HPB_DMAE) += rcar-hpbdma.o
 obj-$(CONFIG_RCAR_DMAC) += rcar-dmac.o
+obj-$(CONFIG_RCAR_AUDMAC_PP) += rcar-audmapp.o
diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
new file mode 100644
index 0000000..eb09cf3
--- /dev/null
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -0,0 +1,348 @@
+/*
+ * This is for Renesas R-Car Audio-DMAC-peri-peri.
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2014 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on the drivers/dma/sh/rcar-dmac.c
+ *
+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include "../dmaengine.h"
+
+/*
+ * DMA register
+ */
+#define PDMASAR		0x00
+#define PDMADAR		0x04
+#define PDMACHCR	0x0c
+
+/* PDMACHCR */
+#define PDMACHCR_DE		(1 << 0)
+
+#define AUDMAPP_MAX_CHANNELS	29
+
+/* Default MEMCPY transfer size = 2^2 = 4 bytes */
+#define LOG2_DEFAULT_XFER_SIZE	2
+
+struct audmapp_priv;
+struct audmapp_chan {
+	struct dma_chan chan;
+	struct dma_async_tx_descriptor async_tx;
+
+	dma_addr_t src;
+	dma_addr_t dst;
+	u32 chcr;
+
+	int id;
+};
+
+struct audmapp_priv {
+	struct dma_device dma;
+	void __iomem *achan_reg;
+
+	struct audmapp_chan achan[AUDMAPP_MAX_CHANNELS];
+	spinlock_t lock;
+};
+
+#define chan_to_achan(chan) container_of(chan, struct audmapp_chan, chan)
+#define achan_to_priv(achan) container_of(achan - achan->id, \
+					  struct audmapp_priv, achan[0])
+
+#define priv_to_dev(priv) ((priv)->dma.dev)
+#define priv_to_dma(priv) (&(priv)->dma)
+
+#define audmapp_reg(achan, _reg) (achan_to_priv(achan)->achan_reg + \
+				  0x20 + (0x10 * achan->id) + _reg)
+
+#define audmapp_for_each_achan(achan, priv, i)				\
+	for (i = 0;							\
+	     (i < AUDMAPP_MAX_CHANNELS && ((achan) = priv->achan + i));	\
+	     i++)
+
+static void audmapp_write(struct audmapp_chan *achan, u32 data, u32 _reg)
+{
+	struct audmapp_priv *priv = achan_to_priv(achan);
+	struct device *dev = priv_to_dev(priv);
+	void __iomem *reg = audmapp_reg(achan, _reg);
+
+	dev_dbg(dev, "w %p : %08x\n", reg, data);
+
+	iowrite32(data, reg);
+}
+
+static u32 audmapp_read(struct audmapp_chan *achan, u32 _reg)
+{
+	return ioread32(audmapp_reg(achan, _reg));
+}
+
+static int audmapp_alloc_chan_resources(struct dma_chan *chan)
+{
+	if (chan->private)
+		return -ENODEV;
+
+	chan->private = chan_to_achan(chan);
+
+	return 0;
+}
+
+static void audmapp_free_chan_resources(struct dma_chan *chan)
+{
+	chan->private = NULL;
+}
+
+static struct dma_async_tx_descriptor *
+audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction dir, unsigned long flags)
+{
+	struct audmapp_chan *achan = chan_to_achan(chan);
+
+	/*
+	 * Audio DMAC peri peri does cyclic transfer automatically
+	 * without special settings.
+	 * Main transfer settings are done in Audio DMAC.
+	 * Nothing to do here.
+	 */
+
+	return &achan->async_tx;
+}
+
+static int audmapp_device_config(struct dma_chan *chan,
+				 struct dma_slave_config *cfg)
+{
+	struct audmapp_chan *achan = chan_to_achan(chan);
+
+	achan->src = cfg->src_addr;
+	achan->dst = cfg->dst_addr;
+
+	return 0;
+}
+
+static int audmapp_terminate_all(struct dma_chan *chan)
+{
+	struct audmapp_chan *achan = chan_to_achan(chan);
+	struct audmapp_priv *priv = achan_to_priv(achan);
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	audmapp_write(achan, 0, PDMACHCR);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	for (i = 0; i < 1024; i++) {
+		if (0 = audmapp_read(achan, PDMACHCR))
+			return 0;
+		udelay(1);
+	}
+
+	return -EIO;
+}
+
+static enum dma_status audmapp_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void audmapp_issue_pending(struct dma_chan *chan)
+{
+	struct audmapp_chan *achan = chan_to_achan(chan);
+	struct audmapp_priv *priv = achan_to_priv(achan);
+	struct device *dev = priv_to_dev(priv);
+	u32 chcr = achan->chcr | PDMACHCR_DE;
+	unsigned long flags;
+
+	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
+		&achan->src, &achan->dst, chcr);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	audmapp_write(achan, achan->src,	PDMASAR);
+	audmapp_write(achan, achan->dst,	PDMADAR);
+	audmapp_write(achan, chcr,		PDMACHCR);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static bool audmapp_chan_filter(struct dma_chan *chan, void *arg)
+{
+	struct dma_device *dma = chan->device;
+	struct of_phandle_args *dma_spec = arg;
+
+	/*
+	 * FIXME: Using a filter on OF platforms is a nonsense. The OF xlate
+	 * function knows from which device it wants to allocate a channel from,
+	 * and would be perfectly capable of selecting the channel it wants.
+	 * Forcing it to call dma_request_channel() and iterate through all
+	 * channels from all controllers is just pointless.
+	 */
+	if (dma->device_config != audmapp_device_config ||
+	    dma_spec->np != dma->dev->of_node)
+		return false;
+
+	/*
+	 * see
+	 *	audmapp_alloc_chan_resources()
+	 *	audmapp_free_chan_resources()
+	 */
+	return !chan->private;
+}
+
+static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct audmapp_chan *achan;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, audmapp_chan_filter, dma_spec);
+	if (!chan)
+		return NULL;
+
+	achan = chan_to_achan(chan);
+	achan->chcr = dma_spec->args[0] << 16;
+
+	return chan;
+}
+
+static dma_cookie_t audmapp_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	return dma_cookie_assign(tx);
+}
+
+static int audmapp_chan_desc_probe(struct platform_device *pdev,
+				   struct audmapp_priv *priv)
+
+{
+	struct dma_device *dma = priv_to_dma(priv);
+	struct device *dev = priv_to_dev(priv);
+	struct audmapp_chan *achan;
+	struct dma_chan *chan;
+	int i;
+
+	audmapp_for_each_achan(achan, priv, i) {
+		chan = &achan->chan;
+
+		achan->id = i;
+
+		/*
+		 * Initialize the DMA engine channel and add it to the DMA
+		 * engine channels list.
+		 */
+		chan->private = NULL;
+		chan->device = dma;
+		dma_cookie_init(chan);
+		list_add_tail(&chan->device_node, &dma->channels);
+
+		achan->async_tx.tx_submit = audmapp_tx_submit;
+		dma_async_tx_descriptor_init(&achan->async_tx, chan);
+
+		dev_dbg(dev, "%02d : %p\n", i, audmapp_reg(achan, 0));
+	}
+
+	return 0;
+}
+
+static int audmapp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct audmapp_priv *priv;
+	struct dma_device *dma;
+	struct resource *res;
+	int ret;
+
+	of_dma_controller_register(dev->of_node, audmapp_of_xlate, pdev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->achan_reg	= devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->achan_reg))
+		return PTR_ERR(priv->achan_reg);
+
+	spin_lock_init(&priv->lock);
+
+	dev_dbg(dev, "%llx => %p\n", (u64)res->start, priv->achan_reg);
+
+	dma = priv_to_dma(priv);
+	dma->copy_align	= LOG2_DEFAULT_XFER_SIZE;
+	INIT_LIST_HEAD(&dma->channels);
+	dma_cap_set(DMA_SLAVE, dma->cap_mask);
+
+	dma->device_alloc_chan_resources	= audmapp_alloc_chan_resources;
+	dma->device_free_chan_resources		= audmapp_free_chan_resources;
+	dma->device_prep_dma_cyclic		= audmapp_prep_dma_cyclic;
+	dma->device_config			= audmapp_device_config;
+	dma->device_terminate_all		= audmapp_terminate_all;
+	dma->device_tx_status			= audmapp_tx_status;
+	dma->device_issue_pending		= audmapp_issue_pending;
+	dma->dev				= dev;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = audmapp_chan_desc_probe(pdev, priv);
+	if (ret)
+		return ret;
+
+	ret = dma_async_device_register(dma);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "probed\n");
+
+	return ret;
+}
+
+static int audmapp_remove(struct platform_device *pdev)
+{
+	struct audmapp_priv *priv = platform_get_drvdata(pdev);
+	struct dma_device *dma = priv_to_dma(priv);
+
+	dma_async_device_unregister(dma);
+
+	of_dma_controller_free(pdev->dev.of_node);
+
+	return 0;
+}
+
+static const struct of_device_id audmapp_of_match[] = {
+	{ .compatible = "renesas,rcar-audmapp", },
+	{},
+};
+
+static struct platform_driver audmapp_driver = {
+	.probe		= audmapp_probe,
+	.remove		= audmapp_remove,
+	.driver		= {
+		.name	= "rcar-audmapp-engine",
+		.of_match_table = audmapp_of_match,
+	},
+};
+module_platform_driver(audmapp_driver);
+
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
+MODULE_DESCRIPTION("Renesas R-Car Audio DMAC peri-peri driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

