From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:55 +0000
Subject: [PATCH/RFC v2 24/29] serial: sh-sci: Stop TX and RX on shutdown
Message-Id: <1437070920-28069-25-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make sure the transmitter and receiver are stopped when shutting down
the port, to avoid new RX DMA requests to arrive.

Inspired by a patch in the BSP by Koji Matsuoka
<koji.matsuoka.xm@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9714fc1b72b3cf8c..dda1f7b13497817a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1846,12 +1846,16 @@ static void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 	unsigned long flags;
+	u16 scscr;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
+	scscr = serial_port_in(port, SCSCR);
+	scscr &= ~(SCSCR_TE | SCSCR_RE);
+	serial_port_out(port, SCSCR, scscr);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	sci_free_dma(port);
-- 
1.9.1

