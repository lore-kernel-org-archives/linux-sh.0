From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:35 +0000
Subject: [PATCH 05/06] ARM: mach-shmobile: r8a7740 map_io and init_early update
Message-Id: <20120229123735.28584.43376.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7740 SoC and the Bonito board to make use of
the functions r8a7740_map_io() and r8a7740_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-bonito.c        |   28 +-------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/setup-r8a7740.c       |   35 ++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 26 deletions(-)

--- 0002/arch/arm/mach-shmobile/board-bonito.c
+++ work/arch/arm/mach-shmobile/board-bonito.c	2012-02-29 17:19:14.000000000 +0900
@@ -327,28 +327,6 @@ static struct platform_device *bonito_ba
  * map I/O
  */
 static struct map_desc bonito_io_desc[] __initdata = {
-	 /*
-	  * for CPGA/INTC/PFC
-	  * 0xe6000000-0xefffffff -> 0xe6000000-0xefffffff
-	  */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 160 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-#ifdef CONFIG_CACHE_L2X0
-	/*
-	 * for l2x0_init()
-	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
-	 */
-	{
-		.virtual	= 0xf0002000,
-		.pfn		= __phys_to_pfn(0xf0100000),
-		.length		= PAGE_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	},
-#endif
 	/*
 	 * for FPGA (0x1800000-0x19ffffff)
 	 * 0x18000000-0x18002000 -> 0xf0003000-0xf0005000
@@ -363,11 +341,8 @@ static struct map_desc bonito_io_desc[]
 
 static void __init bonito_map_io(void)
 {
+	r8a7740_map_io();
 	iotable_init(bonito_io_desc, ARRAY_SIZE(bonito_io_desc));
-
-	/* setup early devices and console here as well */
-	r8a7740_add_early_devices();
-	shmobile_setup_console();
 }
 
 /*
@@ -515,6 +490,7 @@ struct sys_timer bonito_timer = {
 
 MACHINE_START(BONITO, "bonito")
 	.map_io		= bonito_map_io,
+	.init_early	= r8a7740_add_early_devices,
 	.init_irq	= r8a7740_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= bonito_init,
--- 0005/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 17:16:08.000000000 +0900
@@ -59,6 +59,7 @@ extern int sh73a0_boot_secondary(unsigne
 extern void sh73a0_smp_prepare_cpus(void);
 
 extern void r8a7740_init_irq(void);
+extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
 extern void r8a7740_clock_init(u8 md_ck);
--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2012-02-29 17:19:11.000000000 +0900
@@ -25,9 +25,41 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/r8a7740.h>
+#include <mach/common.h>
 #include <asm/mach-types.h>
+#include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+static struct map_desc r8a7740_io_desc[] __initdata = {
+	 /*
+	  * for CPGA/INTC/PFC
+	  * 0xe6000000-0xefffffff -> 0xe6000000-0xefffffff
+	  */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 160 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * for l2x0_init()
+	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
+	 */
+	{
+		.virtual	= 0xf0002000,
+		.pfn		= __phys_to_pfn(0xf0100000),
+		.length		= PAGE_SIZE,
+		.type		= MT_DEVICE_NONSHARED
+	},
+#endif
+};
+
+void __init r8a7740_map_io(void)
+{
+	iotable_init(r8a7740_io_desc, ARRAY_SIZE(r8a7740_io_desc));
+}
+
 /* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
@@ -349,4 +381,7 @@ void __init r8a7740_add_early_devices(vo
 {
 	early_platform_add_devices(r8a7740_early_devices,
 				   ARRAY_SIZE(r8a7740_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
 }
