From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 14:35:39 +0000
Subject: [PATCH 05/05] sh: Remove old early serial console code
Message-Id: <20091105143539.9902.59014.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when the sh-sci driver can do early serial output,
get rid of the old duplicated code. This removes support
for "earlyprintk=serial".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Kconfig.debug         |   20 -----
 arch/sh/kernel/early_printk.c |  143 -----------------------------------------
 2 files changed, 163 deletions(-)

--- 0001/arch/sh/Kconfig.debug
+++ work/arch/sh/Kconfig.debug	2009-11-05 22:47:09.000000000 +0900
@@ -27,26 +27,6 @@ config EARLY_SCIF_CONSOLE
 	  standard BIOS, or do not wish to use the BIOS callbacks for the
 	  serial I/O.
 
-config EARLY_SCIF_CONSOLE_PORT
-	hex
-	depends on EARLY_SCIF_CONSOLE
-	default "0xa4400000" if CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7705
-	default "0xa4430000" if CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721
-	default "0xf8420000" if CPU_SUBTYPE_SH7619
-	default "0xff804000" if CPU_SUBTYPE_MXG
-	default "0xffc30000" if CPU_SUBTYPE_SHX3
-	default "0xffe00000" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7763 || \
-				CPU_SUBTYPE_SH7722 || CPU_SUBTYPE_SH7366 || \
-				CPU_SUBTYPE_SH7343
-	default "0xfe4c0000" if CPU_SUBTYPE_SH7757
-	default "0xffeb0000" if CPU_SUBTYPE_SH7785
-	default "0xffeb0000" if CPU_SUBTYPE_SH7786
-	default "0xfffe8000" if CPU_SUBTYPE_SH7203
-	default "0xfffe9800" if CPU_SUBTYPE_SH7206 || CPU_SUBTYPE_SH7263
-	default "0xffe80000" if CPU_SH4
-	default "0xa4000150" if CPU_SH3
-	default "0x00000000"
-
 config EARLY_PRINTK
 	bool "Early printk support"
 	depends on SH_STANDARD_BIOS || EARLY_SCIF_CONSOLE
--- 0004/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2009-11-05 22:45:21.000000000 +0900
@@ -59,138 +59,6 @@ static struct console bios_console = {
 };
 #endif
 
