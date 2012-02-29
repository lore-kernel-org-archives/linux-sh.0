From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 12:37:27 +0000
Subject: [PATCH 04/06] ARM: mach-shmobile: sh73a0 map_io and init_early update
Message-Id: <20120229123727.28584.79600.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh73a0 SoC and the AG5EVM and Kota2 boards to make use
of the functions sh73a0_map_io() and sh73a0_add_early_devices().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c        |   25 ++-----------------------
 arch/arm/mach-shmobile/board-kota2.c         |   25 ++-----------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c        |   22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 46 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2012-02-29 16:54:35.000000000 +0900
@@ -46,7 +46,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -486,27 +485,6 @@ static struct platform_device *ag5evm_de
 	&sdhi1_device,
 };
 
-static struct map_desc ag5evm_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init ag5evm_map_io(void)
-{
-	iotable_init(ag5evm_io_desc, ARRAY_SIZE(ag5evm_io_desc));
-
-	/* setup early devices and console here as well */
-	sh73a0_add_early_devices();
-	shmobile_setup_console();
-}
-
 static void __init ag5evm_init(void)
 {
 	sh73a0_pinmux_init();
@@ -634,7 +612,8 @@ struct sys_timer ag5evm_timer = {
 };
 
 MACHINE_START(AG5EVM, "ag5evm")
-	.map_io		= ag5evm_map_io,
+	.map_io		= sh73a0_map_io,
+	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2012-02-29 16:54:51.000000000 +0900
@@ -43,7 +43,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -409,27 +408,6 @@ static struct platform_device *kota2_dev
 	&sdhi1_device,
 };
 
-static struct map_desc kota2_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
-	 * used by CPGA, INTC and PFC.
-	 */
-	{
-		.virtual	= 0xe6000000,
-		.pfn		= __phys_to_pfn(0xe6000000),
-		.length		= 256 << 20,
-		.type		= MT_DEVICE_NONSHARED
-	},
-};
-
-static void __init kota2_map_io(void)
-{
-	iotable_init(kota2_io_desc, ARRAY_SIZE(kota2_io_desc));
-
-	/* setup early devices and console here as well */
-	sh73a0_add_early_devices();
-	shmobile_setup_console();
-}
-
 static void __init kota2_init(void)
 {
 	sh73a0_pinmux_init();
@@ -547,7 +525,8 @@ struct sys_timer kota2_timer = {
 };
 
 MACHINE_START(KOTA2, "kota2")
-	.map_io		= kota2_map_io,
+	.map_io		= sh73a0_map_io,
+	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 16:55:52.000000000 +0900
@@ -41,6 +41,7 @@ extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
 extern void sh73a0_init_irq(void);
+extern void sh73a0_map_io(void);
 extern void sh73a0_add_early_devices(void);
 extern void sh73a0_add_standard_devices(void);
 extern void sh73a0_clock_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2012-02-29 16:55:05.000000000 +0900
@@ -32,9 +32,28 @@
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
+#include <mach/common.h>
 #include <asm/mach-types.h>
+#include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+static struct map_desc sh73a0_io_desc[] __initdata = {
+	/* create a 1:1 entity map for 0xe6xxxxxx
+	 * used by CPGA, INTC and PFC.
+	 */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 256 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+void __init sh73a0_map_io(void)
+{
+	iotable_init(sh73a0_io_desc, ARRAY_SIZE(sh73a0_io_desc));
+}
+
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -671,4 +690,7 @@ void __init sh73a0_add_early_devices(voi
 {
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
 }
