From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 07:24:55 +0000
Subject: [PATCH 1/3 v2] sh: prepare the DMA driver for slave functionality
Message-Id: <Pine.LNX.4.64.1001190810530.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Slave DMA functionality uses scatter-gather arrays for data transfers, 
whereas memcpy just uses a single data buffer. This patch converts the 
current memcpy implementation in shdma.c to use scatter-gather, making it 
just a special case with one SG-element. This allows us to isolate 
descriptor list manipulations and locking into one function, thus reducing 
error chances.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
On Thu, 7 Jan 2010, Dan Williams wrote:

> Guennadi Liakhovetski wrote:
> > Slightly clean up and prepare for slave DMA the shdma driver.
> 
> Please add some notes about the why/what of factoring out sh_dmae_prep_sg()
> and sh_dmae_add_desc() .  Reading this changelog I was expecting primarily
> simple cleanups, with maybe a few function renames.
> 
> Otherwise looks ok to me.

v1 -> v2: improve patch description. The patch content remains unchanged. 
Dan, does it look acceptable now?

 drivers/dma/shdma.c |  221 +++++++++++++++++++++++++++++++++++----------------
 1 files changed, 153 insertions(+), 68 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index d10cc89..427c3ef 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -53,12 +53,12 @@ static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
 #define SH_DMAC_CHAN_BASE(id) (dma_base_addr[id])
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
 {
-	ctrl_outl(data, (SH_DMAC_CHAN_BASE(sh_dc->id) + reg));
+	ctrl_outl(data, SH_DMAC_CHAN_BASE(sh_dc->id) + reg);
 }
 
 static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 {
-	return ctrl_inl((SH_DMAC_CHAN_BASE(sh_dc->id) + reg));
+	return ctrl_inl(SH_DMAC_CHAN_BASE(sh_dc->id) + reg);
 }
 
 static void dmae_init(struct sh_dmae_chan *sh_chan)
@@ -95,14 +95,14 @@ static int sh_dmae_rst(int id)
 	return 0;
 }
 
-static int dmae_is_busy(struct sh_dmae_chan *sh_chan)
+static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 {
 	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
-	if (chcr & CHCR_DE) {
-		if (!(chcr & CHCR_TE))
-			return -EBUSY; /* working */
-	}
-	return 0; /* waiting */
+
+	if ((chcr & (CHCR_DE | CHCR_TE)) = CHCR_DE)
+		return true; /* working */
+
+	return false; /* waiting */
 }
 
 static inline unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan)
