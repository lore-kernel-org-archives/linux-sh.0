From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 11:21:10 +0000
Subject: [PATCH] sh: trapped io support for r2d V2
Message-Id: <20080207112110.9738.96395.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch converts the CF device on r2d boards from machvec readb/writeb
to trapped io.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                           |    1 
 arch/sh/boards/renesas/rts7751r2d/setup.c |   45 +++++++++--------------------
 include/asm-sh/rts7751r2d.h               |    3 -
 3 files changed, 15 insertions(+), 34 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-07 18:50:14.000000000 +0900
@@ -452,6 +452,7 @@ config SH_RTS7751R2D
 	bool "RTS7751R2D"
 	depends on CPU_SUBTYPE_SH7751R
 	select SYS_SUPPORTS_PCI
+	select IO_TRAPPED
 	help
 	  Select RTS7751R2D if configuring for a Renesas Technology
 	  Sales SH-Graphics board.
--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-02-07 18:53:44.000000000 +0900
@@ -21,6 +21,7 @@
 #include <asm/machvec.h>
 #include <asm/rts7751r2d.h>
 #include <asm/io.h>
+#include <asm/io_trapped.h>
 #include <asm/spi.h>
 
 static struct resource cf_ide_resources[] = {
@@ -214,13 +215,25 @@ static struct platform_device *rts7751r2
 	&uart_device,
 	&sm501_device,
 #endif
-	&cf_ide_device,
 	&heartbeat_device,
 	&spi_sh_sci_device,
 };
 
+/*
+ * The CF is connected with a 16-bit bus where 8-bit operations are
+ * unsupported. The linux ata driver is however using 8-bit operations, so
+ * insert a trapped io filter to convert 8-bit operations into 16-bit.
+ */
+static struct trapped_io cf_trapped_io = {
+	.resource		= cf_ide_resources,
+	.num_resources		= 2,
+	.minimum_bus_width	= 16,
+};
+
 static int __init rts7751r2d_devices_setup(void)
 {
+	if (register_trapped_io(&cf_trapped_io) = 0)
+		platform_device_register(&cf_ide_device);
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 	return platform_add_devices(rts7751r2d_devices,
 				    ARRAY_SIZE(rts7751r2d_devices));
@@ -232,34 +245,6 @@ static void rts7751r2d_power_off(void)
 	ctrl_outw(0x0001, PA_POWOFF);
 }
 
-static inline unsigned char is_ide_ioaddr(unsigned long addr)
-{
-	return ((cf_ide_resources[0].start <= addr &&
-		 addr <= cf_ide_resources[0].end) ||
-		(cf_ide_resources[1].start <= addr &&
-		 addr <= cf_ide_resources[1].end));
-}
-
-void rts7751r2d_writeb(u8 b, void __iomem *addr)
-{
-	unsigned long tmp = (unsigned long __force)addr;
-
-	if (is_ide_ioaddr(tmp))
-		ctrl_outw((u16)b, tmp);
-	else
-		ctrl_outb(b, tmp);
-}
-
-u8 rts7751r2d_readb(void __iomem *addr)
-{
-	unsigned long tmp = (unsigned long __force)addr;
-
-	if (is_ide_ioaddr(tmp))
-		return ctrl_inw(tmp) & 0xff;
-	else
-		return ctrl_inb(tmp);
-}
-
 /*
  * Initialize the board
  */
@@ -310,6 +295,4 @@ static struct sh_machine_vector mv_rts77
 	.mv_setup		= rts7751r2d_setup,
 	.mv_init_irq		= init_rts7751r2d_IRQ,
 	.mv_irq_demux		= rts7751r2d_irq_demux,
-	.mv_writeb		= rts7751r2d_writeb,
-	.mv_readb		= rts7751r2d_readb,
 };
--- 0001/include/asm-sh/rts7751r2d.h
+++ work/include/asm-sh/rts7751r2d.h	2008-02-07 18:50:14.000000000 +0900
@@ -67,7 +67,4 @@
 void init_rts7751r2d_IRQ(void);
 int rts7751r2d_irq_demux(int);
 
-#define __IO_PREFIX rts7751r2d
-#include <asm/io_generic.h>
-
 #endif  /* __ASM_SH_RENESAS_RTS7751R2D */
