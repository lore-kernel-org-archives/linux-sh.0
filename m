From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Mar 2015 05:39:54 +0000
Subject: [PATCH v2 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <1426052394-5556-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, dan.j.williams@intel.com, laurent.pinchart@ideasonboard.com, horms@verge.net.au, kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This DMAC is Renesas USB high-speed module DMA controller that
supports slave transfer.

This USB-DMAC has similar register sets with R-Car Gen2 DMAC, but
the USB-DMAC has specific registers to control the USB transactions.
If this code is added into the rcar-dmac driver, it will become
unreadable. So, this driver is independent from the rcar-dmac.

And, this USB-DMAC uses virt-dma infrastructure.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/Kconfig    |   9 +
 drivers/dma/sh/Makefile   |   1 +
 drivers/dma/sh/usb-dmac.c | 724 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 734 insertions(+)
 create mode 100644 drivers/dma/sh/usb-dmac.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8190ad2..f6ca002 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -64,3 +64,12 @@ config RCAR_DMAC
 	help
 	  This driver supports the general purpose DMA controller found in the
 	  Renesas R-Car second generation SoCs.
+
+config RENESAS_USB_DMAC
+	tristate "Renesas USB-DMA Controller"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select RENESAS_DMA
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This driver supports the USB-DMA controller found in the Renesas
+	  SoCs.
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 2852f9d..221ab19 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_RCAR_HPB_DMAE) += rcar-hpbdma.o
 obj-$(CONFIG_RCAR_AUDMAC_PP) += rcar-audmapp.o
 obj-$(CONFIG_RCAR_DMAC) += rcar-dmac.o
