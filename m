From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:36:06 +0000
Subject: [PATCH 05/06] ARM: shmobile: r8a7790 Core Standby CPUIdle prototype
Message-Id: <20140316213606.15598.45777.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Prototype code to enable per-cpu power domain control via
the r8a7790 Core Standby sleep mode. Needs more work.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2 
 arch/arm/mach-shmobile/platsmp-apmu.c        |   38 ++++++++++++++++--
 arch/arm/mach-shmobile/pm-r8a7790.c          |   53 +++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h
@@ -24,6 +24,8 @@ extern int shmobile_smp_scu_cpu_kill(uns
 extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
 					    struct task_struct *idle);
+extern void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu);
+extern void shmobile_smp_apmu_cpu_resume(void);
 extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
 struct clk;
--- 0005/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -143,7 +143,7 @@ int shmobile_smp_apmu_boot_secondary(uns
 }
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_CPU_IDLE)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
 static inline void cpu_enter_lowpower_a15(void)
 {
@@ -174,16 +174,44 @@ static inline void cpu_enter_lowpower_a1
 	dsb();
 }
 
-void shmobile_smp_apmu_cpu_die(unsigned int cpu)
+void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
-	/* For this particular CPU deregister boot vector */
-	shmobile_smp_hook(cpu, 0, 0);
-
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
+
+void shmobile_smp_apmu_cpu_resume(void)
+{
+	cpu_leave_lowpower();
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
--- 0004/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c
@@ -10,9 +10,13 @@
  * for more details.
  */
 
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
-#include <linux/smp.h>
+#include <asm/cpuidle.h>
 #include <asm/io.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
 #include <mach/common.h>
 #include <mach/pm-rcar.h>
 #include <mach/r8a7790.h>
@@ -48,6 +52,51 @@ static inline void r8a7790_sysc_init(voi
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_CPU_IDLE
+static int r8a7790_do_idle_core_standby(unsigned long cpu)
+{
+	shmobile_smp_apmu_cpu_shutdown(cpu);
+	cpu_do_idle(); /* WFI selects Core Standby */
+	shmobile_smp_apmu_cpu_resume();
+	return 1;
+}
+
+static int r8a7790_enter_core_standby(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv, int index)
+{
+	cpu_pm_enter();
+	cpu_suspend(smp_processor_id(), r8a7790_do_idle_core_standby);
+	cpu_pm_exit();
+	return index;
+}
+
+static struct cpuidle_driver r8a7790_cpuidle_driver = {
+	.name = "r8a7790_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE,
+		{
+			.name = "C2",
+			.desc = "Core Standby Mode",
+			.exit_latency = 10,
+			.target_residency = 20 + 10,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = r8a7790_enter_core_standby,
+		},
+	},
+	.state_count = 2,
+};
+
+static void __init r8a7790_cpuidle_init(void)
+{
+	/* Initialize APMU in case of uniprocessor software support */
+	shmobile_smp_apmu_prepare_cpus(1);
+	shmobile_cpuidle_set_driver(&r8a7790_cpuidle_driver);
+}
+#else
+static void __init r8a7790_cpuidle_init(void) {}
+#endif
+
 void __init r8a7790_pm_init(void)
 {
 	void __iomem *p;
@@ -57,6 +106,8 @@ void __init r8a7790_pm_init(void)
 	if (once++)
 		return;
 
+	r8a7790_cpuidle_init();
+
 	/* MERAM for jump stub, because BAR requires 256KB aligned address */
 	p = ioremap_nocache(MERAM, shmobile_boot_size);
 	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
