From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:50 +0000
Subject: [PATCH/RFC v2 19/29] serial: sh-sci: Use DMA submission helpers instead of open-coding
Message-Id: <1437070920-28069-20-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace open-coded
  - calls to dma_async_tx_descriptor.tx_submit() by calls to the
    dmaengine_submit() helper,
  - dma_cookie_t comparisons by calls to dma_submit_error().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6eb24f72e89906bb..dec59c0075bbb4bf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1416,10 +1416,10 @@ static void sci_submit_rx(struct sci_port *s)
 			s->desc_rx[i] = desc;
 			desc->callback = sci_dma_rx_complete;
 			desc->callback_param = s;
-			s->cookie_rx[i] = desc->tx_submit(desc);
+			s->cookie_rx[i] = dmaengine_submit(desc);
 		}
 
-		if (!desc || s->cookie_rx[i] < 0) {
+		if (!desc || dma_submit_error(s->cookie_rx[i])) {
 			if (i) {
 				async_tx_ack(s->desc_rx[0]);
 				s->cookie_rx[0] = -EINVAL;
@@ -1485,8 +1485,8 @@ static void work_fn_rx(struct work_struct *work)
 		return;
 	}
 
-	s->cookie_rx[new] = desc->tx_submit(desc);
-	if (s->cookie_rx[new] < 0) {
+	s->cookie_rx[new] = dmaengine_submit(desc);
+	if (dma_submit_error(s->cookie_rx[new])) {
 		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 		sci_rx_dma_release(s, true);
 		return;
@@ -1542,8 +1542,8 @@ static void work_fn_tx(struct work_struct *work)
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
 	spin_unlock_irq(&port->lock);
-	s->cookie_tx = desc->tx_submit(desc);
-	if (s->cookie_tx < 0) {
+	s->cookie_tx = dmaengine_submit(desc);
+	if (dma_submit_error(s->cookie_tx)) {
 		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
@@ -1574,7 +1574,7 @@ static void sci_start_tx(struct uart_port *port)
 	}
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
-	    s->cookie_tx < 0) {
+	    dma_submit_error(s->cookie_tx)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
 	}
-- 
1.9.1

