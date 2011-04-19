From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Apr 2011 10:38:25 +0000
Subject: [PATCH] serial: sh-sci: Runtime PM support
Message-Id: <20110419103825.23756.98622.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for Runtime PM in the sh-sci driver. 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/tty/serial/sh-sci.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0006/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2011-04-19 18:48:01.000000000 +0900
@@ -43,6 +43,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_sci.h>
 #include <linux/notifier.h>
+#include <linux/pm_runtime.h>
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/ctype.h>
@@ -562,6 +563,9 @@ static void sci_break_timer(unsigned lon
 {
 	struct sci_port *port = (struct sci_port *)data;
 
+	if (port->enable)
+		port->enable(&port->port);
+
 	if (sci_rxd_in(&port->port) = 0) {
 		port->break_flag = 1;
 		sci_schedule_break_timer(port);
@@ -571,6 +575,9 @@ static void sci_break_timer(unsigned lon
 		sci_schedule_break_timer(port);
 	} else
 		port->break_flag = 0;
+
+	if (port->disable)
+		port->disable(&port->port);
 }
 
 static int sci_handle_errors(struct uart_port *port)
@@ -839,6 +846,8 @@ static void sci_clk_enable(struct uart_p
 {
 	struct sci_port *sci_port = to_sci_port(port);
 
+	pm_runtime_get_sync(port->dev);
+
 	clk_enable(sci_port->iclk);
 	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
 	clk_enable(sci_port->fclk);
@@ -850,6 +859,8 @@ static void sci_clk_disable(struct uart_
 
 	clk_disable(sci_port->fclk);
 	clk_disable(sci_port->iclk);
+
+	pm_runtime_put_sync(port->dev);
 }
 
 static int sci_request_irq(struct sci_port *port)
@@ -1758,6 +1769,8 @@ static int __devinit sci_init_single(str
 		sci_port->enable = sci_clk_enable;
 		sci_port->disable = sci_clk_disable;
 		port->dev = &dev->dev;
+
+		pm_runtime_enable(&dev->dev);
 	}
 
 	sci_port->break_timer.data = (unsigned long)sci_port;
@@ -1938,6 +1951,7 @@ static int sci_remove(struct platform_de
 	clk_put(port->iclk);
 	clk_put(port->fclk);
 
+	pm_runtime_disable(&dev->dev);
 	return 0;
 }
 
