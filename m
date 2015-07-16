From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:39 +0000
Subject: [PATCH/RFC v2 08/29] serial: sh-sci: Use offset_in_page() helper instead of open coding
Message-Id: <1437070920-28069-9-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

TODO: Simplify by switching to dma_map_single()

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add TODO
---
 drivers/tty/serial/sh-sci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index eae2989890337ee8..d6ee645de1d40794 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1715,10 +1715,10 @@ static void sci_request_dma(struct uart_port *port)
 		s->chan_tx = chan;
 		sg_init_table(&s->sg_tx, 1);
 		/* UART circular tx buffer is an aligned page. */
-		BUG_ON((uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
+		BUG_ON(offset_in_page(port->state->xmit.buf));
 		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
 			    UART_XMIT_SIZE,
-			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
+			    offset_in_page(port->state->xmit.buf));
 		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
 				  DMA_TO_DEVICE);
 		if (!nent)
@@ -1768,7 +1768,7 @@ static void sci_request_dma(struct uart_port *port)
 
 			sg_init_table(sg, 1);
 			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
-				    (uintptr_t)buf[i] & ~PAGE_MASK);
+				    offset_in_page(buf[i]));
 			sg_dma_address(sg) = dma[i];
 		}
 
-- 
1.9.1