@@ -136,10 +136,9 @@ static void dmae_halt(struct sh_dmae_chan *sh_chan)
 
 static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 {
-	int ret = dmae_is_busy(sh_chan);
 	/* When DMA was working, can not set data to CHCR */
-	if (ret)
-		return ret;
+	if (dmae_is_busy(sh_chan))
+		return -EBUSY;
 
 	sh_dmae_writel(sh_chan, val, CHCR);
 	return 0;
@@ -153,9 +152,9 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 {
 	u32 addr;
 	int shift = 0;
-	int ret = dmae_is_busy(sh_chan);
-	if (ret)
-		return ret;
+
+	if (dmae_is_busy(sh_chan))
+		return -EBUSY;
 
 	if (sh_chan->id & DMARS_CHAN_MSK)
 		shift = DMARS_SHIFT;
@@ -301,23 +300,95 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 		kfree(desc);
 }
 
-static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
-	struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
-	size_t len, unsigned long flags)
+/*
+ * sh_dmae_add_desc - get, set up and return one transfer descriptor
+ * @sh_chan:	DMA channel
+ * @flags:	DMA transfer flags
+ * @dest:	destination DMA address, incremented when direction equals
+ *		DMA_FROM_DEVICE or DMA_BIDIRECTIONAL
+ * @src:	source DMA address, incremented when direction equals
+ *		DMA_TO_DEVICE or DMA_BIDIRECTIONAL
+ * @len:	DMA transfer length
+ * @first:	if NULL, set to the current descriptor and cookie set to -EBUSY
+ * @direction:	needed for slave DMA to decide which address to keep constant,
+ *		equals DMA_BIDIRECTIONAL for MEMCPY
+ * Returns 0 or an error
+ * Locks: called with desc_lock held
+ */
+static struct sh_desc *sh_dmae_add_desc(struct sh_dmae_chan *sh_chan,
+	unsigned long flags, dma_addr_t *dest, dma_addr_t *src, size_t *len,
+	struct sh_desc **first, enum dma_data_direction direction)
 {
-	struct sh_dmae_chan *sh_chan;
-	struct sh_desc *first = NULL, *prev = NULL, *new;
+	struct sh_desc *new;
 	size_t copy_size;
-	LIST_HEAD(tx_list);
-	int chunks = (len + SH_DMA_TCR_MAX) / (SH_DMA_TCR_MAX + 1);
 
-	if (!chan)
+	if (!*len)
 		return NULL;
 
-	if (!len)
+	/* Allocate the link descriptor from the free list */
+	new = sh_dmae_get_desc(sh_chan);
+	if (!new) {
+		dev_err(sh_chan->dev, "No free link descriptor available\n");
 		return NULL;
+	}
 
-	sh_chan = to_sh_chan(chan);
+	copy_size = min(*len, (size_t)SH_DMA_TCR_MAX + 1);
+
+	new->hw.sar = *src;
+	new->hw.dar = *dest;
+	new->hw.tcr = copy_size;
+
+	if (!*first) {
+		/* First desc */
+		new->async_tx.cookie = -EBUSY;
+		*first = new;
+	} else {
+		/* Other desc - invisible to the user */
+		new->async_tx.cookie = -EINVAL;
+	}
+
+	dev_dbg(sh_chan->dev, "chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
+		copy_size, *len, *src, *dest, &new->async_tx,
+		new->async_tx.cookie);
+
+	new->mark = DESC_PREPARED;
+	new->async_tx.flags = flags;
+
+	*len -= copy_size;
+	if (direction = DMA_BIDIRECTIONAL || direction = DMA_TO_DEVICE)
+		*src += copy_size;
+	if (direction = DMA_BIDIRECTIONAL || direction = DMA_FROM_DEVICE)
+		*dest += copy_size;
+
+	return new;
+}
+
+/*
+ * sh_dmae_prep_sg - prepare transfer descriptors from an SG list
+ *
+ * Common routine for public (MEMCPY) and slave DMA. The MEMCPY case is also
+ * converted to scatter-gather to guarantee consistent locking and a correct
+ * list manipulation. For slave DMA direction carries the usual meaning, and,
+ * logically, the SG list is RAM and the addr variable contains slave address,
+ * e.g., the FIFO I/O register. For MEMCPY direction equals DMA_BIDIRECTIONAL
+ * and the SG list contains only one element and points at the source buffer.
+ */
+static struct dma_async_tx_descriptor *sh_dmae_prep_sg(struct sh_dmae_chan *sh_chan,
+	struct scatterlist *sgl, unsigned int sg_len, dma_addr_t *addr,
+	enum dma_data_direction direction, unsigned long flags)
+{
+	struct scatterlist *sg;
+	struct sh_desc *first = NULL, *new = NULL /* compiler... */;
+	LIST_HEAD(tx_list);
+	int chunks = 0;
+	int i;
+
+	if (!sg_len)
+		return NULL;
+
+	for_each_sg(sgl, sg, sg_len, i)
+		chunks += (sg_dma_len(sg) + SH_DMA_TCR_MAX) /
+			(SH_DMA_TCR_MAX + 1);
 
 	/* Have to lock the whole loop to protect against concurrent release */
 	spin_lock_bh(&sh_chan->desc_lock);
@@ -333,49 +404,32 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
 	 *	only during this function, then they are immediately spliced
 	 *	back onto the free list in form of a chain
 	 */
-	do {
-		/* Allocate the link descriptor from the free list */
-		new = sh_dmae_get_desc(sh_chan);
-		if (!new) {
-			dev_err(sh_chan->dev,
-				"No free memory for link descriptor\n");
-			list_for_each_entry(new, &tx_list, node)
-				new->mark = DESC_IDLE;
-			list_splice(&tx_list, &sh_chan->ld_free);
-			spin_unlock_bh(&sh_chan->desc_lock);
-			return NULL;
-		}
-
-		copy_size = min(len, (size_t)SH_DMA_TCR_MAX + 1);
-
-		new->hw.sar = dma_src;
-		new->hw.dar = dma_dest;
-		new->hw.tcr = copy_size;
-		if (!first) {
-			/* First desc */
-			new->async_tx.cookie = -EBUSY;
-			first = new;
-		} else {
-			/* Other desc - invisible to the user */
-			new->async_tx.cookie = -EINVAL;
-		}
-
-		dev_dbg(sh_chan->dev,
-			"chaining %u of %u with %p, dst %x, cookie %d\n",
-			copy_size, len, &new->async_tx, dma_dest,
-			new->async_tx.cookie);
-
-		new->mark = DESC_PREPARED;
-		new->async_tx.flags = flags;
-		new->chunks = chunks--;
-
-		prev = new;
-		len -= copy_size;
-		dma_src += copy_size;
-		dma_dest += copy_size;
-		/* Insert the link descriptor to the LD ring */
-		list_add_tail(&new->node, &tx_list);
-	} while (len);
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t sg_addr = sg_dma_address(sg);
+		size_t len = sg_dma_len(sg);
+
+		if (!len)
+			goto err_get_desc;
+
+		do {
+			dev_dbg(sh_chan->dev, "Add SG #%d@%p[%d], dma %llx\n",
+				i, sg, len, (unsigned long long)sg_addr);
+
+			if (direction = DMA_FROM_DEVICE)
+				new = sh_dmae_add_desc(sh_chan, flags,
+						&sg_addr, addr, &len, &first,
+						direction);
+			else
+				new = sh_dmae_add_desc(sh_chan, flags,
+						addr, &sg_addr, &len, &first,
+						direction);
+			if (!new)
+				goto err_get_desc;
+
+			new->chunks = chunks--;
+			list_add_tail(&new->node, &tx_list);
+		} while (len);
+	}
 
 	if (new != first)
 		new->async_tx.cookie = -ENOSPC;
