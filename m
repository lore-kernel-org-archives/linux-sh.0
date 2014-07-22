From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:50 +0000
Subject: [PATCH/RFC 4/5] dmaengine: rcar-dmac: Implement support for hardware descriptor lists
Message-Id: <1406032431-3807-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DMAC supports hardware-based auto-configuration from descriptor
lists. This reduces the number of interrupts required for processing a
DMA transfer. Support that mode in the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 283 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 235 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 371cca3..14606dd 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
@@ -41,6 +42,19 @@ struct rcar_dmac_xfer_chunk {
 };
 
 /*
+ * struct rcar_dmac_hw_desc - Hardware descriptor for a transfer chunk
+ * @sar: value of the SAR register (source address)
+ * @dar: value of the DAR register (destination address)
+ * @tcr: value of the TCR register (transfer count)
+ */
+struct rcar_dmac_hw_desc {
+	u32 sar;
+	u32 dar;
+	u32 tcr;
+	u32 reserved;
+} __attribute__((__packed__));
+
+/*
  * struct rcar_dmac_desc - R-Car Gen2 DMA Transfer Descriptor
  * @async_tx: base DMA asynchronous transaction descriptor
  * @direction: direction of the DMA transfer
@@ -49,6 +63,10 @@ struct rcar_dmac_xfer_chunk {
  * @node: entry in the channel's descriptors lists
  * @chunks: list of transfer chunks for this transfer
  * @running: the transfer chunk being currently processed
+ * @nchunks: number of transfer chunks for this transfer
+ * @hwdescs.mem: hardware descriptors memory for the transfer
+ * @hwdescs.dma: device address of the hardware descriptors memory
+ * @hwdescs.size: size of the hardware descriptors in bytes
  * @size: transfer size in bytes
  * @cyclic: when set indicates that the DMA transfer is cyclic
  */
@@ -61,6 +79,13 @@ struct rcar_dmac_desc {
 	struct list_head node;
 	struct list_head chunks;
 	struct rcar_dmac_xfer_chunk *running;
+	unsigned int nchunks;
+
+	struct {
+		struct rcar_dmac_hw_desc *mem;
+		dma_addr_t dma;
+		size_t size;
+	} hwdescs;
 
 	size_t size;
 	bool cyclic;
@@ -221,7 +246,8 @@ struct rcar_dmac {
 #define RCAR_DMATSRB			0x0038
 #define RCAR_DMACHCRB			0x001c
 #define RCAR_DMACHCRB_DCNT(n)		((n) << 24)
-#define RCAR_DMACHCRB_DPTR(n)		((n) << 16)
+#define RCAR_DMACHCRB_DPTR_MASK		(0xff << 16)
+#define RCAR_DMACHCRB_DPTR_SHIFT	16
 #define RCAR_DMACHCRB_DRST		(1 << 15)
 #define RCAR_DMACHCRB_DTS		(1 << 8)
 #define RCAR_DMACHCRB_SLM_NORMAL	(0 << 4)
@@ -293,30 +319,75 @@ static bool rcar_dmac_chan_is_busy(struct rcar_dmac_chan *chan)
 static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
-	struct rcar_dmac_xfer_chunk *chunk = desc->running;
-
-	dev_dbg(chan->chan.device->dev,
-		"chan%u: queue chunk %p: %u@%pad -> %pad\n",
-		chan->index, chunk, chunk->size, &chunk->src_addr,
-		&chunk->dst_addr);
+	u32 chcr = desc->chcr;
 
 	WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan));
 
