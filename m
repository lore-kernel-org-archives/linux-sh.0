From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 11:23:53 +0000
Subject: [PATCH] sh: trapped io support for highlander V2
Message-Id: <20080207112353.9748.54200.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080206152342.27118.35156.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080206152342.27118.35156.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch converts the highlander CF device from good old machvec readb/writeb
to the new shiny trapped io.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/boards/renesas/r7780rp/setup.c |   47 ++++++++++----------------------
 include/asm-sh/r7780rp.h               |    3 --
 3 files changed, 17 insertions(+), 34 deletions(-)

--- 0007/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-07 19:18:21.000000000 +0900
@@ -472,6 +472,7 @@ config SH_HIGHLANDER
 	bool "Highlander"
 	depends on CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
 	select SYS_SUPPORTS_PCI
+	select IO_TRAPPED
 
 config SH_MIGOR
 	bool "Migo-R"
--- 0001/arch/sh/boards/renesas/r7780rp/setup.c
+++ work/arch/sh/boards/renesas/r7780rp/setup.c	2008-02-07 19:20:09.000000000 +0900
@@ -23,6 +23,7 @@
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
 #include <asm/io.h>
+#include <asm/io_trapped.h>
 
 static struct resource r8a66597_usb_host_resources[] = {
 	[0] = {
@@ -181,13 +182,27 @@ static struct platform_device *r7780rp_d
 	&m66592_usb_peripheral_device,
 	&heartbeat_device,
 #ifndef CONFIG_SH_R7780RP
-	&cf_ide_device,
 	&ax88796_device,
 #endif
 };
 
+/*
+ * The CF is connected using a 16-bit bus where 8-bit operations are
+ * unsupported. The linux ata driver is however using 8-bit operations, so
+ * insert a trapped io filter to convert 8-bit operations into 16-bit.
+ */
+static struct trapped_io cf_trapped_io = {
+	.resource		= cf_ide_resources,
+	.num_resources		= 2,
+	.minimum_bus_width	= 16,
+};
+
 static int __init r7780rp_devices_setup(void)
 {
+#ifndef CONFIG_SH_R7780RP
+	if (register_trapped_io(&cf_trapped_io) = 0)
+		platform_device_register(&cf_ide_device);
+#endif
 	return platform_add_devices(r7780rp_devices,
 				    ARRAY_SIZE(r7780rp_devices));
 }
@@ -226,34 +241,6 @@ static void r7780rp_power_off(void)
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
@@ -338,6 +325,4 @@ static struct sh_machine_vector mv_highl
 	.mv_setup		= highlander_setup,
 	.mv_init_irq		= highlander_init_irq,
 	.mv_irq_demux		= highlander_irq_demux,
-	.mv_readb		= highlander_readb,
-	.mv_writeb		= highlander_writeb,
 };
--- 0001/include/asm-sh/r7780rp.h
+++ work/include/asm-sh/r7780rp.h	2008-02-07 19:18:21.000000000 +0900
@@ -195,7 +195,4 @@ unsigned char *highlander_init_irq_r7780
 unsigned char *highlander_init_irq_r7780rp(void);
 unsigned char *highlander_init_irq_r7785rp(void);
 
-#define __IO_PREFIX	r7780rp
-#include <asm/io_generic.h>
-
 #endif  /* __ASM_SH_RENESAS_R7780RP */