@@ -386,6 +440,37 @@ static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
 	spin_unlock_bh(&sh_chan->desc_lock);
 
 	return &first->async_tx;
+
+err_get_desc:
+	list_for_each_entry(new, &tx_list, node)
+		new->mark = DESC_IDLE;
+	list_splice(&tx_list, &sh_chan->ld_free);
+
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
+	struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
+	size_t len, unsigned long flags)
+{
+	struct sh_dmae_chan *sh_chan;
+	struct scatterlist sg;
+
+	if (!chan || !len)
+		return NULL;
+
+	sh_chan = to_sh_chan(chan);
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, pfn_to_page(PFN_DOWN(dma_src)), len,
+		    offset_in_page(dma_src));
+	sg_dma_address(&sg) = dma_src;
+	sg_dma_len(&sg) = len;
+
+	return sh_dmae_prep_sg(sh_chan, &sg, 1, &dma_dest, DMA_BIDIRECTIONAL,
+			       flags);
 }
 
 static dma_async_tx_callback __ld_cleanup(struct sh_dmae_chan *sh_chan, bool all)
@@ -559,7 +644,7 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 
 	/* IRQ Multi */
 	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		int cnt = 0;
+		int __maybe_unused cnt = 0;
 		switch (irq) {
 #if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
 		case DMTE6_IRQ:
-- 
1.6.2.4

