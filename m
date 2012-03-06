From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:37:01 +0000
Subject: [PATCH 07/08] ARM: mach-shmobile: r8a7779 and Marzen timer rework
Message-Id: <20120306083701.8131.29019.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the SoC specific timer code from Marzen board code
to r8a7779 setup code. This makes is possible to share
the SoC specific timer code across boards and it also
removes the need for a board specific timer structure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patch:
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-marzen.c  |   14 +-------------
 arch/arm/mach-shmobile/setup-r8a7779.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

--- 0007/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2012-03-06 13:23:54.000000000 +0900
@@ -33,7 +33,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/traps.h>
 
@@ -91,17 +90,6 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
-static void __init marzen_timer_init(void)
-{
-	r8a7779_clock_init();
-	shmobile_timer.init();
-	return;
-}
-
-struct sys_timer marzen_timer = {
-	.init	= marzen_timer_init,
-};
-
 MACHINE_START(MARZEN, "marzen")
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
@@ -109,5 +97,5 @@ MACHINE_START(MARZEN, "marzen")
 	.init_irq	= r8a7779_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= marzen_init,
-	.timer		= &marzen_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0028/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2012-03-06 13:23:57.000000000 +0900
@@ -33,6 +33,7 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -260,6 +261,12 @@ void __init r8a7779_add_standard_devices
 			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
+static void __init r8a7779_earlytimer_init(void)
+{
+	r8a7779_clock_init();
+	shmobile_earlytimer_init();
+}
+
 void __init r8a7779_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7779_early_devices,
@@ -280,4 +287,7 @@ void __init r8a7779_add_early_devices(vo
 	 * As a final step pass earlyprint=sh-sci.2,115200 on the kernel
 	 * command line in case of the marzen board.
 	 */
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = r8a7779_earlytimer_init;
 }
