From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 23 Jan 2012 08:42:26 +0000
Subject: Re: [PATCH v4 6/6] dmaengine: shdma: add support for SUDMAC
Message-Id: <4F1D1D72.6050706@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A10.7000708@renesas.com>
In-Reply-To: <4F0D3A10.7000708@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

2012/01/22 1:15, Guennadi Liakhovetski wrote:
>> By the way, when I applied the "dma: shdma: convert to the simple DMA library" patch,
>> I couldn't apply it. (Many "Hunk #nn FAILED" output...)
>> So, would you tell me your using kernel commit?
>> I used today's "torbalds/linux.git" and "slave-dma.git".
> 
> I think, the easiest for you would be to pull from
> 
> git://github.com/lyakh/linux.git
> 
> and use the "shmobile" branch, that already includes all my patches, that 
> you need. In fact, you only need a couple of them, so, you can also drop 
> all my mmc patches, that you don't need.

Thank you very much for the information.

I could implment the sudmac driver using the dma-simple driver.
I wrote the sudmac driver for reference below.
After the dma-simple driver is applied, I will submit this sudmac driver:
---
 drivers/dma/Kconfig    |    9
 drivers/dma/Makefile   |    1
 drivers/dma/sudmac.c   |  484 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sudmac.h   |   64 ++++++
 include/linux/sudmac.h |   92 +++++++++
 5 files changed, 650 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 2696552..bcbd6ae 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -161,6 +161,15 @@ config SH_DMAE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.

