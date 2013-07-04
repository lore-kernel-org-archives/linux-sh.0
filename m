From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Jul 2013 20:40:37 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
Message-Id: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Extract serial interface and CMT device instantiation into a separate
function to be called in both full DT and dummy DT modes. This doesn't
change the behaviour in the dummy DT case, only the instantiation order
changes slightly. The full DT case is extended, previously these devices
were not available there. Also following the r8a7790 example we remove the
call to of_platform_populate() from the exported method to let platforms
extend its parameters if needed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 12a4ee9..2266747 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -17,6 +17,7 @@ enum {
 };
 
 void r8a73a4_add_standard_devices(void);
+void r8a73a4_add_standard_devices_dt(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 void r8a73a4_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 6aa80645..52bf60c 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -302,7 +302,7 @@ static struct resource dma_resources[] = {
 	},
 };
 
-void __init r8a73a4_add_standard_devices(void)
+static void __init r8a73a4_add_common_devices(void)
 {
 	r8a73a4_register_scif(SCIFA0);
 	r8a73a4_register_scif(SCIFA1);
@@ -310,10 +310,15 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_scif(SCIFB1);
 	r8a73a4_register_scif(SCIFB2);
 	r8a73a4_register_scif(SCIFB3);
+	r8a7790_register_cmt(10);
+}
+
+void __init r8a73a4_add_standard_devices(void)
+{
 	r8a73a4_register_irqc(0);
 	r8a73a4_register_irqc(1);
+	r8a73a4_add_common_devices();
 	r8a73a4_register_thermal();
-	r8a7790_register_cmt(10);
 	platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,
 				dma_resources, ARRAY_SIZE(dma_resources),
 				&dma_platform_data, sizeof(dma_platform_data));
@@ -329,7 +334,13 @@ void __init r8a73a4_init_delay(void)
 #ifdef CONFIG_USE_OF
 void __init r8a73a4_add_standard_devices_dt(void)
 {
+	r8a73a4_add_common_devices();
 	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+}
+
+static void __init add_devices_dt(void)
+{
+	r8a73a4_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -340,7 +351,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_delay,
-	.init_machine	= r8a73a4_add_standard_devices_dt,
+	.init_machine	= add_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
-- 
1.7.2.5

