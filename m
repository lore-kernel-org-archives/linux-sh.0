From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:30 +0000
Subject: [PATCH 007/013] sh-sci: improve clock framework support
Message-Id: <20090121151430.29269.65179.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use enable/disable hooks for clock framework integration.
Make sure we control the clock for the serial console as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c    |   87 +++++++++++++++++++++++++++-----------------
 include/linux/serial_sci.h |    1 
 2 files changed, 56 insertions(+), 32 deletions(-)

--- 0007/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-21 19:27:51.000000000 +0900
@@ -76,8 +76,10 @@ struct sci_port {
 	int			break_flag;
 
 #ifdef CONFIG_HAVE_CLK
-	/* Port clock */
-	struct clk		*clk;
+	/* Interface clock */
+	struct clk		*iclk;
+	/* Data clock */
+	struct clk		*dclk;
 #endif
 	struct list_head	node;
 };
@@ -146,7 +148,7 @@ static void sci_poll_put_char(struct uar
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_in(port, SCxSR);            /* Dummy read */
-	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port));
+	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 	sci_out(port, SCxTDR, c);
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
@@ -166,12 +168,12 @@ static void h8300_sci_config(struct uart
 		*mstpcrl &= ~mask;
 }
 
-static inline void h8300_sci_enable(struct uart_port *port)
+static void h8300_sci_enable(struct uart_port *port)
 {
 	h8300_sci_config(port, sci_enable);
 }
 
-static inline void h8300_sci_disable(struct uart_port *port)
+static void h8300_sci_disable(struct uart_port *port)
 {
 	h8300_sci_config(port, sci_disable);
 }
@@ -740,13 +742,34 @@ static int sci_notifier(struct notifier_
 	    (phase = CPUFREQ_RESUMECHANGE)) {
 		spin_lock_irqsave(&priv->lock, flags);
 		list_for_each_entry(sci_port, &priv->ports, node)
-			sci_port->port.uartclk = clk_get_rate(sci_port->clk);
+			sci_port->port.uartclk = clk_get_rate(sci_port->dclk);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return NOTIFY_OK;
 }
+
+static void sci_clk_enable(struct uart_port *port)
+{
+	struct sci_port *sci_port = to_sci_port(port);
+
+	clk_enable(sci_port->dclk);
+	sci_port->port.uartclk = clk_get_rate(sci_port->dclk);
+
+	if (sci_port->iclk)
+		clk_enable(sci_port->iclk);
+}
+
+static void sci_clk_disable(struct uart_port *port)
+{
+	struct sci_port *sci_port = to_sci_port(port);
+
+	if (sci_port->iclk)
+		clk_disable(sci_port->iclk);
+
+	clk_disable(sci_port->dclk);
+}
 #endif
 
 static int sci_request_irq(struct sci_port *port)
@@ -878,10 +901,6 @@ static int sci_startup(struct uart_port 
 	if (s->enable)
 		s->enable(port);
 
-#ifdef CONFIG_HAVE_CLK
-	s->clk = clk_get(NULL, "module_clk");
-#endif
-
 	sci_request_irq(s);
 	sci_start_tx(port);
 	sci_start_rx(port, 1);
@@ -899,11 +918,6 @@ static void sci_shutdown(struct uart_por
 
 	if (s->disable)
 		s->disable(port);
-
-#ifdef CONFIG_HAVE_CLK
-	clk_put(s->clk);
-	s->clk = NULL;
-#endif
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
@@ -1043,7 +1057,8 @@ static struct uart_ops sci_uart_ops = {
 #endif
 };
 
-static void __devinit sci_init_single(struct sci_port *sci_port,
+static void __devinit sci_init_single(struct platform_device *dev,
+				      struct sci_port *sci_port,
 				      unsigned int index,
 				      struct plat_sci_port *p)
 {
@@ -1059,14 +1074,10 @@ static void __devinit sci_init_single(st
 #endif
 	sci_port->port.uartclk	= CONFIG_CPU_CLOCK;
 #elif defined(CONFIG_HAVE_CLK)
-	/*
-	 * XXX: We should use a proper SCI/SCIF clock
-	 */
-	{
-		struct clk *clk = clk_get(NULL, "module_clk");
-		sci_port->port.uartclk = clk_get_rate(clk);
-		clk_put(clk);
-	}
+	sci_port->iclk		= p->clk ? clk_get(&dev->dev, p->clk) : NULL;
+	sci_port->dclk		= clk_get(&dev->dev, "module_clk");
+	sci_port->enable	= sci_clk_enable;
+	sci_port->disable	= sci_clk_disable;
 #else
 #error "Need a valid uartclk"
 #endif
@@ -1080,9 +1091,11 @@ static void __devinit sci_init_single(st
 
 	sci_port->port.irq	= p->irqs[SCIx_TXI_IRQ];
 	sci_port->port.flags	= p->flags;
+	sci_port->port.dev	= &dev->dev;
 	sci_port->type		= sci_port->port.type = p->type;
 
 	memcpy(&sci_port->irqs, &p->irqs, sizeof(p->irqs));
+
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
@@ -1106,7 +1119,22 @@ static void serial_console_putchar(struc
 static void serial_console_write(struct console *co, const char *s,
 				 unsigned count)
 {
-	uart_console_write(co->data, s, count, serial_console_putchar);
+	struct uart_port *port = co->data;
+	struct sci_port *sci_port = to_sci_port(port);
+	unsigned short bits;
+
+	if (sci_port->enable)
+		sci_port->enable(port);
+
+	uart_console_write(port, s, count, serial_console_putchar);
+
+	/* wait until fifo is empty and last bit has been transmitted */
+	bits = SCxSR_TDxE(port) | SCxSR_TEND(port);
+	while ((sci_in(port, SCxSR) & bits) != bits)
+		cpu_relax();
+
+	if (sci_port->disable)
+		sci_port->disable(port);
 }
 
 static int __init serial_console_setup(struct console *co, char *options)
@@ -1140,11 +1168,6 @@ static int __init serial_console_setup(s
 	if (!port->type)
 		return -ENODEV;
 
-#ifdef CONFIG_HAVE_CLK
-	if (!sci_port->clk)
-		sci_port->clk = clk_get(NULL, "module_clk");
-#endif
-
 	sci_config_port(port, 0);
 
 	if (sci_port->enable)
@@ -1159,6 +1182,7 @@ static int __init serial_console_setup(s
 	if (ret = 0)
 		sci_stop_rx(port);
 #endif
+	/* TODO: disable clock */
 	return ret;
 }
 
@@ -1238,8 +1262,7 @@ static int __devinit sci_probe_single(st
 		return 0;
 	}
 
-	sciport->port.dev = &dev->dev;
-	sci_init_single(sciport, index, p);
+	sci_init_single(dev, sciport, index, p);
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 	if (ret)
--- 0004/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2009-01-21 19:25:20.000000000 +0900
@@ -25,6 +25,7 @@ struct plat_sci_port {
 	unsigned int	irqs[SCIx_NR_IRQS];	/* ERI, RXI, TXI, BRI */
 	unsigned int	type;			/* SCI / SCIF / IRDA */
 	upf_t		flags;			/* UPF_* flags */
+	char		*clk;			/* clock string */
 };
 
 #endif /* __LINUX_SERIAL_SCI_H */
