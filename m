From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:57 +0000
Subject: [PATCH/RFC v2 26/29] serial: sh-sci: Do not resubmit DMA descriptors
Message-Id: <1437070920-28069-27-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA engine
driver does not support resubmitting a DMA descriptor.
If a DMA slave resubmits a descriptor, the descriptor will be added to
the "pending list", while it wasn't removed from the "wait" list. This
will cause list corruption, leading to an infinite loop in
rcar_dmac_chan_reinit().

As a (temporary?) workaround, pass DMA_CTRL_ACK to
dmaengine_prep_slave_sg(), and prepare a new DMA descriptor instead of
reusing the old one.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2c6a58595016fe07..0e99c570e2da4d64 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1414,7 +1414,8 @@ static void sci_submit_rx(struct sci_port *s)
 		struct dma_async_tx_descriptor *desc;
 
 		desc = dmaengine_prep_slave_sg(chan,
-			sg, 1, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+			sg, 1, DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc)
 			goto fail;
 
@@ -1491,19 +1492,31 @@ static void work_fn_rx(struct work_struct *work)
 		return;
 	}
 
+	desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[new], 1,
+				       DMA_DEV_TO_MEM,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		goto fail;
+
+	s->desc_rx[new] = desc;
+	desc->callback = sci_dma_rx_complete;
+	desc->callback_param = s;
 	s->cookie_rx[new] = dmaengine_submit(desc);
-	if (dma_submit_error(s->cookie_rx[new])) {
-		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
-		spin_unlock_irqrestore(&port->lock, flags);
-		sci_rx_dma_release(s, true);
-		return;
-	}
+	if (dma_submit_error(s->cookie_rx[new]))
+		goto fail;
 
 	s->active_rx = s->cookie_rx[!new];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
 	spin_unlock_irqrestore(&port->lock, flags);
+	return;
+
+fail:
+	spin_unlock_irqrestore(&port->lock, flags);
+	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+	sci_rx_dma_release(s, true);
+	return;
 }
 
 static void work_fn_tx(struct work_struct *work)
-- 
1.9.1

