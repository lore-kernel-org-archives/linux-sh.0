From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:37 +0000
Subject: [PATCH 04/08] ARM: mach-shmobile: sh7372, AP4EVB and Mackerel timer rework
Message-Id: <20120306083637.8131.67504.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the SoC specific timer code from AP4EVB and Mackerel
to sh7372 setup code. This makes is possible to share
the SoC specific timer code across boards and it also
removes the need for a board specific timer structure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patches:
 "[PATCH] ARM: mach-shmobile: Move sh7372 AP4EVB external clk setup"
 "[PATCH] ARM: mach-shmobile: Move sh7372 Mackerel external clk setup"
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-ap4evb.c   |   13 +------------
 arch/arm/mach-shmobile/board-mackerel.c |   13 +------------
 arch/arm/mach-shmobile/setup-sh7372.c   |   10 ++++++++++
 3 files changed, 12 insertions(+), 24 deletions(-)

--- 0033/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2012-03-06 12:53:01.000000000 +0900
@@ -61,7 +61,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/setup.h>
 
 /*
@@ -1436,21 +1435,11 @@ static void __init ap4evb_init(void)
 	pm_clk_add(&lcdc1_device.dev, "hdmi");
 }
 
-static void __init ap4evb_timer_init(void)
-{
-	sh7372_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer ap4evb_timer = {
-	.init		= ap4evb_timer_init,
-};
-
 MACHINE_START(AP4EVB, "ap4evb")
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= ap4evb_init,
-	.timer		= &ap4evb_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0032/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2012-03-06 12:52:39.000000000 +0900
@@ -57,7 +57,6 @@
 #include <mach/sh7372.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/mach-types.h>
 
 /*
@@ -1554,21 +1553,11 @@ static void __init mackerel_init(void)
 	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
 }
 
-static void __init mackerel_timer_init(void)
-{
-	sh7372_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer mackerel_timer = {
-	.init		= mackerel_timer_init,
-};
-
 MACHINE_START(MACKEREL, "mackerel")
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
-	.timer		= &mackerel_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0004/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-03-06 12:52:48.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -1064,6 +1065,12 @@ void __init sh7372_add_standard_devices(
 	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
 }
 
+static void __init sh7372_earlytimer_init(void)
+{
+	sh7372_clock_init();
+	shmobile_earlytimer_init();
+}
+
 void __init sh7372_add_early_devices(void)
 {
 	early_platform_add_devices(sh7372_early_devices,
@@ -1071,4 +1078,7 @@ void __init sh7372_add_early_devices(voi
 
 	/* setup early console here as well */
 	shmobile_setup_console();
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = sh7372_earlytimer_init;
 }
