From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:47 +0000
Subject: [PATCH/RFC 1/5] dmaengine: rcar-dmac: Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
Message-Id: <1406032431-3807-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The structure models a chunk of a DMA transfer. Rename it accordingly.
The "hw" name will be used to model hardware descriptors.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 156 ++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 45ae37e..0cc6e0d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -26,13 +26,13 @@
 #include "../dmaengine.h"
 
 /*
- * struct rcar_dmac_hw_desc - Descriptor for a single hardware transfer
- * @node: entry in the parent's hwdesc list
+ * struct rcar_dmac_xfer_chunk - Descriptor for a hardware transfer
+ * @node: entry in the parent's chunks list
  * @src_addr: device source address
  * @dst_addr: device destination address
  * @size: transfer size in bytes
  */
-struct rcar_dmac_hw_desc {
+struct rcar_dmac_xfer_chunk {
 	struct list_head node;
 
 	dma_addr_t src_addr;
@@ -47,8 +47,8 @@ struct rcar_dmac_hw_desc {
  * @xfer_shift: log2 of the transfer size
  * @chcr: value of the channel configuration register for this transfer
  * @node: entry in the channel's descriptors lists
- * @hwdescs: list of hardware descriptors for this transfer
- * @running: the hardware transfer being currently processed
+ * @chunks: list of transfer chunks for this transfer
+ * @running: the transfer chunk being currently processed
  * @size: transfer size in bytes
  * @cyclic: when set indicates that the DMA transfer is cyclic
  */
@@ -59,8 +59,8 @@ struct rcar_dmac_desc {
 	u32 chcr;
 
 	struct list_head node;
-	struct list_head hwdescs;
-	struct rcar_dmac_hw_desc *running;
+	struct list_head chunks;
+	struct rcar_dmac_xfer_chunk *running;
 
 	size_t size;
 	bool cyclic;
@@ -72,23 +72,23 @@ struct rcar_dmac_desc {
  * struct rcar_dmac_desc_page - One page worth of descriptors
  * @node: entry in the channel's pages list
  * @descs: array of DMA descriptors
- * @hwdescs: array of hardware descriptors
+ * @chunks: array of transfer chunk descriptors
  */
 struct rcar_dmac_desc_page {
 	struct list_head node;
 
 	union {
 		struct rcar_dmac_desc descs[0];
-		struct rcar_dmac_hw_desc hwdescs[0];
+		struct rcar_dmac_xfer_chunk chunks[0];
 	};
 };
 
 #define RCAR_DMAC_DESCS_PER_PAGE					\
 	((PAGE_SIZE - offsetof(struct rcar_dmac_desc_page, descs)) /	\
 	sizeof(struct rcar_dmac_desc))
-#define RCAR_DMAC_HWDESCS_PER_PAGE					\
-	((PAGE_SIZE - offsetof(struct rcar_dmac_desc_page, hwdescs)) /	\
-	sizeof(struct rcar_dmac_hw_desc))
+#define RCAR_DMAC_XFER_CHUNKS_PER_PAGE					\
+	((PAGE_SIZE - offsetof(struct rcar_dmac_desc_page, chunks)) /	\
+	sizeof(struct rcar_dmac_xfer_chunk))
 
 /*
  * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
@@ -108,7 +108,7 @@ struct rcar_dmac_desc_page {
  * @desc.wait: list of descriptors waiting for an ack
  * @desc.running: the descriptor being processed (a member of the active list)
  * @desc.submitted: number of descriptors submitted and not complete yet
- * @desc.hw_free: list of free hardware descriptors
+ * @desc.chunks_free: list of free transfer chunk descriptors
  * @desc.pages: list of pages used by allocated descriptors
  */
 struct rcar_dmac_chan {
@@ -133,7 +133,7 @@ struct rcar_dmac_chan {
 		struct rcar_dmac_desc *running;
 		unsigned int submitted;
 
-		struct list_head hw_free;
+		struct list_head chunks_free;
 
 		struct list_head pages;
 	} desc;
@@ -294,27 +294,27 @@ static bool rcar_dmac_chan_is_busy(struct rcar_dmac_chan *chan)
 static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
-	struct rcar_dmac_hw_desc *hwdesc = desc->running;
+	struct rcar_dmac_xfer_chunk *chunk = desc->running;
 
 	dev_dbg(chan->chan.device->dev,
-		"chan%u: queue hwdesc %p: %u@%pad -> %pad\n",
-		chan->index, hwdesc, hwdesc->size, &hwdesc->src_addr,
-		&hwdesc->dst_addr);
+		"chan%u: queue chunk %p: %u@%pad -> %pad\n",
+		chan->index, chunk, chunk->size, &chunk->src_addr,
+		&chunk->dst_addr);
 
 	WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan));
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	rcar_dmac_chan_write(chan, RCAR_DMAFIXSAR, hwdesc->src_addr >> 32);
-	rcar_dmac_chan_write(chan, RCAR_DMAFIXDAR, hwdesc->dst_addr >> 32);
+	rcar_dmac_chan_write(chan, RCAR_DMAFIXSAR, chunk->src_addr >> 32);
+	rcar_dmac_chan_write(chan, RCAR_DMAFIXDAR, chunk->dst_addr >> 32);
 #endif
-	rcar_dmac_chan_write(chan, RCAR_DMASAR, hwdesc->src_addr & 0xffffffff);
-	rcar_dmac_chan_write(chan, RCAR_DMADAR, hwdesc->dst_addr & 0xffffffff);
+	rcar_dmac_chan_write(chan, RCAR_DMASAR, chunk->src_addr & 0xffffffff);
+	rcar_dmac_chan_write(chan, RCAR_DMADAR, chunk->dst_addr & 0xffffffff);
 
 	if (chan->mid_rid >= 0)
 		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
 
 	rcar_dmac_chan_write(chan, RCAR_DMATCR,
-			     hwdesc->size >> desc->xfer_shift);
+			     chunk->size >> desc->xfer_shift);
 
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR, desc->chcr | RCAR_DMACHCR_DE |
 			     RCAR_DMACHCR_IE);
@@ -360,8 +360,8 @@ static dma_cookie_t rcar_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
 		chan->index, tx->cookie, desc);
 
 	list_add_tail(&desc->node, &chan->desc.pending);
