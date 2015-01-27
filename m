From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 17:25:13 +0000
Subject: [PATCH 3/6] dmaengine: rcar-dmac: Fix oops due to unintialized list in error ISR
Message-Id: <1422379516-1633-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The error interrupt handler stops and reinitializes all channels. This
causes a crash for channels that have never been used, as their
descriptor lists are uninitialized. Fix it by initializing the
descriptor lists at probe time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index b7ff64557d6d..e76f5e21f666 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -930,11 +930,6 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 	int ret;
 
-	INIT_LIST_HEAD(&rchan->desc.free);
-	INIT_LIST_HEAD(&rchan->desc.pending);
-	INIT_LIST_HEAD(&rchan->desc.active);
-	INIT_LIST_HEAD(&rchan->desc.done);
-	INIT_LIST_HEAD(&rchan->desc.wait);
 	INIT_LIST_HEAD(&rchan->desc.chunks_free);
 	INIT_LIST_HEAD(&rchan->desc.pages);
 
@@ -971,11 +966,11 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 		rchan->mid_rid = -EINVAL;
 	}
 
-	list_splice(&rchan->desc.free, &list);
-	list_splice(&rchan->desc.pending, &list);
-	list_splice(&rchan->desc.active, &list);
-	list_splice(&rchan->desc.done, &list);
-	list_splice(&rchan->desc.wait, &list);
+	list_splice_init(&rchan->desc.free, &list);
+	list_splice_init(&rchan->desc.pending, &list);
+	list_splice_init(&rchan->desc.active, &list);
+	list_splice_init(&rchan->desc.done, &list);
+	list_splice_init(&rchan->desc.wait, &list);
 
 	list_for_each_entry(desc, &list, node)
 		rcar_dmac_realloc_hwdesc(rchan, desc, 0);
@@ -1521,6 +1516,12 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 
 	spin_lock_init(&rchan->lock);
 
+	INIT_LIST_HEAD(&rchan->desc.free);
+	INIT_LIST_HEAD(&rchan->desc.pending);
+	INIT_LIST_HEAD(&rchan->desc.active);
+	INIT_LIST_HEAD(&rchan->desc.done);
+	INIT_LIST_HEAD(&rchan->desc.wait);
+
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
 	irq = platform_get_irq_byname(pdev, pdev_irqname);
-- 
2.0.5

