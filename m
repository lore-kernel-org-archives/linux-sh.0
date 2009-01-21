From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:13:58 +0000
Subject: [PATCH 003/013] sh-sci: remove early_sci_setup()
Message-Id: <20090121151358.29269.16993.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove unused early_sci_setup() function from sh-sci.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c    |   14 --------------
 include/linux/serial_sci.h |    2 --
 2 files changed, 16 deletions(-)

--- 0003/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-20 16:36:38.000000000 +0900
@@ -1086,20 +1086,6 @@ static void __init sci_init_ports(void)
 	}
 }
 
-int __init early_sci_setup(struct uart_port *port)
-{
-	if (unlikely(port->line > SCI_NPORTS))
-		return -ENODEV;
-
-	sci_init_ports();
-
-	sci_ports[port->line].port.membase	= port->membase;
-	sci_ports[port->line].port.mapbase	= port->mapbase;
-	sci_ports[port->line].port.type		= port->type;
-
-	return 0;
-}
-
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
 /*
  *	Print a string to the serial port trying not to disturb
--- 0001/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2009-01-20 16:36:57.000000000 +0900
@@ -27,6 +27,4 @@ struct plat_sci_port {
 	upf_t		flags;			/* UPF_* flags */
 };
 
-int early_sci_setup(struct uart_port *port);
-
 #endif /* __LINUX_SERIAL_SCI_H */
