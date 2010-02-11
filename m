From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:05 +0000
Subject: [PATCH 1/5] async-tx: fix DMA error handling in shdma.c
Message-Id: <Pine.LNX.4.64.1002111705330.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Present DMA error ISR in shdma.c is bogus, it locks the system hard in multiple
ways. Fix it to abort all queued transactions on all channels on the affected
controller and giving submitters a chance to get a DMA_ERROR status for aborted
transactions. Afterwards further functionality is again possible without the
need to re-load the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |   89 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index b75ce8b..7731169 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -73,7 +73,7 @@ static void sh_dmae_ctl_stop(int id)
 {
 	unsigned short dmaor = dmaor_read_reg(id);
 
-	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
+	dmaor &= ~(DMAOR_NMIF | DMAOR_AE | DMAOR_DME);
 	dmaor_write_reg(id, dmaor);
 }
 
@@ -86,7 +86,7 @@ static int sh_dmae_rst(int id)
 
 	dmaor_write_reg(id, dmaor);
 	if (dmaor_read_reg(id) & (DMAOR_AE | DMAOR_NMIF)) {
-		pr_warning(KERN_ERR "dma-sh: Can't initialize DMAOR.\n");
+		pr_warning("dma-sh: Can't initialize DMAOR.\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -661,7 +661,7 @@ static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all)
 
 static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 {
-	struct sh_desc *sd;
+	struct sh_desc *desc;
 
 	spin_lock_bh(&sh_chan->desc_lock);
 	/* DMA work check */
@@ -671,10 +671,10 @@ static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 	}
 
 	/* Find the first not transferred desciptor */
-	list_for_each_entry(sd, &sh_chan->ld_queue, node)
-		if (sd->mark = DESC_SUBMITTED) {
+	list_for_each_entry(desc, &sh_chan->ld_queue, node)
+		if (desc->mark = DESC_SUBMITTED) {
 			/* Get the ld start address from ld_queue */
-			dmae_set_reg(sh_chan, &sd->hw);
+			dmae_set_reg(sh_chan, &desc->hw);
 			dmae_start(sh_chan);
 			break;
 		}
@@ -696,6 +696,7 @@ static enum dma_status sh_dmae_is_complete(struct dma_chan *chan,
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
 	dma_cookie_t last_used;
 	dma_cookie_t last_complete;
+	enum dma_status status;
 
 	sh_dmae_chan_ld_cleanup(sh_chan, false);
 
@@ -709,7 +710,27 @@ static enum dma_status sh_dmae_is_complete(struct dma_chan *chan,
 	if (used)
 		*used = last_used;
 
-	return dma_async_is_complete(cookie, last_complete, last_used);
+	spin_lock_bh(&sh_chan->desc_lock);
+
+	status = dma_async_is_complete(cookie, last_complete, last_used);
+
+	/*
+	 * If we don't find cookie on the queue, it has been aborted and we have
+	 * to report error
+	 */
+	if (status != DMA_SUCCESS) {
+		struct sh_desc *desc;
+		status = DMA_ERROR;
+		list_for_each_entry(desc, &sh_chan->ld_queue, node)
+			if (desc->cookie = cookie) {
+				status = DMA_IN_PROGRESS;
+				break;
+			}
+	}
+
+	spin_unlock_bh(&sh_chan->desc_lock);
+
+	return status;
 }
 
 static irqreturn_t sh_dmae_interrupt(int irq, void *data)
@@ -732,40 +753,36 @@ static irqreturn_t sh_dmae_interrupt(int irq, void *data)
 #if defined(CONFIG_CPU_SH4)
 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
-	int err = 0;
 	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
+	int i;
 
-	/* IRQ Multi */
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		int __maybe_unused cnt = 0;
-		switch (irq) {
-#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
-		case DMTE6_IRQ:
-			cnt++;
-#endif
-		case DMTE0_IRQ:
-			if (dmaor_read_reg(cnt) & (DMAOR_NMIF | DMAOR_AE)) {
-				disable_irq(irq);
-				return IRQ_HANDLED;
+	/* halt the dma controller */
+	sh_dmae_ctl_stop(0);
+	if (shdev->pdata.mode & SHDMA_DMAOR1)
+		sh_dmae_ctl_stop(1);
+
+	/* We cannot detect, which channel caused the error, have to reset all */
+	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
+		struct sh_dmae_chan *sh_chan = shdev->chan[i];
+		if (sh_chan) {
+			struct sh_desc *desc;
+			/* Stop the channel */
+			dmae_halt(sh_chan);
+			/* Complete all  */
+			list_for_each_entry(desc, &sh_chan->ld_queue, node) {
+				struct dma_async_tx_descriptor *tx = &desc->async_tx;
+				desc->mark = DESC_IDLE;
+				if (tx->callback)
+					tx->callback(tx->callback_param);
 			}
-		default:
-			return IRQ_NONE;
+			list_splice_init(&sh_chan->ld_queue, &sh_chan->ld_free);
 		}
-	} else {
-		/* reset dma controller */
-		err = sh_dmae_rst(0);
-		if (err)
-			return err;
-#ifdef SH_DMAC_BASE1
-		if (shdev->pdata.mode & SHDMA_DMAOR1) {
-			err = sh_dmae_rst(1);
-			if (err)
-				return err;
-		}
-#endif
-		disable_irq(irq);
-		return IRQ_HANDLED;
 	}
+	sh_dmae_rst(0);
+	if (shdev->pdata.mode & SHDMA_DMAOR1)
+		sh_dmae_rst(1);
+
+	return IRQ_HANDLED;
 }
 #endif
 
-- 
1.6.2.4

