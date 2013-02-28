From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 28 Feb 2013 17:00:31 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7740: Do not use early devices with DT reference
Message-Id: <1362074410-2960-2-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not initialise any early devices when using the minimal DT
reference code. Only the delay needs to be initialised.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: new patch added to the patchset.

This patch is done the same way as ARM: shmobile: r8a7779: Do not use early devices with DT reference (c0f7d218d5d8623bc1a6728cd30011aa7c4e6f87)

 .../board-armadillo800eva-reference.c              |   10 +++-----
 arch/arm/mach-shmobile/include/mach/common.h       |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |   24 ++++++++------------
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 6991fb1..5ed2299 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -208,12 +208,8 @@ static void __init eva_init(void)
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
-}
-
-static void __init eva_timer_init(void)
-{
+	/* clocks are setup late during boot in the case of DT */
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
-
 	/* the rate of extal1 clock must be set before late_time_init */
 	eva_clock_init();
 }
@@ -232,13 +228,13 @@ static const char *eva_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_add_early_devices_dt,
+	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
-	.init_time	= eva_timer_init,
+	.init_time	= shmobile_timer_init,
 	.dt_compat	= eva_boards_compat_dt,
 	.restart	= eva_restart,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d08a0b8..c9267ed 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -51,11 +51,11 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
+extern void r8a7740_init_delay(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
-extern void r8a7740_add_early_devices_dt(void);
 extern void r8a7740_add_standard_devices(void);
 extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 5312aad..f35e7c2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -378,7 +378,7 @@ static struct platform_device tmu02_device = {
 	.num_resources	= ARRAY_SIZE(tmu02_resources),
 };
 
-static struct platform_device *r8a7740_early_devices[] __initdata = {
+static struct platform_device *r8a7740_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -805,8 +805,8 @@ void __init r8a7740_add_standard_devices(void)
 	r8a7740_init_pm_domains();
 
 	/* add devices */
-	platform_add_devices(r8a7740_early_devices,
-			    ARRAY_SIZE(r8a7740_early_devices));
+	platform_add_devices(r8a7740_devices_dt,
+			    ARRAY_SIZE(r8a7740_devices_dt));
 	platform_add_devices(r8a7740_late_devices,
 			     ARRAY_SIZE(r8a7740_late_devices));
 
@@ -826,8 +826,8 @@ void __init r8a7740_add_standard_devices(void)
 
 void __init r8a7740_add_early_devices(void)
 {
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
+	early_platform_add_devices(r8a7740_devices_dt,
+				   ARRAY_SIZE(r8a7740_devices_dt));
 
 	/* setup early console here as well */
 	shmobile_setup_console();
@@ -835,15 +835,9 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_add_early_devices_dt(void)
+void __init r8a7740_init_delay(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
 }
 
 static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
@@ -852,8 +846,8 @@ static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
-	platform_add_devices(r8a7740_early_devices,
-			    ARRAY_SIZE(r8a7740_early_devices));
+	platform_add_devices(r8a7740_devices_dt,
+			    ARRAY_SIZE(r8a7740_devices_dt));
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     r8a7740_auxdata_lookup, NULL);
@@ -874,7 +868,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_add_early_devices_dt,
+	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= add_standard_devices,
-- 
1.7.9.5