-	desc->running = list_first_entry(&desc->hwdescs,
-					 struct rcar_dmac_hw_desc, node);
+	desc->running = list_first_entry(&desc->chunks,
+					 struct rcar_dmac_xfer_chunk, node);
 
 	/* Resume the device when submitting the first descriptor. */
 	resume = chan->desc.submitted++ = 0;
@@ -399,7 +399,7 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
 
 		dma_async_tx_descriptor_init(&desc->async_tx, &chan->chan);
 		desc->async_tx.tx_submit = rcar_dmac_tx_submit;
-		INIT_LIST_HEAD(&desc->hwdescs);
+		INIT_LIST_HEAD(&desc->chunks);
 
 		list_add_tail(&desc->node, &list);
 	}
@@ -417,9 +417,9 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
  * @chan: the DMA channel
  * @desc: the descriptor
  *
- * Put the descriptor and its hardware descriptors back in the channel's free
- * descriptors lists. The descriptor's hwdesc will be reinitialized to an empty
- * list as a result.
+ * Put the descriptor and its transfer chunk descriptors back in the channel's
+ * free descriptors lists. The descriptor's chunk will be reinitialized to an
+ * empty list as a result.
  *
  * The descriptor must have been removed from the channel's done list before
  * calling this function.
@@ -429,7 +429,7 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
 static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 			       struct rcar_dmac_desc *desc)
 {
-	list_splice_tail_init(&desc->hwdescs, &chan->desc.hw_free);
+	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
 	list_add_tail(&desc->node, &chan->desc.free);
 }
 
@@ -491,10 +491,10 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 }
 
 /*
- * rcar_dmac_hw_desc_alloc - Allocate a page worth of hardware descriptors
+ * rcar_dmac_xfer_chunk_alloc - Allocate a page worth of transfer chunks
  * @chan: the DMA channel
  */
