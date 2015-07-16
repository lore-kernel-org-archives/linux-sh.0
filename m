From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:56 +0000
Subject: [PATCH/RFC v2 25/29] serial: sh-sci: Simplify sci_submit_rx() error handling
Message-Id: <1437070920-28069-26-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Simplify the error handling in sci_submit_rx() by
  - Moving it to the end of the function,
  - Just calling dmaengine_terminate_all() instead of calling
    async_tx_ack() for all already submitted descriptors.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dda1f7b13497817a..2c6a58595016fe07 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1415,28 +1415,16 @@ static void sci_submit_rx(struct sci_port *s)
 
 		desc = dmaengine_prep_slave_sg(chan,
 			sg, 1, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+		if (!desc)
+			goto fail;
 
-		if (desc) {
-			s->desc_rx[i] = desc;
-			desc->callback = sci_dma_rx_complete;
-			desc->callback_param = s;
-			s->cookie_rx[i] = dmaengine_submit(desc);
-		}
+		s->desc_rx[i] = desc;
+		desc->callback = sci_dma_rx_complete;
+		desc->callback_param = s;
+		s->cookie_rx[i] = dmaengine_submit(desc);
+		if (dma_submit_error(s->cookie_rx[i]))
+			goto fail;
 
-		if (!desc || dma_submit_error(s->cookie_rx[i])) {
-			if (i) {
-				async_tx_ack(s->desc_rx[0]);
-				s->cookie_rx[0] = -EINVAL;
-			}
-			if (desc) {
-				async_tx_ack(desc);
-				s->cookie_rx[i] = -EINVAL;
-			}
-			dev_warn(s->port.dev,
-				 "Failed to re-start Rx DMA, using PIO\n");
-			sci_rx_dma_release(s, true);
-			return;
-		}
 		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
 			s->cookie_rx[i], i);
 	}
@@ -1444,6 +1432,18 @@ static void sci_submit_rx(struct sci_port *s)
 	s->active_rx = s->cookie_rx[0];
 
 	dma_async_issue_pending(chan);
+	return;
+
+fail:
+	if (i)
+		dmaengine_terminate_all(chan);
+	for (i = 0; i < 2; i++) {
+		s->desc_rx[i] = NULL;
+		s->cookie_rx[i] = -EINVAL;
+	}
+	s->active_rx = -EINVAL;
+	dev_warn(s->port.dev, "Failed to re-start Rx DMA, using PIO\n");
+	sci_rx_dma_release(s, true);
 }
 
 static void work_fn_rx(struct work_struct *work)
-- 
1.9.1

