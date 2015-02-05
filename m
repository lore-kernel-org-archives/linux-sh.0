From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Feb 2015 02:27:37 +0000
Subject: [PATCH] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <87sielhz1i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Jun Watanabe <jun.watanabe.ue@renesas.com>

Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
in some functions. But, some other driver might call DMAEngine API
during interrupt disabled. In such case, rcar-dmac side spin_unlock_irq()
forcefully allows all interrupts. Therefore, other driver receives
unexpected interruption, and its exclusive access control will be broken.
This patch replaces spin_lock_irq() to spin_lock_irqsave(),
and spin_unlock_irq() to spin_unlock_irqrestore().

Signed-off-by: Jun Watanabe <jun.watanabe.ue@renesas.com>
Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesasu.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c |   61 +++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 29dd09a..6bc9941 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -453,6 +453,7 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 	struct rcar_dmac_desc_page *page;
 	LIST_HEAD(list);
 	unsigned int i;
+	unsigned long flags;
 
 	page = (void *)get_zeroed_page(gfp);
 	if (!page)
@@ -468,10 +469,10 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 		list_add_tail(&desc->node, &list);
 	}
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice_tail(&list, &chan->desc.free);
 	list_add_tail(&page->node, &chan->desc.pages);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return 0;
 }
@@ -493,15 +494,18 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 			       struct rcar_dmac_desc *desc)
 {
-	spin_lock_irq(&chan->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
 	list_add_tail(&desc->node, &chan->desc.free);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc, *_desc;
+	unsigned long flags;
 	LIST_HEAD(list);
 
 	/*
@@ -510,9 +514,9 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 	 * list_for_each_entry_safe, isn't safe if we release the channel lock
 	 * around the rcar_dmac_desc_put() call.
 	 */
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice_init(&chan->desc.wait, &list);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	list_for_each_entry_safe(desc, _desc, &list, node) {
 		if (async_tx_test_ack(&desc->async_tx)) {
@@ -525,9 +529,9 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 		return;
 
 	/* Put the remaining descriptors back in the wait list. */
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice(&list, &chan->desc.wait);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 /*
@@ -542,12 +546,13 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc;
+	unsigned long flags;
 	int ret;
 
 	/* Recycle acked descriptors before attempting allocation. */
 	rcar_dmac_desc_recycle_acked(chan);
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	do {
 		if (list_empty(&chan->desc.free)) {
@@ -557,11 +562,11 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 			 * the newly allocated descriptors. If the allocation
 			 * fails return an error.
 			 */
-			spin_unlock_irq(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, flags);
 			ret = rcar_dmac_desc_alloc(chan, GFP_NOWAIT);
 			if (ret < 0)
 				return NULL;
-			spin_lock_irq(&chan->lock);
+			spin_lock_irqsave(&chan->lock, flags);
 			continue;
 		}
 
@@ -570,7 +575,7 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 		list_del(&desc->node);
 	} while (!desc);
 
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return desc;
 }
@@ -585,6 +590,7 @@ static int rcar_dmac_xfer_chunk_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 	struct rcar_dmac_desc_page *page;
 	LIST_HEAD(list);
 	unsigned int i;
+	unsigned long flags;
 
 	page = (void *)get_zeroed_page(gfp);
 	if (!page)
@@ -596,10 +602,10 @@ static int rcar_dmac_xfer_chunk_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 		list_add_tail(&chunk->node, &list);
 	}
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice_tail(&list, &chan->desc.chunks_free);
 	list_add_tail(&page->node, &chan->desc.pages);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return 0;
 }
@@ -617,9 +623,10 @@ static struct rcar_dmac_xfer_chunk *
 rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_xfer_chunk *chunk;
+	unsigned long flags;
 	int ret;
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	do {
 		if (list_empty(&chan->desc.chunks_free)) {
@@ -629,11 +636,11 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 			 * the newly allocated descriptors. If the allocation
 			 * fails return an error.
 			 */
-			spin_unlock_irq(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, flags);
 			ret = rcar_dmac_xfer_chunk_alloc(chan, GFP_NOWAIT);
 			if (ret < 0)
 				return NULL;
-			spin_lock_irq(&chan->lock);
+			spin_lock_irqsave(&chan->lock, flags);
 			continue;
 		}
 
@@ -642,7 +649,7 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 		list_del(&chunk->node);
 	} while (!chunk);
 
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return chunk;
 }
@@ -962,12 +969,13 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
 	struct rcar_dmac_desc_page *page, *_page;
 	struct rcar_dmac_desc *desc;
+	unsigned long flags;
 	LIST_HEAD(list);
 
 	/* Protect against ISR */
-	spin_lock_irq(&rchan->lock);
+	spin_lock_irqsave(&rchan->lock, flags);
 	rcar_dmac_chan_halt(rchan);
-	spin_unlock_irq(&rchan->lock);
+	spin_unlock_irqrestore(&rchan->lock, flags);
 
 	/* Now no new interrupts will occur */
 
@@ -1349,8 +1357,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 {
 	struct rcar_dmac_chan *chan = dev;
 	struct rcar_dmac_desc *desc;
+	unsigned long flags;
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	/* For cyclic transfers notify the user after every chunk. */
 	if (chan->desc.running && chan->desc.running->cyclic) {
@@ -1362,9 +1371,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 		callback_param = desc->async_tx.callback_param;
 
 		if (callback) {
-			spin_unlock_irq(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, flags);
 			callback(callback_param);
-			spin_lock_irq(&chan->lock);
+			spin_lock_irqsave(&chan->lock, flags);
 		}
 	}
 
@@ -1379,20 +1388,20 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 		list_del(&desc->node);
 
 		if (desc->async_tx.callback) {
-			spin_unlock_irq(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, flags);
 			/*
 			 * We own the only reference to this descriptor, we can
 			 * safely dereference it without holding the channel
 			 * lock.
 			 */
 			desc->async_tx.callback(desc->async_tx.callback_param);
-			spin_lock_irq(&chan->lock);
+			spin_lock_irqsave(&chan->lock, flags);
 		}
 
 		list_add_tail(&desc->node, &chan->desc.wait);
 	}
 
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Recycle all acked descriptors. */
 	rcar_dmac_desc_recycle_acked(chan);
-- 
1.7.9.5

