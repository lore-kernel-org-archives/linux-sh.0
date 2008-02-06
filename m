From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 15:26:29 +0000
Subject: [PATCH] sh: trapped io support for r2d
Message-Id: <20080206152629.27123.30852.sendpatchset@clockwork.opensource.se>
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
 arch/sh/boards/renesas/rts7751r2d/setup.c |   49 +++++++++++------------------
 include/asm-sh/rts7751r2d.h               |    3 -
 3 files changed, 20 insertions(+), 33 deletions(-)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-05 21:44:12.000000000 +0900
@@ -455,6 +455,7 @@ config SH_RTS7751R2D
 	bool "RTS7751R2D"
 	depends on CPU_SUBTYPE_SH7751R
 	select SYS_SUPPORTS_PCI
+	select IO_TRAPPED
 	help
 	  Select RTS7751R2D if configuring for a Renesas Technology
 	  Sales SH-Graphics board.
--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-02-06 12:33:59.000000000 +0900
@@ -21,6 +21,7 @@
 #include <asm/machvec.h>
 #include <asm/rts7751r2d.h>
 #include <asm/io.h>
+#include <asm/io_trapped.h>
 #include <asm/spi.h>
 
 static struct resource cf_ide_resources[] = {
@@ -219,8 +220,26 @@ static struct platform_device *rts7751r2
 	&spi_sh_sci_device,
 };
 
+/*
+ * The CF is connected using a 16-bit bus where 8-bit operations are
+ * unsupported. The linux ide driver is however using 8-bit operations, so
+ * insert a trapped io handler to convert 8-bit operations into 16-bit.
+ */
+
+static struct trapped_io cf_trapped_io = {
+	.resource	= cf_ide_resources,
+	.num_resources	= 2,
+	.read8		= trapped_ioread16,
+	.read16		= trapped_ioread16,
+	.read32		= trapped_ioread32,
+	.write8		= trapped_iowrite16,
+	.write16	= trapped_iowrite16,
+	.write32	= trapped_iowrite32,
+};
+
 static int __init rts7751r2d_devices_setup(void)
 {
+	register_trapped_io_handler(&cf_trapped_io);
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 	return platform_add_devices(rts7751r2d_devices,
 				    ARRAY_SIZE(rts7751r2d_devices));
@@ -232,34 +251,6 @@ static void rts7751r2d_power_off(void)
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
@@ -310,6 +301,4 @@ static struct sh_machine_vector mv_rts77
 	.mv_setup		= rts7751r2d_setup,
 	.mv_init_irq		= init_rts7751r2d_IRQ,
 	.mv_irq_demux		= rts7751r2d_irq_demux,
-	.mv_writeb		= rts7751r2d_writeb,
-	.mv_readb		= rts7751r2d_readb,
 };
--- 0001/include/asm-sh/rts7751r2d.h
+++ work/include/asm-sh/rts7751r2d.h	2008-02-05 21:44:12.000000000 +0900
@@ -67,7 +67,4 @@
 void init_rts7751r2d_IRQ(void);
 int rts7751r2d_irq_demux(int);
 
-#define __IO_PREFIX rts7751r2d
-#include <asm/io_generic.h>
-
 #endif  /* __ASM_SH_RENESAS_RTS7751R2D */
