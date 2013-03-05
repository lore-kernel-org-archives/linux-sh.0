From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Mar 2013 06:46:42 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: Reference DT implementation
Message-Id: <87r4jumjht.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Provide SoC code for the R-Car M1 to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |    3 ++
 arch/arm/mach-shmobile/intc-r8a7778.c        |   27 ++++++++++----
 arch/arm/mach-shmobile/setup-r8a7778.c       |   49 +++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 90427a8..2cf3ef3 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -61,9 +61,12 @@ extern void r8a7740_pm_init(void);
 extern void r8a7778_add_early_devices(void);
 extern void r8a7778_earlytimer_init(void);
 extern void r8a7778_add_standard_devices(void);
+extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_map_io(void);
 extern void r8a7778_clock_init(void);
+extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
+extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_pinmux_init(void);
 
 extern void r8a7779_init_delay(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7778.c b/arch/arm/mach-shmobile/intc-r8a7778.c
index afe9197..f40f8e0 100644
--- a/arch/arm/mach-shmobile/intc-r8a7778.c
+++ b/arch/arm/mach-shmobile/intc-r8a7778.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/intc.h>
@@ -45,13 +46,8 @@ static int r8a7778_set_wake(struct irq_data *data, unsigned int on)
 	return 0; /* always allow wakeup */
 }
 
-void __init r8a7778_init_irq(void)
+static void __init r8a7778_init_irq_common(void)
 {
-	void __iomem *gic_dist_base = IOMEM(0xfe438000);
-	void __iomem *gic_cpu_base = IOMEM(0xfe430000);
-
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 	gic_arch_extn.irq_set_wake = r8a7778_set_wake;
 
 	/* route all interrupts to ARM */
@@ -62,3 +58,22 @@ void __init r8a7778_init_irq(void)
 	__raw_writel(0x08330773, INT2SMSKCR0);
 	__raw_writel(0x00311110, INT2SMSKCR1);
 }
+
+void __init r8a7778_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xfe438000);
+	void __iomem *gic_cpu_base = IOMEM(0xfe430000);
+
+	/* use GIC to handle interrupts */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	r8a7778_init_irq_common();
+}
+
+#ifdef CONFIG_OF
+void __init r8a7778_init_irq_dt(void)
+{
+	irqchip_init();
+	r8a7778_init_irq_common();
+}
+#endif
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index f5a04f1..12db0c9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -26,6 +26,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -253,7 +255,7 @@ static struct platform_device tmu01_device = {
 	.num_resources	= ARRAY_SIZE(tmu01_resources),
 };
 
-static struct platform_device *r8a7778_early_devices[] __initdata = {
+static struct platform_device *r8a7778_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -274,8 +276,8 @@ void __init r8a7778_add_standard_devices(void)
 	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
 #endif
 
-	platform_add_devices(r8a7778_early_devices,
-			    ARRAY_SIZE(r8a7778_early_devices));
+	platform_add_devices(r8a7778_devices_dt,
+			     ARRAY_SIZE(r8a7778_devices_dt));
 	platform_add_devices(r8a7778_late_devices,
 			    ARRAY_SIZE(r8a7778_late_devices));
 }
@@ -288,8 +290,8 @@ void __init r8a7778_earlytimer_init(void)
 
 void __init r8a7778_add_early_devices(void)
 {
-	early_platform_add_devices(r8a7778_early_devices,
-				   ARRAY_SIZE(r8a7778_early_devices));
+	early_platform_add_devices(r8a7778_devices_dt,
+				   ARRAY_SIZE(r8a7778_devices_dt));
 
 	/* Early serial console setup is not included here due to
 	 * memory map collisions. The SCIF serial ports in r8a7778
@@ -307,3 +309,40 @@ void __init r8a7778_add_early_devices(void)
 	 * command line in case of the board.
 	 */
 }
+
+#ifdef CONFIG_USE_OF
+void __init r8a7778_init_delay(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+}
+
+static const struct of_dev_auxdata r8a7778_auxdata_lookup[] __initconst = {
+	{},
+};
+
+void __init r8a7778_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	r8a7778_clock_init();
+
+	platform_add_devices(r8a7778_devices_dt,
+			     ARRAY_SIZE(r8a7778_devices_dt));
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     r8a7778_auxdata_lookup, NULL);
+}
+
+static const char *r8a7778_compat_dt[] __initdata = {
+	"renesas,r8a7778",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
+	.map_io		= r8a7778_map_io,
+	.init_early	= r8a7778_init_delay,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7778_init_irq_dt,
+	.init_machine	= r8a7778_add_standard_devices_dt,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= r8a7778_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
1.7.9.5

