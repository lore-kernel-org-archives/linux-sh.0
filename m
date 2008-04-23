From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:00:54 +0000
Subject: [PATCH] sh: use sci_out() for early printk
Message-Id: <20080423120054.3919.65164.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use sci_out() instead of ctrl_outw() for early printk setup code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/early_printk.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- 0001/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2008-04-22 18:00:42.000000000 +0900
@@ -141,6 +141,7 @@ static void scif_sercon_init(char *s)
  */
 static void scif_sercon_init(char *s)
 {
+	struct uart_port *port = &scif_port;
 	unsigned baud = DEFAULT_BAUD;
 	char *e;
 
@@ -160,19 +161,20 @@ static void scif_sercon_init(char *s)
 			baud = DEFAULT_BAUD;
 	}
 
-	ctrl_outw(0, scif_port.mapbase + 8);
-	ctrl_outw(0, scif_port.mapbase);
+	sci_out(port, SCSCR, 0);	 /* TE=0, RE=0 */
+	sci_out(port, SCSMR, 0);
 
 	/* Set baud rate */
-	ctrl_outb((CONFIG_SH_PCLK_FREQ + 16 * baud) /
-		  (32 * baud) - 1, scif_port.mapbase + 4);
+	sci_out(port, SCBRR, (CONFIG_SH_PCLK_FREQ + 16 * baud) /
+		(32 * baud) - 1);
 
-	ctrl_outw(12, scif_port.mapbase + 24);
-	ctrl_outw(8, scif_port.mapbase + 24);
-	ctrl_outw(0, scif_port.mapbase + 32);
-	ctrl_outw(0x60, scif_port.mapbase + 16);
-	ctrl_outw(0, scif_port.mapbase + 36);
-	ctrl_outw(0x30, scif_port.mapbase + 8);
+	sci_out(port, SCFCR, 12);
+	sci_out(port, SCFCR, 8);
+
+	sci_out(port, SCSPTR, 0);
+	sci_out(port, SCxSR, 0x60);
+	sci_out(port, SCLSR, 0);
+	sci_out(port, SCSCR, 0x30);	 /* TE=1, RE=1 */
 }
 #endif /* defined(CONFIG_CPU_SUBTYPE_SH7720) */
 #endif /* !defined(CONFIG_SH_STANDARD_BIOS) */
