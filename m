From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Jan 2015 07:25:32 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: Instantiate GIC from C board code in legacy builds
Message-Id: <20150129072532.25107.17303.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), the Lager legacy board support is known to be broken.

The IRQ numbers of the GIC are now virtual, and no longer match the
hardcoded hardware IRQ numbers in the legacy platform board code.

To fix this issue specific to non-multiplatform r8a7790 and Lager:
 1) Instantiate the GIC from platform board code and also
 2) Skip over the DT arch timer as well as
 3) Force delay setup based on DT CPU frequency

With these 3 fixes in place interrupts on Lager are now unbroken.

Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Suitable as a fix for v3.19-rc6. Depends on [PATCH v2]
 ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds

 arch/arm/mach-shmobile/board-lager.c     |   13 +++++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c |    2 ++
 arch/arm/mach-shmobile/timer.c           |    5 +++++
 3 files changed, 20 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2015-01-29 16:16:32.065025352 +0900
@@ -21,6 +21,8 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/mfd/tmio.h>
@@ -811,6 +813,16 @@ static void __init lager_init(void)
 					  lager_ksz8041_fixup);
 }
 
+static void __init lager_legacy_init_irq(void)
+{
+	void __iomem *gic_dist_base = ioremap_nocache(0xf1001000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xf1002000, 0x1000);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	/* Do not invoke DT-based interrupt code via irqchip_init() */
+}
+
 static const char * const lager_boards_compat_dt[] __initconst = {
 	"renesas,lager",
 	NULL,
@@ -819,6 +831,7 @@ static const char * const lager_boards_c
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
+	.init_irq	= lager_legacy_init_irq,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2015-01-29 16:16:32.065025352 +0900
@@ -133,7 +133,9 @@ void __init rcar_gen2_timer_init(void)
 #ifdef CONFIG_COMMON_CLK
 	rcar_gen2_clocks_init(mode);
 #endif
+#ifdef CONFIG_ARCH_SHMOBILE_MULTI
 	clocksource_of_init();
+#endif
 }
 
 struct memory_reserve_config {
--- 0002/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2015-01-29 16:17:04.915025234 +0900
@@ -75,6 +75,11 @@ void __init shmobile_init_delay(void)
 	 * to GIC being initialized from C and arch timer via DT */
 	if (of_machine_is_compatible("renesas,r8a73a4"))
 		has_arch_timer = false;
+
+	/* Non-multiplatform r8a7790 SoC cannot use arch timer due
+	 * to GIC being initialized from C and arch timer via DT */
+	if (of_machine_is_compatible("renesas,r8a7790"))
+		has_arch_timer = false;
 #endif
 
 	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
