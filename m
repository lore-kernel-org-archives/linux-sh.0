From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 17:25:12 +0000
Subject: [PATCH 2/6] dmaengine: rcar-dmac: Fix spinlock issues in interrupt
Message-Id: <1422379516-1633-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The rcar_dmac_desc_put() function is called in interrupt context and
must thus use spin_lock_irqsave() instead of spin_lock_irq().
Furthermore, as the driver can be used on SMP systems, the IRQ handlers
must use spin_lock_irqsave() instead of spin_lock().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 8367578bac63..b7ff64557d6d 100644
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
@@ -738,6 +738,7 @@ static void rcar_dmac_stop(struct rcar_dmac *dmac)
 
 static void rcar_dmac_abort(struct rcar_dmac *dmac)
 {
+	unsigned long flags;
 	unsigned int i;
 
 	/* Stop all channels. */
@@ -745,9 +746,9 @@ static void rcar_dmac_abort(struct rcar_dmac *dmac)
 		struct rcar_dmac_chan *chan = &dmac->channels[i];
 
 		/* Stop and reinitialize the channel. */
-		spin_lock(&chan->lock);
+		spin_lock_irqsave(&chan->lock, flags);
 		rcar_dmac_chan_halt(chan);
-		spin_unlock(&chan->lock);
+		spin_unlock_irqrestore(&chan->lock, flags);
 
 		rcar_dmac_chan_reinit(chan);
 	}
@@ -1318,9 +1319,10 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
 	u32 mask = RCAR_DMACHCR_DSE | RCAR_DMACHCR_TE;
 	struct rcar_dmac_chan *chan = dev;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
 	u32 chcr;
 
-	spin_lock(&chan->lock);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
 	if (chcr & RCAR_DMACHCR_TE)
@@ -1333,7 +1335,7 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
 	if (chcr & RCAR_DMACHCR_TE)
 		ret |= rcar_dmac_isr_transfer_end(chan);
 
-	spin_unlock(&chan->lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return ret;
 }
-- 
2.0.5