-static int rcar_dmac_hw_desc_alloc(struct rcar_dmac_chan *chan)
+static int rcar_dmac_xfer_chunk_alloc(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc_page *page;
 	LIST_HEAD(list);
@@ -504,14 +504,14 @@ static int rcar_dmac_hw_desc_alloc(struct rcar_dmac_chan *chan)
 	if (!page)
 		return -ENOMEM;
 
-	for (i = 0; i < RCAR_DMAC_HWDESCS_PER_PAGE; ++i) {
-		struct rcar_dmac_hw_desc *hwdesc = &page->hwdescs[i];
+	for (i = 0; i < RCAR_DMAC_XFER_CHUNKS_PER_PAGE; ++i) {
+		struct rcar_dmac_xfer_chunk *chunk = &page->chunks[i];
 
-		list_add_tail(&hwdesc->node, &list);
+		list_add_tail(&chunk->node, &list);
 	}
 
 	spin_lock_irq(&chan->lock);
-	list_splice_tail(&list, &chan->desc.hw_free);
+	list_splice_tail(&list, &chan->desc.chunks_free);
 	list_add_tail(&page->node, &chan->desc.pages);
 	spin_unlock_irq(&chan->lock);
 
@@ -519,24 +519,24 @@ static int rcar_dmac_hw_desc_alloc(struct rcar_dmac_chan *chan)
 }
 
 /*
- * rcar_dmac_hw_desc_get - Allocate a hardware descriptor for a DMA transfer
+ * rcar_dmac_xfer_chunk_get - Allocate a transfer chunk for a DMA transfer
  * @chan: the DMA channel
  *
  * Locking: This function must be called in a non-atomic context.
  *
- * Return: A pointer to the allocated hardware descriptor or NULL if no
+ * Return: A pointer to the allocated transfer chunk descriptor or NULL if no
  * descriptor can be allocated.
  */
-static struct rcar_dmac_hw_desc *
-rcar_dmac_hw_desc_get(struct rcar_dmac_chan *chan)
+static struct rcar_dmac_xfer_chunk *
+rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 {
-	struct rcar_dmac_hw_desc *hwdesc;
+	struct rcar_dmac_xfer_chunk *chunk;
 	int ret;
 
 	spin_lock_irq(&chan->lock);
 
 	do {
-		if (list_empty(&chan->desc.hw_free)) {
+		if (list_empty(&chan->desc.chunks_free)) {
 			/*
 			 * No free descriptors, allocate a page worth of them
 			 * and try again, as someone else could race us to get
@@ -544,21 +544,21 @@ rcar_dmac_hw_desc_get(struct rcar_dmac_chan *chan)
 			 * fails return an error.
 			 */
 			spin_unlock_irq(&chan->lock);
-			ret = rcar_dmac_hw_desc_alloc(chan);
+			ret = rcar_dmac_xfer_chunk_alloc(chan);
 			if (ret < 0)
 				return NULL;
 			spin_lock_irq(&chan->lock);
 			continue;
 		}
 
-		hwdesc = list_first_entry(&chan->desc.hw_free,
-					  struct rcar_dmac_hw_desc, node);
-		list_del(&hwdesc->node);
-	} while (!hwdesc);
+		chunk = list_first_entry(&chan->desc.chunks_free,
+					  struct rcar_dmac_xfer_chunk, node);
+		list_del(&chunk->node);
+	} while (!chunk);
 
 	spin_unlock_irq(&chan->lock);
 
-	return hwdesc;
+	return chunk;
 }
 
 /* -----------------------------------------------------------------------------
@@ -698,7 +698,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 		       enum dma_transfer_direction dir, unsigned long dma_flags,
 		       bool cyclic)
 {
-	struct rcar_dmac_hw_desc *hwdesc;
+	struct rcar_dmac_xfer_chunk *chunk;
 	struct rcar_dmac_desc *desc;
 	struct scatterlist *sg = sgl;
 	size_t full_size = 0;
@@ -717,8 +717,8 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 	rcar_dmac_chan_configure_desc(chan, desc);
 
 	/*
-	 * Allocate and fill the hardware descriptors. We own the only reference
-	 * to the DMA descriptor, there's no need for locking.
+	 * Allocate and fill the transfer chunk descriptors. We own the only
+	 * reference to the DMA descriptor, there's no need for locking.
 	 */
 	for_each_sg(sgl, sg, sg_len, i) {
 		dma_addr_t mem_addr = sg_dma_address(sg);
@@ -740,26 +740,26 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 				size = ALIGN(mem_addr, 1ULL << 32) - mem_addr;
 #endif
 
-			hwdesc = rcar_dmac_hw_desc_get(chan);
-			if (!hwdesc) {
+			chunk = rcar_dmac_xfer_chunk_get(chan);
+			if (!chunk) {
 				rcar_dmac_desc_put(chan, desc);
 				return NULL;
 			}
 
 			if (dir = DMA_DEV_TO_MEM) {
-				hwdesc->src_addr = dev_addr;
-				hwdesc->dst_addr = mem_addr;
+				chunk->src_addr = dev_addr;
+				chunk->dst_addr = mem_addr;
 			} else {
-				hwdesc->src_addr = mem_addr;
-				hwdesc->dst_addr = dev_addr;
+				chunk->src_addr = mem_addr;
+				chunk->dst_addr = dev_addr;
 			}
 
-			hwdesc->size = size;
+			chunk->size = size;
 
 			dev_dbg(chan->chan.device->dev,
-				"chan%u: hwdesc %p/%p sgl %u@%p, %u/%u %pad -> %pad\n",
-				chan->index, hwdesc, desc, i, sg, size, len,
-				&hwdesc->src_addr, &hwdesc->dst_addr);
+				"chan%u: chunk %p/%p sgl %u@%p, %u/%u %pad -> %pad\n",
+				chan->index, chunk, desc, i, sg, size, len,
+				&chunk->src_addr, &chunk->dst_addr);
 
 			mem_addr += size;
 			if (dir = DMA_MEM_TO_MEM)
@@ -767,7 +767,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 
 			len -= size;
 
-			list_add_tail(&hwdesc->node, &desc->hwdescs);
+			list_add_tail(&chunk->node, &desc->chunks);
 		}
 	}
 
