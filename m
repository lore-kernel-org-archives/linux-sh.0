From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:51 +0000
Subject: [PATCH/RFC 5/5] dmaengine: rcar-dmac: Cache hardware descriptors memory
Message-Id: <1406032431-3807-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unlike DMA transfers descriptors that are preallocated and cached,
memory used to store hardware descriptors is allocated and freed with
the DMA coherent allocation API for every transfer. Beside degrading
performances, this creates a CMA stress test that seem to cause issues.
Running dmatest with the noverify option produces

[   50.066539] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
[   50.235180] alloc_contig_range test_pages_isolated(6b848, 6b84e) failed
[   52.964584] alloc_contig_range test_pages_isolated(6b847, 6b848) failed
[   54.127113] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
[   56.270253] alloc_contig_range test_pages_isolated(6b84c, 6b850) failed

The root cause need to be fixed, but in the meantime, as a workaround
and a performance improvement, cache hardware descriptors.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 59 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 14606dd..c314a6c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -488,8 +488,8 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
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
@@ -499,12 +499,6 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
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
@@ -658,20 +652,42 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 	return chunk;
 }
 
-static void rcar_dmac_alloc_hwdesc(struct rcar_dmac_chan *chan,
-				   struct rcar_dmac_desc *desc)
+static void rcar_dmac_realloc_hwdesc(struct rcar_dmac_chan *chan,
+				     struct rcar_dmac_desc *desc, size_t size)
+{
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
+					       GFP_KERNEL);
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
 
-	hwdesc = dma_alloc_coherent(NULL, size, &desc->hwdescs.dma, GFP_KERNEL);
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
@@ -918,7 +934,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 	 * additional complexity remains to be studied.
 	 */
 	if (!highmem && nchunks > 1)
-		rcar_dmac_alloc_hwdesc(chan, desc);
+		rcar_dmac_fill_hwdesc(chan, desc);
 
 	return &desc->async_tx;
 }
@@ -953,6 +969,8 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 	struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
 	struct rcar_dmac_desc_page *page, *_page;
+	struct rcar_dmac_desc *desc;
+	LIST_HEAD(list);
 
 	/* Protect against ISR */
 	spin_lock_irq(&rchan->lock);
@@ -967,6 +985,15 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
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
-- 
1.8.5.5

