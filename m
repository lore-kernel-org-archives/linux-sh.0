From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 04 Sep 2009 08:19:42 +0000
Subject: [PATCH v6] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <4AA0CD9E.3030908@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Dan.

Nobuhiro Iwamatsu wrote:
> Hi, Dan.
> 
> Thank you for your check.
> 
> Dan Williams wrote:
>> Nobuhiro Iwamatsu wrote:
>>> This supported all DMA channels, and it was tested in SH7722,
>>> SH7780 and SH7763.
>>> This can not use with SH DMA API.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>
>>> ---
>>>  v5: Fix some bug.
>>>      Add Cyclic extention API (got hint from dw_dmac.c)
>> Have you run this with CONFIG_PROVE_LOCKING=y?  I suspect it will find 
>> some issues.  It looks like desc_lock in the interrupt handler is only 
>> protecting updates to the CHCR register.  In other places desc_lock is 
>> protecting descriptor chain updates.  And the code varies from spin_lock 
>> to spin_lock_bh?  If you can't move all register manipulations to bh or 
>> process context then you will most likely need a separate register_lock 
>> which can be taken with spin_lock_irq... see what CONFIG_PROVE_LOCKING 
>> reports.
> 
> OK, I check this point, and send report.
I checked this.
Work fine.

I send update patch.

Best regards,
 Nobuhiro

------

This supported all DMA channels, and it was tested in SH7722,
SH7780, SH7785 and SH7763.
This can not use with SH DMA API.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>

---
 arch/sh/drivers/dma/Kconfig  |   12 +-
 arch/sh/drivers/dma/Makefile |    3 +-
 arch/sh/include/asm/dma-sh.h |   13 +
 drivers/dma/Kconfig          |    8 +
 drivers/dma/Makefile         |    1 +
 drivers/dma/shdma.c          |  782 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/shdma.h          |   63 ++++
 7 files changed, 877 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/shdma.c
 create mode 100644 drivers/dma/shdma.h

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index b91fa8d..4d58eb0 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -1,12 +1,9 @@
 menu "DMA support"

-config SH_DMA_API
-	bool

 config SH_DMA
 	bool "SuperH on-chip DMA controller (DMAC) support"
 	depends on CPU_SH3 || CPU_SH4
-	select SH_DMA_API
 	default n

 config SH_DMA_IRQ_MULTI
@@ -19,6 +16,15 @@ config SH_DMA_IRQ_MULTI
 		     CPU_SUBTYPE_SH7780  || CPU_SUBTYPE_SH7785  || \
 		     CPU_SUBTYPE_SH7760

+config SH_DMA_API
+	depends on SH_DMA
+	bool "SuperH DMA API support"
+	default n
+	help
+	  SH_DMA_API always enabled DMA API of used SuperH.
+	  If you want to use DMA ENGINE, you must not enable this.
+	  Please enable DMA_ENGINE and SH_DMAE.
+
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
diff --git a/arch/sh/drivers/dma/Makefile b/arch/sh/drivers/dma/Makefile
index c606813..d88c948 100644
--- a/arch/sh/drivers/dma/Makefile
+++ b/arch/sh/drivers/dma/Makefile
@@ -2,8 +2,7 @@
 # Makefile for the SuperH DMA specific kernel interface routines under Linux.
 #

-obj-$(CONFIG_SH_DMA_API)	+= dma-api.o dma-sysfs.o
-obj-$(CONFIG_SH_DMA)		+= dma-sh.o
+obj-$(CONFIG_SH_DMA_API)	+= dma-sh.o dma-api.o dma-sysfs.o
 obj-$(CONFIG_PVR2_DMA)		+= dma-pvr2.o
 obj-$(CONFIG_G2_DMA)		+= dma-g2.o
 obj-$(CONFIG_SH_DMABRG)		+= dmabrg.o
diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 68a5f4c..78eed3e 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -116,4 +116,17 @@ static u32 dma_base_addr[] __maybe_unused = {
 #define CHCR    0x0C
 #define DMAOR	0x40

+/*
+ * for dma engine
+ *
+ * SuperH DMA mode
+ */
+#define SHDMA_MIX_IRQ	(1 << 1)
+#define SHDMA_DMAOR1	(1 << 2)
+#define SHDMA_DMAE1		(1 << 3)
+
+struct sh_dmae_pdata {
+	unsigned int mode;
+};
+
 #endif /* __DMA_SH_H */
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 377bd07..69341a8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -97,6 +97,14 @@ config TXX9_DMAC
 	  Support the TXx9 SoC internal DMA controller.  This can be
 	  integrated in chips such as the Toshiba TX4927/38/39.

+config SH_DMAE
+	tristate "Renesas SuperH DMAC support"
+	depends on SUPERH && SH_DMA
+	depends on !SH_DMA_API
+	select DMA_ENGINE
+	help
+	  Enable support for the Renesas SuperH DMA controllers.
+
 config DMA_ENGINE
 	bool

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 40e1e00..af30516 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DW_DMAC) += dw_dmac.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_MX3_IPU) += ipu/
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
+obj-$(CONFIG_SH_DMAE) += shdma.o
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
new file mode 100644
index 0000000..2ca4c9b
--- /dev/null
+++ b/drivers/dma/shdma.c
@@ -0,0 +1,782 @@
+/*
+ * Renesas SuperH DMA Engine support
+ *
+ * base is drivers/dma/flsdma.c
+ *
+ * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
+ * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * - DMA of SuperH does not have Hardware DMA chain mode.
+ * - MAX DMA size is 16MB.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/platform_device.h>
+#include <cpu/dma.h>
+#include <asm/dma-sh.h>
+#include "shdma.h"
+
+/* DMA descriptor control */
+#define DESC_LAST	(-1)
+#define DESC_COMP	(1)
+#define DESC_NCOMP	(0)
+
+#define NR_DESCS_PER_CHANNEL 32
+/*
+ * Define the default configuration for dual address memory-memory transfer.
+ * The 0x400 value represents auto-request, external->external.
+ */
+#define RS_DEFAULT  RS_DUAL
+
+#define SH_DMAC_CHAN_BASE(id) (dma_base_addr[id])
+static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
+{
+	ctrl_outl(data, (SH_DMAC_CHAN_BASE(sh_dc->id) + reg));
+}
+
+static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
+{
+	return ctrl_inl((SH_DMAC_CHAN_BASE(sh_dc->id) + reg));
+}
+
+static void dmae_init(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = RS_DEFAULT; /* default is DUAL mode */
+	sh_dmae_writel(sh_chan, chcr, CHCR);
+}
+
+/*
+ * Reset DMA controller
+ *
+ * SH7780 has two DMAOR register
+ */
+static void sh_dmae_ctl_stop(int id)
+{
+	unsigned short dmaor = dmaor_read_reg(id);
+
+	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
+	dmaor_write_reg(id, dmaor);
+}
+
+static int sh_dmae_rst(int id)
+{
+	unsigned short dmaor;
+
+	sh_dmae_ctl_stop(id);
+	dmaor = (dmaor_read_reg(id)|DMAOR_INIT);
+
+	dmaor_write_reg(id, dmaor);
+	if ((dmaor_read_reg(id) & (DMAOR_AE | DMAOR_NMIF))) {
+		pr_warning(KERN_ERR "dma-sh: Can't initialize DMAOR.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int dmae_is_idle(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+	if (chcr & CHCR_DE) {
+		if (!(chcr & CHCR_TE))
+			return -EBUSY; /* working */
+	}
+	return 0; /* waiting */
+}
+
+static inline unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+	return ts_shift[(chcr & CHCR_TS_MASK) >> CHCR_TS_SHIFT];
+}
+
+static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs hw)
+{
+	sh_dmae_writel(sh_chan, hw.sar, SAR);
+	sh_dmae_writel(sh_chan, hw.dar, DAR);
+	sh_dmae_writel(sh_chan,
+		(hw.tcr >> calc_xmit_shift(sh_chan)), TCR);
+}
+
+static void dmae_start(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+
+	chcr |= (CHCR_DE|CHCR_IE);
+	sh_dmae_writel(sh_chan, chcr, CHCR);
+}
+
+static void dmae_halt(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+
+	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
+	sh_dmae_writel(sh_chan, chcr, CHCR);
+}
+
+static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
+{
+	int ret = dmae_is_idle(sh_chan);
+	/* When DMA was working, can not set data to CHCR */
+	if (ret)
+		return ret;
+
+	sh_dmae_writel(sh_chan, val, CHCR);
+	return 0;
+}
+
+#define DMARS1_ADDR	0x04
+#define DMARS2_ADDR	0x08
+#define DMARS_SHIFT 8
+#define DMARS_CHAN_MSK 0x01
+static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
+{
+	u32 addr;
+	int shift = 0;
+	int ret = dmae_is_idle(sh_chan);
+	if (ret)
+		return ret;
+
+	if (sh_chan->id & DMARS_CHAN_MSK)
+		shift = DMARS_SHIFT;
+
+	switch (sh_chan->id) {
+	/* DMARS0 */
+	case 0:
+	case 1:
+		addr = SH_DMARS_BASE;
+		break;
+	/* DMARS1 */
+	case 2:
+	case 3:
+		addr = (SH_DMARS_BASE + DMARS1_ADDR);
+		break;
+	/* DMARS2 */
+	case 4:
+	case 5:
+		addr = (SH_DMARS_BASE + DMARS2_ADDR);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ctrl_outw((val << shift) |
+		(ctrl_inw(addr) & (shift ? 0xFF00 : 0x00FF)),
+		addr);
+
+	return 0;
+}
+
+static dma_cookie_t sh_dmae_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct sh_desc *desc = tx_to_sh_desc(tx);
+	struct sh_dmae_chan *sh_chan = to_sh_chan(tx->chan);
+	dma_cookie_t cookie;
+
+	spin_lock_bh(&sh_chan->desc_lock);
+
+	cookie = sh_chan->common.cookie;
+	cookie++;
+	if (cookie < 0)
+		cookie = 1;
+
+	/* If desc only in the case of 1 */
+	if (desc->async_tx.cookie != -EBUSY)
+		desc->async_tx.cookie = cookie;
+	sh_chan->common.cookie = desc->async_tx.cookie;
+
+	list_splice_init(&desc->async_tx.tx_list, sh_chan->ld_queue.prev);
+
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	return cookie;
+}
+
+static struct sh_desc *sh_dmae_get_desc(struct sh_dmae_chan *sh_chan)
+{
+	struct sh_desc *desc, *_desc, *ret = NULL;
+
+	spin_lock_bh(&sh_chan->desc_lock);
+	list_for_each_entry_safe(desc, _desc, &sh_chan->ld_free, node) {
+		if (async_tx_test_ack(&desc->async_tx)) {
+			list_del(&desc->node);
+			ret = desc;
+			break;
+		}
+	}
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	return ret;
+}
+
+static void sh_dmae_put_desc(struct sh_dmae_chan *sh_chan, struct sh_desc *desc)
+{
+	if (desc) {
+		spin_lock_bh(&sh_chan->desc_lock);
+
+		list_splice_init(&desc->async_tx.tx_list, &sh_chan->ld_free);
+		list_add(&desc->node, &sh_chan->ld_free);
+
+		spin_unlock_bh(&sh_chan->desc_lock);
+	}
+}
+
+static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
+	struct sh_desc *desc;
+
+	spin_lock_bh(&sh_chan->desc_lock);
+	while (sh_chan->descs_allocated < NR_DESCS_PER_CHANNEL) {
+		spin_unlock_bh(&sh_chan->desc_lock);
+		desc = kzalloc(sizeof(struct sh_desc), GFP_KERNEL);
+		if (!desc) {
+			spin_lock_bh(&sh_chan->desc_lock);
+			break;
+		}
+		dma_async_tx_descriptor_init(&desc->async_tx,
+					&sh_chan->common);
+		desc->async_tx.tx_submit = sh_dmae_tx_submit;
+		desc->async_tx.flags = DMA_CTRL_ACK;
+		INIT_LIST_HEAD(&desc->async_tx.tx_list);
+		sh_dmae_put_desc(sh_chan, desc);
+
+		spin_lock_bh(&sh_chan->desc_lock);
+		sh_chan->descs_allocated++;
+	}
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	return sh_chan->descs_allocated;
+}
+
+/*
+ * sh_dma_free_chan_resources - Free all resources of the channel.
+ */
+static void sh_dmae_free_chan_resources(struct dma_chan *chan)
+{
+	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
+	struct sh_desc *desc, *_desc;
+	LIST_HEAD(list);
+
+	BUG_ON(!list_empty(&sh_chan->ld_queue));
+	spin_lock_bh(&sh_chan->desc_lock);
+
+	list_splice_init(&sh_chan->ld_free, &list);
+	sh_chan->descs_allocated = 0;
+
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	list_for_each_entry_safe(desc, _desc, &list, node)
+		kfree(desc);
+}
+
+static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
+	struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
+	size_t len, unsigned long flags)
+{
+	struct sh_dmae_chan *sh_chan;
+	struct sh_desc *first = NULL, *prev = NULL, *new;
+	size_t copy_size;
+
+	if (!chan)
+		return NULL;
+
+	if (!len)
+		return NULL;
+
+	sh_chan = to_sh_chan(chan);
+
+	do {
+		/* Allocate the link descriptor from DMA pool */
+		new = sh_dmae_get_desc(sh_chan);
+		if (!new) {
+			dev_err(sh_chan->dev,
+					"No free memory for link descriptor\n");
+			goto err_get_desc;
+		}
+
+		copy_size = min(len, (size_t)SH_DMA_TCR_MAX);
+
+		new->hw.sar = dma_src;
+		new->hw.dar = dma_dest;
+		new->hw.tcr = copy_size;
+		if (!first)
+			first = new;
+
+		new->mark = DESC_NCOMP;
+		async_tx_ack(&new->async_tx);
+
+		prev = new;
+		len -= copy_size;
+		dma_src += copy_size;
+		dma_dest += copy_size;
+		/* Insert the link descriptor to the LD ring */
+		list_add_tail(&new->node, &first->async_tx.tx_list);
+	} while (len);
+
+	new->async_tx.flags = flags; /* client is in control of this ack */
+	new->async_tx.cookie = -EBUSY; /* Last desc */
+
+	return &first->async_tx;
+
+err_get_desc:
+	sh_dmae_put_desc(sh_chan, first);
+	return NULL;
+
+}
+
+/*
+ * sh_chan_ld_cleanup - Clean up link descriptors
+ *
+ * This function clean up the ld_queue of DMA channel.
+ */
+static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan)
+{
+	struct sh_desc *desc, *_desc;
+
+	spin_lock_bh(&sh_chan->desc_lock);
+	list_for_each_entry_safe(desc, _desc, &sh_chan->ld_queue, node) {
+		dma_async_tx_callback callback;
+		void *callback_param;
+
+		/* non send data */
+		if (desc->mark = DESC_NCOMP)
+			break;
+
+		/* send data sesc */
+		callback = desc->async_tx.callback;
+		callback_param = desc->async_tx.callback_param;
+
+		/* Remove from ld_queue list */
+		list_splice_init(&desc->async_tx.tx_list, &sh_chan->ld_free);
+
+		dev_dbg(sh_chan->dev, "link descriptor %p will be recycle.\n",
+				desc);
+
+		list_move(&desc->node, &sh_chan->ld_free);
+		/* Run the link descriptor callback function */
+		if (callback) {
+			spin_unlock_bh(&sh_chan->desc_lock);
+			dev_dbg(sh_chan->dev, "link descriptor %p callback\n",
+					desc);
+			callback(callback_param);
+			spin_lock_bh(&sh_chan->desc_lock);
+		}
+	}
+	spin_unlock_bh(&sh_chan->desc_lock);
+}
+
+static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
+{
+	struct list_head *ld_node;
+	struct sh_dmae_regs hw;
+
+	/* DMA work check */
+	if (dmae_is_idle(sh_chan))
+		return;
+
+	/* Find the first un-transfer desciptor */
+	for (ld_node = sh_chan->ld_queue.next;
+		(ld_node != &sh_chan->ld_queue)
+			&& (to_sh_desc(ld_node)->mark = DESC_COMP);
+		ld_node = ld_node->next)
+		cpu_relax();
+
+	if (ld_node != &sh_chan->ld_queue) {
+		/* Get the ld start address from ld_queue */
+		hw = to_sh_desc(ld_node)->hw;
+		dmae_set_reg(sh_chan, hw);
+		dmae_start(sh_chan);
+	}
+}
+
+static void sh_dmae_memcpy_issue_pending(struct dma_chan *chan)
+{
+	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
+	sh_chan_xfer_ld_queue(sh_chan);
+}
+
+static enum dma_status sh_dmae_is_complete(struct dma_chan *chan,
+					dma_cookie_t cookie,
+					dma_cookie_t *done,
+					dma_cookie_t *used)
+{
+	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+
+	sh_dmae_chan_ld_cleanup(sh_chan);
+
+	last_used = chan->cookie;
+	last_complete = sh_chan->completed_cookie;
+	if (last_complete = -EBUSY)
+		last_complete = last_used;
+
+	if (done)
+		*done = last_complete;
+
+	if (used)
+		*used = last_used;
+
+	return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+static irqreturn_t sh_dmae_interrupt(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+	struct sh_dmae_chan *sh_chan = (struct sh_dmae_chan *)data;
+	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+
+	if (chcr & CHCR_TE) {
+		/* DMA stop */
+		dmae_halt(sh_chan);
+
+		ret = IRQ_HANDLED;
+		tasklet_schedule(&sh_chan->tasklet);
+	}
+
+	return ret;
+}
+
+#if defined(CONFIG_CPU_SH4)
+static irqreturn_t sh_dmae_err(int irq, void *data)
+{
+	int err = 0;
+	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
+
+	/* IRQ Multi */
+	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+		int cnt = 0;
+		switch (irq) {
+#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
+		case DMTE6_IRQ:
+			cnt++;
+#endif
+		case DMTE0_IRQ:
+			if (dmaor_read_reg(cnt) & (DMAOR_NMIF | DMAOR_AE)) {
+				disable_irq(irq);
+				return IRQ_HANDLED;
+			}
+		default:
+			return IRQ_NONE;
+		}
+	} else {
+		/* reset dma controller */
+		err = sh_dmae_rst(0);
+		if (err)
+			return err;
+		if (shdev->pdata.mode & SHDMA_DMAOR1) {
+			err = sh_dmae_rst(1);
+			if (err)
+				return err;
+		}
+		disable_irq(irq);
+		return IRQ_HANDLED;
+	}
+}
+#endif
+
+static void dmae_do_tasklet(unsigned long data)
+{
+	struct sh_dmae_chan *sh_chan = (struct sh_dmae_chan *)data;
+	struct sh_desc *desc, *_desc, *cur_desc = NULL;
+	u32 sar_buf = sh_dmae_readl(sh_chan, SAR);
+	list_for_each_entry_safe(desc, _desc,
+					&sh_chan->ld_queue, node) {
+		if ((desc->hw.sar + desc->hw.tcr) = sar_buf) {
+			cur_desc = desc;
+			break;
+		}
+	}
+
+	if (cur_desc) {
+		switch (cur_desc->async_tx.cookie) {
+		case 0: /* other desc data */
+			break;
+		case -EBUSY: /* last desc */
+		sh_chan->completed_cookie +				cur_desc->async_tx.cookie;
+			break;
+		default: /* first desc ( 0 < )*/
+			sh_chan->completed_cookie +				cur_desc->async_tx.cookie - 1;
+			break;
+		}
+		cur_desc->mark = DESC_COMP;
+	}
+	/* Next desc */
+	sh_chan_xfer_ld_queue(sh_chan);
+	sh_dmae_chan_ld_cleanup(sh_chan);
+}
+
+static unsigned int get_dmae_irq(unsigned int id)
+{
+	unsigned int irq = 0;
+	if (id < ARRAY_SIZE(dmte_irq_map))
+		irq = dmte_irq_map[id];
+	return irq;
+}
+
+static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
+{
+	int err;
+	unsigned int irq = get_dmae_irq(id);
+	unsigned long irqflags = IRQF_DISABLED;
+	struct sh_dmae_chan *new_sh_chan;
+
+	/* alloc channel */
+	new_sh_chan = kzalloc(sizeof(struct sh_dmae_chan), GFP_KERNEL);
+	if (!new_sh_chan) {
+		dev_err(shdev->common.dev, "No free memory for allocating "
+				"dma channels!\n");
+		return -ENOMEM;
+	}
+
+	new_sh_chan->dev = shdev->common.dev;
+	new_sh_chan->id = id;
+
+	/* Init DMA tasklet */
+	tasklet_init(&new_sh_chan->tasklet, dmae_do_tasklet,
+			(unsigned long)new_sh_chan);
+
+	/* Init the channel */
+	dmae_init(new_sh_chan);
+
+	spin_lock_init(&new_sh_chan->desc_lock);
+
+	/* Init descripter manage list */
+	INIT_LIST_HEAD(&new_sh_chan->ld_queue);
+	INIT_LIST_HEAD(&new_sh_chan->ld_free);
+
+	/* copy struct dma_device */
+	new_sh_chan->common.device = &shdev->common;
+
+	/* Add the channel to DMA device channel list */
+	list_add_tail(&new_sh_chan->common.device_node,
+			&shdev->common.channels);
+	shdev->common.chancnt++;
+
+	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+		irqflags = IRQF_SHARED;
+#if defined(DMTE6_IRQ)
+		if (irq >= DMTE6_IRQ)
+			irq = DMTE6_IRQ;
+		else
+#endif
+			irq = DMTE0_IRQ;
+	}
+
+	snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
+			"sh-dmae%d", new_sh_chan->id);
+
+	/* set up channel irq */
+	err = request_irq(irq, &sh_dmae_interrupt,
+		irqflags, new_sh_chan->dev_id, new_sh_chan);
+	if (err) {
+		dev_err(shdev->common.dev, "DMA channel %d request_irq error "
+			"with return %d\n", id, err);
+		goto err_no_irq;
+	}
+
+	/* CHCR register control function */
+	new_sh_chan->set_chcr = dmae_set_chcr;
+	/* DMARS register control function */
+	new_sh_chan->set_dmars = dmae_set_dmars;
+
+	shdev->chan[id] = new_sh_chan;
+	return 0;
+
+err_no_irq:
+	/* remove from dmaengine device node */
+	list_del(&new_sh_chan->common.device_node);
+	kfree(new_sh_chan);
+	return err;
+}
+
+static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
+{
+	int i;
+
+	for (i = shdev->common.chancnt - 1 ; i >= 0 ; i--) {
+		if (shdev->chan[i]) {
+			struct sh_dmae_chan *shchan = shdev->chan[i];
+			if (!(shdev->pdata.mode & SHDMA_MIX_IRQ))
+				free_irq(dmte_irq_map[i], shchan);
+
+			list_del(&shchan->common.device_node);
+			kfree(shchan);
+			shdev->chan[i] = NULL;
+		}
+	}
+	shdev->common.chancnt = 0;
+}
+
+static int __init sh_dmae_probe(struct platform_device *pdev)
+{
+	int err = 0, cnt, ecnt;
+	unsigned long irqflags = IRQF_DISABLED;
+#if defined(CONFIG_CPU_SH4)
+	int eirq[] = { DMAE0_IRQ,
+#if defined(DMAE1_IRQ)
+			DMAE1_IRQ
+#endif
+		};
+#endif
+	struct sh_dmae_device *shdev;
+
+	shdev = kzalloc(sizeof(struct sh_dmae_device), GFP_KERNEL);
+	if (!shdev) {
+		dev_err(&pdev->dev, "No enough memory\n");
+		err = -ENOMEM;
+		goto shdev_err;
+	}
+
+	/* get platform data */
+	if (!pdev->dev.platform_data)
+		goto shdev_err;
+
+	/* platform data */
+	memcpy(&shdev->pdata, pdev->dev.platform_data,
+			sizeof(struct sh_dmae_pdata));
+
+	/* reset dma controller */
+	err = sh_dmae_rst(0);
+	if (err)
+		goto rst_err;
+
+	/* SH7780/85/23 has DMAOR1 */
+	if (shdev->pdata.mode & SHDMA_DMAOR1) {
+		err = sh_dmae_rst(1);
+		if (err)
+			goto rst_err;
+	}
+
+	INIT_LIST_HEAD(&shdev->common.channels);
+
+	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
+	shdev->common.device_alloc_chan_resources
+		= sh_dmae_alloc_chan_resources;
+	shdev->common.device_free_chan_resources = sh_dmae_free_chan_resources;
+	shdev->common.device_prep_dma_memcpy = sh_dmae_prep_memcpy;
+	shdev->common.device_is_tx_complete = sh_dmae_is_complete;
+	shdev->common.device_issue_pending = sh_dmae_memcpy_issue_pending;
+	shdev->common.dev = &pdev->dev;
+
+#if defined(CONFIG_CPU_SH4)
+	/* Non Mix IRQ mode SH7722/SH7730 etc... */
+	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+		irqflags = IRQF_SHARED;
+		eirq[0] = DMTE0_IRQ;
+#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
+		eirq[1] = DMTE6_IRQ;
+#endif
+	}
+
+	for (ecnt = 0 ; ecnt < ARRAY_SIZE(eirq); ecnt++) {
+		err = request_irq(eirq[ecnt], sh_dmae_err,
+			irqflags, "DMAC Address Error", shdev);
+		if (err) {
+			dev_err(&pdev->dev, "DMA device request_irq"
+				"error (irq %d) with return %d\n",
+				eirq[ecnt], err);
+			goto eirq_err;
+		}
+	}
+#endif /* CONFIG_CPU_SH4 */
+
+	/* Create DMA Channel */
+	for (cnt = 0 ; cnt < MAX_DMA_CHANNELS ; cnt++) {
+		err = sh_dmae_chan_probe(shdev, cnt);
+		if (err)
+			goto chan_probe_err;
+	}
+
+	platform_set_drvdata(pdev, shdev);
+	dma_async_device_register(&shdev->common);
+
+	return err;
+
+chan_probe_err:
+	sh_dmae_chan_remove(shdev);
+
+eirq_err:
+	for (ecnt-- ; ecnt >= 0; ecnt--)
+		free_irq(eirq[ecnt], shdev);
+
+rst_err:
+	kfree(shdev);
+
+shdev_err:
+	return err;
+}
+
+static int __exit sh_dmae_remove(struct platform_device *pdev)
+{
+	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+
+	dma_async_device_unregister(&shdev->common);
+
+	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+		free_irq(DMTE0_IRQ, shdev);
+#if defined(DMTE6_IRQ)
+		free_irq(DMTE6_IRQ, shdev);
+#endif
+	}
+
+	/* channel data remove */
+	sh_dmae_chan_remove(shdev);
+
+	if (!(shdev->pdata.mode & SHDMA_MIX_IRQ)) {
+		free_irq(DMAE0_IRQ, shdev);
+#if defined(DMAE1_IRQ)
+		free_irq(DMAE1_IRQ, shdev);
+#endif
+	}
+	kfree(shdev);
+
+	return 0;
+}
+
+static void sh_dmae_shutdown(struct platform_device *pdev)
+{
+	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+	sh_dmae_ctl_stop(0);
+	if (shdev->pdata.mode & SHDMA_DMAOR1)
+		sh_dmae_ctl_stop(1);
+}
+
+static struct platform_driver sh_dmae_driver = {
+	.remove		= __exit_p(sh_dmae_remove),
+	.shutdown	= sh_dmae_shutdown,
+	.driver = {
+		.name	= "sh-dma-engine",
+	},
+};
+
+static int __init sh_dmae_init(void)
+{
+	return platform_driver_probe(&sh_dmae_driver, sh_dmae_probe);
+}
+module_init(sh_dmae_init);
+
+static void __exit sh_dmae_exit(void)
+{
+	platform_driver_unregister(&sh_dmae_driver);
+}
+module_exit(sh_dmae_exit);
+
+MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>");
+MODULE_DESCRIPTION("Renesas SH DMA Engine driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
new file mode 100644
index 0000000..c93555c
--- /dev/null
+++ b/drivers/dma/shdma.h
@@ -0,0 +1,63 @@
+/*
+ * Renesas SuperH DMA Engine support
+ *
+ * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
+ * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __DMA_SHDMA_H
+#define __DMA_SHDMA_H
+
+#include <linux/device.h>
+#include <linux/dmapool.h>
+#include <linux/dmaengine.h>
+
+#define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
+
+struct sh_dmae_regs {
+	u32 sar; /* SAR / source address */
+	u32 dar; /* DAR / destination address */
+	u32 tcr; /* TCR / transfer count */
+};
+
+struct sh_desc {
+	struct sh_dmae_regs hw;
+	struct list_head node;
+	struct dma_async_tx_descriptor async_tx;
+	int mark;
+};
+
+struct sh_dmae_chan {
+	dma_cookie_t completed_cookie;	/* The maximum cookie completed */
+	spinlock_t desc_lock;			/* Descriptor operation lock */
+	struct list_head ld_queue;		/* Link descriptors queue */
+	struct list_head ld_free;		/* Link descriptors free */
+	struct dma_chan common;			/* DMA common channel */
+	struct device *dev;				/* Channel device */
+	struct tasklet_struct tasklet;	/* Tasklet */
+	int descs_allocated;			/* desc count */
+	int id;				/* Raw id of this channel */
+	char dev_id[16];	/* unique name per DMAC of channel */
+
+	/* Set chcr */
+	int (*set_chcr)(struct sh_dmae_chan *sh_chan, u32 regs);
+	/* Set DMA resource */
+	int (*set_dmars)(struct sh_dmae_chan *sh_chan, u16 res);
+};
+
+struct sh_dmae_device {
+	struct dma_device common;
+	struct sh_dmae_chan *chan[MAX_DMA_CHANNELS];
+	struct sh_dmae_pdata pdata;
+};
+
+#define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
+#define to_sh_desc(lh) container_of(lh, struct sh_desc, node)
+#define tx_to_sh_desc(tx) container_of(tx, struct sh_desc, async_tx)
+
+#endif	/* __DMA_SHDMA_H */
-- 
1.6.3.3



