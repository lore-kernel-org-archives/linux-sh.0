From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Nov 2014 09:02:38 +0000
Subject: [PATCH] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Renesas Audio DMAC Peri Peri driver is based on
SH_DMAE_BASE driver which is used for Renesas SH-Mobile.
But, basically, SH_DMAE_BASE driver was created for
SuperH SoC, and it is not fully cared for DT.

For example, current SH_DMAE_BASE base driver will return
non-matching DMA channel if some non-SH_DMAE_BASE drivers
are probed.
So, sound driver will get wrong DMA channel
if Audio DMAC (= rcar-dma) was not probed,
but Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.

OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE
driver, and Renesas R-Car series will not use it anymore.
Maintenance cost for fully cared DT support on SH_DMAE_BASE
will be very high
(and keeping compatibility will be very complex).

In addition, Audio DMAC Peri Peri itself is very simple device,
and, no SoC/board is using it from non-DT environment.

This patch makes rcar-audmapp driver simply independents
from SH_DMAE_BASE.
It is keeping DT bindings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/Kconfig                         |    3 +-
 drivers/dma/sh/rcar-audmapp.c                  |  399 +++++++++++-------------
 include/linux/platform_data/dma-rcar-audmapp.h |   34 --
 3 files changed, 184 insertions(+), 252 deletions(-)
 delete mode 100644 include/linux/platform_data/dma-rcar-audmapp.h

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8190ad2..41e5c97 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -53,7 +53,8 @@ config RCAR_HPB_DMAE
 
 config RCAR_AUDMAC_PP
 	tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"
-	depends on SH_DMAE_BASE
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select RENESAS_DMA
 	help
 	  Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
 
diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
index d95bbdd..b39e388 100644
--- a/drivers/dma/sh/rcar-audmapp.c
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -18,14 +18,10 @@
  *
  */
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/dmaengine.h>
 #include <linux/of_dma.h>
-#include <linux/platform_data/dma-rcar-audmapp.h>
 #include <linux/platform_device.h>
-#include <linux/shdma-base.h>
+#include "../dmaengine.h"
 
 /*
  * DMA register
@@ -41,317 +37,286 @@
 
 /* Default MEMCPY transfer size = 2^2 = 4 bytes */
 #define LOG2_DEFAULT_XFER_SIZE	2
-#define AUDMAPP_SLAVE_NUMBER	256
-#define AUDMAPP_LEN_MAX		(16 * 1024 * 1024)
 
+struct audmapp_priv;
 struct audmapp_chan {
-	struct shdma_chan shdma_chan;
-	void __iomem *base;
-	dma_addr_t slave_addr;
+	struct dma_chan chan;
+	struct dma_async_tx_descriptor async_tx;
+
+	dma_addr_t src;
+	dma_addr_t dst;
 	u32 chcr;
-};
 
-struct audmapp_device {
-	struct shdma_dev shdma_dev;
-	struct audmapp_pdata *pdata;
-	struct device *dev;
-	void __iomem *chan_reg;
+	int id;
 };
 
-struct audmapp_desc {
-	struct shdma_desc shdma_desc;
-	dma_addr_t src;
-	dma_addr_t dst;
+struct audmapp_priv {
+	struct dma_device dma;
+	void __iomem *achan_reg;
+
+	struct audmapp_chan achan[AUDMAPP_MAX_CHANNELS];
 };
 
-#define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
+#define chan_to_achan(chan) container_of(chan, struct audmapp_chan, chan)
+#define achan_to_priv(achan) container_of(achan - achan->id, \
+					  struct audmapp_priv, achan[0])
+
+#define priv_to_dev(priv) ((priv)->dma.dev)
+#define priv_to_dma(priv) (&(priv)->dma)
 
-#define to_chan(chan) container_of(chan, struct audmapp_chan, shdma_chan)
-#define to_desc(sdesc) container_of(sdesc, struct audmapp_desc, shdma_desc)
-#define to_dev(chan) container_of(chan->shdma_chan.dma_chan.device,	\
-				  struct audmapp_device, shdma_dev.dma_dev)
+#define audmapp_reg(achan, _reg) (achan_to_priv(achan)->achan_reg + \
+				  0x20 + (0x10 * achan->id) + _reg)
 
