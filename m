From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Jun 2016 07:22:58 +0000
Subject: [PATCH] sh-sci: Separate sci_port on earlycon
Message-Id: <1467098578-10364-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

sci0 and earlycon use same sci_port.
So earlycon dead after sci0 initialize.

This fix assign separate sci_port for earlycon.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5a73620..210c95e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -146,6 +146,8 @@ struct sci_port {
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
 
 static struct sci_port sci_ports[SCI_NPORTS];
+#define EARLY_INDEX 256
+static struct sci_port earlycon_port;
 static struct uart_driver sci_uart_driver;
 
 static inline struct sci_port *
@@ -2510,7 +2512,6 @@ static int sci_init_single(struct platform_device *dev,
 	int ret;
 
 	sci_port->cfg	= p;
-
 	port->ops	= &sci_uart_ops;
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
@@ -2668,12 +2669,16 @@ static void serial_console_putchar(struct uart_port *port, int ch)
 static void serial_console_write(struct console *co, const char *s,
 				 unsigned count)
 {
-	struct sci_port *sci_port = &sci_ports[co->index];
-	struct uart_port *port = &sci_port->port;
+	struct sci_port *sci_port;
+	struct uart_port *port;
 	unsigned short bits, ctrl, ctrl_temp;
 	unsigned long flags;
 	int locked = 1;
 
+	sci_port = (co->index != EARLY_INDEX) ? 
+		&sci_ports[co->index] :  &earlycon_port;
+	port = &sci_port->port;
+
 	local_irq_save(flags);
 #if defined(SUPPORT_SYSRQ)
 	if (port->sysrq)
@@ -3036,13 +3041,14 @@ static int __init early_console_setup(struct earlycon_device *device,
 	device->port.serial_in = sci_serial_in;
 	device->port.serial_out	= sci_serial_out;
 	device->port.type = type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
-	sci_ports[0].cfg = &port_cfg;
-	sci_ports[0].cfg->type = type;
-	sci_probe_regmap(sci_ports[0].cfg);
-	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR) |
+	device->con->index = EARLY_INDEX;
+	memcpy(&earlycon_port.port, &device->port, sizeof(struct uart_port));
+	earlycon_port.cfg = &port_cfg;
+	earlycon_port.cfg->type = type;
+	sci_probe_regmap(earlycon_port.cfg);
+	port_cfg.scscr = sci_serial_in(&earlycon_port.port, SCSCR) |
 			 SCSCR_RE | SCSCR_TE;
-	sci_serial_out(&sci_ports[0].port, SCSCR, port_cfg.scscr);
+	sci_serial_out(&earlycon_port.port, SCSCR, port_cfg.scscr);
 
 	device->con->write = serial_console_write;
 	return 0;
-- 
2.7.0

