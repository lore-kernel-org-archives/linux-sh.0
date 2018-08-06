From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 06 Aug 2018 14:07:52 +0000
Subject: [PATCH/RFC 1/4] sh-sci: Use a separate sci_port for earlycon
Message-Id: <20180806140755.24087-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

The first sh-sci port and earlycon use the same sci_port.
Hence after the initialization of the first port, earlycon may die.

Fis this by assigning a separate sci_port for earlycon.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
[geert: Rebased, reworded]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I still don't fully understand why Sato-san needed this for H8/300, and
we never needed it on Renesas ARM SoCs before.

Also, I don't like the early index.
---
 drivers/tty/serial/sh-sci.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ac4424bf6b136cc4..cf3195bed0246a3d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -164,6 +164,8 @@ struct sci_port {
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
 
 static struct sci_port sci_ports[SCI_NPORTS];
+#define EARLY_INDEX 256
+static struct sci_port earlycon_port;
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 
@@ -2941,12 +2943,16 @@ static void serial_console_putchar(struct uart_port *port, int ch)
 static void serial_console_write(struct console *co, const char *s,
 				 unsigned count)
 {
-	struct sci_port *sci_port = &sci_ports[co->index];
-	struct uart_port *port = &sci_port->port;
 	unsigned short bits, ctrl, ctrl_temp;
+	struct sci_port *sci_port;
+	struct uart_port *port;
 	unsigned long flags;
 	int locked = 1;
 
+	sci_port = (co->index != EARLY_INDEX) ?
+		&sci_ports[co->index] : &earlycon_port;
+	port = &sci_port->port;
+
 #if defined(SUPPORT_SYSRQ)
 	if (port->sysrq)
 		locked = 0;
@@ -3367,12 +3373,13 @@ static int __init early_console_setup(struct earlycon_device *device,
 	device->port.serial_in = sci_serial_in;
 	device->port.serial_out	= sci_serial_out;
 	device->port.type = type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	device->con->index = EARLY_INDEX;
+	memcpy(&earlycon_port.port, &device->port, sizeof(struct uart_port));
 	port_cfg.type = type;
-	sci_ports[0].cfg = &port_cfg;
-	sci_ports[0].params = sci_probe_regmap(&port_cfg);
-	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
-	sci_serial_out(&sci_ports[0].port, SCSCR,
+	earlycon_port.cfg = &port_cfg;
+	earlycon_port.params = sci_probe_regmap(&port_cfg);
+	port_cfg.scscr = sci_serial_in(&earlycon_port.port, SCSCR);
+	sci_serial_out(&earlycon_port.port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
-- 
2.17.1

