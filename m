From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:43 +0000
Subject: [PATCH/RFC v2 12/29] serial: sh-sci: Use SCSMR_CKS instead of hardcoded value 3
Message-Id: <1437070920-28069-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ec891ec51b8672e3..df4727186d7a9f29 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2001,7 +2001,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sci_reset(port);
 
-	smr_val |= serial_port_in(port, SCSMR) & 3;
+	smr_val |= serial_port_in(port, SCSMR) & SCSMR_CKS;
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-- 
1.9.1

