From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 May 2015 18:06:13 +0000
Subject: [PATCH 7/8] serial: sh-sci: Improve DMA error messages
Message-Id: <1432145174-11534-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make the life of the driver developer/debugger easier:
  - Add __func__ prefix to identical messages,
  - Add DMA directions to messages,
  - Add TX failure messages.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c9fd4e8d7b6537c2..42634d99d047681f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1323,7 +1323,8 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 	} else if (s->active_rx = s->cookie_rx[1]) {
 		active = 1;
 	} else {
-		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
+			s->active_rx);
 		return 0;
 	}
 
@@ -1433,7 +1434,7 @@ static void sci_submit_rx(struct sci_port *s)
 				s->cookie_rx[i] = -EINVAL;
 			}
 			dev_warn(s->port.dev,
-				 "failed to re-start DMA, using PIO\n");
+				 "Failed to re-start Rx DMA, using PIO\n");
 			sci_rx_dma_release(s, true);
 			return;
 		}
@@ -1458,7 +1459,8 @@ static void work_fn_rx(struct work_struct *work)
 	} else if (s->active_rx = s->cookie_rx[1]) {
 		new = 1;
 	} else {
-		dev_err(port->dev, "cookie %d not found!\n", s->active_rx);
+		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
+			s->active_rx);
 		return;
 	}
 	desc = s->desc_rx[new];
@@ -1532,6 +1534,7 @@ static void work_fn_tx(struct work_struct *work)
 			sg, s->sg_len_tx, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dev_warn(port->dev, "Failed preparing Tx DMA descriptor\n");
 		/* switch to PIO */
 		sci_tx_dma_release(s, true);
 		return;
@@ -1718,13 +1721,15 @@ static void sci_request_dma(struct uart_port *port)
 		sg_init_one(&s->sg_tx, port->state->xmit.buf, UART_XMIT_SIZE);
 		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
 				  DMA_TO_DEVICE);
-		if (!nent)
+		if (!nent) {
+			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			sci_tx_dma_release(s, false);
-		else
+		} else {
 			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n",
 				__func__,
 				sg_dma_len(&s->sg_tx), port->state->xmit.buf,
 				&sg_dma_address(&s->sg_tx));
+		}
 
 		s->sg_len_tx = nent;
 
@@ -1752,7 +1757,7 @@ static void sci_request_dma(struct uart_port *port)
 
 		if (!buf[0]) {
 			dev_warn(port->dev,
-				 "failed to allocate dma buffer, using PIO\n");
+				 "Failed to allocate Rx dma buffer, using PIO\n");
 			sci_rx_dma_release(s, true);
 			return;
 		}
-- 
1.9.1

