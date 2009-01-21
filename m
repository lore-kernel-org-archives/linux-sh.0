From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:06 +0000
Subject: [PATCH 004/013] sh-sci: rework serial console support
Message-Id: <20090121151406.29269.2905.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci serial console code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |   48 ++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

--- 0004/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-21 19:17:10.000000000 +0900
@@ -91,10 +91,6 @@ struct sh_sci_priv {
 #endif
 };
 
-#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
-static struct sci_port *serial_console_port;
-#endif
-
 /* Function prototypes */
 static void sci_stop_tx(struct uart_port *port);
 
@@ -1087,6 +1083,19 @@ static void __init sci_init_ports(void)
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+
+struct tty_driver *serial_console_device(struct console *co, int *index)
+{
+	struct uart_driver *p = &sci_uart_driver;
+	*index = co->index;
+	return p->tty_driver;
+}
+
+static void serial_console_putchar(struct uart_port *port, int ch)
+{
+	sci_poll_put_char(port, ch);
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -1094,19 +1103,12 @@ static void __init sci_init_ports(void)
 static void serial_console_write(struct console *co, const char *s,
 				 unsigned count)
 {
-	struct uart_port *port = &serial_console_port->port;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		if (*s = 10)
-			sci_poll_put_char(port, '\r');
-
-		sci_poll_put_char(port, *s++);
-	}
+	uart_console_write(co->data, s, count, serial_console_putchar);
 }
 
 static int __init serial_console_setup(struct console *co, char *options)
 {
+	struct sci_port *sci_port;
 	struct uart_port *port;
 	int baud = 115200;
 	int bits = 8;
@@ -1122,8 +1124,9 @@ static int __init serial_console_setup(s
 	if (co->index >= SCI_NPORTS)
 		co->index = 0;
 
-	serial_console_port = &sci_ports[co->index];
-	port = &serial_console_port->port;
+	sci_port = &sci_ports[co->index];
+	port = &sci_port->port;
+	co->data = port;
 
 	/*
 	 * Also need to check port->type, we don't actually have any
@@ -1133,21 +1136,17 @@ static int __init serial_console_setup(s
 	 */
 	if (!port->type)
 		return -ENODEV;
-	if (!port->membase || !port->mapbase)
-		return -ENODEV;
-
-	port->type = serial_console_port->type;
 
 #ifdef CONFIG_HAVE_CLK
-	if (!serial_console_port->clk)
-		serial_console_port->clk = clk_get(NULL, "module_clk");
+	if (!sci_port->clk)
+		sci_port->clk = clk_get(NULL, "module_clk");
 #endif
 
 	if (port->flags & UPF_IOREMAP)
 		sci_config_port(port, 0);
 
-	if (serial_console_port->enable)
-		serial_console_port->enable(port);
+	if (sci_port->enable)
+		sci_port->enable(port);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1163,12 +1162,11 @@ static int __init serial_console_setup(s
 
 static struct console serial_console = {
 	.name		= "ttySC",
-	.device		= uart_console_device,
+	.device		= serial_console_device,
 	.write		= serial_console_write,
 	.setup		= serial_console_setup,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
-	.data		= &sci_uart_driver,
 };
 
 static int __init sci_console_init(void)