+	if (chan->mid_rid >= 0)
+		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
+
+	if (desc->hwdescs.mem) {
+		dev_dbg(chan->chan.device->dev,
+			"chan%u: queue desc %p: %u@%pad\n",
+			chan->index, desc, desc->nchunks, &desc->hwdescs.dma);
+
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	rcar_dmac_chan_write(chan, RCAR_DMAFIXSAR, chunk->src_addr >> 32);
-	rcar_dmac_chan_write(chan, RCAR_DMAFIXDAR, chunk->dst_addr >> 32);
+		rcar_dmac_chan_write(chan, RCAR_DMAFIXDPBASE,
+				     desc->hwdescs.dma >> 32);
 #endif
-	rcar_dmac_chan_write(chan, RCAR_DMASAR, chunk->src_addr & 0xffffffff);
-	rcar_dmac_chan_write(chan, RCAR_DMADAR, chunk->dst_addr & 0xffffffff);
+		rcar_dmac_chan_write(chan, RCAR_DMADPBASE,
+				     (desc->hwdescs.dma & 0xfffffff0) |
+				     RCAR_DMADPBASE_SEL);
+		rcar_dmac_chan_write(chan, RCAR_DMACHCRB,
+				     RCAR_DMACHCRB_DCNT(desc->nchunks - 1) |
+				     RCAR_DMACHCRB_DRST);
 
-	if (chan->mid_rid >= 0)
-		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
+		chcr |= RCAR_DMACHCR_RPT_SAR | RCAR_DMACHCR_RPT_DAR
+		     |  RCAR_DMACHCR_RPT_TCR | RCAR_DMACHCR_DPB;
 
-	rcar_dmac_chan_write(chan, RCAR_DMATCR,
-			     chunk->size >> desc->xfer_shift);
+		/*
+		 * If the descriptor isn't cyclic enable normal descriptor mode
+		 * and the transfer completion interrupt.
+		 */
+		if (!desc->cyclic)
+			chcr |= RCAR_DMACHCR_DPM_ENABLED | RCAR_DMACHCR_IE;
+		/*
+		 * If the descriptor is cyclic and has a callback enable the
+		 * descriptor stage interrupt in infinite repeat mode.
+		 */
+		else if (desc->async_tx.callback)
+			chcr |= RCAR_DMACHCR_DPM_INFINITE | RCAR_DMACHCR_DSIE;
+		/*
+		 * Otherwise just select infinite repeat mode without any
+		 * interrupt.
+		 */
+		else
+			chcr |= RCAR_DMACHCR_DPM_INFINITE;
+	} else {
+		struct rcar_dmac_xfer_chunk *chunk = desc->running;
+
+		dev_dbg(chan->chan.device->dev,
+			"chan%u: queue chunk %p: %u@%pad -> %pad\n",
+			chan->index, chunk, chunk->size, &chunk->src_addr,
+			&chunk->dst_addr);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		rcar_dmac_chan_write(chan, RCAR_DMAFIXSAR,
+				     chunk->src_addr >> 32);
+		rcar_dmac_chan_write(chan, RCAR_DMAFIXDAR,
+				     chunk->dst_addr >> 32);
+#endif
+		rcar_dmac_chan_write(chan, RCAR_DMASAR,
+				     chunk->src_addr & 0xffffffff);
+		rcar_dmac_chan_write(chan, RCAR_DMADAR,
+				     chunk->dst_addr & 0xffffffff);
+		rcar_dmac_chan_write(chan, RCAR_DMATCR,
+				     chunk->size >> desc->xfer_shift);
+
+		chcr |= RCAR_DMACHCR_DPM_DISABLED | RCAR_DMACHCR_IE;
+	}
 
-	rcar_dmac_chan_write(chan, RCAR_DMACHCR, desc->chcr | RCAR_DMACHCR_DE |
-			     RCAR_DMACHCR_IE);
+	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr | RCAR_DMACHCR_DE);
 }
 
 static int rcar_dmac_init(struct rcar_dmac *dmac)
@@ -417,31 +488,58 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
  * @desc: the descriptor
  *
  * Put the descriptor and its transfer chunk descriptors back in the channel's
- * free descriptors lists. The descriptor's chunk will be reinitialized to an
- * empty list as a result.
+ * free descriptors lists, and free the hardware descriptors list memory. The
+ * descriptor's chunks list will be reinitialized to an empty list as a result.
  *
- * The descriptor must have been removed from the channel's done list before
- * calling this function.
+ * The descriptor must have been removed from the channel's lists before calling
+ * this function.
  *
- * Locking: Must be called with the channel lock held.
+ * Locking: Must be called in non-atomic context.
  */
 static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 			       struct rcar_dmac_desc *desc)
 {
+	if (desc->hwdescs.mem) {
+		dma_free_coherent(NULL, desc->hwdescs.size, desc->hwdescs.mem,
+				  desc->hwdescs.dma);
+		desc->hwdescs.mem = NULL;
+	}
+
+	spin_lock_irq(&chan->lock);
 	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
 	list_add_tail(&desc->node, &chan->desc.free);
+	spin_unlock_irq(&chan->lock);
 }
 
 static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc, *_desc;
+	LIST_HEAD(list);
+
+	/*
+	 * We have to temporarily move all descriptors from the wait list to a
+	 * local list as iterating over the wait list, even with
+	 * list_for_each_entry_safe, isn't safe if we release the channel lock
+	 * around the rcar_dmac_desc_put() call.
+	 */
+	spin_lock_irq(&chan->lock);
+	list_splice_init(&chan->desc.wait, &list);
+	spin_unlock_irq(&chan->lock);
 
