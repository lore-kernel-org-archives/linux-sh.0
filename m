From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:53 +0000
Subject: [PATCH 06/08] ARM: mach-shmobile: r8a7740 and Bonito timer rework
Message-Id: <20120306083653.8131.8509.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Copy the SoC specific timer code from Bonito board code
to r8a7740 setup code. This makes is possible to share
the SoC specific timer code across boards. The Bonito
specific timer setup code tied to the FPGA is kept as-is.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the patch:
 "[PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()"

 arch/arm/mach-shmobile/board-bonito.c  |   18 +++++++++++-------
 arch/arm/mach-shmobile/setup-r8a7740.c |   10 ++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

--- 0006/arch/arm/mach-shmobile/board-bonito.c
+++ work/arch/arm/mach-shmobile/board-bonito.c	2012-03-06 13:17:44.000000000 +0900
@@ -466,7 +466,7 @@ static void __init bonito_init(void)
 	}
 }
 
-static void __init bonito_timer_init(void)
+static void __init bonito_earlytimer_init(void)
 {
 	u16 val;
 	u8 md_ck = 0;
@@ -481,18 +481,22 @@ static void __init bonito_timer_init(voi
 		md_ck |= MD_CK0;
 
 	r8a7740_clock_init(md_ck);
-	shmobile_timer.init();
+	shmobile_earlytimer_init();
 }
 
-struct sys_timer bonito_timer = {
-	.init	= bonito_timer_init,
-};
+void __init bonito_add_early_devices(void)
+{
+	r8a7740_add_early_devices();
+
+	/* override timer setup with board-specific code */
+	shmobile_timer.init = bonito_earlytimer_init;
+}
 
 MACHINE_START(BONITO, "bonito")
 	.map_io		= bonito_map_io,
-	.init_early	= r8a7740_add_early_devices,
+	.init_early	= bonito_add_early_devices,
 	.init_irq	= r8a7740_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= bonito_init,
-	.timer		= &bonito_timer,
+	.timer		= &shmobile_timer,
 MACHINE_END
--- 0006/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2012-03-06 13:19:18.000000000 +0900
@@ -29,6 +29,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 
 static struct map_desc r8a7740_io_desc[] __initdata = {
 	 /*
@@ -377,6 +378,12 @@ void __init r8a7740_add_standard_devices
 			     ARRAY_SIZE(r8a7740_late_devices));
 }
 
+static void __init r8a7740_earlytimer_init(void)
+{
+	r8a7740_clock_init(0);
+	shmobile_earlytimer_init();
+}
+
 void __init r8a7740_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7740_early_devices,
@@ -384,4 +391,7 @@ void __init r8a7740_add_early_devices(vo
 
 	/* setup early console here as well */
 	shmobile_setup_console();
+
+	/* override timer setup with soc-specific code */
+	shmobile_timer.init = r8a7740_earlytimer_init;
 }
