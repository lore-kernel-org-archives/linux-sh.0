From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 07 Jun 2015 09:28:27 +0000
Subject: [RFC] sh-sci: Add CONFIG_SERIAL_EARLYCON support
Message-Id: <1433669307-19478-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

"earlyprintk" is architecture specific option.
I think general "earlycon" option support more better.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/Kconfig  |  6 ++++
 drivers/tty/serial/sh-sci.c | 70 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index dea1eff..b4c9820 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -741,6 +741,12 @@ config SERIAL_SH_SCI_CONSOLE
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 
+config SERIAL_SH_SCI_EARLYCON
+	bool "Support for early console on SuperH SCI(F)"
+	depends on SERIAL_SH_SCI=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
 	depends on SERIAL_SH_SCI && SH_DMAE
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 95772cf..6eb82e1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -466,7 +466,8 @@ static void sci_port_disable(struct sci_port *sci_port)
 	pm_runtime_put_sync(sci_port->port.dev);
 }
 
-#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
+#if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_SH_SCI_CONSOLE) \
+	|| defined(CONFIG_SERIAL_EARLYCON)
 
 #ifdef CONFIG_CONSOLE_POLL
 static int sci_poll_get_char(struct uart_port *port)
@@ -2339,7 +2340,7 @@ static void sci_cleanup_single(struct sci_port *port)
 	pm_runtime_disable(port->port.dev);
 }
 
-#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, int ch)
 {
 	sci_poll_put_char(port, ch);
@@ -2359,9 +2360,12 @@ static void serial_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	local_irq_save(flags);
+#if defined(SUPPORT_SYSRQ)
 	if (port->sysrq)
 		locked = 0;
-	else if (oops_in_progress)
+	else
+#endif
+	if (oops_in_progress)
 		locked = spin_trylock(&port->lock);
 	else
 		spin_lock(&port->lock);
@@ -2719,6 +2723,66 @@ static void __exit sci_exit(void)
 early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
+#ifdef CONFIG_SERIAL_EARLYCON
+static struct __init plat_sci_port port_cfg;
+
+static int __init early_console_setup(struct earlycon_device *device,
+				      int type)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.serial_in = sci_serial_in;
+	device->port.serial_out	= sci_serial_out;
+	device->port.type = type;
+	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].cfg = &port_cfg;
+	sci_ports[0].cfg->type = type;
+	sci_probe_regmap(sci_ports[0].cfg);
+	port_cfg.scscr = SCSCR_RE | SCSCR_TE;
+	sci_serial_out(&sci_ports[0].port, SCSCR, port_cfg.scscr);
+
+	device->con->write = serial_console_write;
+	return 0;
+}
+static int __init sci_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCI);
+}
+static int __init scif_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIF);
+}
+static int __init scifa_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIFA);
+}
+static int __init scifb_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_SCIFB);
+}
+static int __init hscif_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	return early_console_setup(device, PORT_HSCIF);
+}
+
+EARLYCON_DECLARE(sci, sci_early_console_setup);
+OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
+EARLYCON_DECLARE(scif, scif_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
+EARLYCON_DECLARE(scifa, scifa_early_console_setup);
+OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
+EARLYCON_DECLARE(scifb, scifb_early_console_setup);
+OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
+EARLYCON_DECLARE(hscif, hscif_early_console_setup);
+OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
+#endif
+
 module_init(sci_init);
 module_exit(sci_exit);
 
-- 
2.1.4