-static void audmapp_write(struct audmapp_chan *auchan, u32 data, u32 reg)
+#define audmapp_for_each_achan(achan, priv, i)				\
+	for (i = 0;							\
+	     (i < AUDMAPP_MAX_CHANNELS && ((achan) = priv->achan + i));	\
+	     i++)
+
+static void audmapp_write(struct audmapp_chan *achan, u32 data, u32 _reg)
 {
-	struct audmapp_device *audev = to_dev(auchan);
-	struct device *dev = audev->dev;
+	struct audmapp_priv *priv = achan_to_priv(achan);
+	struct device *dev = priv_to_dev(priv);
+	void __iomem *reg = audmapp_reg(achan, _reg);
 
-	dev_dbg(dev, "w %p : %08x\n", auchan->base + reg, data);
+	dev_dbg(dev, "w %p : %08x\n", reg, data);
 
-	iowrite32(data, auchan->base + reg);
+	iowrite32(data, reg);
 }
 
-static u32 audmapp_read(struct audmapp_chan *auchan, u32 reg)
+static u32 audmapp_read(struct audmapp_chan *achan, u32 _reg)
 {
-	return ioread32(auchan->base + reg);
+	return ioread32(audmapp_reg(achan, _reg));
 }
 
-static void audmapp_halt(struct shdma_chan *schan)
+static void audmapp_halt(struct audmapp_chan *achan)
 {
-	struct audmapp_chan *auchan = to_chan(schan);
 	int i;
 
-	audmapp_write(auchan, 0, PDMACHCR);
+	audmapp_write(achan, 0, PDMACHCR);
 
 	for (i = 0; i < 1024; i++) {
-		if (0 = audmapp_read(auchan, PDMACHCR))
+		if (0 = audmapp_read(achan, PDMACHCR))
 			return;
 		udelay(1);
 	}
 }
 
-static void audmapp_start_xfer(struct shdma_chan *schan,
-			       struct shdma_desc *sdesc)
+static int audmapp_alloc_chan_resources(struct dma_chan *chan)
 {
-	struct audmapp_chan *auchan = to_chan(schan);
-	struct audmapp_device *audev = to_dev(auchan);
-	struct audmapp_desc *desc = to_desc(sdesc);
-	struct device *dev = audev->dev;
-	u32 chcr = auchan->chcr | PDMACHCR_DE;
+	if (chan->private)
+		return -ENODEV;
 
-	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
-		&desc->src, &desc->dst, chcr);
+	chan->private = chan_to_achan(chan);
 
-	audmapp_write(auchan, desc->src,	PDMASAR);
-	audmapp_write(auchan, desc->dst,	PDMADAR);
-	audmapp_write(auchan, chcr,	PDMACHCR);
+	return 0;
 }
 
-static int audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
-			      u32 *chcr, dma_addr_t *dst)
+static void audmapp_free_chan_resources(struct dma_chan *chan)
 {
-	struct audmapp_device *audev = to_dev(auchan);
-	struct audmapp_pdata *pdata = audev->pdata;
-	struct audmapp_slave_config *cfg;
-	int i;
-
-	*chcr	= 0;
-	*dst	= 0;
-
-	if (!pdata) { /* DT */
-		*chcr = ((u32)slave_id) << 16;
-		auchan->shdma_chan.slave_id = (slave_id) >> 8;
-		return 0;
-	}
-
-	/* non-DT */
-
-	if (slave_id >= AUDMAPP_SLAVE_NUMBER)
-		return -ENXIO;
-
-	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
-		if (cfg->slave_id = slave_id) {
-			*chcr	= cfg->chcr;
-			*dst	= cfg->dst;
-			return 0;
-		}
-
-	return -ENXIO;
+	chan->private = NULL;
 }
 
