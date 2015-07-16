From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:22:00 +0000
Subject: [PATCH/RFC v2 29/29] serial: sh-sci: Remove schedule_work in sci_dma_rx_complete
Message-Id: <1437070920-28069-30-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch calls work_fn_rx() directly so that the driver can avoid
executing of next sci_dma_rx_complete() before work_fn_rx() completes.

FIXME: Move work_fn_rx() instead of using a forward declaration

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 27c811351e1bff45..7e8fa3703e5de328 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -128,6 +128,9 @@ struct sci_port {
 static void sci_start_tx(struct uart_port *port);
 static void sci_stop_tx(struct uart_port *port);
 static void sci_start_rx(struct uart_port *port);
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+static void work_fn_rx(struct work_struct *work);
+#endif
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
 
@@ -1364,7 +1367,7 @@ static void sci_dma_rx_complete(void *arg)
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
-	schedule_work(&s->work_rx);
+	work_fn_rx(&s->work_rx);
 }
 
 static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
-- 
1.9.1

