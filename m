From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:22 +0000
Subject: [PATCH 02/08] ARM: mach-shmobile: sh7367 and G3EVM timer rework
Message-Id: <20120306083622.8131.5018.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the SoC specific timer code from G3EVM board code
to sh7367 setup code. This makes is possible to share
the SoC specific timer code across boards and it also
removes the need for a board specific timer structure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patch:
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-g3evm.c  |   13 +------------
 arch/arm/mach-shmobile/setup-sh7367.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

--- 0008/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2012-03-06 12:56:44.000000000 +0900
@@ -37,7 +37,6 @@
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 
 /*
  * IrDA
@@ -332,21 +331,11 @@ static void __init g3evm_init(void)
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
 }
 
-static void __init g3evm_timer_init(void)
-{
-	sh7367_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer g3evm_timer = {
-	.init		= g3evm_timer_init,
-};
-
 MACHINE_START(G3EVM, "g3evm")
 	.map_io		= sh7367_map_io,
 	.init_early	= sh7367_add_early_devices,
 	.init_irq	= sh7367_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g3evm_init,
-	.timer		= &g3evm_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0008/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2012-03-06 12:56:54.000000000 +0900
@@ -33,6 +33,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 static struct map_desc sh7367_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -454,6 +455,12 @@ void __init sh7367_add_standard_devices(
 			    ARRAY_SIZE(sh7367_devices));
 }
 
+static void __init sh7367_earlytimer_init(void)
+{
+	sh7367_clock_init();
+	shmobile_earlytimer_init();
+}
+
 #define SYMSTPCR2 0xe6158048
 #define SYMSTPCR2_CMT1 (1 << 29)
 
@@ -467,4 +474,7 @@ void __init sh7367_add_early_devices(voi
 
 	/* setup early console here as well */
 	shmobile_setup_console();
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = sh7367_earlytimer_init;
 }
