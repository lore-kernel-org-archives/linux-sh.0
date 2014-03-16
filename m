From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:35:56 +0000
Subject: [PATCH 04/06] ARM: shmobile: Also build APMU code for non-SMP r8a7790
Message-Id: <20140316213556.15598.38851.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Build APMU code on r8a7790 when CPUIdle is enabled regardless
if SMP is enabled or not.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile       |    1 +
 arch/arm/mach-shmobile/platsmp-apmu.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790
 
 # CPU PM objects
 cpu-y				:= cpuidle.o platsmp.o headsmp.o
+cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -69,7 +69,7 @@ static int apmu_wrap(int cpu, int (*fn)(
 
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
-	if (apmu_cpus[cpu].iomem)
+	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
 		return;
 
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
@@ -133,6 +133,7 @@ void __init shmobile_smp_apmu_prepare_cp
 	apmu_parse_cfg(apmu_init_cpu);
 }
 
+#ifdef CONFIG_SMP
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
@@ -140,6 +141,7 @@ int shmobile_smp_apmu_boot_secondary(uns
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
+#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* nicked from arch/arm/mach-exynos/hotplug.c */
