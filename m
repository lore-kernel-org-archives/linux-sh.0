From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:20 +0000
Subject: [PATCH 02/08] ARM: shmobile: Adjust APMU code to build for non-SMP
Message-Id: <20140605051520.18075.77930.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the APMU code to allow build when CONFIG_SMP=n.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-apmu.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-06-05 11:20:35.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/suspend.h>
+#include <linux/threads.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/proc-fns.h>
@@ -25,13 +26,13 @@
 static struct {
 	void __iomem *iomem;
 	int bit;
-} apmu_cpus[CONFIG_NR_CPUS];
+} apmu_cpus[NR_CPUS];
 
 #define WUPCR_OFFS 0x10
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
 
-static int apmu_power_on(void __iomem *p, int bit)
+static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 {
 	/* request power on */
 	writel_relaxed(BIT(bit), p + WUPCR_OFFS);
@@ -50,7 +51,7 @@ static int apmu_power_off(void __iomem *
 	return 0;
 }
 
-static int apmu_power_off_poll(void __iomem *p, int bit)
+static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 {
 	int k;
 
@@ -73,7 +74,7 @@ static int apmu_wrap(int cpu, int (*fn)(
 
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
-	if (apmu_cpus[cpu].iomem)
+	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
 		return;
 
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
@@ -137,6 +138,7 @@ void __init shmobile_smp_apmu_prepare_cp
 	apmu_parse_cfg(apmu_init_cpu);
 }
 
+#ifdef CONFIG_SMP
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
@@ -144,6 +146,7 @@ int shmobile_smp_apmu_boot_secondary(uns
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
+#endif
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
