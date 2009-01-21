From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:14:22 +0000
Subject: [PATCH 006/013] sh-sci: ioremap() in a single place
Message-Id: <20090121151422.29269.32455.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Handle ioremap() in sci_config_port only.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |   47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

--- 0006/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-21 19:21:15.000000000 +0900
@@ -992,16 +992,19 @@ static void sci_config_port(struct uart_
 
 	port->type = s->type;
 
-	if (port->flags & UPF_IOREMAP && !port->membase) {
+	if (port->membase)
+		return;
+
+	if (port->flags & UPF_IOREMAP) {
 #if defined(CONFIG_SUPERH64)
 		port->mapbase = onchip_remap(SCIF_ADDR_SH5, 1024, "SCIF");
 		port->membase = (void __iomem *)port->mapbase;
 #else
 		port->membase = ioremap_nocache(port->mapbase, 0x40);
 #endif
-
 		dev_err(port->dev, "can't remap port#%d\n", port->line);
-	}
+	} else
+		port->membase = (void __iomem *)port->mapbase;
 }
 
 static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
@@ -1040,9 +1043,9 @@ static struct uart_ops sci_uart_ops = {
 #endif
 };
 
-static int __devinit sci_init_single(struct sci_port *sci_port,
-				     unsigned int index,
-				     struct plat_sci_port *p)
+static void __devinit sci_init_single(struct sci_port *sci_port,
+				      unsigned int index,
+				      struct plat_sci_port *p)
 {
 	sci_port->port.ops	= &sci_uart_ops;
 	sci_port->port.iotype	= UPIO_MEM;
@@ -1073,22 +1076,6 @@ static int __devinit sci_init_single(str
 	init_timer(&sci_port->break_timer);
 
 	sci_port->port.mapbase	= p->mapbase;
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
 	sci_port->port.membase	= p->membase;
 
 	sci_port->port.irq	= p->irqs[SCIx_TXI_IRQ];
@@ -1096,8 +1083,6 @@ static int __devinit sci_init_single(str
 	sci_port->type		= sci_port->port.type = p->type;
 
 	memcpy(&sci_port->irqs, &p->irqs, sizeof(p->irqs));
-
-	return 0;
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
@@ -1160,8 +1145,7 @@ static int __init serial_console_setup(s
 		sci_port->clk = clk_get(NULL, "module_clk");
 #endif
 
-	if (port->flags & UPF_IOREMAP)
-		sci_config_port(port, 0);
+	sci_config_port(port, 0);
 
 	if (sci_port->enable)
 		sci_port->enable(port);
@@ -1255,18 +1239,11 @@ static int __devinit sci_probe_single(st
 	}
 
 	sciport->port.dev = &dev->dev;
-	ret = sci_init_single(sciport, index, p);
-	if (ret)
-		return ret;
+	sci_init_single(sciport, index, p);
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-
-	if (ret) {
-		if (p->flags & UPF_IOREMAP)
-			iounmap(p->membase);
-
+	if (ret)
 		return ret;
-	}
 
 	INIT_LIST_HEAD(&sciport->node);
 