-	list_for_each_entry_safe(desc, _desc, &chan->desc.wait, node) {
+	list_for_each_entry_safe(desc, _desc, &list, node) {
 		if (async_tx_test_ack(&desc->async_tx)) {
 			list_del(&desc->node);
 			rcar_dmac_desc_put(chan, desc);
 		}
 	}
+
+	if (list_empty(&list))
+		return;
+
+	/* Put the remaining descriptors back in the wait list. */
+	spin_lock_irq(&chan->lock);
+	list_splice(&list, &chan->desc.wait);
+	spin_unlock_irq(&chan->lock);
 }
 
 /*
@@ -458,11 +556,11 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 	struct rcar_dmac_desc *desc;
 	int ret;
 
-	spin_lock_irq(&chan->lock);
-
 	/* Recycle acked descriptors before attempting allocation. */
 	rcar_dmac_desc_recycle_acked(chan);
 
+	spin_lock_irq(&chan->lock);
+
 	do {
 		if (list_empty(&chan->desc.free)) {
 			/*
@@ -560,6 +658,28 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 	return chunk;
 }
 
+static void rcar_dmac_alloc_hwdesc(struct rcar_dmac_chan *chan,
+				   struct rcar_dmac_desc *desc)
+{
+	struct rcar_dmac_xfer_chunk *chunk;
+	struct rcar_dmac_hw_desc *hwdesc;
+	size_t size = desc->nchunks * sizeof(*hwdesc);
+
+	hwdesc = dma_alloc_coherent(NULL, size, &desc->hwdescs.dma, GFP_KERNEL);
+	if (!hwdesc)
+		return;
+
+	desc->hwdescs.mem = hwdesc;
+	desc->hwdescs.size = size;
+
+	list_for_each_entry(chunk, &desc->chunks, node) {
+		hwdesc->sar = chunk->src_addr;
+		hwdesc->dar = chunk->dst_addr;
+		hwdesc->tcr = chunk->size >> desc->xfer_shift;
+		hwdesc++;
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * Stop and reset
  */
@@ -700,8 +820,10 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 	struct rcar_dmac_xfer_chunk *chunk;
 	struct rcar_dmac_desc *desc;
 	struct scatterlist *sg = sgl;
+	unsigned int nchunks = 0;
 	size_t max_chunk_size;
 	size_t full_size = 0;
+	bool highmem = false;
 	unsigned int i;
 
 	desc = rcar_dmac_desc_get(chan);
@@ -740,6 +862,14 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 				size = ALIGN(dev_addr, 1ULL << 32) - dev_addr;
 			if (mem_addr >> 32 != (mem_addr + size - 1) >> 32)
 				size = ALIGN(mem_addr, 1ULL << 32) - mem_addr;
+
+			/*
+			 * Check if either of the source or destination address
+			 * can't be expressed on 32 bits. If so we can't use
+			 * hardware descriptors lists.
+			 */
+			if (dev_addr >> 32 || mem_addr >> 32)
+				highmem = true;
 #endif
 
 			chunk = rcar_dmac_xfer_chunk_get(chan);
@@ -770,11 +900,26 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 			len -= size;
 
 			list_add_tail(&chunk->node, &desc->chunks);
+			nchunks++;
 		}
 	}
 
+	desc->nchunks = nchunks;
 	desc->size = full_size;
 
+	/*
+	 * Use hardware descriptor lists if possible when more than one chunk
+	 * needs to be transferred (otherwise they don't make much sense).
+	 *
+	 * The highmem check currently covers the whole transfer. As an
+	 * optimization we could use descriptor lists for consecutive lowmem
+	 * chunks and direct manual mode for highmem chunks. Whether the
+	 * performance improvement would be significant enough compared to the
+	 * additional complexity remains to be studied.
+	 */
+	if (!highmem && nchunks > 1)
+		rcar_dmac_alloc_hwdesc(chan, desc);
+
 	return &desc->async_tx;
 }
 
@@ -965,7 +1110,9 @@ static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 					 dma_cookie_t cookie)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
+	struct rcar_dmac_xfer_chunk *running = NULL;
 	struct rcar_dmac_xfer_chunk *chunk;
+	unsigned int dptr = 0;
 	size_t residue = 0;
 
 	if (!desc)
@@ -979,9 +1126,23 @@ static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 	if (cookie != desc->async_tx.cookie)
 		return desc->size;
 
