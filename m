From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:29 +0000
Subject: [PATCH 03/08] ARM: mach-shmobile: sh7377 and G4EVM timer rework
Message-Id: <20120306083629.8131.19500.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the SoC specific timer code from G4EVM board code
to sh7377 setup code. This makes is possible to share
the SoC specific timer code across boards and it also
removes the need for a board specific timer structure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patch:
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-g4evm.c  |   13 +------------
 arch/arm/mach-shmobile/setup-sh7377.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

--- 0005/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2012-03-06 13:02:00.000000000 +0900
@@ -38,7 +38,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 
 /*
  * SDHI
@@ -375,21 +374,11 @@ static void __init g4evm_init(void)
 	platform_add_devices(g4evm_devices, ARRAY_SIZE(g4evm_devices));
 }
 
-static void __init g4evm_timer_init(void)
-{
-	sh7377_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer g4evm_timer = {
-	.init		= g4evm_timer_init,
-};
-
 MACHINE_START(G4EVM, "g4evm")
 	.map_io		= sh7377_map_io,
 	.init_early	= sh7377_add_early_devices,
 	.init_irq	= sh7377_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g4evm_init,
-	.timer		= &g4evm_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0005/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2012-03-06 13:01:05.000000000 +0900
@@ -34,6 +34,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 
 static struct map_desc sh7377_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -475,6 +476,12 @@ void __init sh7377_add_standard_devices(
 			    ARRAY_SIZE(sh7377_devices));
 }
 
+static void __init sh7377_earlytimer_init(void)
+{
+	sh7377_clock_init();
+	shmobile_earlytimer_init();
+}
+
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR3_CMT1 (1 << 29)
 
@@ -488,4 +495,7 @@ void __init sh7377_add_early_devices(voi
 
 	/* setup early console here as well */
 	shmobile_setup_console();
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = sh7377_earlytimer_init;
 }
