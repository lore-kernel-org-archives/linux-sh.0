From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:14 +0000
Subject: [PATCH 005/013] sh-sci: replace sci_init_ports()
Message-Id: <20090121151414.29269.48426.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Replace sci_init_ports() with sci_init_single().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |  109 +++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

--- 0006/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-21 13:25:41.000000000 +0900
@@ -1040,46 +1040,64 @@ static struct uart_ops sci_uart_ops = {
 #endif
 };
 
-static void __init sci_init_ports(void)
-{
-	static int first = 1;
-	int i;
-
-	if (!first)
-		return;
-
-	first = 0;
-
-	for (i = 0; i < SCI_NPORTS; i++) {
-		sci_ports[i].port.ops		= &sci_uart_ops;
-		sci_ports[i].port.iotype	= UPIO_MEM;
-		sci_ports[i].port.line		= i;
-		sci_ports[i].port.fifosize	= 1;
+static int __devinit sci_init_single(struct sci_port *sci_port,
+				     unsigned int index,
+				     struct plat_sci_port *p)
+{
+	sci_port->port.ops	= &sci_uart_ops;
+	sci_port->port.iotype	= UPIO_MEM;
+	sci_port->port.line	= index;
+	sci_port->port.fifosize	= 1;
 
 #if defined(__H8300H__) || defined(__H8300S__)
 #ifdef __H8300S__
-		sci_ports[i].enable	= h8300_sci_enable;
-		sci_ports[i].disable	= h8300_sci_disable;
+	sci_port->enable	= h8300_sci_enable;
+	sci_port->disable	= h8300_sci_disable;
 #endif
-		sci_ports[i].port.uartclk = CONFIG_CPU_CLOCK;
+	sci_port->port.uartclk	= CONFIG_CPU_CLOCK;
 #elif defined(CONFIG_HAVE_CLK)
-		/*
-		 * XXX: We should use a proper SCI/SCIF clock
-		 */
-		{
-			struct clk *clk = clk_get(NULL, "module_clk");
-			sci_ports[i].port.uartclk = clk_get_rate(clk);
-			clk_put(clk);
-		}
+	/*
+	 * XXX: We should use a proper SCI/SCIF clock
+	 */
+	{
+		struct clk *clk = clk_get(NULL, "module_clk");
+		sci_port->port.uartclk = clk_get_rate(clk);
+		clk_put(clk);
+	}
 #else
 #error "Need a valid uartclk"
 #endif
 
-		sci_ports[i].break_timer.data = (unsigned long)&sci_ports[i];
-		sci_ports[i].break_timer.function = sci_break_timer;
+	sci_port->break_timer.data = (unsigned long)sci_port;
+	sci_port->break_timer.function = sci_break_timer;
+	init_timer(&sci_port->break_timer);
+
+	sci_port->port.mapbase	= p->mapbase;
 
-		init_timer(&sci_ports[i].break_timer);
+	if (p->mapbase && !p->membase) {
+		if (p->flags & UPF_IOREMAP) {
+			p->membase = ioremap_nocache(p->mapbase, 0x40);
+			if (IS_ERR(p->membase))
+				return PTR_ERR(p->membase);
+		} else {
+			/*
+			 * For the simple (and majority of) cases
+			 * where we don't need to do any remapping,
+			 * just cast the cookie directly.
+			 */
+			p->membase = (void __iomem *)p->mapbase;
+		}
 	}
+
+	sci_port->port.membase	= p->membase;
+
+	sci_port->port.irq	= p->irqs[SCIx_TXI_IRQ];
+	sci_port->port.flags	= p->flags;
+	sci_port->type		= sci_port->port.type = p->type;
+
+	memcpy(&sci_port->irqs, &p->irqs, sizeof(p->irqs));
+
+	return 0;
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
@@ -1175,7 +1193,6 @@ static struct console serial_console = {
 
 static int __init sci_console_init(void)
 {
-	sci_init_ports();
 	register_console(&serial_console);
 	return 0;
 }
@@ -1241,32 +1258,10 @@ static int __devinit sci_probe_single(st
 		return 0;
 	}
 
-	sciport->port.mapbase	= p->mapbase;
-
-	if (p->mapbase && !p->membase) {
-		if (p->flags & UPF_IOREMAP) {
-			p->membase = ioremap_nocache(p->mapbase, 0x40);
-			if (IS_ERR(p->membase))
-				return PTR_ERR(p->membase);
-		} else {
-			/*
-			 * For the simple (and majority of) cases
-			 * where we don't need to do any remapping,
-			 * just cast the cookie directly.
-			 */
-			p->membase = (void __iomem *)p->mapbase;
-		}
-	}
-
-	sciport->port.membase	= p->membase;
-
-	sciport->port.irq	= p->irqs[SCIx_TXI_IRQ];
-	sciport->port.flags	= p->flags;
-	sciport->port.dev	= &dev->dev;
-
-	sciport->type		= sciport->port.type = p->type;
-
-	memcpy(&sciport->irqs, &p->irqs, sizeof(p->irqs));
+	sciport->port.dev = &dev->dev;
+	ret = sci_init_single(sciport, index, p);
+	if (ret)
+		return ret;
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 
@@ -1381,8 +1376,6 @@ static int __init sci_init(void)
 
 	printk(banner);
 
-	sci_init_ports();
-
 	ret = uart_register_driver(&sci_uart_driver);
 	if (likely(ret = 0)) {
 		ret = platform_driver_register(&sci_driver);