+	/*
+	 * In descriptor more the descriptor running pointer is not maintained
+	 * by the interrupt handler, find the running descriptor from the
+	 * descriptor pointer field in the CHCRB register. In non-descriptor
+	 * mode just use the running descriptor pointer.
+	 */
+	if (desc->hwdescs.mem) {
+		dptr = (rcar_dmac_chan_read(chan, RCAR_DMACHCRB) &
+			RCAR_DMACHCRB_DPTR_MASK) >> RCAR_DMACHCRB_DPTR_SHIFT;
+		WARN_ON(dptr >= desc->nchunks);
+	} else {
+		running = desc->running;
+	}
+
 	/* Compute the size of all chunks still to be transferred. */
 	list_for_each_entry_reverse(chunk, &desc->chunks, node) {
-		if (chunk = desc->running)
+		if (chunk = running || ++dptr = desc->nchunks)
 			break;
 
 		residue += chunk->size;
@@ -1069,42 +1230,65 @@ static int rcar_dmac_slave_caps(struct dma_chan *chan,
  * IRQ handling
  */
 
+static irqreturn_t rcar_dmac_isr_desc_stage_end(struct rcar_dmac_chan *chan)
+{
+	struct rcar_dmac_desc *desc = chan->desc.running;
+
+	if (WARN_ON(!desc || !desc->cyclic)) {
+		/*
+		 * This should never happen, there should always be a running
+		 * cyclic descriptor when a descriptor stage end interrupt is
+		 * triggered. Warn and return.
+		 */
+		return IRQ_NONE;
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
-	struct rcar_dmac_xfer_chunk *chunk;
 	irqreturn_t ret = IRQ_WAKE_THREAD;
 
 	if (WARN_ON(!desc)) {
 		/*
-		 * This should never happen, there should always be
-		 * a running descriptor when a transfer ends. Warn and
-		 * return.
+		 * This should never happen, there should always be a running
+		 * descriptor when a transfer end interrupt is triggered. Warn
+		 * and return.
 		 */
 		return IRQ_NONE;
 	}
 
 	/*
-	 * If we haven't completed the last transfer chunk simply move to the
-	 * next one. Only wake the IRQ thread if the transfer is cyclic.
+	 * The transfer end interrupt isn't generated for each chunk when using
+	 * descriptor mode. Only update the running chunk pointer in
+	 * non-descriptor mode.
 	 */
-	chunk = desc->running;
-	if (!list_is_last(&chunk->node, &desc->chunks)) {
-		desc->running = list_next_entry(chunk, node);
-		if (!desc->cyclic)
-			ret = IRQ_HANDLED;
-		goto done;
-	}
+	if (!desc->hwdescs.mem) {
+		/*
+		 * If we haven't completed the last transfer chunk simply move
+		 * to the next one. Only wake the IRQ thread if the transfer is
+		 * cyclic.
+		 */
+		if (!list_is_last(&desc->running->node, &desc->chunks)) {
+			desc->running = list_next_entry(desc->running, node);
+			if (!desc->cyclic)
+				ret = IRQ_HANDLED;
+			goto done;
+		}
 
-	/*
-	 * We've completed the last transfer chunk. If the transfer is cyclic,
-	 * move back to the first one.
-	 */
-	if (desc->cyclic) {
-		desc->running = list_first_entry(&desc->chunks,
+		/*
+		 * We've completed the last transfer chunk. If the transfer is
+		 * cyclic, move back to the first one.
+		 */
+		if (desc->cyclic) {
+			desc->running +				list_first_entry(&desc->chunks,
 						 struct rcar_dmac_xfer_chunk,
 						 node);
-		goto done;
+			goto done;
+		}
 	}
 
 	/* The descriptor is complete, move it to the done list. */
@@ -1142,6 +1326,9 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR,
 			     chcr & ~(RCAR_DMACHCR_TE | RCAR_DMACHCR_DE));
 
+	if (chcr & RCAR_DMACHCR_DSE)
+		ret |= rcar_dmac_isr_desc_stage_end(chan);
+
 	if (chcr & RCAR_DMACHCR_TE)
 		ret |= rcar_dmac_isr_transfer_end(chan);
 
@@ -1197,11 +1384,11 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 		list_add_tail(&desc->node, &chan->desc.wait);
 	}
 
+	spin_unlock_irq(&chan->lock);
+
 	/* Recycle all acked descriptors. */
 	rcar_dmac_desc_recycle_acked(chan);
 
-	spin_unlock_irq(&chan->lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
1.8.5.5

