From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Sep 2012 14:34:56 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 Coupled CPUIdle Prototype
Message-Id: <20120913143456.18093.68682.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Prototype patch to enable the coupled CPUIdle
helper code on sh73a0. Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    1 
 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/board-ag5evm.c        |    2 
 arch/arm/mach-shmobile/board-kota2.c         |    2 
 arch/arm/mach-shmobile/board-kzm9g.c         |    2 
 arch/arm/mach-shmobile/cpuidle.c             |   20 ++++++---
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/pm-sh73a0.c           |   57 ++++++++++++++++++++++++++
 8 files changed, 81 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2012-09-13 22:53:09.000000000 +0900
@@ -28,6 +28,7 @@ config ARCH_SH73A0
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select I2C
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2012-09-13 23:15:48.000000000 +0900
@@ -41,6 +41,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2012-09-13 23:17:41.000000000 +0900
@@ -647,6 +647,8 @@ static void __init ag5evm_init(void)
 #endif
 	sh73a0_add_standard_devices();
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
+
+	sh73a0_pm_init();
 }
 
 MACHINE_START(AG5EVM, "ag5evm")
--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2012-09-13 23:17:30.000000000 +0900
@@ -542,6 +542,8 @@ static void __init kota2_init(void)
 #endif
 	sh73a0_add_standard_devices();
 	platform_add_devices(kota2_devices, ARRAY_SIZE(kota2_devices));
+
+	sh73a0_pm_init();
 }
 
 MACHINE_START(KOTA2, "kota2")
--- 0001/arch/arm/mach-shmobile/board-kzm9g.c
+++ work/arch/arm/mach-shmobile/board-kzm9g.c	2012-09-13 23:17:53.000000000 +0900
@@ -761,6 +761,8 @@ static void __init kzm_init(void)
 
 	sh73a0_add_standard_devices();
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
+
+	sh73a0_pm_init();
 }
 
 static const char *kzm9g_boards_compat_dt[] __initdata = {
--- 0001/arch/arm/mach-shmobile/cpuidle.c
+++ work/arch/arm/mach-shmobile/cpuidle.c	2012-09-13 23:26:49.000000000 +0900
@@ -34,7 +34,7 @@ static int shmobile_cpuidle_enter(struct
 	return index;
 }
 
-static struct cpuidle_device shmobile_cpuidle_dev;
+static DEFINE_PER_CPU(struct cpuidle_device, shmobile_cpuidle_dev);
 static struct cpuidle_driver shmobile_cpuidle_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
@@ -48,8 +48,9 @@ void (*shmobile_cpuidle_setup)(struct cp
 
 int shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
 	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
+	struct cpuidle_device *dev;
+	unsigned int cpu_id = 0;
 	int i;
 
 	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
@@ -60,8 +61,17 @@ int shmobile_cpuidle_init(void)
 
 	cpuidle_register_driver(drv);
 
-	dev->state_count = drv->state_count;
-	cpuidle_register_device(dev);
-
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		dev = &per_cpu(shmobile_cpuidle_dev, cpu_id);
+		dev->cpu = cpu_id;
+		dev->state_count = drv->state_count;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		dev->coupled_cpus = *cpu_online_mask;
+#endif
+		if (cpuidle_register_device(dev)) {
+			pr_err("Unable to register CPUIdle device\n");
+			return -EIO;
+		}
+	}
 	return 0;
 }
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-09-13 23:13:48.000000000 +0900
@@ -53,6 +53,7 @@ extern void sh73a0_add_early_devices(voi
 extern void sh73a0_add_standard_devices(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
+void __init sh73a0_pm_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-sh73a0.c	2012-09-13 23:29:44.000000000 +0900
@@ -0,0 +1,57 @@
+/*
+ * sh73a0 Power management support
+ *
+ *  Copyright (C) 2012 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/console.h>
+#include <asm/io.h>
+#include <asm/tlbflush.h>
+#include <mach/common.h>
+#include <mach/sh73a0.h>
+
+#ifdef CONFIG_CPU_IDLE
+
+static void sh73a0_enter_coupled(void)
+{
+	cpu_do_idle(); /* nothing special for now */
+}
+
+static void sh73a0_cpuidle_setup(struct cpuidle_driver *drv)
+{
+	struct cpuidle_state *state = &drv->states[drv->state_count];
+
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+	strncpy(state->desc, "Coupled Prototype Mode", CPUIDLE_DESC_LEN);
+	state->exit_latency = 10;
+	state->target_residency = 20 + 10;
+	state->flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED;
+	shmobile_cpuidle_modes[drv->state_count] = sh73a0_enter_coupled;
+	drv->state_count++;
+}
+
+static void sh73a0_cpuidle_init(void)
+{
+	shmobile_cpuidle_setup = sh73a0_cpuidle_setup;
+}
+#else
+static void sh73a0_cpuidle_init(void) {}
+#endif
+
+void __init sh73a0_pm_init(void)
+{
+	sh73a0_cpuidle_init();
+}
