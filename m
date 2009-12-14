From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 10:24:42 +0000
Subject: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This is V2 of early serial console support for the sh-sci
driver. The early serial console is using early platform
devices and "earlyprintk". To use this feature the early
platform devices must be broken out to one device per port
and the desired port should be selected on the kernel command
line like: "earlyprintk=sh-sci.N[,baudrate][,keep]"

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "Driver Core: Early platform driver buffer"

 Changes since V1:
 - Removed #ifdefs, only CONFIG_SERIAL_SH_SCI_CONSOLE now left

 Platform device patches apply on top of this, a cleanup patch
 that removes the old duplicated serial port code will follow.

 arch/sh/kernel/early_printk.c |   10 -------
 arch/sh/kernel/setup.c        |    3 ++
 drivers/serial/sh-sci.c       |   54 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 18 deletions(-)

--- 0001/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2009-12-14 15:57:25.000000000 +0900
@@ -191,15 +191,7 @@ static void scif_sercon_init(char *s)
  * Setup a default console, if more than one is compiled in, rely on the
  * earlyprintk= parsing to give priority.
  */
-static struct console *early_console -#ifdef CONFIG_SH_STANDARD_BIOS
-	&bios_console
-#elif defined(CONFIG_EARLY_SCIF_CONSOLE)
-	&scif_console
-#else
-	NULL
-#endif
-	;
+static struct console *early_console;
 
 static int __init setup_early_printk(char *buf)
 {
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2009-12-14 15:58:45.000000000 +0900
@@ -423,6 +423,9 @@ void __init setup_arch(char **cmdline_p)
 
 	plat_early_device_setup();
 
+	/* Let earlyprintk output early console messages */
+	early_platform_driver_probe("earlyprintk", 1, 1);
+
 	sh_mv_setup();
 
 	/*
--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-12-14 15:57:25.000000000 +0900
@@ -1043,10 +1043,14 @@ static void __devinit sci_init_single(st
 	sci_port->port.iotype	= UPIO_MEM;
 	sci_port->port.line	= index;
 	sci_port->port.fifosize	= 1;
-	sci_port->iclk		= p->clk ? clk_get(&dev->dev, p->clk) : NULL;
-	sci_port->dclk		= clk_get(&dev->dev, "peripheral_clk");
-	sci_port->enable	= sci_clk_enable;
-	sci_port->disable	= sci_clk_disable;
+
+	if (dev) {
+		sci_port->iclk = p->clk ? clk_get(&dev->dev, p->clk) : NULL;
+		sci_port->dclk = clk_get(&dev->dev, "peripheral_clk");
+		sci_port->enable = sci_clk_enable;
+		sci_port->disable = sci_clk_disable;
+		sci_port->port.dev = &dev->dev;
+	}
 
 	sci_port->break_timer.data = (unsigned long)sci_port;
 	sci_port->break_timer.function = sci_break_timer;
@@ -1057,7 +1061,6 @@ static void __devinit sci_init_single(st
 
 	sci_port->port.irq	= p->irqs[SCIx_TXI_IRQ];
 	sci_port->port.flags	= p->flags;
-	sci_port->port.dev	= &dev->dev;
 	sci_port->type		= sci_port->port.type = p->type;
 
 	memcpy(&sci_port->irqs, &p->irqs, sizeof(p->irqs));
@@ -1101,7 +1104,7 @@ static void serial_console_write(struct 
 		sci_port->disable(port);
 }
 
-static int __init serial_console_setup(struct console *co, char *options)
+static int __devinit serial_console_setup(struct console *co, char *options)
 {
 	struct sci_port *sci_port;
 	struct uart_port *port;
@@ -1119,9 +1122,14 @@ static int __init serial_console_setup(s
 	if (co->index >= SCI_NPORTS)
 		co->index = 0;
 
-	sci_port = &sci_ports[co->index];
-	port = &sci_port->port;
-	co->data = port;
+	if (co->data) {
+		port = co->data;
+		sci_port = to_sci_port(port);
+	} else {
+		sci_port = &sci_ports[co->index];
+		port = &sci_port->port;
+		co->data = port;
+	}
 
 	/*
 	 * Also need to check port->type, we don't actually have any
@@ -1165,6 +1173,15 @@ static int __init sci_console_init(void)
 	return 0;
 }
 console_initcall(sci_console_init);
+
+static struct sci_port early_serial_port;
+static struct console early_serial_console = {
+	.name           = "early_ttySC",
+	.write          = serial_console_write,
+	.flags          = CON_PRINTBUFFER,
+};
+static char early_serial_buf[32];
+
 #endif /* CONFIG_SERIAL_SH_SCI_CONSOLE */
 
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
@@ -1250,6 +1267,21 @@ static int __devinit sci_probe(struct pl
 	struct sh_sci_priv *priv;
 	int i, ret = -EINVAL;
 
+#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+	if (is_early_platform_device(dev)) {
+		if (dev->id = -1)
+			return -ENOTSUPP;
+		early_serial_console.index = dev->id;
+		early_serial_console.data = &early_serial_port.port;
+		sci_init_single(NULL, &early_serial_port, dev->id, p);
+		serial_console_setup(&early_serial_console, early_serial_buf);
+		if (!strstr(early_serial_buf, "keep"))
+			early_serial_console.flags |= CON_BOOT;
+		register_console(&early_serial_console);
+		return 0;
+	}
+#endif
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -1349,6 +1381,10 @@ static void __exit sci_exit(void)
 	uart_unregister_driver(&sci_uart_driver);
 }
 
+#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+early_platform_init_buffer("earlyprintk", &sci_driver,
+			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
+#endif
 module_init(sci_init);
 module_exit(sci_exit);
 
