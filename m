From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:10 +0000
Subject: [RFC/RFT 2/6] ARM: shmobile: export apmu_power_* functions
Message-Id: <1444671674-19275-3-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

The on/off functions will be called from the mcpm
callbacks which are implemented in a separate file.

Make it simpler to use this functions by changing the
parameters to take only the cpu logical number
and remove the wrapper function.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 36 ++++++++++++++++++++++-------------
 arch/arm/mach-shmobile/platsmp-apmu.h |  4 +++-
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4e54512..d2ff5af 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -34,8 +34,14 @@ static struct {
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
 
-static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
+int __maybe_unused apmu_power_on(unsigned int cpu)
 {
+	void __iomem *p = apmu_cpus[cpu].iomem;
+	int bit =  apmu_cpus[cpu].bit;
+
+	if (!p)
+		return -EINVAL;
+
 	/* request power on */
 	writel_relaxed(BIT(bit), p + WUPCR_OFFS);
 
@@ -46,17 +52,28 @@ static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 	return 0;
 }
 
-static int __maybe_unused apmu_power_off(void __iomem *p, int bit)
+int __maybe_unused apmu_power_off(unsigned int cpu)
 {
+	void __iomem *p = apmu_cpus[cpu].iomem;
+	int bit =  apmu_cpus[cpu].bit;
+
+	if (!p)
+		return -EINVAL;
+
 	/* request Core Standby for next WFI */
 	writel_relaxed(3, p + CPUNCR_OFFS(bit));
 	return 0;
 }
 
-static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
+int __maybe_unused apmu_power_off_poll(unsigned int cpu)
 {
+	void __iomem *p = apmu_cpus[cpu].iomem;
+	int bit =  apmu_cpus[cpu].bit;
 	int k;
 
+	if (!p)
+		return -EINVAL;
+
 	for (k = 0; k < 1000; k++) {
 		if (((readl_relaxed(p + PSTR_OFFS) >> (bit * 4)) & 0x03) = 3)
 			return 1;
@@ -67,13 +84,6 @@ static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 	return 0;
 }
 
-static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
-{
-	void __iomem *p = apmu_cpus[cpu].iomem;
-
-	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
-}
-
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
 	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
@@ -135,7 +145,7 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/* For this particular CPU register boot vector */
 	shmobile_smp_hook(cpu, virt_to_phys(secondary_startup), 0);
 
-	return apmu_wrap(cpu, apmu_power_on);
+	return apmu_power_on(cpu);
 }
 #endif
 
@@ -174,7 +184,7 @@ void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
 
 	/* Select next sleep mode using the APMU */
-	apmu_wrap(cpu, apmu_power_off);
+	apmu_power_off(cpu);
 
 	/* Do ARM specific CPU shutdown */
 	cpu_enter_lowpower_a15();
@@ -211,7 +221,7 @@ void shmobile_smp_apmu_cpu_die(unsigned int cpu)
 
 int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 {
-	return apmu_wrap(cpu, apmu_power_off_poll);
+	return apmu_power_off_poll(cpu);
 }
 #endif
 
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.h b/arch/arm/mach-shmobile/platsmp-apmu.h
index 76512c9..c29adf1 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.h
+++ b/arch/arm/mach-shmobile/platsmp-apmu.h
@@ -28,5 +28,7 @@ extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
 					    struct task_struct *idle);
 extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
-
+extern int apmu_power_on(unsigned int cpu);
+extern int apmu_power_off(unsigned int cpu);
+extern int apmu_power_off_poll(unsigned int cpu);
 #endif /* PLATSMP_APMU_H */
-- 
2.4.5

