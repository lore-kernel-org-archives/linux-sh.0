From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 01 Feb 2010 19:05:53 +0000
Subject: [PATCH 3/3 v2] sh: implement DMA_SLAVE capability in SH dmaengine
Message-Id: <Pine.LNX.4.64.1002012003350.4617@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190825120.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190825120.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Tested to work with a SIU ASoC driver on sh7722 (migor).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:
1. no real changes, just rebased to new CHCR_TS_{LOW,HIGH}_{MASK,SHIFT} 
   names

 arch/sh/include/asm/dma-sh.h           |   41 +++++++-
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |   15 ++-
 drivers/dma/shdma.c                    |  190 ++++++++++++++++++++++++--------
 drivers/dma/shdma.h                    |    7 +-
 4 files changed, 192 insertions(+), 61 deletions(-)

diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 01d2fc7..c8d8ce7 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -64,8 +64,10 @@ static int dmte_irq_map[] __maybe_unused = {
 #define ACK_L	0x00010000
 #define DM_INC	0x00004000
 #define DM_DEC	0x00008000
+#define DM_FIX	0x0000c000
 #define SM_INC	0x00001000
 #define SM_DEC	0x00002000
+#define SM_FIX	0x00003000
 #define RS_IN	0x00000200
 #define RS_OUT	0x00000300
 #define TS_BLK	0x00000040
@@ -123,10 +125,47 @@ static u32 dma_base_addr[] __maybe_unused = {
  */
 #define SHDMA_MIX_IRQ	(1 << 1)
 #define SHDMA_DMAOR1	(1 << 2)
-#define SHDMA_DMAE1		(1 << 3)
+#define SHDMA_DMAE1	(1 << 3)
+
+enum sh_dmae_slave_chan_id {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SIUA_TX,
+	SHDMA_SLAVE_SIUA_RX,
+	SHDMA_SLAVE_SIUB_TX,
+	SHDMA_SLAVE_SIUB_RX,
+	SHDMA_SLAVE_NUMBER,	/* Must stay last */
+};
+
+struct sh_dmae_slave_config {
+	enum sh_dmae_slave_chan_id	slave_id;
+	dma_addr_t			addr;
+	u32				chcr;
+	char				mid_rid;
+};
 
 struct sh_dmae_pdata {
 	unsigned int mode;
+	struct sh_dmae_slave_config *config;
+	int config_num;
+};
+
+struct device;
+
+struct sh_dmae_slave {
+	enum sh_dmae_slave_chan_id	slave_id; /* Set by the platform */
+	struct device			*dma_dev; /* Set by the platform */
+	struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
 
 #endif /* __DMA_SH_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index cc1cf3e..e734ea4 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -7,7 +7,7 @@
 #define DMTE4_IRQ	76
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
-#define SH_DMARS_BASE	0xFE009000
+#define SH_DMARS_BASE0	0xFE009000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
@@ -17,7 +17,7 @@
 #define DMTE4_IRQ	76
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
-#define SH_DMARS_BASE	0xFE009000
+#define SH_DMARS_BASE0	0xFE009000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0x00300000
@@ -28,7 +28,7 @@
 #define DMTE4_IRQ	44
 #define DMAE0_IRQ	38
 #define SH_DMAC_BASE0	0xFF608020
-#define SH_DMARS_BASE	0xFF609000
+#define SH_DMARS_BASE0	0xFF609000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
@@ -45,7 +45,7 @@
 #define DMAE1_IRQ	74	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMAC_BASE1	0xFDC08020
-#define SH_DMARS_BASE	0xFDC09000
+#define SH_DMARS_BASE0	0xFDC09000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
@@ -62,7 +62,8 @@
 #define DMAE1_IRQ	74	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMAC_BASE1	0xFDC08020
-#define SH_DMARS_BASE	0xFDC09000
+#define SH_DMARS_BASE0	0xFE009000
+#define SH_DMARS_BASE1	0xFDC09000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0x00600000
@@ -78,7 +79,7 @@
 #define DMAE0_IRQ	38	/* DMA Error IRQ */
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFC818020
-#define SH_DMARS_BASE	0xFC809000
+#define SH_DMARS_BASE0	0xFC809000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
@@ -95,7 +96,7 @@
 #define DMAE1_IRQ	58	/* DMA Error IRQ1 */
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFCC08020
-#define SH_DMARS_BASE	0xFC809000
+#define SH_DMARS_BASE0	0xFC809000
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 3e1037c..9837a50 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -48,6 +48,9 @@ enum sh_dmae_desc_status {
  */
 #define RS_DEFAULT  (RS_DUAL)
 
+/* A bitmask with bits enough for enum sh_dmae_slave_chan_id */
+static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SHDMA_SLAVE_NUMBER)];
+
 static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
 
 #define SH_DMAC_CHAN_BASE(id) (dma_base_addr[id])
@@ -61,12 +64,6 @@ static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 	return ctrl_inl(SH_DMAC_CHAN_BASE(sh_dc->id) + reg);
 }
 
-static void dmae_init(struct sh_dmae_chan *sh_chan)
-{
-	u32 chcr = RS_DEFAULT; /* default is DUAL mode */
-	sh_dmae_writel(sh_chan, chcr, CHCR);
-}
-
 /*
  * Reset DMA controller
  *
@@ -106,9 +103,8 @@ static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 }
 
 static unsigned int ts_shift[] = TS_SHIFT;
-static inline unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan)
+static inline unsigned int calc_xmit_shift(u32 chcr)
 {
-	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
 	int cnt = ((chcr & CHCR_TS_LOW_MASK) >> CHCR_TS_LOW_SHIFT) |
 		((chcr & CHCR_TS_HIGH_MASK) >> CHCR_TS_HIGH_SHIFT);
 
@@ -119,7 +115,7 @@ static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
 {
 	sh_dmae_writel(sh_chan, hw->sar, SAR);
 	sh_dmae_writel(sh_chan, hw->dar, DAR);
-	sh_dmae_writel(sh_chan, hw->tcr >> calc_xmit_shift(sh_chan), TCR);
+	sh_dmae_writel(sh_chan, hw->tcr >> sh_chan->xmit_shift, TCR);
 }
 
 static void dmae_start(struct sh_dmae_chan *sh_chan)
@@ -127,7 +123,7 @@ static void dmae_start(struct sh_dmae_chan *sh_chan)
 	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
 
 	chcr |= CHCR_DE | CHCR_IE;
-	sh_dmae_writel(sh_chan, chcr, CHCR);
+	sh_dmae_writel(sh_chan, chcr & ~CHCR_TE, CHCR);
 }
 
 static void dmae_halt(struct sh_dmae_chan *sh_chan)
@@ -138,20 +134,27 @@ static void dmae_halt(struct sh_dmae_chan *sh_chan)
 	sh_dmae_writel(sh_chan, chcr, CHCR);
 }
 
+static void dmae_init(struct sh_dmae_chan *sh_chan)
+{
+	u32 chcr = RS_DEFAULT; /* default is DUAL mode */
+	sh_chan->xmit_shift = calc_xmit_shift(chcr);
+	sh_dmae_writel(sh_chan, chcr, CHCR);
+}
+
 static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 {
 	/* When DMA was working, can not set data to CHCR */
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
+	sh_chan->xmit_shift = calc_xmit_shift(val);
 	sh_dmae_writel(sh_chan, val, CHCR);
+
 	return 0;
 }
 
