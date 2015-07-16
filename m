From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:37 +0000
Subject: [PATCH/RFC v2 06/29] serial: sh-sci: Use min_t()/max_t() instead of casts
Message-Id: <1437070920-28069-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When comparing differently sized types, it's better to use
min_t()/max_t() than adding casts.

Also use "unsigned int" instead of "int", as that's the right type for
the length of an SG entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8ffc6320ff0a8448..afbfcab8f19a6b99 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1520,7 +1520,8 @@ static void work_fn_tx(struct work_struct *work)
 	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
 	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
 		sg->offset;
-	sg_dma_len(sg) = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
+	sg_dma_len(sg) = min_t(unsigned int,
+		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
 		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
 	spin_unlock_irq(&port->lock);
 
@@ -1746,7 +1747,7 @@ static void sci_request_dma(struct uart_port *port)
 
 		s->chan_rx = chan;
 
-		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
+		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
 		buf[0] = dma_alloc_coherent(chan->device->dev,
 					    s->buf_len_rx * 2, &dma[0],
 					    GFP_KERNEL);
-- 
1.9.1

