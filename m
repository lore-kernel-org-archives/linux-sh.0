From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:26:13 +0000
Subject: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When freeing channel resources we need to ensure that no IRQ will occur
for the given channel. In order to do so the driver stops the hardware,
but an IRQ handler could still be running, especially given that the
channel IRQ is threaded. Fix it by waiting for pending IRQs completion
with synchronize_irq()

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

Hi Morimoto-san,

This patch is compile-tested only. Would you be able to check if it fixes the
issue you've reported with SDHI and rcar-dmac ?

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07e7bee..da50c8f4d533 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -121,6 +121,7 @@ struct rcar_dmac_desc_page {
  * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
  * @chan: base DMA channel object
  * @iomem: channel I/O memory base
+ * @irq: channel IRQ number
  * @index: index of this channel in the controller
  * @src_xfer_size: size (in bytes) of hardware transfers on the source side
  * @dst_xfer_size: size (in bytes) of hardware transfers on the destination side
@@ -140,6 +141,7 @@ struct rcar_dmac_desc_page {
 struct rcar_dmac_chan {
 	struct dma_chan chan;
 	void __iomem *iomem;
+	int irq;
 	unsigned int index;
 
 	unsigned int src_xfer_size;
@@ -726,6 +728,15 @@ static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
 }
 
+static void rcar_dmac_chan_halt_and_wait(struct rcar_dmac_chan *chan)
+{
+	spin_lock_irq(&chan->lock);
+	rcar_dmac_chan_halt(chan);
+	spin_unlock_irq(&chan->lock);
+
+	synchronize_irq(chan->irq);
+}
+
 static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
 {
 	struct rcar_dmac_desc *desc, *_desc;
@@ -972,9 +983,7 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(list);
 
 	/* Protect against ISR */
-	spin_lock_irq(&rchan->lock);
-	rcar_dmac_chan_halt(rchan);
-	spin_unlock_irq(&rchan->lock);
+	rcar_dmac_chan_halt_and_wait(rchan);
 
 	/* Now no new interrupts will occur */
 
@@ -1121,17 +1130,8 @@ static int rcar_dmac_device_config(struct dma_chan *chan,
 static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
 {
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
-	unsigned long flags;
-
-	spin_lock_irqsave(&rchan->lock, flags);
-	rcar_dmac_chan_halt(rchan);
-	spin_unlock_irqrestore(&rchan->lock, flags);
-
-	/*
-	 * FIXME: No new interrupt can occur now, but the IRQ thread might still
-	 * be running.
-	 */
 
+	rcar_dmac_chan_halt_and_wait(rchan);
 	rcar_dmac_chan_reinit(rchan);
 
 	return 0;
@@ -1524,7 +1524,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	struct dma_chan *chan = &rchan->chan;
 	char pdev_irqname[5];
 	char *irqname;
-	int irq;
 	int ret;
 
 	rchan->index = index;
@@ -1541,8 +1540,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
-	irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (irq < 0) {
+	rchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (rchan->irq < 0) {
 		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
 		return -ENODEV;
 	}
@@ -1552,11 +1551,13 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	if (!irqname)
 		return -ENOMEM;
 
-	ret = devm_request_threaded_irq(dmac->dev, irq, rcar_dmac_isr_channel,
+	ret = devm_request_threaded_irq(dmac->dev, rchan->irq,
+					rcar_dmac_isr_channel,
 					rcar_dmac_isr_channel_thread, 0,
 					irqname, rchan);
 	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
+			rchan->irq, ret);
 		return ret;
 	}
 
-- 
Regards,

Laurent Pinchart

