From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 May 2015 18:06:12 +0000
Subject: [PATCH 6/8] serial: sh-sci: Use sg_init_one() helper instead of open coding
Message-Id: <1432145174-11534-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note: There's another sg_init_table()/sg_set_page() combo in
      sci_request_dma() that looks eligible for conversion to
      sg_init_one().
      However, that one operates on memory allocated by
      dma_alloc_coherent(), which triggers the

	  BUG_ON(!virt_addr_valid(buf));

      in sg_set_buf() if CONFIG_DEBUG_SG=y. Sigh...
---
 drivers/tty/serial/sh-sci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d2734e13b17bf720..c9fd4e8d7b6537c2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1713,12 +1713,9 @@ static void sci_request_dma(struct uart_port *port)
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
 		s->chan_tx = chan;
-		sg_init_table(&s->sg_tx, 1);
 		/* UART circular tx buffer is an aligned page. */
 		BUG_ON(offset_in_page(port->state->xmit.buf));
-		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
-			    UART_XMIT_SIZE,
-			    offset_in_page(port->state->xmit.buf));
+		sg_init_one(&s->sg_tx, port->state->xmit.buf, UART_XMIT_SIZE);
 		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
 				  DMA_TO_DEVICE);
 		if (!nent)
-- 
1.9.1

