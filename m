From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 13 Apr 2009 04:17:59 +0000
Subject: [Review request] sh-sci clock
Message-Id: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

Now I'm creating SH7724 sub cpu support patch.
And I would like to use "bus_clk" for SCIFA on sh-sci.
Current sh-sci use module_clk only.
So, I created attached patch to be able to select "bus_clk" or "module_clk".

It works well on SH7724/SH7723/SH7722
But I can not check about other CPU.

Please review it.

** from here **

sh-sci: sh-sci can select bus_clk or module_clk

SCIFA had used module_clk up to now though it used bus_clk.
This patch modify this problem, and checked by SH7723/SH7722.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/serial/sh-sci.c |   18 ++++++++++++++----
 drivers/serial/sh-sci.h |    4 ++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index dbf5357..dd60a1c 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -92,6 +92,11 @@ static void sci_stop_tx(struct uart_port *port);
 static struct sci_port sci_ports[SCI_NPORTS];
 static struct uart_driver sci_uart_driver;
 
+static inline const char *get_clk_source(struct sci_port *s)
+{
+	return (s->type = PORT_SCIFA) ? "bus_clk" : "module_clk";
+}
+
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
 {
@@ -871,7 +876,7 @@ static int sci_startup(struct uart_port *port)
 		s->enable(port);
 
 #ifdef CONFIG_HAVE_CLK
-	s->clk = clk_get(NULL, "module_clk");
+	s->clk = clk_get(NULL, get_clk_source(s));
 #endif
 
 	sci_request_irq(s);
@@ -1059,7 +1064,8 @@ static void __init sci_init_ports(void)
 		 * XXX: We should use a proper SCI/SCIF clock
 		 */
 		{
-			struct clk *clk = clk_get(NULL, "module_clk");
+			struct clk *clk = clk_get(NULL,
+						  get_clk_source(sci_ports+i));
 			sci_ports[i].port.uartclk = clk_get_rate(clk);
 			clk_put(clk);
 		}
@@ -1147,8 +1153,12 @@ static int __init serial_console_setup(struct console *co, char *options)
 	port->type = serial_console_port->type;
 
 #ifdef CONFIG_HAVE_CLK
-	if (!serial_console_port->clk)
-		serial_console_port->clk = clk_get(NULL, "module_clk");
+	if (!serial_console_port->clk) {
+		serial_console_port->clk +			clk_get(NULL, get_clk_source(serial_console_port));
+		serial_console_port->port.uartclk +			clk_get_rate(serial_console_port->clk);
+	}
 #endif
 
 	if (port->flags & UPF_IOREMAP)
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index d0aa82d..5215b9d 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -761,9 +761,9 @@ static inline int sci_rxd_in(struct uart_port *port)
 static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 {
 	if (port->type = PORT_SCIF)
-		return (clk+16*bps)/(32*bps)-1;
+		return (clk/(32*bps))-1;
 	else
-		return ((clk*2)+16*bps)/(16*bps)-1;
+		return (clk/(16*bps))-1;
 }
 #define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #elif defined(__H8300H__) || defined(__H8300S__)
-- 
1.5.6.3