-#define DMARS1_ADDR	0x04
-#define DMARS2_ADDR	0x08
-#define DMARS_SHIFT 8
-#define DMARS_CHAN_MSK 0x01
+#define DMARS_SHIFT	8
+#define DMARS_CHAN_MSK	0x01
 static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 {
 	u32 addr;
@@ -163,29 +166,18 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	if (sh_chan->id & DMARS_CHAN_MSK)
 		shift = DMARS_SHIFT;
 
-	switch (sh_chan->id) {
-	/* DMARS0 */
-	case 0:
-	case 1:
-		addr = SH_DMARS_BASE;
-		break;
-	/* DMARS1 */
-	case 2:
-	case 3:
-		addr = (SH_DMARS_BASE + DMARS1_ADDR);
-		break;
-	/* DMARS2 */
-	case 4:
-	case 5:
-		addr = (SH_DMARS_BASE + DMARS2_ADDR);
-		break;
-	default:
+	if (sh_chan->id < 6)
+		/* DMA0RS0 - DMA0RS2 */
+		addr = SH_DMARS_BASE0 + (sh_chan->id / 2) * 4;
+#ifdef SH_DMARS_BASE1
+	else if (sh_chan->id < 12)
+		/* DMA1RS0 - DMA1RS2 */
+		addr = SH_DMARS_BASE1 + ((sh_chan->id - 6) / 2) * 4;
+#endif
+	else
 		return -EINVAL;
-	}
 
-	ctrl_outw((val << shift) |
-		(ctrl_inw(addr) & (shift ? 0xFF00 : 0x00FF)),
-		addr);
+	ctrl_outw((val << shift) | (ctrl_inw(addr) & (0xFF00 >> shift)), addr);
 
 	return 0;
 }
