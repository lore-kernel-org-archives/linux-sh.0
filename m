From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 02:40:06 +0000
Subject: [PATCH RFC 3/7] ARM: shmobile: Implement L2 shutdown mode for Suspend-to-RAM
Message-Id: <5424D206.1010405@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From now on, Suspend to RAM will enter L2 shutdown mode,
instead of Core Standby mode.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/common.h       |    2 ++
 arch/arm/mach-shmobile/headsmp.S      |    9 +++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |   16 ++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 0f08656..361bb3f 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -53,6 +53,8 @@ static inline int shmobile_cpufreq_init(void) { return 0; }
 #endif
 
 extern void __iomem *shmobile_scu_base;
+extern phys_addr_t cpu_resume_phys_addr;
+extern void rcar_cpu_resume(void);
 
 static inline void __init shmobile_init_late(void)
 {
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 50c4915..800b53d 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -23,6 +23,15 @@ ENTRY(shmobile_invalidate_start)
 ENDPROC(shmobile_invalidate_start)
 #endif
 
+ENTRY(rcar_cpu_resume)
+	bl	v7_invalidate_l1
+	ldr     pc, 1f
+ENDPROC(rcar_cpu_resume)
+
+	.globl	cpu_resume_phys_addr
+cpu_resume_phys_addr:
+1:	.space	4
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index f6e4f0b..fb6d3e5 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -34,6 +34,9 @@ static struct {
 #define WUPCR_OFFS 0x10
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
+#define CPUCMCR 0xe6154184
+
+void __iomem *cpucmcr;
 
 static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 {
@@ -133,6 +136,9 @@ static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit))
 
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus)
 {
+	/* pass physical address of cpu_resume() to assembly resume code */
+	cpu_resume_phys_addr = virt_to_phys(cpu_resume);
+
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
 	shmobile_boot_arg = MPIDR_HWID_BITMASK;
@@ -207,7 +213,7 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
 	shmobile_smp_apmu_cpu_shutdown(cpu);
-	cpu_do_idle(); /* WFI selects Core Standby */
+	cpu_do_idle();
 	return 1;
 }
 #endif
@@ -222,14 +228,20 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 	 */
 	gic_cpu_if_down();
 
-	shmobile_smp_hook(smp_processor_id(), virt_to_phys(cpu_resume), 0);
+	writel_relaxed(0x2, cpucmcr);
+
+	shmobile_smp_hook(smp_processor_id(), virt_to_phys(rcar_cpu_resume), 0);
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
 	cpu_leave_lowpower();
+
+	writel_relaxed(0x0, cpucmcr);
+
 	return 0;
 }
 
 void __init shmobile_smp_apmu_suspend_init(void)
 {
+	cpucmcr = ioremap_nocache(CPUCMCR, 0x4);
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #endif
-- 
1.7.9.5
