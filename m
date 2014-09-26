From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 02:40:12 +0000
Subject: [PATCH RFC 4/7] ARM: shmobile: Backup and restore L2CTLR in Suspend-to-RAM
Message-Id: <5424D20C.1090406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is needed for CA15 only, to maintain L2CTLR register value
set in bootloader.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/common.h       |    2 ++
 arch/arm/mach-shmobile/headsmp.S      |   19 +++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |    8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 361bb3f..7990968 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -55,6 +55,8 @@ static inline int shmobile_cpufreq_init(void) { return 0; }
 extern void __iomem *shmobile_scu_base;
 extern phys_addr_t cpu_resume_phys_addr;
 extern void rcar_cpu_resume(void);
+extern unsigned int is_a15_l2shutdown;
+extern unsigned int l2ctlr_value;
 
 static inline void __init shmobile_init_late(void)
 {
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 800b53d..5afe65f 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -25,12 +25,31 @@ ENDPROC(shmobile_invalidate_start)
 
 ENTRY(rcar_cpu_resume)
 	bl	v7_invalidate_l1
+	bl	rcar_l2_restore
 	ldr     pc, 1f
 ENDPROC(rcar_cpu_resume)
 
+ENTRY(rcar_l2_restore)
+	ldr	r1, 2f
+	tst	r0, #1			@ is CA15
+	bne	_exit_init_l2_a15
+
+	ldr	r1, 3f
+	mcr 	p15, 1, r1, c9 , c0, 2
+_exit_init_l2_a15:
+
+	mov	pc, lr
+ENDPROC(rcar_l2_restore)
+
 	.globl	cpu_resume_phys_addr
 cpu_resume_phys_addr:
 1:	.space	4
+	.globl	is_a15_l2shutdown
+is_a15_l2shutdown:
+2:	.space	4
+	.globl	l2ctlr_value
+l2ctlr_value:
+3:	.space	4
 
 /*
  * Reset vector for secondary CPUs.
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index fb6d3e5..f883697 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -19,6 +19,7 @@
 #include <linux/suspend.h>
 #include <linux/threads.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/cp15.h>
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
@@ -229,6 +230,13 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 	gic_cpu_if_down();
 
 	writel_relaxed(0x2, cpucmcr);
+	if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15) {
+		is_a15_l2shutdown = 1;
+		asm volatile("mrc p15, 1, %0, c9 , c0, 2"
+			     : "=r" (l2ctlr_value));
+		pr_debug("%s: l2ctlr: 0x%08x\n", __func__, l2ctlr_value);
+	} else
+		is_a15_l2shutdown = 0;
 
 	shmobile_smp_hook(smp_processor_id(), virt_to_phys(rcar_cpu_resume), 0);
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
-- 
1.7.9.5
