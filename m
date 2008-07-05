From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:33:07 +0000
Subject: [PATCH] sh: fix sh-sci build breakage in linux-next
Message-Id: <20080705033307.17255.91257.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix tty member build error in sh-sci.c.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to linux-next, works ok on ap325rxa.

 drivers/serial/sh-sci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2008-07-05 09:52:31.000000000 +0900
@@ -536,7 +536,7 @@ static void sci_transmit_chars(struct ua
 static inline void sci_receive_chars(struct uart_port *port)
 {
 	struct sci_port *sci_port = (struct sci_port *)port;
-	struct tty_struct *tty = port->info->tty;
+	struct tty_struct *tty = port->info->port.tty;
 	int i, count, copied = 0;
 	unsigned short status;
 	unsigned char flag;
@@ -657,7 +657,7 @@ static inline int sci_handle_errors(stru
 {
 	int copied = 0;
 	unsigned short status = sci_in(port, SCxSR);
-	struct tty_struct *tty = port->info->tty;
+	struct tty_struct *tty = port->info->port.tty;
 
 	if (status & SCxSR_ORER(port)) {
 		/* overrun error */
@@ -707,7 +707,7 @@ static inline int sci_handle_breaks(stru
 {
 	int copied = 0;
 	unsigned short status = sci_in(port, SCxSR);
-	struct tty_struct *tty = port->info->tty;
+	struct tty_struct *tty = port->info->port.tty;
 	struct sci_port *s = &sci_ports[port->line];
 
 	if (uart_handle_break(port))
@@ -777,7 +777,7 @@ static irqreturn_t sci_er_interrupt(int 
 	} else {
 #if defined(SCIF_ORER)
 		if((sci_in(port, SCLSR) & SCIF_ORER) != 0) {
-			struct tty_struct *tty = port->info->tty;
+			struct tty_struct *tty = port->info->port.tty;
 
 			sci_out(port, SCLSR, 0);
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
