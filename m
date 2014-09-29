From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 29 Sep 2014 05:05:58 +0000
Subject: [PATCH RFC v2 6/7] ARM: shmobile: Do additional settings for L2shutdown mode
Message-Id: <5428E8B6.4010504@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to Cortex-A15 TRM, some additional settings are needed.
Although the procedure was not completely same as in TRM, it was
referred to vexpress implementation to arrange order of additional
settings.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ef146fa..82db155 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -161,8 +161,32 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || \
 defined(CONFIG_CPU_IDLE)
+static void do_l2shutdown_settings(void)
+{
+	unsigned int v;
+
+	/* Disable L2$ prefetches */
+	asm volatile(
+	"       mrc     p15, 1, %0, c15, c0, 3\n"
+	"       orr     %0, %0, %1\n"
+	"       mcr     p15, 1, %0, c15, c0, 3\n"
+		: "=&r" (v)
+		: "Ir" (0x400)
+		: "cc");
+	isb();
+	dsb();
+
+	flush_cache_all();
+
+	/* Set Double lock control bit */
+	__asm__ __volatile__("mcr p14, 0, %0, c1, c3, 4" : : "r" (0x1));
+}
+
 static inline void cpu_enter_lowpower_a15(void)
 {
+	if (is_a15_l2shutdown)
+		do_l2shutdown_settings();
+
 	v7_exit_coherency_flush(louis);
 }
 
@@ -246,6 +270,7 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 
 	writel_relaxed(0x0, cpucmcr);
 	rcar_sysc_clear_event_status();
+	is_a15_l2shutdown = 0;
 
 	return 0;
 }
-- 
1.7.9.5
