From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 29 Jan 2015 23:59:38 +0000
Subject: [PATCH v2 2/6] dmaengine: rcar-dmac: Fix spinlock issues in interrupt
Message-Id: <1422576013-7846-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The rcar_dmac_desc_put() function is called in interrupt context and
must thus use spin_lock_irqsave() instead of spin_lock_irq().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 8367578bac63..5a6b85527107 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -487,16 +487,16 @@ static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan, gfp_t gfp)
  *
  * The descriptor must have been removed from the channel's lists before calling
  * this function.
- *
- * Locking: Must be called in non-atomic context.
  */
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
-- 
2.0.5

