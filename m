From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 02:39:53 +0000
Subject: [PATCH RFC 1/7] ARM: shmobile: use common ARMv7 cache disabling code
Message-Id: <5424D1F9.1090006@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The effort to consolidate ARMv7 cache disabling code via macro
v7_exit_coherency_flush() was introduced by 'commit 39792c7cf311
("ARM: 7861/1: cacheflush: consolidate single-CPU ARMv7 cache
disabling code")'. The code was made use in core powerdown and
cluster powerdown in other SoC.
Hence, it's worth changing our code to use it.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |   27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 3bfb1a0..21f8ddd 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -152,34 +152,9 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || \
 defined(CONFIG_CPU_IDLE)
-/* nicked from arch/arm/mach-exynos/hotplug.c */
 static inline void cpu_enter_lowpower_a15(void)
 {
-	unsigned int v;
-
-	asm volatile(
-	"       mrc     p15, 0, %0, c1, c0, 0\n"
-	"       bic     %0, %0, %1\n"
-	"       mcr     p15, 0, %0, c1, c0, 0\n"
-		: "=&r" (v)
-		: "Ir" (CR_C)
-		: "cc");
-
-	flush_cache_louis();
-
-	asm volatile(
-	/*
-	 * Turn off coherency
-	 */
-	"       mrc     p15, 0, %0, c1, c0, 1\n"
-	"       bic     %0, %0, %1\n"
-	"       mcr     p15, 0, %0, c1, c0, 1\n"
-		: "=&r" (v)
-		: "Ir" (0x40)
-		: "cc");
-
-	isb();
-	dsb();
+	v7_exit_coherency_flush(louis);
 }
 
 void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
-- 
1.7.9.5