-static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
-			     dma_addr_t slave_addr, bool try)
+static struct dma_async_tx_descriptor *
+audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction dir, unsigned long flags)
 {
-	struct audmapp_chan *auchan = to_chan(schan);
-	u32 chcr;
-	dma_addr_t dst;
-	int ret;
-
-	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
-	if (ret < 0)
-		return ret;
-
-	if (try)
-		return 0;
-
-	auchan->chcr		= chcr;
-	auchan->slave_addr	= slave_addr ? : dst;
+	struct audmapp_chan *achan = chan_to_achan(chan);
 
-	return 0;
+	return &achan->async_tx;
 }
 
-static int audmapp_desc_setup(struct shdma_chan *schan,
-			      struct shdma_desc *sdesc,
-			      dma_addr_t src, dma_addr_t dst, size_t *len)
+static void audmapp_slave_config(struct audmapp_chan *achan,
+				 struct dma_slave_config *cfg)
 {
-	struct audmapp_desc *desc = to_desc(sdesc);
-
-	if (*len > (size_t)AUDMAPP_LEN_MAX)
-		*len = (size_t)AUDMAPP_LEN_MAX;
-
-	desc->src = src;
-	desc->dst = dst;
-
-	return 0;
+	achan->src = cfg->src_addr;
+	achan->dst = cfg->dst_addr;
 }
 
-static void audmapp_setup_xfer(struct shdma_chan *schan,
-			       int slave_id)
+static int audmapp_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+			   unsigned long arg)
 {
+	struct audmapp_chan *achan = chan_to_achan(chan);
+
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		audmapp_halt(achan);
+		break;
+	case DMA_SLAVE_CONFIG:
+		audmapp_slave_config(achan, (struct dma_slave_config *)arg);
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
 }
 
-static dma_addr_t audmapp_slave_addr(struct shdma_chan *schan)
+static enum dma_status audmapp_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
 {
-	struct audmapp_chan *auchan = to_chan(schan);
-
-	return auchan->slave_addr;
+	return dma_cookie_status(chan, cookie, txstate);
 }
 
-static bool audmapp_channel_busy(struct shdma_chan *schan)
+static void audmapp_issue_pending(struct dma_chan *chan)
 {
-	struct audmapp_chan *auchan = to_chan(schan);
-	u32 chcr = audmapp_read(auchan, PDMACHCR);
+	struct audmapp_chan *achan = chan_to_achan(chan);
+	struct audmapp_priv *priv = achan_to_priv(achan);
+	struct device *dev = priv_to_dev(priv);
+	u32 chcr = achan->chcr | PDMACHCR_DE;
 
-	return chcr & ~PDMACHCR_DE;
-}
+	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
+		&achan->src, &achan->dst, chcr);
 
-static bool audmapp_desc_completed(struct shdma_chan *schan,
-				   struct shdma_desc *sdesc)
-{
-	return true;
+	audmapp_write(achan, achan->src,	PDMASAR);
+	audmapp_write(achan, achan->dst,	PDMADAR);
+	audmapp_write(achan, chcr,		PDMACHCR);
 }
 
-static struct shdma_desc *audmapp_embedded_desc(void *buf, int i)
+static bool audmapp_chan_filter(struct dma_chan *chan, void *arg)
 {
-	return &((struct audmapp_desc *)buf)[i].shdma_desc;
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
+	if (dma->device_control != audmapp_control ||
+	    dma_spec->np != dma->dev->of_node)
+		return false;
+
+	/*
+	 * see
+	 *	audmapp_alloc_chan_resources()
+	 *	audmapp_free_chan_resources()
+	 */
+	return !chan->private;
 }
 
