From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:38 +0000
Subject: [PATCH 008/013] sh-sci: use to_sci_port() if possible
Message-Id: <20090121151438.29269.94681.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

--- 0007/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-20 19:25:11.000000000 +0900
@@ -616,7 +616,7 @@ static inline int sci_handle_breaks(stru
 	int copied = 0;
 	unsigned short status = sci_in(port, SCxSR);
 	struct tty_struct *tty = port->info->port.tty;
-	struct sci_port *s = &sci_ports[port->line];
+	struct sci_port *s = to_sci_port(port);
 
 	if (uart_handle_break(port))
 		return 0;
@@ -873,7 +873,7 @@ static void sci_break_ctl(struct uart_po
 
 static int sci_startup(struct uart_port *port)
 {
-	struct sci_port *s = &sci_ports[port->line];
+	struct sci_port *s = to_sci_port(port);
 
 	if (s->enable)
 		s->enable(port);
@@ -891,7 +891,7 @@ static int sci_startup(struct uart_port 
 
 static void sci_shutdown(struct uart_port *port)
 {
-	struct sci_port *s = &sci_ports[port->line];
+	struct sci_port *s = to_sci_port(port);
 
 	sci_stop_rx(port);
 	sci_stop_tx(port);
@@ -988,7 +988,7 @@ static int sci_request_port(struct uart_
 
 static void sci_config_port(struct uart_port *port, int flags)
 {
-	struct sci_port *s = &sci_ports[port->line];
+	struct sci_port *s = to_sci_port(port);
 
 	port->type = s->type;
 
@@ -1006,7 +1006,7 @@ static void sci_config_port(struct uart_
 
 static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct sci_port *s = &sci_ports[port->line];
+	struct sci_port *s = to_sci_port(port);
 
 	if (ser->irq != s->irqs[SCIx_TXI_IRQ] || ser->irq > nr_irqs)
 		return -EINVAL;
