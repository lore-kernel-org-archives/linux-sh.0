From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:44 +0000
Subject: [PATCH/RFC v2 13/29] serial: sh-sci: Drop path in reference to serial_core.c
Message-Id: <1437070920-28069-14-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

serial_core.c was moved from drivers/serial/ to drivers/tty/serial/ a
while ago. Remove the path to make it move-proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index df4727186d7a9f29..63dab7ce5be92b6b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2046,7 +2046,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
 	 * Calculate delay for 2 DMA buffers (4 FIFO).
-	 * See drivers/serial/serial_core.c::uart_update_timeout(). With 10
+	 * See serial_core.c::uart_update_timeout(). With 10
 	 * bits (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
 	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
 	 * Then below we calculate 5 jiffies (20ms) for 2 DMA buffers (4 FIFO
-- 
1.9.1

