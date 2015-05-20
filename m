From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 May 2015 03:46:19 +0000
Subject: [PATCH 1/4] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <871tib52vy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
in some functions. But, some other driver might call DMAEngine API
during interrupt disabled. In such case, rcar-dmac side spin_unlock_irq()
forcefully allows all interrupts. Therefore, other driver receives
unexpected interruption, and its exclusive access control will be broken.
This patch replaces spin_lock_irq() to spin_lock_irqsave(),
and spin_unlock_irq() to spin_unlock_irqrestore().

Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 55 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index a18d16c..6a5d4b9 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -465,6 +465,7 @@ static dma_cookie_t rcar_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
 static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 {
 	struct rcar_dmac_desc_page *page;
+	unsigned long flags;
 	LIST_HEAD(list);
 	unsigned int i;
 
@@ -482,10 +483,10 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
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
@@ -516,6 +517,7 @@ static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc, *_desc;
+	unsigned long flags;
 	LIST_HEAD(list);
 
 	/*
@@ -524,9 +526,9 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
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
@@ -539,9 +541,9 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 		return;
 
 	/* Put the remaining descriptors back in the wait list. */
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 	list_splice(&list, &chan->desc.wait);
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 /*
@@ -556,12 +558,13 @@ static void rcar_dmac_desc_recycle_acked(struct rcar_dmac_chan *chan)
 static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc;
+	unsigned long flags;
 	int ret;
 
 	/* Recycle acked descriptors before attempting allocation. */
 	rcar_dmac_desc_recycle_acked(chan);
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	while (list_empty(&chan->desc.free)) {
 		/*
@@ -570,17 +573,17 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 		 * allocated descriptors. If the allocation fails return an
 		 * error.
 		 */
-		spin_unlock_irq(&chan->lock);
+		spin_unlock_irqrestore(&chan->lock, flags);
 		ret = rcar_dmac_desc_alloc(chan, GFP_NOWAIT);
 		if (ret < 0)
 			return NULL;
-		spin_lock_irq(&chan->lock);
+		spin_lock_irqsave(&chan->lock, flags);
 	}
 
 	desc = list_first_entry(&chan->desc.free, struct rcar_dmac_desc, node);
 	list_del(&desc->node);
 
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return desc;
 }
@@ -593,6 +596,7 @@ static struct rcar_dmac_desc *rcar_dmac_desc_get(struct rcar_dmac_chan *chan)
 static int rcar_dmac_xfer_chunk_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
 {
 	struct rcar_dmac_desc_page *page;
+	unsigned long flags;
 	LIST_HEAD(list);
 	unsigned int i;
 
@@ -606,10 +610,10 @@ static int rcar_dmac_xfer_chunk_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
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
@@ -627,9 +631,10 @@ static struct rcar_dmac_xfer_chunk *
 rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_xfer_chunk *chunk;
+	unsigned long flags;
 	int ret;
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	while (list_empty(&chan->desc.chunks_free)) {
 		/*
@@ -638,18 +643,18 @@ rcar_dmac_xfer_chunk_get(struct rcar_dmac_chan *chan)
 		 * allocated descriptors. If the allocation fails return an
 		 * error.
 		 */
-		spin_unlock_irq(&chan->lock);
+		spin_unlock_irqrestore(&chan->lock, flags);
 		ret = rcar_dmac_xfer_chunk_alloc(chan, GFP_NOWAIT);
 		if (ret < 0)
 			return NULL;
-		spin_lock_irq(&chan->lock);
+		spin_lock_irqsave(&chan->lock, flags);
 	}
 
 	chunk = list_first_entry(&chan->desc.chunks_free,
 				 struct rcar_dmac_xfer_chunk, node);
 	list_del(&chunk->node);
 
-	spin_unlock_irq(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return chunk;
 }
@@ -964,12 +969,13 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
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
 
@@ -1351,8 +1357,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 {
 	struct rcar_dmac_chan *chan = dev;
 	struct rcar_dmac_desc *desc;
+	unsigned long flags;
 
-	spin_lock_irq(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	/* For cyclic transfers notify the user after every chunk. */
 	if (chan->desc.running && chan->desc.running->cyclic) {
@@ -1364,9 +1371,9 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 		callback_param = desc->async_tx.callback_param;
 
 		if (callback) {
-			spin_unlock_irq(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, flags);
 			callback(callback_param);
-			spin_lock_irq(&chan->lock);
+			spin_lock_irqsave(&chan->lock, flags);
 		}
 	}
 
@@ -1381,20 +1388,20 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
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
1.9.1

