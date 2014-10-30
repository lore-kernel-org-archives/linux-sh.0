From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 30 Oct 2014 00:28:14 +0000
Subject: [PATCH v4 5/5] dmaengine: rcar-dmac: Cache hardware descriptors memory
Message-Id: <1414628894-24460-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unlike DMA transfers descriptors that are preallocated and cached,
memory used to store hardware descriptors is allocated and freed with
the DMA coherent allocation API for every transfer. Besides degrading
performances, this creates a CMA stress test that seems to cause issues.
Running dmatest with the noverify option produces

[   50.066539] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
[   50.235180] alloc_contig_range test_pages_isolated(6b848, 6b84e) failed
[   52.964584] alloc_contig_range test_pages_isolated(6b847, 6b848) failed
[   54.127113] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
[   56.270253] alloc_contig_range test_pages_isolated(6b84c, 6b850) failed

The root cause needs to be fixed, but in the meantime, as a workaround
and a performance improvement, cache hardware descriptors.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---

Changes since v3:

- Typo fixes
- Align allocated hwdesc size to page size
- Ignore allocated hwdesc memory when the transfer doesn't use hwdescs
---
 drivers/dma/sh/rcar-dmac.c | 78 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 531b4ecdcd18..f8f70ebb1bb0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -64,6 +64,7 @@ struct rcar_dmac_hw_desc {
  * @chunks: list of transfer chunks for this transfer
  * @running: the transfer chunk being currently processed
  * @nchunks: number of transfer chunks for this transfer
+ * @hwdescs.use: whether the transfer descriptor uses hardware descriptors
  * @hwdescs.mem: hardware descriptors memory for the transfer
  * @hwdescs.dma: device address of the hardware descriptors memory
  * @hwdescs.size: size of the hardware descriptors in bytes
@@ -82,6 +83,7 @@ struct rcar_dmac_desc {
 	unsigned int nchunks;
 
 	struct {
+		bool use;
 		struct rcar_dmac_hw_desc *mem;
 		dma_addr_t dma;
 		size_t size;
@@ -322,7 +324,7 @@ static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 	if (chan->mid_rid >= 0)
 		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
 
-	if (desc->hwdescs.mem) {
+	if (desc->hwdescs.use) {
 		dev_dbg(chan->chan.device->dev,
 			"chan%u: queue desc %p: %u@%pad\n",
 			chan->index, desc, desc->nchunks, &desc->hwdescs.dma);
@@ -480,8 +482,8 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
  * @desc: the descriptor
  *
  * Put the descriptor and its transfer chunk descriptors back in the channel's
- * free descriptors lists, and free the hardware descriptors list memory. The
- * descriptor's chunks list will be reinitialized to an empty list as a result.
+ * free descriptors lists. The descriptor's chunks list will be reinitialized to
+ * an empty list as a result.
  *
  * The descriptor must have been removed from the channel's lists before calling
  * this function.
@@ -491,12 +493,6 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 			       struct rcar_dmac_desc *desc)
 {
-	if (desc->hwdescs.mem) {
-		dma_free_coherent(NULL, desc->hwdescs.size, desc->hwdescs.mem,
-				  desc->hwdescs.dma);
-		desc->hwdescs.mem = NULL;
-	}
-
 	spin_lock_irq(&chan->lock);
 	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
 	list_add_tail(&desc->node, &chan->desc.free);
@@ -651,20 +647,50 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 	return chunk;
 }
 
-static void rcar_dmac_alloc_hwdesc(struct rcar_dmac_chan *chan,
-				   struct rcar_dmac_desc *desc)
+static void rcar_dmac_realloc_hwdesc(struct rcar_dmac_chan *chan,
+				     struct rcar_dmac_desc *desc, size_t size)
+{
+	/*
+	 * dma_alloc_coherent() allocates memory in page size increments. To
+	 * avoid reallocating the hardware descriptors when the allocated size
+	 * wouldn't change align the requested size to a multiple of the page
+	 * size.
+	 */
+	size = PAGE_ALIGN(size);
+
+	if (desc->hwdescs.size = size)
+		return;
+
+	if (desc->hwdescs.mem) {
+		dma_free_coherent(NULL, desc->hwdescs.size, desc->hwdescs.mem,
+				   desc->hwdescs.dma);
+		desc->hwdescs.mem = NULL;
+		desc->hwdescs.size = 0;
+	}
+
+	if (!size)
+		return;
+
+	desc->hwdescs.mem = dma_alloc_coherent(NULL, size, &desc->hwdescs.dma,
+					       GFP_NOWAIT);
+	if (!desc->hwdescs.mem)
+		return;
+
+	desc->hwdescs.size = size;
+}
+
+static void rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
+				  struct rcar_dmac_desc *desc)
 {
 	struct rcar_dmac_xfer_chunk *chunk;
 	struct rcar_dmac_hw_desc *hwdesc;
-	size_t size = desc->nchunks * sizeof(*hwdesc);
 
-	hwdesc = dma_alloc_coherent(NULL, size, &desc->hwdescs.dma, GFP_NOWAIT);
+	rcar_dmac_realloc_hwdesc(chan, desc, desc->nchunks * sizeof(*hwdesc));
+
+	hwdesc = desc->hwdescs.mem;
 	if (!hwdesc)
 		return;
 
-	desc->hwdescs.mem = hwdesc;
-	desc->hwdescs.size = size;
-
 	list_for_each_entry(chunk, &desc->chunks, node) {
 		hwdesc->sar = chunk->src_addr;
 		hwdesc->dar = chunk->dst_addr;
@@ -906,8 +932,9 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 	 * performance improvement would be significant enough compared to the
 	 * additional complexity remains to be investigated.
 	 */
-	if (!highmem && nchunks > 1)
-		rcar_dmac_alloc_hwdesc(chan, desc);
+	desc->hwdescs.use = !highmem && nchunks > 1;
+	if (desc->hwdescs.use)
+		rcar_dmac_fill_hwdesc(chan, desc);
 
 	return &desc->async_tx;
 }
@@ -946,6 +973,8 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 	struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
 	struct rcar_dmac_desc_page *page, *_page;
+	struct rcar_dmac_desc *desc;
+	LIST_HEAD(list);
 
 	/* Protect against ISR */
 	spin_lock_irq(&rchan->lock);
@@ -960,6 +989,15 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 		rchan->mid_rid = -EINVAL;
 	}
 
+	list_splice(&rchan->desc.free, &list);
+	list_splice(&rchan->desc.pending, &list);
+	list_splice(&rchan->desc.active, &list);
+	list_splice(&rchan->desc.done, &list);
+	list_splice(&rchan->desc.wait, &list);
+
+	list_for_each_entry(desc, &list, node)
+		rcar_dmac_realloc_hwdesc(rchan, desc, 0);
+
 	list_for_each_entry_safe(page, _page, &rchan->desc.pages, node) {
 		list_del(&page->node);
 		free_page((unsigned long)page);
@@ -1128,7 +1166,7 @@ static unsigned int rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 	 * descriptor pointer field in the CHCRB register. In non-descriptor
 	 * mode just use the running descriptor pointer.
 	 */
-	if (desc->hwdescs.mem) {
+	if (desc->hwdescs.use) {
 		dptr = (rcar_dmac_chan_read(chan, RCAR_DMACHCRB) &
 			RCAR_DMACHCRB_DPTR_MASK) >> RCAR_DMACHCRB_DPTR_SHIFT;
 		WARN_ON(dptr >= desc->nchunks);
@@ -1272,7 +1310,7 @@ static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
 	 * descriptor mode. Only update the running chunk pointer in
 	 * non-descriptor mode.
 	 */
-	if (!desc->hwdescs.mem) {
+	if (!desc->hwdescs.use) {
 		/*
 		 * If we haven't completed the last transfer chunk simply move
 		 * to the next one. Only wake the IRQ thread if the transfer is
-- 
2.0.4