-static const struct shdma_ops audmapp_shdma_ops = {
-	.halt_channel	= audmapp_halt,
-	.desc_setup	= audmapp_desc_setup,
-	.set_slave	= audmapp_set_slave,
-	.start_xfer	= audmapp_start_xfer,
-	.embedded_desc	= audmapp_embedded_desc,
-	.setup_xfer	= audmapp_setup_xfer,
-	.slave_addr	= audmapp_slave_addr,
-	.channel_busy	= audmapp_channel_busy,
-	.desc_completed	= audmapp_desc_completed,
-};
-
-static int audmapp_chan_probe(struct platform_device *pdev,
-			      struct audmapp_device *audev, int id)
+static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
 {
-	struct shdma_dev *sdev = &audev->shdma_dev;
-	struct audmapp_chan *auchan;
-	struct shdma_chan *schan;
-	struct device *dev = audev->dev;
+	struct audmapp_chan *achan;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
 
-	auchan = devm_kzalloc(dev, sizeof(*auchan), GFP_KERNEL);
-	if (!auchan)
-		return -ENOMEM;
+	if (dma_spec->args_count != 1)
+		return NULL;
 
-	schan = &auchan->shdma_chan;
-	schan->max_xfer_len = AUDMAPP_LEN_MAX;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
 
-	shdma_chan_probe(sdev, schan, id);
+	chan = dma_request_channel(mask, audmapp_chan_filter, dma_spec);
+	if (!chan)
+		return NULL;
 
-	auchan->base = audev->chan_reg + 0x20 + (0x10 * id);
-	dev_dbg(dev, "%02d : %p / %p", id, auchan->base, audev->chan_reg);
+	achan = chan_to_achan(chan);
+	achan->chcr = dma_spec->args[0] << 16;
 
-	return 0;
+	return chan;
 }
 
-static void audmapp_chan_remove(struct audmapp_device *audev)
+static dma_cookie_t audmapp_tx_submit(struct dma_async_tx_descriptor *tx)
 {
-	struct shdma_chan *schan;
-	int i;
-
-	shdma_for_each_chan(schan, &audev->shdma_dev, i) {
-		BUG_ON(!schan);
-		shdma_chan_remove(schan);
-	}
+	return dma_cookie_assign(tx);
 }
 
-static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
-					 struct of_dma *ofdma)
+static int audmapp_chan_desc_probe(struct platform_device *pdev,
+				   struct audmapp_priv *priv)
+
 {
-	dma_cap_mask_t mask;
+	struct dma_device *dma = priv_to_dma(priv);
+	struct device *dev = priv_to_dev(priv);
+	struct audmapp_chan *achan;
 	struct dma_chan *chan;
-	u32 chcr = dma_spec->args[0];
+	int i;
 
-	if (dma_spec->args_count != 1)
-		return NULL;
+	audmapp_for_each_achan(achan, priv, i) {
+		chan = &achan->chan;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+		achan->id = i;
 
-	chan = dma_request_channel(mask, shdma_chan_filter, NULL);
-	if (chan)
-		to_shdma_chan(chan)->hw_req = chcr;
+		/*
+		 * Initialize the DMA engine channel and add it to the DMA
+		 * engine channels list.
+		 */
+		chan->private = NULL;
+		chan->device = dma;
+		dma_cookie_init(chan);
+		list_add_tail(&chan->device_node, &dma->channels);
 
-	return chan;
+		achan->async_tx.tx_submit = audmapp_tx_submit;
+		dma_async_tx_descriptor_init(&achan->async_tx, chan);
+
+		dev_dbg(dev, "%02d : %p\n", i, audmapp_reg(achan, 0));
+	}
+
+	return 0;
 }
 
 static int audmapp_probe(struct platform_device *pdev)
 {
-	struct audmapp_pdata *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
-	struct audmapp_device *audev;
-	struct shdma_dev *sdev;
-	struct dma_device *dma_dev;
+	struct device *dev = &pdev->dev;
+	struct audmapp_priv *priv;
+	struct dma_device *dma;
 	struct resource *res;
-	int err, i;
+	int ret;
 
-	if (np)
-		of_dma_controller_register(np, audmapp_of_xlate, pdev);
-	else if (!pdata)
-		return -ENODEV;
+	of_dma_controller_register(dev->of_node, audmapp_of_xlate, pdev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	audev = devm_kzalloc(&pdev->dev, sizeof(*audev), GFP_KERNEL);
-	if (!audev)
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	audev->dev	= &pdev->dev;
-	audev->pdata	= pdata;
-	audev->chan_reg	= devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(audev->chan_reg))
-		return PTR_ERR(audev->chan_reg);
+	priv->achan_reg	= devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->achan_reg))
+		return PTR_ERR(priv->achan_reg);
 
