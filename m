From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 22 Dec 2009 03:37:28 +0000
Subject: [PATCH] sh-sci: earlyprintk zero uartclk fix
Message-Id: <20091222033728.7243.23141.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/serial/sh-sci.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- 0014/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-12-21 21:53:07.000000000 +0900
@@ -902,11 +902,20 @@ static void sci_shutdown(struct uart_por
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
-	unsigned int status, baud, smr_val;
+	unsigned int status, baud, smr_val, max_baud;
 	int t = -1;
 
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
-	if (likely(baud))
+	/* earlyprintk comes here early on with port->uartclk set to zero.
+	 * the clock framework is not up and running at this point so here
+	 * we assume that 115200 is the maximum baud rate. please note that
+	 * the baud rate is not programmed during earlyprintk - it is assumed
+	 * that the previous boot loader has enabled required clocks and
+	 * setup the baud rate generator hardware for us already.
+	 */
+	max_baud = port->uartclk ? port->uartclk / 16 : 115200;
+
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
+	if (likely(baud && port->uartclk))
 		t = SCBRR_VALUE(baud, port->uartclk);
 
 	do {