+config SUDMAC
+	tristate "Renesas SUDMAC support"
+	depends on SUPERH && SH_DMA
+	depends on !SH_DMA_API
+	select DMA_ENGINE
+	select DMA_SIMPLE
+	help
+	  Enable support for the Renesas SUDMAC controllers.
+
 config COH901318
 	bool "ST-Ericsson COH901318 DMA support"
 	select DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index d63f773..4a09f3c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_MX3_IPU) += ipu/
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_SH_DMAE) += shdma.o
+obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
diff --git a/drivers/dma/sudmac.c b/drivers/dma/sudmac.c
new file mode 100644
index 0000000..68efe78
--- /dev/null
+++ b/drivers/dma/sudmac.c
@@ -0,0 +1,484 @@
+/*
+ * Renesas SUDMAC support
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * base is drivers/dma/shdma.c
+ * Copyright (C) 2011-2012 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
+ * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/sudmac.h>
+#include <linux/kdebug.h>
+#include <linux/spinlock.h>
+#include <linux/rculist.h>
+#include "sudmac.h"
+
+#define SH_DMAE_DRV_NAME "sudmac"
+
+static void sudmac_writel(struct sudmac_chan *sh_dc, u32 data, u16 reg)
+{
+	__raw_writel(data, sh_dc->base + reg);
+}
+
+static u32 sudmac_readl(struct sudmac_chan *sh_dc, u16 reg)
+{
+	return __raw_readl(sh_dc->base + reg);
+}
+
+static bool dmae_is_busy(struct sudmac_chan *sh_chan)
+{
+	u32 den = sudmac_readl(sh_chan, sh_chan->den);
+
+	if (den)
+		return true;	/* working */
+
+	return false;	/* idle */
+}
+
+static void dmae_set_reg(struct sudmac_chan *sh_chan, struct sudmac_regs *hw)
+{
+	sudmac_writel(sh_chan, LBA_WAIT | RCVENDM, sh_chan->cfg);
+	sudmac_writel(sh_chan, hw->ba, sh_chan->ba);
+	sudmac_writel(sh_chan, hw->bbc, sh_chan->bbc);
+}
+
+static void dmae_start(struct sudmac_chan *sh_chan)
+{
+	sudmac_writel(sh_chan, sh_chan->dint_end_bit, DINTCTRL);
+	sudmac_writel(sh_chan, DEN, sh_chan->den);
+}
+
+static void sudmac_start_xfer(struct dma_simple_chan *schan,
+			       struct dma_simple_desc *sdesc)
+{
+	struct sudmac_chan *sh_chan = to_chan(schan);
+	struct sudmac_desc *sh_desc = to_desc(sdesc);
+
+	dev_dbg(sh_chan->simple_chan.dev, "Queue #%d to %d: %u, %x (%s)\n",
+		sdesc->async_tx.cookie, sh_chan->simple_chan.id,
+		sh_desc->hw.bbc, sh_desc->hw.ba,
+		(sdesc->direction = DMA_DEV_TO_MEM) ? "read" : "write");
+	dmae_set_reg(sh_chan, &sh_desc->hw);
+	dmae_start(sh_chan);
+}
+
+static bool sudmac_channel_busy(struct dma_simple_chan *schan)
+{
+	struct sudmac_chan *sh_chan = to_chan(schan);
+
+	return dmae_is_busy(sh_chan);
+}
+
+static void sudmac_setup_xfer(struct dma_simple_chan *schan,
+			       struct dma_simple_slave *sslave)
+{
+	/* Nothing */
+}
+
+static const struct sudmac_slave_config *dmae_find_slave(
+	struct sudmac_chan *sh_chan, struct sudmac_slave *slave)
+{
+	struct sudmac_device *shdev = to_sudmac(sh_chan);
+	struct sudmac_pdata *pdata = shdev->pdata;
+	const struct sudmac_slave_config *cfg;
+	int i;
+
+	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
+		if (cfg->slave_id = slave->simple_slave.slave_id)
+			return cfg;
+
+	return NULL;
+}
+
+static int sudmac_set_slave(struct dma_simple_chan *schan,
+			     struct dma_simple_slave *sslave)
+{
+	struct sudmac_chan *sh_chan = to_chan(schan);
+	struct sudmac_slave *slave = to_slave(sslave);
+	const struct sudmac_slave_config *cfg = dmae_find_slave(sh_chan, slave);
+
+	if (!cfg)
+		return -ENODEV;
+
+	slave->config = cfg;
+
+	return 0;
+}
+
+static void dmae_halt(struct sudmac_chan *sh_chan)
+{
+	sudmac_writel(sh_chan, 0, sh_chan->den);
+	sudmac_writel(sh_chan, ~sh_chan->dint_end_bit, DINTCTRL);
+	sudmac_writel(sh_chan, sh_chan->dint_end_bit, DINTSTSCLR);
+}
+
+static int sudmac_desc_setup(struct dma_simple_chan *schan,
+			      struct dma_simple_desc *sdesc,
+			      dma_addr_t src, dma_addr_t dst, size_t *len)
+{
+	struct sudmac_desc *sh_desc = to_desc(sdesc);
+
+	if (*len > schan->max_xfer_len)
+		*len = schan->max_xfer_len;
+
+	if (sdesc->direction = DMA_DEV_TO_MEM)
+		sh_desc->hw.ba = dst;
+	else
+		sh_desc->hw.ba = src;
+	sh_desc->hw.bbc = *len;
+
+	return 0;
+}
+
+static void sudmac_halt(struct dma_simple_chan *schan)
+{
+	struct sudmac_chan *sh_chan = to_chan(schan);
+
+	dmae_halt(sh_chan);
+}
+
+static irqreturn_t sudmac_interrupt(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+	struct sudmac_chan *sh_chan = data;
+	u32 dintstat = sudmac_readl(sh_chan, DINTSTS);
+
+	dma_simple_lock(&sh_chan->simple_chan);
+
+	if (dintstat & CH0ENDS) {
+		/* DMA stop */
+		dmae_halt(sh_chan);
+
+		ret = IRQ_HANDLED;
+		/* clean up completed, submit new transfers */
+		dma_simple_reload(&sh_chan->simple_chan);
+	}
+
+	dma_simple_unlock(&sh_chan->simple_chan);
+
+	return ret;
+}
+
+static bool sudmac_desc_completed(struct dma_simple_chan *schan,
+				   struct dma_simple_desc *sdesc)
+{
+	struct sudmac_chan *sh_chan = to_chan(schan);
+	struct sudmac_desc *sh_desc = to_desc(sdesc);
+	u32 ca = sudmac_readl(sh_chan, sh_chan->ca);
+
+	return ((sh_desc->hw.ba + sh_desc->hw.bbc) = ca);
+}
+
+static int __devinit sudmac_chan_probe(struct sudmac_device *shdev, int id,
+					int irq, unsigned long flags)
+{
+	struct dma_simple_dev *sdev = &shdev->simple_dev;
+	struct platform_device *pdev = to_platform_device(sdev->dma_dev.dev);
+	struct sudmac_chan *sh_chan;
+	struct dma_simple_chan *schan;
+	u16 channel_offset;
+	int err;
+
+	sh_chan = kzalloc(sizeof(struct sudmac_chan), GFP_KERNEL);
+	if (!sh_chan) {
+		dev_err(sdev->dma_dev.dev,
+			"No free memory for allocating dma channels!\n");
+		return -ENOMEM;
+	}
+
+	schan = &sh_chan->simple_chan;
+	schan->max_xfer_len = 64 * 1024 * 1024 - 1;
+
+	dma_simple_chan_probe(sdev, schan, id);
+
+	sh_chan->irq = irq;
+	sh_chan->base = shdev->chan_reg;
+
+	/* Registers offset */
+	channel_offset = shdev->pdata->channel->channel_no ? 4 : 0;
+
+	sh_chan->cfg = CH0CFG + channel_offset;
+	sh_chan->ba = CH0BA + channel_offset;
+	sh_chan->bbc = CH0BBC + channel_offset;
+	sh_chan->ca = CH0CA + channel_offset;
+	sh_chan->cbc = CH0CBC + channel_offset;
+	sh_chan->den = CH0DEN + channel_offset;
+
+	/* Registers bit offset */
+	sh_chan->dint_end_bit = shdev->pdata->channel->channel_no ?
+							CH1ENDE : CH0ENDE;
+
+	/* set up channel irq */
+	if (pdev->id >= 0)
+		snprintf(sh_chan->dev_id, sizeof(sh_chan->dev_id),
+			 "sudmac%d.%d", pdev->id, id);
+	else
+		snprintf(sh_chan->dev_id, sizeof(sh_chan->dev_id),
+			 "sudmac%d", id);
+
+	err = request_irq(irq, &sudmac_interrupt, flags,
+			  sh_chan->dev_id, sh_chan);
+	if (err) {
+		dev_err(sdev->dma_dev.dev,
+			"DMA channel %d request_irq error %d\n",
+			id, err);
+		goto err_no_irq;
+	}
+
+	shdev->chan[id] = sh_chan;
+	return 0;
+
+err_no_irq:
+	dma_simple_chan_remove(schan);
+	kfree(sh_chan);
+	return err;
+}
+
+static void sudmac_chan_remove(struct sudmac_device *shdev)
+{
+	struct dma_device *dma_dev = &shdev->simple_dev.dma_dev;
+	struct dma_simple_chan *schan;
+	int i;
+
+	dma_simple_for_each_chan(schan, &shdev->simple_dev, i) {
+		struct sudmac_chan *sh_chan = to_chan(schan);
+
+		BUG_ON(!schan);
+
+		dma_simple_chan_remove(schan);
+		kfree(sh_chan);
+	}
+	dma_dev->chancnt = 0;
+}
+
+static void sudmac_shutdown(struct platform_device *pdev)
+{
+}
+
+static int sudmac_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int sudmac_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sudmac_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int sudmac_resume(struct device *dev)
+{
+	return 0;
+}
+#else
+#define sudmac_suspend NULL
+#define sudmac_resume NULL
+#endif
+
+const struct dev_pm_ops sudmac_pm = {
+	.suspend		= sudmac_suspend,
+	.resume			= sudmac_resume,
+	.runtime_suspend	= sudmac_runtime_suspend,
+	.runtime_resume		= sudmac_runtime_resume,
+};
+
+static dma_addr_t sudmac_slave_addr(struct dma_simple_chan *schan)
+{
+	struct sudmac_slave *param = schan->dma_chan.private;
+
+	/*
+	 * Implicit BUG_ON(!param)
+	 * if (param != NULL), this is a successfully requested slave channel,
+	 * therefore param->config != NULL too.
+	 */
+	return param->config->addr;
+}
+
+static struct dma_simple_desc *sudmac_embedded_desc(void *buf, int i)
+{
+	return &((struct sudmac_desc *)buf)[i].simple_desc;
+}
+
+static const struct dma_simple_ops sudmac_simple_ops = {
+	.desc_completed = sudmac_desc_completed,
+	.halt_channel = sudmac_halt,
+	.channel_busy = sudmac_channel_busy,
+	.slave_addr = sudmac_slave_addr,
+	.desc_setup = sudmac_desc_setup,
+	.set_slave = sudmac_set_slave,
+	.setup_xfer = sudmac_setup_xfer,
+	.start_xfer = sudmac_start_xfer,
+	.embedded_desc = sudmac_embedded_desc,
+};
+
+static int __devinit sudmac_probe(struct platform_device *pdev)
+{
+	struct sudmac_pdata *pdata = pdev->dev.platform_data;
+	int err, i;
+	struct sudmac_device *shdev;
+	struct dma_device *dma_dev;
+	struct resource *chan, *irq_res;
+
+	/* get platform data */
+	if (!pdata)
+		return -ENODEV;
+
+	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!chan || !irq_res)
+		return -ENODEV;
+
+	if (!request_mem_region(chan->start, resource_size(chan), pdev->name)) {
+		dev_err(&pdev->dev, "DMAC register region already claimed\n");
+		return -EBUSY;
+	}
+
+	err = -ENOMEM;
+	shdev = kzalloc(sizeof(struct sudmac_device), GFP_KERNEL);
+	if (!shdev) {
+		dev_err(&pdev->dev, "Not enough memory\n");
+		goto ealloc;
+	}
+
+	dma_dev = &shdev->simple_dev.dma_dev;
+
+	shdev->chan_reg = ioremap(chan->start, resource_size(chan));
+	if (!shdev->chan_reg)
+		goto emapchan;
+
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+
+	/* Default transfer size of 32 bytes requires 32-byte alignment */
+	shdev->simple_dev.ops = &sudmac_simple_ops;
+	shdev->simple_dev.desc_size = sizeof(struct sudmac_desc);
+	err = dma_simple_init(&pdev->dev, &shdev->simple_dev,
+			      pdata->channel_num);
+	if (err < 0)
+		goto esimple;
+
+	/* platform data */
+	shdev->pdata = pdev->dev.platform_data;
+
+	platform_set_drvdata(pdev, shdev);
+
+	pm_runtime_enable(&pdev->dev);
+	err = pm_runtime_get_sync(&pdev->dev);
+	if (err < 0)
+		dev_err(&pdev->dev, "%s(): GET = %d\n", __func__, err);
+
+	/* Create DMA Channel */
+	for (i = 0; i < pdata->channel_num; i++) {
+		err = sudmac_chan_probe(shdev, i, irq_res->start, IRQF_SHARED);
+		if (err)
+			goto chan_probe_err;
+	}
+
+	pm_runtime_put(&pdev->dev);
+
+	err = dma_async_device_register(&shdev->simple_dev.dma_dev);
+	if (err < 0)
+		goto edmadevreg;
+
+	return err;
+
+edmadevreg:
+	pm_runtime_get(&pdev->dev);
+
+chan_probe_err:
+	sudmac_chan_remove(shdev);
+	free_irq(irq_res->start, shdev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	platform_set_drvdata(pdev, NULL);
+	dma_simple_cleanup(&shdev->simple_dev);
+esimple:
+	iounmap(shdev->chan_reg);
+	synchronize_rcu();
+emapchan:
+	kfree(shdev);
+ealloc:
+	release_mem_region(chan->start, resource_size(chan));
+
+	return err;
+}
+
+static int __devexit sudmac_remove(struct platform_device *pdev)
+{
+	struct sudmac_device *shdev = platform_get_drvdata(pdev);
+	struct dma_device *dma_dev = &shdev->simple_dev.dma_dev;
+	struct resource *res;
+	int irq = platform_get_irq(pdev, 0);
+
+	dma_async_device_unregister(dma_dev);
+
+	free_irq(irq, shdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	sudmac_chan_remove(shdev);
+	dma_simple_cleanup(&shdev->simple_dev);
+
+	iounmap(shdev->chan_reg);
+
+	platform_set_drvdata(pdev, NULL);
+
+	synchronize_rcu();
+	kfree(shdev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+
+	return 0;
+}
+
+static struct platform_driver sudmac_driver = {
+	.driver 	= {
+		.owner	= THIS_MODULE,
+		.pm	= &sudmac_pm,
+		.name	= SH_DMAE_DRV_NAME,
+	},
+	.remove		= __devexit_p(sudmac_remove),
+	.shutdown	= sudmac_shutdown,
+};
+
+static int __init sudmac_init(void)
+{
+	return platform_driver_probe(&sudmac_driver, sudmac_probe);
+}
+module_init(sudmac_init);
+
+static void __exit sudmac_exit(void)
+{
+	platform_driver_unregister(&sudmac_driver);
+}
+module_exit(sudmac_exit);
+
+MODULE_AUTHOR("Yoshihiro Shimoda");
+MODULE_DESCRIPTION("Renesas SUDMAC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1.0");
+MODULE_ALIAS("platform:" SH_DMAE_DRV_NAME);
diff --git a/drivers/dma/sudmac.h b/drivers/dma/sudmac.h
new file mode 100644
index 0000000..3b62ca3
--- /dev/null
+++ b/drivers/dma/sudmac.h
@@ -0,0 +1,64 @@
+/*
+ * Renesas SUDMAC support
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __DMA_SUDMAC_H
+#define __DMA_SUDMAC_H
+
+#include <linux/dma-simple.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+
+#define SH_DMAE_MAX_CHANNELS	2
+struct device;
+
+struct sudmac_chan {
+	struct dma_simple_chan simple_chan;
+	int irq;
+	void __iomem *base;
+	char dev_id[16];		/* unique name per DMAC of channel */
+
+	/* Registers offset */
+	u16 cfg;
+	u16 ba;
+	u16 bbc;
+	u16 ca;
+	u16 cbc;
+	u16 den;
+
+	/* Registers bit offset */
+	u32 dint_end_bit;	/* DSTSCLR, DINTCTRL, DINTSTS, DINTSTSCLR */
+};
+
+struct sudmac_device {
+	struct dma_simple_dev simple_dev;
+	struct sudmac_chan *chan[SH_DMAE_MAX_CHANNELS];
+	struct sudmac_pdata *pdata;
+	u32 __iomem *chan_reg;
+};
+
+struct sudmac_regs {
+	u32 ba;		/* CHnBA / Base Address */
+	u32 bbc;	/* CHnBBC / Base Byte Count */
+};
+
+struct sudmac_desc {
+	struct sudmac_regs hw;
+	struct dma_simple_desc simple_desc;
+};
+
+#define to_chan(schan) container_of(schan, struct sudmac_chan, simple_chan)
+#define to_slave(sslave) container_of(sslave, struct sudmac_slave, simple_slave)
+#define to_desc(sdesc) container_of(sdesc, struct sudmac_desc, simple_desc)
+#define to_sudmac(chan) container_of(chan->simple_chan.dma_chan.device,\
+				     struct sudmac_device, simple_dev.dma_dev)
+
+#endif	/* __DMA_SHDMA_H */
diff --git a/include/linux/sudmac.h b/include/linux/sudmac.h
new file mode 100644
index 0000000..e6bf10d
--- /dev/null
+++ b/include/linux/sudmac.h
@@ -0,0 +1,92 @@
+/*
+ * Header for the SUDMAC driver
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef SUDMAC_H
+#define SUDMAC_H
+
+#include <linux/dma-simple.h>
+#include <linux/dmaengine.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct device;
+
+/*
+ * Supplied by platforms to specify, how a DMA channel has to be configured for
+ * a certain peripheral
+ */
+struct sudmac_slave_config {
+	unsigned int			slave_id;
+	dma_addr_t			addr;
+};
+
+/* Used by slave DMA clients to request DMA to/from a specific peripheral */
+struct sudmac_slave {
+	struct dma_simple_slave		simple_slave;	/* Set by the platform */
+	struct device			*dma_dev;	/* Set by the platform */
+	const struct sudmac_slave_config *config;	/* Set by the driver */
+};
+
+struct sudmac_channel {
+	unsigned int	channel_no;
+};
+
+struct sudmac_pdata {
+	const struct sudmac_slave_config *slave;
+	int slave_num;
+	const struct sudmac_channel *channel;
+	int channel_num;
+};
+
+/* SUDMAC register */
+#define CH0CFG		0x00
+#define CH1CFG		0x04
+#define CH0BA		0x10
+#define CH1BA		0x14
+#define CH0BBC		0x18
+#define CH1BBC		0x1C
+#define CH0CA		0x20
+#define CH1CA		0x24
+#define CH0CBC		0x28
+#define CH1CBC		0x2C
+#define CH0DEN		0x30
+#define CH1DEN		0x34
+#define DSTSCLR		0x38
+#define DBUFCTRL	0x3C
+#define DINTCTRL	0x40
+#define DINTSTS		0x44
+#define DINTSTSCLR	0x48
+#define CH0SHCTRL	0x50
+#define CH1SHCTRL	0x54
+
+/* Definitions for the SUDMAC */
+#define SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
+#define RCVENDM		0x0100 /* b8: Receive Data Transfer End Mode */
+#define LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
+#define DEN		0x0001 /* b0: DMA Transfer Enable */
+#define CH1STCLR	0x0002 /* b1: Ch1 DMA Status Clear */
+#define CH0STCLR	0x0001 /* b0: Ch0 DMA Status Clear */
+#define CH1BUFW		0x0200 /* b9: Ch1 DMA Buffer Data Transfer Enable */
+#define CH0BUFW		0x0100 /* b8: Ch0 DMA Buffer Data Transfer Enable */
+#define CH1BUFS		0x0002 /* b1: Ch1 DMA Buffer Data Status */
+#define CH0BUFS		0x0001 /* b0: Ch0 DMA Buffer Data Status */
+#define CH1ERRE		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Enable */
+#define CH0ERRE		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Enable */
+#define CH1ENDE		0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
+#define CH0ENDE		0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
+#define CH1ERRS		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Status */
+#define CH0ERRS		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Status */
+#define CH1ENDS		0x0002 /* b1: Ch1 DMA Transfer End Int Status */
+#define CH0ENDS		0x0001 /* b0: Ch0 DMA Transfer End Int Status */
+#define CH1ERRC		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Stat Clear */
+#define CH0ERRC		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Stat Clear */
+#define CH1ENDC		0x0002 /* b1: Ch1 DMA Transfer End Int Stat Clear */
+#define CH0ENDC		0x0001 /* b0: Ch0 DMA Transfer End Int Stat Clear */
+
+#endif
---

Best regards,
Yoshihiro Shimoda


> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
