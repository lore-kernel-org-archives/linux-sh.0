From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:45 +0000
Subject: [PATCH 05/08] ARM: mach-shmobile: sh73a0, AG5EVM and Kota2 timer rework
Message-Id: <20120306083645.8131.86727.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the SoC specific timer code from AG5EVM and Kota2
to sh73a0 setup code. This makes is possible to share
the SoC specific timer code across boards and it also
removes the need for a board specific timer structure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patch:
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-ag5evm.c |   14 +-------------
 arch/arm/mach-shmobile/board-kota2.c  |   13 +------------
 arch/arm/mach-shmobile/setup-sh73a0.c |   10 ++++++++++
 3 files changed, 12 insertions(+), 25 deletions(-)

--- 0003/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2012-03-06 13:08:33.000000000 +0900
@@ -46,7 +46,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
@@ -600,17 +599,6 @@ static void __init ag5evm_init(void)
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
 }
 
-static void __init ag5evm_timer_init(void)
-{
-	sh73a0_clock_init();
-	shmobile_timer.init();
-	return;
-}
-
-struct sys_timer ag5evm_timer = {
-	.init	= ag5evm_timer_init,
-};
-
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
@@ -618,5 +606,5 @@ MACHINE_START(AG5EVM, "ag5evm")
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= ag5evm_init,
-	.timer		= &ag5evm_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0003/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2012-03-06 13:08:29.000000000 +0900
@@ -513,17 +513,6 @@ static void __init kota2_init(void)
 	platform_add_devices(kota2_devices, ARRAY_SIZE(kota2_devices));
 }
 
-static void __init kota2_timer_init(void)
-{
-	sh73a0_clock_init();
-	shmobile_timer.init();
-	return;
-}
-
-struct sys_timer kota2_timer = {
-	.init	= kota2_timer_init,
-};
-
 MACHINE_START(KOTA2, "kota2")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
@@ -531,5 +520,5 @@ MACHINE_START(KOTA2, "kota2")
 	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= kota2_init,
-	.timer		= &kota2_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0003/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2012-03-06 13:08:38.000000000 +0900
@@ -36,6 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -686,6 +687,12 @@ void __init sh73a0_add_standard_devices(
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
+static void __init sh73a0_earlytimer_init(void)
+{
+	sh73a0_clock_init();
+	shmobile_earlytimer_init();
+}
+
 void __init sh73a0_add_early_devices(void)
 {
 	early_platform_add_devices(sh73a0_early_devices,
@@ -693,4 +700,7 @@ void __init sh73a0_add_early_devices(voi
 
 	/* setup early console here as well */
 	shmobile_setup_console();
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = sh73a0_earlytimer_init;
 }
