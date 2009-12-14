From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:52:53 +0000
Subject: [PATCH] sh: Remove old early serial console code V2
Message-Id: <20091214125253.10868.14417.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when the sh-sci driver can do early serial output,
get rid of the old duplicated code. This patch is V2 and
removes support for "earlyprintk=serial" together with
the following kconfig options:
CONFIG_EARLY_SCIF_CONSOLE
CONFIG_EARLY_SCIF_CONSOLE_PORT
CONFIG_EARLY_PRINTK

With this patch applied "earlyprintk=" support is always
built-in the SuperH kernel. For this to work the serial
driver must have early platform support and in the case
of sh-sci the serial console needs to be enabled:
CONFIG_SERIAL_SH_SCI_CONSOLE=y

So after enabling the SuperH SCI console kconfig option
you also need to point out port using the kernel command
line: "earlyprintk=sh-sci.N[,baudrate][,keep]"

Remember that clocks may be disabled by the boot loader
so you may have to do some board specific static clock 
setup before earlyprintk will work on your platform.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Kconfig.debug         |   44 ------------
 arch/sh/kernel/Makefile       |    3 
 arch/sh/kernel/early_printk.c |  147 -----------------------------------------
 3 files changed, 1 insertion(+), 193 deletions(-)

--- 0001/arch/sh/Kconfig.debug
+++ work/arch/sh/Kconfig.debug	2009-12-14 16:17:25.000000000 +0900
@@ -19,50 +19,6 @@ config SH_STANDARD_BIOS
 	  mask ROM and no flash (WindowsCE machines fall in this category).
 	  If unsure, say N.
 
-config EARLY_SCIF_CONSOLE
-	bool "Use early SCIF console"
-	help
-	  This enables an early console using a fixed SCIF port. This can
-	  be used by platforms that are either not running the SH
-	  standard BIOS, or do not wish to use the BIOS callbacks for the
-	  serial I/O.
-
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
-config EARLY_PRINTK
-	bool "Early printk support"
-	depends on SH_STANDARD_BIOS || EARLY_SCIF_CONSOLE
-	help
-	  Say Y here to redirect kernel printk messages to the serial port
-	  used by the SH-IPL bootloader, starting very early in the boot
-	  process and ending when the kernel's serial console is initialised.
-	  This option is only useful porting the kernel to a new machine,
-	  when the kernel may crash or hang before the serial console is
-	  initialised. If unsure, say N.
-
-	  On devices that are running SH-IPL and want to keep the port
-	  initialization consistent while not using the BIOS callbacks,
-	  select both the EARLY_SCIF_CONSOLE and SH_STANDARD_BIOS, using
-	  the kernel command line option to toggle back and forth.
-
 config STACK_DEBUG
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL && SUPERH32
--- 0001/arch/sh/kernel/Makefile
+++ work/arch/sh/kernel/Makefile	2009-12-14 16:18:23.000000000 +0900
@@ -22,11 +22,10 @@ obj-y	:= debugtraps.o dma-nommu.o dumpst
 obj-y				+= cpu/
 obj-$(CONFIG_VSYSCALL)		+= vsyscall/
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
+obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o early_printk.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_SH_CPU_FREQ)	+= cpufreq.o
 obj-$(CONFIG_MODULES)		+= sh_ksyms_$(BITS).o module.o
-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
--- 0004/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2009-12-14 16:18:01.000000000 +0900
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_SH_STANDARD_BIOS
 #include <asm/sh_bios.h>
 
 /*
@@ -57,140 +56,7 @@ static struct console bios_console = {
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 };
-#endif
 
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
@@ -203,21 +69,8 @@ static int __init setup_early_printk(cha
 	if (strstr(buf, "keep"))
 		keep_early = 1;
 
-#ifdef CONFIG_SH_STANDARD_BIOS
 	if (!strncmp(buf, "bios", 4))
 		early_console = &bios_console;
-#endif
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