@@ -790,11 +790,11 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
 	INIT_LIST_HEAD(&rchan->desc.active);
 	INIT_LIST_HEAD(&rchan->desc.done);
 	INIT_LIST_HEAD(&rchan->desc.wait);
-	INIT_LIST_HEAD(&rchan->desc.hw_free);
+	INIT_LIST_HEAD(&rchan->desc.chunks_free);
 	INIT_LIST_HEAD(&rchan->desc.pages);
 
 	/* Preallocate descriptors. */
-	ret = rcar_dmac_hw_desc_alloc(rchan);
+	ret = rcar_dmac_xfer_chunk_alloc(rchan);
 	if (ret < 0)
 		return -ENOMEM;
 
@@ -963,7 +963,7 @@ static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 					 dma_cookie_t cookie)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
-	struct rcar_dmac_hw_desc *hwdesc;
+	struct rcar_dmac_xfer_chunk *chunk;
 	size_t residue = 0;
 
 	if (!desc)
@@ -978,11 +978,11 @@ static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 		return desc->size;
 
 	/* Compute the size of all chunks still to be transferred. */
-	list_for_each_entry_reverse(hwdesc, &desc->hwdescs, node) {
-		if (hwdesc = desc->running)
+	list_for_each_entry_reverse(chunk, &desc->chunks, node) {
+		if (chunk = desc->running)
 			break;
 
-		residue += hwdesc->size;
+		residue += chunk->size;
 	}
 
 	/* Add the residue for the current chunk. */
@@ -1070,7 +1070,7 @@ static int rcar_dmac_slave_caps(struct dma_chan *chan,
 static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc = chan->desc.running;
-	struct rcar_dmac_hw_desc *hwdesc;
+	struct rcar_dmac_xfer_chunk *chunk;
 	irqreturn_t ret = IRQ_WAKE_THREAD;
 
 	if (WARN_ON(!desc)) {
@@ -1083,24 +1083,24 @@ static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
 	}
 
 	/*
-	 * If we haven't completed the last hardware descriptor simply move to
-	 * the next one. Only wake the IRQ thread if the transfer is cyclic.
+	 * If we haven't completed the last transfer chunk simply move to the
+	 * next one. Only wake the IRQ thread if the transfer is cyclic.
 	 */
-	hwdesc = desc->running;
-	if (!list_is_last(&hwdesc->node, &desc->hwdescs)) {
-		desc->running = list_next_entry(hwdesc, node);
+	chunk = desc->running;
+	if (!list_is_last(&chunk->node, &desc->chunks)) {
+		desc->running = list_next_entry(chunk, node);
 		if (!desc->cyclic)
 			ret = IRQ_HANDLED;
 		goto done;
 	}
 
 	/*
-	 * We've completed the last hardware. If the transfer is cyclic, move
-	 * back to the first one.
+	 * We've completed the last transfer chunk. If the transfer is cyclic,
+	 * move back to the first one.
 	 */
 	if (desc->cyclic) {
-		desc->running = list_first_entry(&desc->hwdescs,
-						 struct rcar_dmac_hw_desc,
+		desc->running = list_first_entry(&desc->chunks,
+						 struct rcar_dmac_xfer_chunk,
 						 node);
 		goto done;
 	}
-- 
1.8.5.5

