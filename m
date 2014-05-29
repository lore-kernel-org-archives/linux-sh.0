From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Thu, 29 May 2014 07:24:27 +0000
Subject: [PATCH 1/3] ARM: shmobile: APMU: Add Core-Standby-state for Suspend to RAM
Message-Id: <5386E0AB.9010906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch add Core-Standby-state for Suspend to RAM.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/platsmp-apmu.c        |   60 ++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index f7a360e..8f0cd57 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -35,8 +35,10 @@ extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
+void shmobile_smp_apmu_suspend_init(void);
 #else
 static inline int shmobile_suspend_init(void) { return 0; }
+static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 8cb641c..c64fc12 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -7,15 +7,19 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
+#include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <mach/common.h>
 
 static struct {
@@ -141,7 +145,7 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return apmu_wrap(cpu, apmu_power_on);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
 static inline void cpu_enter_lowpower_a15(void)
 {
@@ -172,16 +176,40 @@ static inline void cpu_enter_lowpower_a15(void)
 	dsb();
 }
 
-void shmobile_smp_apmu_cpu_die(unsigned int cpu)
+void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
-	/* For this particular CPU deregister boot vector */
-	shmobile_smp_hook(cpu, 0, 0);
 
 	/* Select next sleep mode using the APMU */
 	apmu_wrap(cpu, apmu_power_off);
 
 	/* Do ARM specific CPU shutdown */
 	cpu_enter_lowpower_a15();
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile("mrc    p15, 0, %0, c1, c0, 0\n"
+		     "       orr     %0, %0, %1\n"
+		     "       mcr     p15, 0, %0, c1, c0, 0\n"
+		     "       mrc     p15, 0, %0, c1, c0, 1\n"
+		     "       orr     %0, %0, %2\n"
+		     "       mcr     p15, 0, %0, c1, c0, 1\n"
+		     : "=&r" (v)
+		     : "Ir" (CR_C), "Ir" (0x40)
+		     : "cc");
+}
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+void shmobile_smp_apmu_cpu_die(unsigned int cpu)
+{
+	/* For this particular CPU deregister boot vector */
+	shmobile_smp_hook(cpu, 0, 0);
+
+	/* Shutdown CPU core */
+	shmobile_smp_apmu_cpu_shutdown(cpu);
 
 	/* jump to shared mach-shmobile sleep / reset code */
 	shmobile_smp_sleep();
@@ -192,3 +220,27 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 	return apmu_wrap(cpu, apmu_power_off_poll);
 }
 #endif
+
+#if defined(CONFIG_SUSPEND)
+static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
+{
+	shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
+	shmobile_smp_apmu_cpu_shutdown(cpu);
+	cpu_do_idle(); /* WFI selects Core Standby */
+	return 1;
+}
+
+static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
+{
+	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
+	cpu_leave_lowpower();
+	return 0;
+}
+
+void shmobile_smp_apmu_suspend_init(void)
+{
+	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
+}
+#else
+void shmobile_smp_apmu_suspend_init(void) {}
+#endif
-- 
1.7.9.5

