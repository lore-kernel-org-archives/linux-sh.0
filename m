From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 15:23:42 +0000
Subject: [PATCH] sh: trapped io support for highlander
Message-Id: <20080206152342.27118.35156.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch converts the higlander CF device from good old machvec readb/writeb
to the new shiny trapped io.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/boards/renesas/r7780rp/setup.c |   49 ++++++++++++--------------------
 include/asm-sh/r7780rp.h               |    3 -
 3 files changed, 20 insertions(+), 33 deletions(-)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-06 13:02:42.000000000 +0900
@@ -471,6 +471,7 @@ config SH_HIGHLANDER
 	bool "Highlander"
 	depends on CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
 	select SYS_SUPPORTS_PCI
+	select IO_TRAPPED
 
 config SH_EDOSK7705
 	bool "EDOSK7705"
--- 0001/arch/sh/boards/renesas/r7780rp/setup.c
+++ work/arch/sh/boards/renesas/r7780rp/setup.c	2008-02-06 12:54:55.000000000 +0900
@@ -23,6 +23,7 @@
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
 #include <asm/io.h>
+#include <asm/io_trapped.h>
 
 static struct resource r8a66597_usb_host_resources[] = {
 	[0] = {
@@ -186,8 +187,26 @@ static struct platform_device *r7780rp_d
 #endif
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
 static int __init r7780rp_devices_setup(void)
 {
+	register_trapped_io_handler(&cf_trapped_io);
 	return platform_add_devices(r7780rp_devices,
 				    ARRAY_SIZE(r7780rp_devices));
 }
@@ -226,34 +245,6 @@ static void r7780rp_power_off(void)
 		ctrl_outw(0x0001, PA_POFF);
 }
 
-static inline unsigned char is_ide_ioaddr(unsigned long addr)
-{
-	return ((cf_ide_resources[0].start <= addr &&
-		 addr <= cf_ide_resources[0].end) ||
-		(cf_ide_resources[1].start <= addr &&
-		 addr <= cf_ide_resources[1].end));
-}
-
-void highlander_writeb(u8 b, void __iomem *addr)
-{
-	unsigned long tmp = (unsigned long __force)addr;
-
-	if (is_ide_ioaddr(tmp))
-		ctrl_outw((u16)b, tmp);
-	else
-		ctrl_outb(b, tmp);
-}
-
-u8 highlander_readb(void __iomem *addr)
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
@@ -338,6 +329,4 @@ static struct sh_machine_vector mv_highl
 	.mv_setup		= highlander_setup,
 	.mv_init_irq		= highlander_init_irq,
 	.mv_irq_demux		= highlander_irq_demux,
-	.mv_readb		= highlander_readb,
-	.mv_writeb		= highlander_writeb,
 };
--- 0001/include/asm-sh/r7780rp.h
+++ work/include/asm-sh/r7780rp.h	2008-02-06 13:03:06.000000000 +0900
@@ -195,7 +195,4 @@ unsigned char *highlander_init_irq_r7780
 unsigned char *highlander_init_irq_r7780rp(void);
 unsigned char *highlander_init_irq_r7785rp(void);
 
-#define __IO_PREFIX	r7780rp
-#include <asm/io_generic.h>
-
 #endif  /* __ASM_SH_RENESAS_R7780RP */