-#ifdef CONFIG_EARLY_SCIF_CONSOLE
-#include <linux/serial_core.h>
-#include "../../../drivers/serial/sh-sci.h"
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define EPK_SCSMR_VALUE 0x000
-#define EPK_SCBRR_VALUE 0x00C
-#define EPK_FIFO_SIZE 64
-#define EPK_FIFO_BITS (0x7f00 >> 8)
-#else
-#define EPK_FIFO_SIZE 16
-#define EPK_FIFO_BITS (0x1f00 >> 8)
-#endif
-
-static struct uart_port scif_port = {
-	.type		= PORT_SCIF,
-	.mapbase	= CONFIG_EARLY_SCIF_CONSOLE_PORT,
-	.membase	= (char __iomem *)CONFIG_EARLY_SCIF_CONSOLE_PORT,
-};
-
-static void scif_sercon_putc(int c)
-{
-	while (((sci_in(&scif_port, SCFDR) & EPK_FIFO_BITS) >= EPK_FIFO_SIZE))
-		;
-
-	sci_in(&scif_port, SCxSR);
-	sci_out(&scif_port, SCxSR, 0xf3 & ~(0x20 | 0x40));
-	sci_out(&scif_port, SCxTDR, c);
-
-	while ((sci_in(&scif_port, SCxSR) & 0x40) = 0)
-		;
-
-	if (c = '\n')
-		scif_sercon_putc('\r');
-}
-
-static void scif_sercon_write(struct console *con, const char *s,
-			      unsigned count)
-{
-	while (count-- > 0)
-		scif_sercon_putc(*s++);
-}
-
-static int __init scif_sercon_setup(struct console *con, char *options)
-{
-	con->cflag = CREAD | HUPCL | CLOCAL | B115200 | CS8;
-
-	return 0;
-}
-
-static struct console scif_console = {
-	.name		= "sercon",
-	.write		= scif_sercon_write,
-	.setup		= scif_sercon_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-};
-
-#if !defined(CONFIG_SH_STANDARD_BIOS)
-#if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
-static void scif_sercon_init(char *s)
-{
-	sci_out(&scif_port, SCSCR, 0x0000);	/* clear TE and RE */
-	sci_out(&scif_port, SCFCR, 0x4006);	/* reset */
-	sci_out(&scif_port, SCSCR, 0x0000);	/* select internal clock */
-	sci_out(&scif_port, SCSMR, EPK_SCSMR_VALUE);
-	sci_out(&scif_port, SCBRR, EPK_SCBRR_VALUE);
-
-	mdelay(1);	/* wait 1-bit time */
-
-	sci_out(&scif_port, SCFCR, 0x0030);	/* TTRG=b'11 */
-	sci_out(&scif_port, SCSCR, 0x0030);	/* TE, RE */
-}
-#elif defined(CONFIG_CPU_SH4) || defined(CONFIG_CPU_SH3)
-#define DEFAULT_BAUD 115200
-/*
- * Simple SCIF init, primarily aimed at SH7750 and other similar SH-4
- * devices that aren't using sh-ipl+g.
- */
-static void scif_sercon_init(char *s)
-{
-	struct uart_port *port = &scif_port;
-	unsigned baud = DEFAULT_BAUD;
-	unsigned int status;
-	char *e;
-
-	if (*s = ',')
-		++s;
-
-	if (*s) {
-		/* ignore ioport/device name */
-		s += strcspn(s, ",");
-		if (*s = ',')
-			s++;
-	}
-
-	if (*s) {
-		baud = simple_strtoul(s, &e, 0);
-		if (baud = 0 || s = e)
-			baud = DEFAULT_BAUD;
-	}
-
-	do {
-		status = sci_in(port, SCxSR);
-	} while (!(status & SCxSR_TEND(port)));
-
-	sci_out(port, SCSCR, 0);	 /* TE=0, RE=0 */
-	sci_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
-	sci_out(port, SCSMR, 0);
-
-	/* Set baud rate */
-	sci_out(port, SCBRR, (CONFIG_SH_PCLK_FREQ + 16 * baud) /
-		(32 * baud) - 1);
-	udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
-
-	sci_out(port, SCSPTR, 0);
-	sci_out(port, SCxSR, 0x60);
-	sci_out(port, SCLSR, 0);
-
-	sci_out(port, SCFCR, 0);
-	sci_out(port, SCSCR, 0x30);	 /* TE=1, RE=1 */
-}
-#endif /* defined(CONFIG_CPU_SUBTYPE_SH7720) */
-#endif /* !defined(CONFIG_SH_STANDARD_BIOS) */
-#endif /* CONFIG_EARLY_SCIF_CONSOLE */
-
-/*
- * Setup a default console, if more than one is compiled in, rely on the
- * earlyprintk= parsing to give priority.
- */
 static struct console *early_console;
 
 static int __init setup_early_printk(char *buf)
@@ -207,17 +75,6 @@ static int __init setup_early_printk(cha
 	if (!strncmp(buf, "bios", 4))
 		early_console = &bios_console;
 #endif
-#if defined(CONFIG_EARLY_SCIF_CONSOLE)
-	if (!strncmp(buf, "serial", 6)) {
-		early_console = &scif_console;
-
-#if !defined(CONFIG_SH_STANDARD_BIOS)
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_CPU_SH3)
-		scif_sercon_init(buf + 6);
-#endif
-#endif
-	}
-#endif
 
 	if (likely(early_console)) {
 		if (keep_early)
