From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:14:05 +0000
Subject: [PATCH 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <1423469645-2976-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469645-2976-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423469645-2976-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/Kconfig    |    8 +
 drivers/dma/sh/Makefile   |    1 +
 drivers/dma/sh/usb-dmac.c | 1274 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1283 insertions(+)
 create mode 100644 drivers/dma/sh/usb-dmac.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8190ad2..89f006f 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -64,3 +64,11 @@ config RCAR_DMAC
 	help
 	  This driver supports the general purpose DMA controller found in the
 	  Renesas R-Car second generation SoCs.
+
+config RENESAS_USB_DMAC
+	tristate "Renesas USB-DMA Controller"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select RENESAS_DMA
+	help
+	  This driver supports the USB-DMA controller found in the Renesas
+          SoCs.
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
index 0000000..cefaf82
--- /dev/null
+++ b/drivers/dma/sh/usb-dmac.c
@@ -0,0 +1,1274 @@
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
+
+/*
+ * struct usb_dmac_xfer_chunk - Descriptor for a hardware transfer
+ * @node: entry in the parent's chunks list
+ * @mem_addr: memory address
+ * @size: transfer size in bytes
+ */
+struct usb_dmac_xfer_chunk {
+	struct list_head node;
+
+	dma_addr_t mem_addr;
+	u32 size;
+};
+
+/*
+ * struct usb_dmac_desc - USB DMA Transfer Descriptor
+ * @async_tx: base DMA asynchronous transaction descriptor
+ * @direction: direction of the DMA transfer
+ * @node: entry in the channel's descriptors lists
+ * @chunks: list of transfer chunks for this transfer
+ * @running: the transfer chunk being currently processed
+ * @nchunks: number of transfer chunks for this transfer
+ * @size: transfer size in bytes
+ */
+struct usb_dmac_desc {
+	struct dma_async_tx_descriptor async_tx;
+	enum dma_transfer_direction direction;
+
+	struct list_head node;
+	struct list_head chunks;
+	struct usb_dmac_xfer_chunk *running;
+	unsigned int nchunks;
+
+	unsigned int size;
+};
+
+#define to_usb_dmac_desc(d)	container_of(d, struct usb_dmac_desc, async_tx)
+
+/*
+ * struct usb_dmac_desc_page - One page worth of descriptors
+ * @node: entry in the channel's pages list
+ * @descs: array of DMA descriptors
+ * @chunks: array of transfer chunk descriptors
+ */
+struct usb_dmac_desc_page {
+	struct list_head node;
+
+	union {
+		struct usb_dmac_desc descs[0];
+		struct usb_dmac_xfer_chunk chunks[0];
+	};
+};
+
+#define USB_DMAC_DESCS_PER_PAGE					\
+	((PAGE_SIZE - offsetof(struct usb_dmac_desc_page, descs)) /	\
+	sizeof(struct usb_dmac_desc))
+#define USB_DMAC_XFER_CHUNKS_PER_PAGE					\
+	((PAGE_SIZE - offsetof(struct usb_dmac_desc_page, chunks)) /	\
+	sizeof(struct usb_dmac_xfer_chunk))
+
+/*
+ * struct usb_dmac_chan - USB DMA Controller Channel
+ * @chan: base DMA channel object
+ * @iomem: channel I/O memory base
+ * @index: index of this channel in the controller
+ * @lock: protects the channel CHCR register and the desc members
+ * @desc.free: list of free descriptors
+ * @desc.pending: list of pending descriptors (submitted with tx_submit)
+ * @desc.active: list of active descriptors (activated with issue_pending)
+ * @desc.done: list of completed descriptors
+ * @desc.wait: list of descriptors waiting for an ack
+ * @desc.running: the descriptor being processed (a member of the active list)
+ * @desc.last_done: the descriptor to get residue after done
+ * @desc.chunks_free: list of free transfer chunk descriptors
+ * @desc.pages: list of pages used by allocated descriptors
+ */
+struct usb_dmac_chan {
+	struct dma_chan chan;
+	void __iomem *iomem;
+	unsigned int index;
+
+	spinlock_t lock;
+
+	struct {
+		struct list_head free;
+		struct list_head pending;
+		struct list_head active;
+		struct list_head done;
+		struct list_head wait;
+		struct usb_dmac_desc *running;
+		struct usb_dmac_desc *last_done;
+
+		struct list_head chunks_free;
+
+		struct list_head pages;
+	} desc;
+};
+
+#define to_usb_dmac_chan(c)	container_of(c, struct usb_dmac_chan, chan)
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
+static void usb_dmac_chan_start_xfer(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc = chan->desc.running;
+	struct usb_dmac_xfer_chunk *chunk = desc->running;
+	dma_addr_t src_addr = 0, dst_addr = 0;
+
+	WARN_ON_ONCE(usb_dmac_chan_is_busy(chan));
+
+	if (desc->direction = DMA_DEV_TO_MEM)
+		dst_addr = chunk->mem_addr;
+	else
+		src_addr = chunk->mem_addr;
+
+	dev_dbg(chan->chan.device->dev,
+		"chan%u: queue chunk %p: %u@%pad -> %pad\n",
+		chan->index, chunk, chunk->size, &src_addr, &dst_addr);
+
+	usb_dmac_chan_write(chan, USB_DMASAR, src_addr & 0xffffffff);
+	usb_dmac_chan_write(chan, USB_DMADAR, dst_addr & 0xffffffff);
+	usb_dmac_chan_write(chan, USB_DMATCR,
+			    DIV_ROUND_UP(chunk->size, USB_DMAC_XFER_SIZE));
+	usb_dmac_chan_write(chan, USB_DMATEND, usb_dmac_calc_tend(chunk->size));
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
+ * Descriptors submission
+ */
+
+static dma_cookie_t usb_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct usb_dmac_chan *chan = to_usb_dmac_chan(tx->chan);
+	struct usb_dmac_desc *desc = to_usb_dmac_desc(tx);
+	unsigned long flags;
+	dma_cookie_t cookie;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	cookie = dma_cookie_assign(tx);
+
+	dev_dbg(chan->chan.device->dev, "chan%u: submit #%d@%p\n",
+		chan->index, tx->cookie, desc);
+
+	list_add_tail(&desc->node, &chan->desc.pending);
+	desc->running = list_first_entry(&desc->chunks,
+					 struct usb_dmac_xfer_chunk, node);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return cookie;
+}
+
+/* -----------------------------------------------------------------------------
+ * Descriptors allocation and free
+ */
+
+/*
+ * usb_dmac_desc_alloc - Allocate a page worth of DMA descriptors
+ * @chan: the DMA channel
+ * @gfp: allocation flags
+ */
+static int usb_dmac_desc_alloc(struct usb_dmac_chan *chan, gfp_t gfp)
+{
+	struct usb_dmac_desc_page *page;
+	LIST_HEAD(list);
+	unsigned int i;
+	unsigned long flags;
+
+	page = (void *)get_zeroed_page(gfp);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < USB_DMAC_DESCS_PER_PAGE; ++i) {
+		struct usb_dmac_desc *desc = &page->descs[i];
+
+		dma_async_tx_descriptor_init(&desc->async_tx, &chan->chan);
+		desc->async_tx.tx_submit = usb_dmac_tx_submit;
+		INIT_LIST_HEAD(&desc->chunks);
+
+		list_add_tail(&desc->node, &list);
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	list_splice_tail(&list, &chan->desc.free);
+	list_add_tail(&page->node, &chan->desc.pages);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+/*
+ * usb_dmac_desc_put - Release a DMA transfer descriptor
+ * @chan: the DMA channel
+ * @desc: the descriptor
+ *
+ * Put the descriptor and its transfer chunk descriptors back in the channel's
+ * free descriptors lists. The descriptor's chunks list will be reinitialized to
+ * an empty list as a result.
+ *
+ * The descriptor must have been removed from the channel's lists before calling
+ * this function.
+ */
+static void usb_dmac_desc_put(struct usb_dmac_chan *chan,
+			      struct usb_dmac_desc *desc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
+	list_add_tail(&desc->node, &chan->desc.free);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static void usb_dmac_desc_recycle_acked(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc, *_desc;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	/*
+	 * We have to temporarily move all descriptors from the wait list to a
+	 * local list as iterating over the wait list, even with
+	 * list_for_each_entry_safe, isn't safe if we release the channel lock
+	 * around the usb_dmac_desc_put() call.
+	 */
+	spin_lock_irqsave(&chan->lock, flags);
+	list_splice_init(&chan->desc.wait, &list);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	list_for_each_entry_safe(desc, _desc, &list, node) {
+		if (async_tx_test_ack(&desc->async_tx)) {
+			list_del(&desc->node);
+			usb_dmac_desc_put(chan, desc);
+		}
+	}
+
+	if (list_empty(&list))
+		return;
+
+	/* Put the remaining descriptors back in the wait list. */
+	spin_lock_irqsave(&chan->lock, flags);
+	list_splice(&list, &chan->desc.wait);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/*
+ * usb_dmac_desc_get - Allocate a descriptor for a DMA transfer
+ * @chan: the DMA channel
+ *
+ * Locking: This function must be called in a non-atomic context.
+ *
+ * Return: A pointer to the allocated descriptor or NULL if no descriptor can
+ * be allocated.
+ */
+static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc;
+	unsigned long flags;
+	int ret;
+
+	/* Recycle acked descriptors before attempting allocation. */
+	usb_dmac_desc_recycle_acked(chan);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	while (list_empty(&chan->desc.free)) {
+		/*
+		 * No free descriptors, allocate a page worth of them and try
+		 * again, as someone else could race us to get the newly
+		 * allocated descriptors. If the allocation fails return an
+		 * error.
+		 */
+		spin_unlock_irqrestore(&chan->lock, flags);
+		ret = usb_dmac_desc_alloc(chan, GFP_NOWAIT);
+		if (ret < 0)
+			return NULL;
+		spin_lock_irqsave(&chan->lock, flags);
+	}
+
+	desc = list_first_entry(&chan->desc.free, struct usb_dmac_desc, node);
+	list_del(&desc->node);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return desc;
+}
+
+/*
+ * usb_dmac_xfer_chunk_alloc - Allocate a page worth of transfer chunks
+ * @chan: the DMA channel
+ * @gfp: allocation flags
+ */
+static int usb_dmac_xfer_chunk_alloc(struct usb_dmac_chan *chan, gfp_t gfp)
+{
+	struct usb_dmac_desc_page *page;
+	LIST_HEAD(list);
+	unsigned int i;
+	unsigned long flags;
+
+	page = (void *)get_zeroed_page(gfp);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < USB_DMAC_XFER_CHUNKS_PER_PAGE; ++i) {
+		struct usb_dmac_xfer_chunk *chunk = &page->chunks[i];
+
+		list_add_tail(&chunk->node, &list);
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	list_splice_tail(&list, &chan->desc.chunks_free);
+	list_add_tail(&page->node, &chan->desc.pages);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+/*
+ * usb_dmac_xfer_chunk_get - Allocate a transfer chunk for a DMA transfer
+ * @chan: the DMA channel
+ *
+ * Locking: This function must be called in a non-atomic context.
+ *
+ * Return: A pointer to the allocated transfer chunk descriptor or NULL if no
+ * descriptor can be allocated.
+ */
+static struct usb_dmac_xfer_chunk *
+usb_dmac_xfer_chunk_get(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_xfer_chunk *chunk;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	while (list_empty(&chan->desc.chunks_free)) {
+		/*
+		 * No free descriptors, allocate a page worth of them and try
+		 * again, as someone else could race us to get the newly
+		 * allocated descriptors. If the allocation fails return an
+		 * error.
+		 */
+		spin_unlock_irqrestore(&chan->lock, flags);
+		ret = usb_dmac_xfer_chunk_alloc(chan, GFP_NOWAIT);
+		if (ret < 0)
+			return NULL;
+		spin_lock_irqsave(&chan->lock, flags);
+	}
+
+	chunk = list_first_entry(&chan->desc.chunks_free,
+				 struct usb_dmac_xfer_chunk, node);
+	list_del(&chunk->node);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return chunk;
+}
+
+/* -----------------------------------------------------------------------------
+ * Stop and reset
+ */
+
+static void usb_dmac_soft_reset(struct usb_dmac_chan *uchan)
+{
+	struct dma_chan *chan = &uchan->chan;
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
+static void usb_dmac_chan_reinit(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc, *_desc;
+	unsigned long flags;
+	LIST_HEAD(descs);
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	/* Move all non-free descriptors to the local lists. */
+	list_splice_init(&chan->desc.pending, &descs);
+	list_splice_init(&chan->desc.active, &descs);
+	list_splice_init(&chan->desc.done, &descs);
+	list_splice_init(&chan->desc.wait, &descs);
+
+	chan->desc.running = NULL;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	list_for_each_entry_safe(desc, _desc, &descs, node) {
+		list_del(&desc->node);
+		usb_dmac_desc_put(chan, desc);
+	}
+}
+
+static void usb_dmac_stop(struct usb_dmac *dmac)
+{
+	usb_dmac_write(dmac, USB_DMAOR, 0);
+}
+
+/* -----------------------------------------------------------------------------
+ * Descriptors preparation
+ */
+
+/*
+ * usb_dmac_chan_prep_sg - prepare transfer descriptors from an SG list
+ *
+ * Common routine for public (MEMCPY) and slave DMA. The MEMCPY case is also
+ * converted to scatter-gather to guarantee consistent locking and a correct
+ * list manipulation. For slave DMA direction carries the usual meaning, and,
+ * logically, the SG list is RAM and the addr variable contains slave address,
+ * e.g., the FIFO I/O register. For MEMCPY direction equals DMA_MEM_TO_MEM
+ * and the SG list contains only one element and points at the source buffer.
+ */
+static struct dma_async_tx_descriptor *
+usb_dmac_chan_prep_sg(struct usb_dmac_chan *chan, struct scatterlist *sgl,
+		      unsigned int sg_len, enum dma_transfer_direction dir,
+		      unsigned long dma_flags)
+{
+	struct usb_dmac_xfer_chunk *chunk;
+	struct usb_dmac_desc *desc;
+	struct scatterlist *sg;
+	unsigned int nchunks = 0;
+	unsigned int max_chunk_size;
+	unsigned int full_size = 0;
+	unsigned int i;
+
+	desc = usb_dmac_desc_get(chan);
+	if (!desc)
+		return NULL;
+
+	desc->async_tx.flags = dma_flags;
+	desc->async_tx.cookie = -EBUSY;
+
+	desc->direction = dir;
+
+	max_chunk_size = (USB_DMATCR_MASK + 1) << USB_DMAC_XFER_SHIFT;
+
+	/*
+	 * Allocate and fill the transfer chunk descriptors. We own the only
+	 * reference to the DMA descriptor, there's no need for locking.
+	 */
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t mem_addr = sg_dma_address(sg);
+		unsigned int len = sg_dma_len(sg);
+
+		full_size += len;
+
+		while (len) {
+			unsigned int size = min(len, max_chunk_size);
+
+			chunk = usb_dmac_xfer_chunk_get(chan);
+			if (!chunk) {
+				usb_dmac_desc_put(chan, desc);
+				return NULL;
+			}
+
+			chunk->mem_addr = mem_addr;
+			chunk->size = size;
+
+			dev_dbg(chan->chan.device->dev,
+				"chan%u: chunk %p/%p sgl %u@%p, %u/%u %pad\n",
+				chan->index, chunk, desc, i, sg, size, len,
+				&chunk->mem_addr);
+
+			mem_addr += size;
+			len -= size;
+
+			list_add_tail(&chunk->node, &desc->chunks);
+			nchunks++;
+		}
+	}
+
+	desc->nchunks = nchunks;
+	desc->size = full_size;
+
+	return &desc->async_tx;
+}
+
+/* -----------------------------------------------------------------------------
+ * DMA engine operations
+ */
+
+static int usb_dmac_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	int ret;
+
+	INIT_LIST_HEAD(&uchan->desc.chunks_free);
+	INIT_LIST_HEAD(&uchan->desc.pages);
+
+	/* Preallocate descriptors. */
+	ret = usb_dmac_xfer_chunk_alloc(uchan, GFP_KERNEL);
+	if (ret < 0)
+		return -ENOMEM;
+
+	ret = usb_dmac_desc_alloc(uchan, GFP_KERNEL);
+	if (ret < 0)
+		return -ENOMEM;
+
+	return pm_runtime_get_sync(chan->device->dev);
+}
+
+static void usb_dmac_free_chan_resources(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	struct usb_dmac_desc_page *page, *_page;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	/* Protect against ISR */
+	spin_lock_irqsave(&uchan->lock, flags);
+	usb_dmac_chan_halt(uchan);
+	spin_unlock_irqrestore(&uchan->lock, flags);
+
+	/* Now no new interrupts will occur */
+
+	list_splice_init(&uchan->desc.free, &list);
+	list_splice_init(&uchan->desc.pending, &list);
+	list_splice_init(&uchan->desc.active, &list);
+	list_splice_init(&uchan->desc.done, &list);
+	list_splice_init(&uchan->desc.wait, &list);
+
+	list_for_each_entry_safe(page, _page, &uchan->desc.pages, node) {
+		list_del(&page->node);
+		free_page((unsigned long)page);
+	}
+
+	pm_runtime_put(chan->device->dev);
+}
+
+static struct dma_async_tx_descriptor *
+usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       unsigned int sg_len, enum dma_transfer_direction dir,
+		       unsigned long flags, void *context)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+
+	/* Someone calling slave DMA on a generic channel? */
+	if (!sg_len) {
+		dev_warn(chan->device->dev,
+			 "%s: bad parameter: len=%d\n", __func__, sg_len);
+		return NULL;
+	}
+
+	return usb_dmac_chan_prep_sg(uchan, sgl, sg_len, dir, flags);
+}
+
+static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
+{
+	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&uchan->lock, flags);
+	usb_dmac_chan_halt(uchan);
+	spin_unlock_irqrestore(&uchan->lock, flags);
+
+	/*
+	 * FIXME: No new interrupt can occur now, but the IRQ thread might still
+	 * be running.
+	 */
+
+	usb_dmac_chan_reinit(uchan);
+
+	return 0;
+}
+
+static unsigned int
+usb_dmac_chan_get_last_residue(struct usb_dmac_chan *chan,
+			       struct usb_dmac_xfer_chunk *chunk,
+			       enum dma_transfer_direction direction)
+{
+	u32 mem_addr = chunk->mem_addr & 0xffffffff;
+	unsigned int residue = chunk->size;
+
+	/*
+	 * We cannot use USB_DMATCR to calculate residue because USB_DMATCR
+	 * has unsuited value to calculate.
+	 */
+	if (direction = DMA_DEV_TO_MEM)
+		residue -= usb_dmac_chan_read(chan, USB_DMADAR) - mem_addr;
+	else
+		residue -= usb_dmac_chan_read(chan, USB_DMASAR) - mem_addr;
+
+	return residue;
+}
+
+static unsigned int
+usb_dmac_chan_get_residue_if_complete(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc = chan->desc.last_done;
+	struct usb_dmac_xfer_chunk *chunk = desc ? desc->running : NULL;
+
+	if (!chunk)
+		return 0;
+
+	return usb_dmac_chan_get_last_residue(chan, chunk, desc->direction);
+}
+
+static unsigned int usb_dmac_chan_get_residue(struct usb_dmac_chan *chan,
+					      dma_cookie_t cookie)
+{
+	struct usb_dmac_desc *desc = chan->desc.running;
+	struct usb_dmac_xfer_chunk *running = NULL;
+	struct usb_dmac_xfer_chunk *chunk;
+	unsigned int residue = 0;
+	unsigned int dptr = 0;
+
+	if (!desc)
+		return 0;
+
+	/*
+	 * If the cookie doesn't correspond to the currently running transfer
+	 * then the descriptor hasn't been processed yet, and the residue is
+	 * equal to the full descriptor size.
+	 */
+	if (cookie != desc->async_tx.cookie)
+		return desc->size;
+
+	running = desc->running;
+
+	/* Compute the size of all chunks still to be transferred. */
+	list_for_each_entry_reverse(chunk, &desc->chunks, node) {
+		if (chunk = running || ++dptr = desc->nchunks)
+			break;
+
+		residue += chunk->size;
+	}
+
+	/* Add the residue for the current chunk. */
+	residue += usb_dmac_chan_get_last_residue(chan, chunk, desc->direction);
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
+	spin_lock_irqsave(&uchan->lock, flags);
+	if (status = DMA_COMPLETE)
+		residue = usb_dmac_chan_get_residue_if_complete(uchan);
+	else
+		residue = usb_dmac_chan_get_residue(uchan, cookie);
+	spin_unlock_irqrestore(&uchan->lock, flags);
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
+	spin_lock_irqsave(&uchan->lock, flags);
+
+	if (list_empty(&uchan->desc.pending))
+		goto done;
+
+	/* Append the pending list to the active list. */
+	list_splice_tail_init(&uchan->desc.pending, &uchan->desc.active);
+
+	/*
+	 * If no transfer is running pick the first descriptor from the active
+	 * list and start the transfer.
+	 */
+	if (!uchan->desc.running) {
+		struct usb_dmac_desc *desc;
+
+		desc = list_first_entry(&uchan->desc.active,
+					struct usb_dmac_desc, node);
+		uchan->desc.running = desc;
+
+		usb_dmac_chan_start_xfer(uchan);
+	}
+
+done:
+	spin_unlock_irqrestore(&uchan->lock, flags);
+}
+
+/* -----------------------------------------------------------------------------
+ * IRQ handling
+ */
+
+static irqreturn_t usb_dmac_isr_transfer_end(struct usb_dmac_chan *chan)
+{
+	struct usb_dmac_desc *desc = chan->desc.running;
+	irqreturn_t ret = IRQ_WAKE_THREAD;
+
+	if (WARN_ON_ONCE(!desc)) {
+		/*
+		 * This should never happen, there should always be a running
+		 * descriptor when a transfer end interrupt is triggered. Warn
+		 * and return.
+		 */
+		return IRQ_NONE;
+	}
+
+	/*
+	 * If we haven't completed the last transfer chunk simply move
+	 * to the next one. Only wake the IRQ thread.
+	 */
+	if (!list_is_last(&desc->running->node, &desc->chunks)) {
+		desc->running = list_next_entry(desc->running, node);
+		ret = IRQ_HANDLED;
+		goto done;
+	}
+
+	/* The descriptor is complete, move it to the done list. */
+	list_move_tail(&desc->node, &chan->desc.done);
+
+	/* Queue the next descriptor, if any. */
+	if (!list_empty(&chan->desc.active))
+		chan->desc.running = list_first_entry(&chan->desc.active,
+						      struct usb_dmac_desc,
+						      node);
+	else
+		chan->desc.running = NULL;
+
+done:
+	if (chan->desc.running)
+		usb_dmac_chan_start_xfer(chan);
+
+	return ret;
+}
+
+static irqreturn_t usb_dmac_isr_channel(int irq, void *dev)
+{
+	u32 mask = USB_DMACHCR_TE;
+	struct usb_dmac_chan *chan = dev;
+	irqreturn_t ret = IRQ_NONE;
+	u32 chcr;
+	u32 check_bits = USB_DMACHCR_TE | USB_DMACHCR_SP;
+
+	spin_lock(&chan->lock);
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
+	if (chcr & check_bits)
+		ret |= usb_dmac_isr_transfer_end(chan);
+
+	spin_unlock(&chan->lock);
+
+	return ret;
+}
+
+static irqreturn_t usb_dmac_isr_channel_thread(int irq, void *dev)
+{
+	struct usb_dmac_chan *chan = dev;
+	struct usb_dmac_desc *desc;
+
+	spin_lock_irq(&chan->lock);
+
+	/*
+	 * Call the callback function for all descriptors on the done list and
+	 * move them to the ack wait list.
+	 */
+	while (!list_empty(&chan->desc.done)) {
+		desc = list_first_entry(&chan->desc.done, struct usb_dmac_desc,
+					node);
+		dma_cookie_complete(&desc->async_tx);
+		list_del(&desc->node);
+
+		/* This last_done is used to get residue after DMA_COMPLETE */
+		chan->desc.last_done = desc;
+
+		if (desc->async_tx.callback) {
+			spin_unlock_irq(&chan->lock);
+			/*
+			 * We own the only reference to this descriptor, we can
+			 * safely dereference it without holding the channel
+			 * lock.
+			 */
+			desc->async_tx.callback(desc->async_tx.callback_param);
+			spin_lock_irq(&chan->lock);
+		}
+
+		list_add_tail(&desc->node, &chan->desc.wait);
+	}
+
+	spin_unlock_irq(&chan->lock);
+
+	/* Recycle all acked descriptors. */
+	usb_dmac_desc_recycle_acked(chan);
+
+	return IRQ_HANDLED;
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
+#ifdef CONFIG_PM_SLEEP
+static int usb_dmac_sleep_suspend(struct device *dev)
+{
+	/*
+	 * TODO: Wait for the current transfer to complete and stop the device.
+	 */
+	return 0;
+}
+
+static int usb_dmac_sleep_resume(struct device *dev)
+{
+	/* TODO: Resume transfers, if any. */
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int usb_dmac_runtime_suspend(struct device *dev)
+{
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
+	SET_SYSTEM_SLEEP_PM_OPS(usb_dmac_sleep_suspend, usb_dmac_sleep_resume)
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
+	struct dma_chan *chan = &uchan->chan;
+	char pdev_irqname[5];
+	char *irqname;
+	int irq;
+	int ret;
+
+	uchan->index = index;
+	uchan->iomem = dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
+
+	spin_lock_init(&uchan->lock);
+
+	INIT_LIST_HEAD(&uchan->desc.free);
+	INIT_LIST_HEAD(&uchan->desc.pending);
+	INIT_LIST_HEAD(&uchan->desc.active);
+	INIT_LIST_HEAD(&uchan->desc.done);
+	INIT_LIST_HEAD(&uchan->desc.wait);
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
+	ret = devm_request_threaded_irq(dmac->dev, irq, usb_dmac_isr_channel,
+					usb_dmac_isr_channel_thread,
+					IRQF_SHARED,
+					irqname, uchan);
+	if (ret) {
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
+		return ret;
+	}
+
+	/*
+	 * Initialize the DMA engine channel and add it to the DMA engine
+	 * channels list.
+	 */
+	chan->device = &dmac->engine;
+	dma_cookie_init(chan);
+
+	list_add_tail(&chan->device_node, &dmac->engine.channels);
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
+static int usb_dmac_remove(struct platform_device *pdev)
+{
+	struct usb_dmac *dmac = platform_get_drvdata(pdev);
+
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
+MODULE_DESCRIPTION("USB DMA Controller Driver");
+MODULE_AUTHOR("Yoshihiro Shimoda <yoshihiro.shimoda.uh@ideasonboard.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