@@ -253,10 +245,53 @@ static struct sh_desc *sh_dmae_get_desc(struct sh_dmae_chan *sh_chan)
 	return NULL;
 }
 
+static struct sh_dmae_slave_config *sh_dmae_find_slave(
+	struct sh_dmae_chan *sh_chan, enum sh_dmae_slave_chan_id slave_id)
+{
+	struct dma_device *dma_dev = sh_chan->common.device;
+	struct sh_dmae_device *shdev = container_of(dma_dev,
+					struct sh_dmae_device, common);
+	struct sh_dmae_pdata *pdata = &shdev->pdata;
+	int i;
+
+	if ((unsigned)slave_id >= SHDMA_SLAVE_NUMBER)
+		return NULL;
+
+	for (i = 0; i < pdata->config_num; i++)
+		if (pdata->config[i].slave_id = slave_id)
+			return pdata->config + i;
+
+	return NULL;
+}
+
 static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
 	struct sh_desc *desc;
+	struct sh_dmae_slave *param = chan->private;
+
+	/*
+	 * Called under dma_list_mutex, take care to perform all slave channel
+	 * ID manipulations under that lock.
+	 */
+	if (param) {
+		struct sh_dmae_slave_config *cfg;
+
+		cfg = sh_dmae_find_slave(sh_chan, param->slave_id);
+		if (!cfg)
+			return -EINVAL;
+
+		if (test_and_set_bit(param->slave_id, sh_dmae_slave_used))
+			return -EBUSY;
+
+		param->config = cfg;
+
+		dmae_set_dmars(sh_chan, cfg->mid_rid);
+		dmae_set_chcr(sh_chan, cfg->chcr);
+	} else {
+		if ((sh_dmae_readl(sh_chan, CHCR) & 0x700) != 0x400)
+			dmae_set_chcr(sh_chan, RS_DEFAULT);
+	}
 
 	spin_lock_bh(&sh_chan->desc_lock);
 	while (sh_chan->descs_allocated < NR_DESCS_PER_CHANNEL) {
@@ -289,10 +324,18 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 	struct sh_desc *desc, *_desc;
 	LIST_HEAD(list);
 
+	dmae_halt(sh_chan);
+
 	/* Prepared and not submitted descriptors can still be on the queue */
 	if (!list_empty(&sh_chan->ld_queue))
 		sh_dmae_chan_ld_cleanup(sh_chan, true);
 
+	if (chan->private) {
+		/* The caller is holding dma_list_mutex */
+		struct sh_dmae_slave *param = chan->private;
+		clear_bit(param->slave_id, sh_dmae_slave_used);
+	}
+
 	spin_lock_bh(&sh_chan->desc_lock);
 
 	list_splice_init(&sh_chan->ld_free, &list);
@@ -304,7 +347,7 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 		kfree(desc);
 }
 
