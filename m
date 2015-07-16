From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:45 +0000
Subject: [PATCH/RFC v2 14/29] serial: sh-sci: Improve comments for DMA timeout calculation
Message-Id: <1437070920-28069-15-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reformat, grammar improvements, use "ms" instead of "msec".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 63dab7ce5be92b6b..d8a851b913dcadd7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2046,13 +2046,13 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
 	 * Calculate delay for 2 DMA buffers (4 FIFO).
-	 * See serial_core.c::uart_update_timeout(). With 10
-	 * bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
-	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
-	 * Then below we calculate 5 jiffies (20ms) for 2 DMA buffers (4 FIFO
-	 * sizes), but when performing a faster transfer, value obtained by
-	 * this formula is may not enough. Therefore, if value is smaller than
-	 * 20msec, this sets 20msec as timeout of DMA.
+	 * See serial_core.c::uart_update_timeout().
+	 * With 10 bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above
+	 * function calculates 1 jiffie for the data plus 5 jiffies for the
+	 * "slop(e)." Then below we calculate 5 jiffies (20ms) for 2 DMA
+	 * buffers (4 FIFO sizes), but when performing a faster transfer, the
+	 * value obtained by this formula is too small. Therefore, if the value
+	 * is smaller than 20ms, use 20ms as the timeout value for DMA.
 	 */
 	if (s->chan_rx) {
 		unsigned int bits;
-- 
1.9.1