+obj-$(CONFIG_RENESAS_USB_DMAC) += usb-dmac.o
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
new file mode 100644
index 0000000..1bbae34
--- /dev/null
+++ b/drivers/dma/sh/usb-dmac.c
@@ -0,0 +1,724 @@
+/*
+ * Renesas USB DMA Controller Driver
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * based on rcar-dmac.c
+ * Copyright (C) 2014 Renesas Electronics Inc.
+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+/*
+ * struct usb_dmac_desc - USB DMA Transfer Descriptor
+ * @vd: base virtual channel DMA transaction descriptor
+ * @direction: direction of the DMA transfer
+ * @mem_addr: memory address
+ * @size: transfer size in bytes
+ */
+struct usb_dmac_desc {
+	struct virt_dma_desc vd;
+	enum dma_transfer_direction direction;
+	dma_addr_t mem_addr;
+	u32 size;
+};
+
+#define to_usb_dmac_desc(vd)	container_of(vd, struct usb_dmac_desc, vd)
+
+/*
+ * struct usb_dmac_chan - USB DMA Controller Channel
+ * @vc: base virtual DMA channel object
+ * @task: tasklet object
+ * @iomem: channel I/O memory base
+ * @index: index of this channel in the controller
+ * @residue: residue after the DMAC completed a transfer
+ * @desc: the current descriptor
+ */
+struct usb_dmac_chan {
+	struct virt_dma_chan vc;
+	struct tasklet_struct task;
+	void __iomem *iomem;
+	unsigned int index;
+	u32 residue;
+	struct usb_dmac_desc *desc;
+};
+
+#define to_usb_dmac_chan(c) container_of(c, struct usb_dmac_chan, vc.chan)
+
+/*
+ * struct usb_dmac - USB DMA Controller
+ * @engine: base DMA engine object
+ * @dev: the hardware device
+ * @iomem: remapped I/O memory base
+ * @n_channels: number of available channels
+ * @channels: array of DMAC channels
+ */
+struct usb_dmac {
+	struct dma_device engine;
+	struct device *dev;
+	void __iomem *iomem;
+
+	unsigned int n_channels;
+	struct usb_dmac_chan *channels;
+};
+
+#define to_usb_dmac(d)		container_of(d, struct usb_dmac, engine)
+
+/* -----------------------------------------------------------------------------
+ * Registers
+ */
+
+#define USB_DMAC_CHAN_OFFSET(i)		(0x20 + 0x20 * (i))
+
+#define USB_DMASWR			0x0008
+#define USB_DMASWR_SWR			(1 << 0)
+#define USB_DMAOR			0x0060
+#define USB_DMAOR_AE			(1 << 2)
+#define USB_DMAOR_DME			(1 << 0)
+
+#define USB_DMASAR			0x0000
+#define USB_DMADAR			0x0004
+#define USB_DMATCR			0x0008
+#define USB_DMATCR_MASK			0x00ffffff
+#define USB_DMACHCR			0x0014
+#define USB_DMACHCR_FTE			(1 << 24)
+#define USB_DMACHCR_NULLE		(1 << 16)
+#define USB_DMACHCR_NULL		(1 << 12)
+#define USB_DMACHCR_TS_8B		((0 << 7) | (0 << 6))
+#define USB_DMACHCR_TS_16B		((0 << 7) | (1 << 6))
+#define USB_DMACHCR_TS_32B		((1 << 7) | (0 << 6))
+#define USB_DMACHCR_IE			(1 << 5)
+#define USB_DMACHCR_SP			(1 << 2)
+#define USB_DMACHCR_TE			(1 << 1)
+#define USB_DMACHCR_DE			(1 << 0)
+#define USB_DMATEND			0x0018
+
+/* Hardcode the xfer_shift to 5 (32bytes) */
+#define USB_DMAC_XFER_SHIFT	5
+#define USB_DMAC_XFER_SIZE	(1 << USB_DMAC_XFER_SHIFT)
+#define USB_DMAC_CHCR_TS	USB_DMACHCR_TS_32B
+#define USB_DMAC_SLAVE_BUSWIDTH	DMA_SLAVE_BUSWIDTH_32_BYTES
+
+/* -----------------------------------------------------------------------------
+ * Device access
+ */
+
+static void usb_dmac_write(struct usb_dmac *dmac, u32 reg, u32 data)
+{
+	writel(data, dmac->iomem + reg);
+}
+
+static u32 usb_dmac_read(struct usb_dmac *dmac, u32 reg)
+{
+	return readl(dmac->iomem + reg);
+}
+
+static u32 usb_dmac_chan_read(struct usb_dmac_chan *chan, u32 reg)
+{
+	return readl(chan->iomem + reg);
+}
+
+static void usb_dmac_chan_write(struct usb_dmac_chan *chan, u32 reg, u32 data)
+{
+	writel(data, chan->iomem + reg);
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization and configuration
+ */
+
+static bool usb_dmac_chan_is_busy(struct usb_dmac_chan *chan)
+{
+	u32 chcr = usb_dmac_chan_read(chan, USB_DMACHCR);
+
+	return (chcr & (USB_DMACHCR_DE | USB_DMACHCR_TE)) = USB_DMACHCR_DE;
+}
+
+static u32 usb_dmac_calc_tend(u32 size)
+{
+	/*
+	 * Please refer to the Figure "Example of Final Transaction Valid
+	 * Data Transfer Enable (EDTEN) Setting" in the data sheet.
+	 */
+	return 0xffffffff << (32 - (size % USB_DMAC_XFER_SIZE ?	:
+						USB_DMAC_XFER_SIZE));
+}
+
+/* This function is already held by vc.lock */
+static void usb_dmac_chan_start_xfer(struct usb_dmac_chan *chan)
+{
+	struct virt_dma_desc *vd;
+	struct usb_dmac_desc *desc;
+	dma_addr_t src_addr = 0, dst_addr = 0;
+
+	vd = vchan_next_desc(&chan->vc);
+	if (!vd) {
+		chan->desc = NULL;
+		return;
+	}
+
+	/*
+	 * Remove this request from vc->desc_issued. Otherwise, this driver
+	 * will get the previous value from vchan_next_desc() after a transfer
+	 * was completed.
+	 */
+	list_del(&vd->node);
+
+	chan->desc = desc = to_usb_dmac_desc(vd);
+	chan->residue = desc->size;
+
+	WARN_ON_ONCE(usb_dmac_chan_is_busy(chan));
+
+	if (desc->direction = DMA_DEV_TO_MEM)
+		dst_addr = desc->mem_addr;
+	else
+		src_addr = desc->mem_addr;
+
+	dev_dbg(chan->vc.chan.device->dev,
+		"chan%u: queue desc %p: %u@%pad -> %pad\n",
+		chan->index, desc, desc->size, &src_addr, &dst_addr);
+
+	usb_dmac_chan_write(chan, USB_DMASAR, src_addr & 0xffffffff);
+	usb_dmac_chan_write(chan, USB_DMADAR, dst_addr & 0xffffffff);
+	usb_dmac_chan_write(chan, USB_DMATCR,
+			    DIV_ROUND_UP(desc->size, USB_DMAC_XFER_SIZE));
+	usb_dmac_chan_write(chan, USB_DMATEND, usb_dmac_calc_tend(desc->size));
+
+	usb_dmac_chan_write(chan, USB_DMACHCR, USB_DMAC_CHCR_TS |
+			USB_DMACHCR_NULLE | USB_DMACHCR_IE | USB_DMACHCR_DE);
+}
+
+static int usb_dmac_init(struct usb_dmac *dmac)
+{
+	u16 dmaor;
+
+	/* Clear all channels and enable the DMAC globally. */
+	usb_dmac_write(dmac, USB_DMAOR, USB_DMAOR_DME);
+
+	dmaor = usb_dmac_read(dmac, USB_DMAOR);
+	if ((dmaor & (USB_DMAOR_AE | USB_DMAOR_DME)) != USB_DMAOR_DME) {
+		dev_warn(dmac->dev, "DMAOR initialization failed.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * Stop and reset
+ */
+
+static void usb_dmac_soft_reset(struct usb_dmac_chan *uchan)
+{
+	struct dma_chan *chan = &uchan->vc.chan;
+	struct usb_dmac *dmac = to_usb_dmac(chan->device);
+	int i;
+
+	/* Don't issue soft reset if any one of channels is busy */
+	for (i = 0; i < dmac->n_channels; ++i) {
+		if (usb_dmac_chan_is_busy(uchan))
+			return;
+	}
+
+	usb_dmac_write(dmac, USB_DMAOR, 0);
+	usb_dmac_write(dmac, USB_DMASWR, USB_DMASWR_SWR);
+	udelay(100);
+	usb_dmac_write(dmac, USB_DMASWR, 0);
+	usb_dmac_write(dmac, USB_DMAOR, 1);
+}
+
+static void usb_dmac_chan_halt(struct usb_dmac_chan *chan)
+{
+	u32 chcr = usb_dmac_chan_read(chan, USB_DMACHCR);
+
+	chcr &= ~(USB_DMACHCR_IE | USB_DMACHCR_TE | USB_DMACHCR_DE);
+	usb_dmac_chan_write(chan, USB_DMACHCR, chcr);
+
+	usb_dmac_soft_reset(chan);
+}
+
+static void usb_dmac_stop(struct usb_dmac *dmac)
+{
+	usb_dmac_write(dmac, USB_DMAOR, 0);
+}
+
+/* -----------------------------------------------------------------------------
+ * DMA engine operations
+ */
+
+static int usb_dmac_alloc_chan_resources(struct dma_chan *chan)
+{
+	return pm_runtime_get_sync(chan->device->dev);
+}
+
+static void usb_dmac_free_chan_resources(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	unsigned long flags;
+
+	/* Protect against ISR */
+	spin_lock_irqsave(&uchan->vc.lock, flags);
+	usb_dmac_chan_halt(uchan);
+	spin_unlock_irqrestore(&uchan->vc.lock, flags);
+
+	vchan_free_chan_resources(&uchan->vc);
+
+	pm_runtime_put(chan->device->dev);
+}
+
+static struct dma_async_tx_descriptor *
+usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       unsigned int sg_len, enum dma_transfer_direction dir,
+		       unsigned long dma_flags, void *context)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	struct usb_dmac_desc *desc;
+
+	/* A client driver will use dmaengine_prep_slave_single() */
+	if (sg_len != 1) {
+		dev_warn(chan->device->dev,
+			 "%s: bad parameter: len=%d\n", __func__, sg_len);
+		return NULL;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->direction = dir;
+	desc->mem_addr = sg_dma_address(sgl);
+	desc->size = sg_dma_len(sgl);
+
+	return vchan_tx_prep(&uchan->vc, &desc->vd, dma_flags);
+}
+
+static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&uchan->vc.lock, flags);
+	usb_dmac_chan_halt(uchan);
+	vchan_get_all_descriptors(&uchan->vc, &head);
+	if (uchan->desc)
+		uchan->desc = NULL;
+	spin_unlock_irqrestore(&uchan->vc.lock, flags);
+	vchan_dma_desc_free_list(&uchan->vc, &head);
+
+	return 0;
+}
+
+static unsigned int
+usb_dmac_chan_get_last_residue(struct usb_dmac_chan *chan,
+			       struct usb_dmac_desc *desc)
+{
+	u32 mem_addr = desc->mem_addr & 0xffffffff;
+	unsigned int residue = desc->size;
+
+	/*
+	 * We cannot use USB_DMATCR to calculate residue because USB_DMATCR
+	 * has unsuited value to calculate.
+	 */
+	if (desc->direction = DMA_DEV_TO_MEM)
+		residue -= usb_dmac_chan_read(chan, USB_DMADAR) - mem_addr;
+	else
+		residue -= usb_dmac_chan_read(chan, USB_DMASAR) - mem_addr;
+
+	return residue;
+}
+
+static enum dma_status usb_dmac_tx_status(struct dma_chan *chan,
+					  dma_cookie_t cookie,
+					  struct dma_tx_state *txstate)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	enum dma_status status;
+	unsigned long flags;
+	unsigned int residue;
+
+	status = dma_cookie_status(chan, cookie, txstate);
+	/* a client driver will get residue after DMA_COMPLETE */
+	if (!txstate)
+		return status;
+
+	spin_lock_irqsave(&uchan->vc.lock, flags);
+	residue = uchan->residue;
+	spin_unlock_irqrestore(&uchan->vc.lock, flags);
+
+	dma_set_residue(txstate, residue);
+
+	return status;
+}
+
+static void usb_dmac_issue_pending(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&uchan->vc.lock, flags);
+	if (vchan_issue_pending(&uchan->vc) && !uchan->desc)
+		tasklet_schedule(&uchan->task);
+	spin_unlock_irqrestore(&uchan->vc.lock, flags);
+}
+
+static void usb_dmac_desc_free(struct virt_dma_desc *vd)
+{
+	kfree(to_usb_dmac_desc(vd));
+}
+
+/* -----------------------------------------------------------------------------
+ * IRQ handling
+ */
+
+static irqreturn_t usb_dmac_isr_channel(int irq, void *dev)
+{
+	struct usb_dmac_chan *chan = dev;
+	irqreturn_t ret = IRQ_NONE;
+	u32 mask = USB_DMACHCR_TE;
+	u32 check_bits = USB_DMACHCR_TE | USB_DMACHCR_SP;
+	u32 chcr;
+
+	spin_lock(&chan->vc.lock);
+
+	chcr = usb_dmac_chan_read(chan, USB_DMACHCR);
+	if (chcr & check_bits)
+		mask |= USB_DMACHCR_DE | check_bits;
+	if (chcr & USB_DMACHCR_NULL) {
+		/* An interruption of TE will happen after we set FTE */
+		mask |= USB_DMACHCR_NULL;
+		chcr |= USB_DMACHCR_FTE;
+		ret |= IRQ_HANDLED;
+	}
+	usb_dmac_chan_write(chan, USB_DMACHCR, chcr & ~mask);
+
+	if (chcr & check_bits) {
+		tasklet_schedule(&chan->task);
+		ret |= IRQ_HANDLED;
+	}
+
+	spin_unlock(&chan->vc.lock);
+
+	return ret;
+}
+
+static void usb_dmac_chan_tasklet(unsigned long data)
+{
+	struct usb_dmac_chan *chan = (struct usb_dmac_chan *)data;
+	struct usb_dmac_desc *desc = chan->desc;
+
+	spin_lock_irq(&chan->vc.lock);
+
+	/* This driver assumes a transfer finishes if desc is not NULL */
+	if (desc) {
+		chan->residue = usb_dmac_chan_get_last_residue(chan, desc);
+		vchan_cookie_complete(&desc->vd);
+	}
+
+	/* (Re)start the next transfer if this driver has a next desc */
+	usb_dmac_chan_start_xfer(chan);
+
+	spin_unlock_irq(&chan->vc.lock);
+}
+
+/* -----------------------------------------------------------------------------
+ * OF xlate and channel filter
+ */
+
+static bool usb_dmac_chan_filter(struct dma_chan *chan, void *arg)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	struct of_phandle_args *dma_spec = arg;
+
+	if (dma_spec->np != chan->device->dev->of_node)
+		return false;
+
+	/* USB-DMAC should be used with fixed usb controller's FIFO */
+	if (uchan->index != dma_spec->args[0])
+		return false;
+
+	return true;
+}
+
+static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
+					  struct of_dma *ofdma)
+{
+	struct usb_dmac_chan *uchan;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	/* Only slave DMA channels can be allocated via DT */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, usb_dmac_chan_filter, dma_spec);
+	if (!chan)
+		return NULL;
+
+	uchan = to_usb_dmac_chan(chan);
+
+	return chan;
+}
+
+/* -----------------------------------------------------------------------------
+ * Power management
+ */
+
+#ifdef CONFIG_PM
+static int usb_dmac_runtime_suspend(struct device *dev)
+{
+	struct usb_dmac *dmac = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < dmac->n_channels; ++i)
+		usb_dmac_chan_halt(&dmac->channels[i]);
+
+	return 0;
+}
+
+static int usb_dmac_runtime_resume(struct device *dev)
+{
+	struct usb_dmac *dmac = dev_get_drvdata(dev);
+
+	return usb_dmac_init(dmac);
+}
+#endif
+
+static const struct dev_pm_ops usb_dmac_pm = {
+	SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
+			   NULL)
+};
+
+/* -----------------------------------------------------------------------------
+ * Probe and remove
+ */
+
+static int usb_dmac_chan_probe(struct usb_dmac *dmac,
+			       struct usb_dmac_chan *uchan,
+			       unsigned int index)
+{
+	struct platform_device *pdev = to_platform_device(dmac->dev);
+	char pdev_irqname[5];
+	char *irqname;
+	int irq;
+	int ret;
+
+	uchan->index = index;
+	uchan->iomem = dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
+
+	/* Request the channel interrupt. */
+	sprintf(pdev_irqname, "ch%u", index);
+	irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0) {
+		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
+		return -ENODEV;
+	}
+
+	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
+				 dev_name(dmac->dev), index);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_irq(dmac->dev, irq, usb_dmac_isr_channel,
+			       IRQF_SHARED, irqname, uchan);
+	if (ret) {
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
+		return ret;
+	}
+
+	tasklet_init(&uchan->task, usb_dmac_chan_tasklet, (unsigned long)uchan);
+
+	uchan->vc.desc_free = usb_dmac_desc_free;
+	vchan_init(&uchan->vc, &dmac->engine);
+
+	return 0;
+}
+
+static int usb_dmac_parse_of(struct device *dev, struct usb_dmac *dmac)
+{
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ret = of_property_read_u32(np, "dma-channels", &dmac->n_channels);
+	if (ret < 0) {
+		dev_err(dev, "unable to read dma-channels property\n");
+		return ret;
+	}
+
+	if (dmac->n_channels <= 0 || dmac->n_channels >= 100) {
+		dev_err(dev, "invalid number of channels %u\n",
+			dmac->n_channels);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int usb_dmac_probe(struct platform_device *pdev)
+{
+	const enum dma_slave_buswidth widths = USB_DMAC_SLAVE_BUSWIDTH;
+	struct dma_device *engine;
+	struct usb_dmac *dmac;
+	struct resource *mem;
+	unsigned int i;
+	int ret;
+
+	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
+	if (!dmac)
+		return -ENOMEM;
+
+	dmac->dev = &pdev->dev;
+	platform_set_drvdata(pdev, dmac);
+
+	ret = usb_dmac_parse_of(&pdev->dev, dmac);
+	if (ret < 0)
+		return ret;
+
+	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
+				      sizeof(*dmac->channels), GFP_KERNEL);
+	if (!dmac->channels)
+		return -ENOMEM;
+
+	/* Request resources. */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dmac->iomem))
+		return PTR_ERR(dmac->iomem);
+
+	/* Enable runtime PM and initialize the device. */
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = usb_dmac_init(dmac);
+	pm_runtime_put(&pdev->dev);
+
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reset device\n");
+		goto error;
+	}
+
+	/* Initialize the channels. */
+	INIT_LIST_HEAD(&dmac->engine.channels);
+
+	for (i = 0; i < dmac->n_channels; ++i) {
+		ret = usb_dmac_chan_probe(dmac, &dmac->channels[i], i);
+		if (ret < 0)
+			goto error;
+	}
+
+	/* Register the DMAC as a DMA provider for DT. */
+	ret = of_dma_controller_register(pdev->dev.of_node, usb_dmac_of_xlate,
+					 NULL);
+	if (ret < 0)
+		goto error;
+
+	/*
+	 * Register the DMA engine device.
+	 *
+	 * Default transfer size of 32 bytes requires 32-byte alignment.
+	 */
+	engine = &dmac->engine;
+	dma_cap_set(DMA_SLAVE, engine->cap_mask);
+
+	engine->dev = &pdev->dev;
+
+	engine->src_addr_widths = widths;
+	engine->dst_addr_widths = widths;
+	engine->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	engine->device_alloc_chan_resources = usb_dmac_alloc_chan_resources;
+	engine->device_free_chan_resources = usb_dmac_free_chan_resources;
+	engine->device_prep_slave_sg = usb_dmac_prep_slave_sg;
+	engine->device_terminate_all = usb_dmac_chan_terminate_all;
+	engine->device_tx_status = usb_dmac_tx_status;
+	engine->device_issue_pending = usb_dmac_issue_pending;
+
+	ret = dma_async_device_register(engine);
+	if (ret < 0)
+		goto error;
+
+	return 0;
+
+error:
+	of_dma_controller_free(pdev->dev.of_node);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static void usb_dmac_chan_remove(struct usb_dmac_chan *uchan)
+{
+	tasklet_kill(&uchan->task);
+}
+
+static int usb_dmac_remove(struct platform_device *pdev)
+{
+	struct usb_dmac *dmac = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < dmac->n_channels; ++i)
+		usb_dmac_chan_remove(&dmac->channels[i]);
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&dmac->engine);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static void usb_dmac_shutdown(struct platform_device *pdev)
+{
+	struct usb_dmac *dmac = platform_get_drvdata(pdev);
+
+	usb_dmac_stop(dmac);
+}
+
+static const struct of_device_id usb_dmac_of_ids[] = {
+	{ .compatible = "renesas,usb-dmac", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, usb_dmac_of_ids);
+
+static struct platform_driver usb_dmac_driver = {
+	.driver		= {
+		.pm	= &usb_dmac_pm,
+		.name	= "usb-dmac",
+		.of_match_table = usb_dmac_of_ids,
+	},
+	.probe		= usb_dmac_probe,
+	.remove		= usb_dmac_remove,
+	.shutdown	= usb_dmac_shutdown,
+};
+
+module_platform_driver(usb_dmac_driver);
+
+MODULE_DESCRIPTION("Renesas USB DMA Controller Driver");
+MODULE_AUTHOR("Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