-	sdev		= &audev->shdma_dev;
-	sdev->ops	= &audmapp_shdma_ops;
-	sdev->desc_size	= sizeof(struct audmapp_desc);
+	dev_dbg(dev, "%llx => %p\n", (u64)res->start, priv->achan_reg);
 
-	dma_dev			= &sdev->dma_dev;
-	dma_dev->copy_align	= LOG2_DEFAULT_XFER_SIZE;
-	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma = priv_to_dma(priv);
+	dma->copy_align	= LOG2_DEFAULT_XFER_SIZE;
+	INIT_LIST_HEAD(&dma->channels);
+	dma_cap_set(DMA_SLAVE, dma->cap_mask);
 
-	err = shdma_init(&pdev->dev, sdev, AUDMAPP_MAX_CHANNELS);
-	if (err < 0)
-		return err;
+	dma->device_alloc_chan_resources	= audmapp_alloc_chan_resources;
+	dma->device_free_chan_resources		= audmapp_free_chan_resources;
+	dma->device_prep_dma_cyclic		= audmapp_prep_dma_cyclic;
+	dma->device_control			= audmapp_control;
+	dma->device_tx_status			= audmapp_tx_status;
+	dma->device_issue_pending		= audmapp_issue_pending;
+	dma->dev				= dev;
 
-	platform_set_drvdata(pdev, audev);
+	platform_set_drvdata(pdev, priv);
 
-	/* Create DMA Channel */
-	for (i = 0; i < AUDMAPP_MAX_CHANNELS; i++) {
-		err = audmapp_chan_probe(pdev, audev, i);
-		if (err)
-			goto chan_probe_err;
-	}
-
-	err = dma_async_device_register(dma_dev);
-	if (err < 0)
-		goto chan_probe_err;
+	ret = audmapp_chan_desc_probe(pdev, priv);
+	if (ret)
+		return ret;
 
-	return err;
+	ret = dma_async_device_register(dma);
+	if (ret)
+		return ret;
 
-chan_probe_err:
-	audmapp_chan_remove(audev);
-	shdma_cleanup(sdev);
+	dev_info(dev, "probed\n");
 
-	return err;
+	return ret;
 }
 
 static int audmapp_remove(struct platform_device *pdev)
 {
-	struct audmapp_device *audev = platform_get_drvdata(pdev);
-	struct dma_device *dma_dev = &audev->shdma_dev.dma_dev;
+	struct audmapp_priv *priv = platform_get_drvdata(pdev);
+	struct dma_device *dma = priv_to_dma(priv);
 
-	dma_async_device_unregister(dma_dev);
+	dma_async_device_unregister(dma);
 
-	audmapp_chan_remove(audev);
-	shdma_cleanup(&audev->shdma_dev);
+	of_dma_controller_free(pdev->dev.of_node);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/dma-rcar-audmapp.h b/include/linux/platform_data/dma-rcar-audmapp.h
deleted file mode 100644
index 471fffe..0000000
--- a/include/linux/platform_data/dma-rcar-audmapp.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This is for Renesas R-Car Audio-DMAC-peri-peri.
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- * Copyright (C) 2014 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This file is based on the include/linux/sh_dma.h
- *
- * Header for the new SH dmaengine driver
- *
- * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef SH_AUDMAPP_H
-#define SH_AUDMAPP_H
-
-#include <linux/dmaengine.h>
-
-struct audmapp_slave_config {
-	int		slave_id;
-	dma_addr_t	src;
-	dma_addr_t	dst;
-	u32		chcr;
-};
-
-struct audmapp_pdata {
-	struct audmapp_slave_config *slave;
-	int slave_num;
-};
-
-#endif /* SH_AUDMAPP_H */
-- 
1.7.9.5