-/*
+/**
  * sh_dmae_add_desc - get, set up and return one transfer descriptor
  * @sh_chan:	DMA channel
  * @flags:	DMA transfer flags
@@ -351,12 +394,14 @@ static struct sh_desc *sh_dmae_add_desc(struct sh_dmae_chan *sh_chan,
 		new->async_tx.cookie = -EINVAL;
 	}
 
-	dev_dbg(sh_chan->dev, "chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
+	dev_dbg(sh_chan->dev,
+		"chaining (%u/%u)@%x -> %x with %p, cookie %d, shift %d\n",
 		copy_size, *len, *src, *dest, &new->async_tx,
-		new->async_tx.cookie);
+		new->async_tx.cookie, sh_chan->xmit_shift);
 
 	new->mark = DESC_PREPARED;
 	new->async_tx.flags = flags;
+	new->direction = direction;
 
 	*len -= copy_size;
 	if (direction = DMA_BIDIRECTIONAL || direction = DMA_TO_DEVICE)
@@ -465,6 +510,8 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
 	if (!chan || !len)
 		return NULL;
 
+	chan->private = NULL;
+
 	sh_chan = to_sh_chan(chan);
 
 	sg_init_table(&sg, 1);
@@ -477,6 +524,44 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
 			       flags);
 }
 
+static struct dma_async_tx_descriptor *sh_dmae_prep_slave_sg(
+	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_data_direction direction, unsigned long flags)
+{
+	struct sh_dmae_slave *param;
+	struct sh_dmae_chan *sh_chan;
+
+	if (!chan)
+		return NULL;
+
+	sh_chan = to_sh_chan(chan);
+	param = chan->private;
+
+	/* Someone calling slave DMA on a public channel? */
+	if (!param || !sg_len) {
+		dev_warn(sh_chan->dev, "%s: bad parameter: %p, %d, %d\n",
+			 __func__, param, sg_len, param ? param->slave_id : -1);
+		return NULL;
+	}
+
+	/*
+	 * if (param != NULL), this is a successfully requested slave channel,
+	 * therefore param->config != NULL too.
+	 */
+	return sh_dmae_prep_sg(sh_chan, sgl, sg_len, &param->config->addr,
+			       direction, flags);
+}
+
+static void sh_dmae_terminate_all(struct dma_chan *chan)
+{
+	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
+
+	if (!chan)
+		return;
+
+	sh_dmae_chan_ld_cleanup(sh_chan, true);
+}
+
 static dma_async_tx_callback __ld_cleanup(struct sh_dmae_chan *sh_chan, bool all)
 {
 	struct sh_desc *desc, *_desc;
@@ -508,7 +593,11 @@ static dma_async_tx_callback __ld_cleanup(struct sh_dmae_chan *sh_chan, bool all
 			cookie = tx->cookie;
 
 		if (desc->mark = DESC_COMPLETED && desc->chunks = 1) {
-			BUG_ON(sh_chan->completed_cookie != desc->cookie - 1);
+			if (sh_chan->completed_cookie != desc->cookie - 1)
+				dev_dbg(sh_chan->dev,
+					"Completing cookie %d, expected %d\n",
+					desc->cookie,
+					sh_chan->completed_cookie + 1);
 			sh_chan->completed_cookie = desc->cookie;
 		}
 
@@ -581,7 +670,7 @@ static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 		return;
 	}
 
-	/* Find the first un-transfer desciptor */
+	/* Find the first not transferred desciptor */
 	list_for_each_entry(sd, &sh_chan->ld_queue, node)
 		if (sd->mark = DESC_SUBMITTED) {
 			/* Get the ld start address from ld_queue */
@@ -685,11 +774,14 @@ static void dmae_do_tasklet(unsigned long data)
 	struct sh_dmae_chan *sh_chan = (struct sh_dmae_chan *)data;
 	struct sh_desc *desc;
 	u32 sar_buf = sh_dmae_readl(sh_chan, SAR);
+	u32 dar_buf = sh_dmae_readl(sh_chan, DAR);
 
 	spin_lock(&sh_chan->desc_lock);
 	list_for_each_entry(desc, &sh_chan->ld_queue, node) {
-		if ((desc->hw.sar + desc->hw.tcr) = sar_buf &&
-		    desc->mark = DESC_SUBMITTED) {
+		if (desc->mark = DESC_SUBMITTED &&
+		    ((desc->direction = DMA_FROM_DEVICE &&
+		      (desc->hw.dar + desc->hw.tcr) = dar_buf) ||
+		     (desc->hw.sar + desc->hw.tcr) = sar_buf)) {
 			dev_dbg(sh_chan->dev, "done #%d@%p dst %u\n",
 				desc->async_tx.cookie, &desc->async_tx,
 				desc->hw.dar);
@@ -762,7 +854,7 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 	}
 
 	snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
-			"sh-dmae%d", new_sh_chan->id);
+		 "sh-dmae%d", new_sh_chan->id);
 
 	/* set up channel irq */
 	err = request_irq(irq, &sh_dmae_interrupt, irqflags,
@@ -773,11 +865,6 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 		goto err_no_irq;
 	}
 
-	/* CHCR register control function */
-	new_sh_chan->set_chcr = dmae_set_chcr;
-	/* DMARS register control function */
-	new_sh_chan->set_dmars = dmae_set_dmars;
-
 	shdev->chan[id] = new_sh_chan;
 	return 0;
 
@@ -848,12 +935,19 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&shdev->common.channels);
 
 	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
+	dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
+
 	shdev->common.device_alloc_chan_resources
 		= sh_dmae_alloc_chan_resources;
 	shdev->common.device_free_chan_resources = sh_dmae_free_chan_resources;
 	shdev->common.device_prep_dma_memcpy = sh_dmae_prep_memcpy;
 	shdev->common.device_is_tx_complete = sh_dmae_is_complete;
 	shdev->common.device_issue_pending = sh_dmae_memcpy_issue_pending;
+
+	/* Compulsory for DMA_SLAVE fields */
+	shdev->common.device_prep_slave_sg = sh_dmae_prep_slave_sg;
+	shdev->common.device_terminate_all = sh_dmae_terminate_all;
+
 	shdev->common.dev = &pdev->dev;
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
 	shdev->common.copy_align = 5;
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 108f1cf..7e227f3 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -29,6 +29,7 @@ struct sh_desc {
 	struct sh_dmae_regs hw;
 	struct list_head node;
 	struct dma_async_tx_descriptor async_tx;
+	enum dma_data_direction direction;
 	dma_cookie_t cookie;
 	int chunks;
 	int mark;
@@ -45,13 +46,9 @@ struct sh_dmae_chan {
 	struct device *dev;		/* Channel device */
 	struct tasklet_struct tasklet;	/* Tasklet */
 	int descs_allocated;		/* desc count */
+	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	int id;				/* Raw id of this channel */
 	char dev_id[16];		/* unique name per DMAC of channel */
-
-	/* Set chcr */
-	int (*set_chcr)(struct sh_dmae_chan *sh_chan, u32 regs);
-	/* Set DMA resource */
-	int (*set_dmars)(struct sh_dmae_chan *sh_chan, u16 res);
 };
 
 struct sh_dmae_device {
-- 
1.6.2.4

