From: Rich Felker <dalias@libc.org>
Date: Sun, 27 Mar 2016 17:03:13 +0000
Subject: [PATCH] sh: fix smp-shx3 build regression from removal of arch localtimer
Message-Id: <20160327170313.GZ21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The removal was not complete and left behind one reference to a
removed function in smp-shx3.c. For completeness, also remove
declarations for functions that were removed.

Fixes: 45624ac38926 "sh: remove arch-specific localtimer and use generic one"
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/include/asm/smp.h          | 5 -----
 arch/sh/kernel/cpu/sh4a/smp-shx3.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/sh/include/asm/smp.h b/arch/sh/include/asm/smp.h
index 1baf0ba..c9f8bbd 100644
--- a/arch/sh/include/asm/smp.h
+++ b/arch/sh/include/asm/smp.h
@@ -34,11 +34,6 @@ enum {
 DECLARE_PER_CPU(int, cpu_state);
 
 void smp_message_recv(unsigned int msg);
-void smp_timer_broadcast(const struct cpumask *mask);
-
-void local_timer_interrupt(void);
-void local_timer_setup(unsigned int cpu);
-void local_timer_stop(unsigned int cpu);
 
 void arch_send_call_function_single_ipi(int cpu);
 void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
index 4a29880..839612c 100644
--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -73,8 +73,6 @@ static void shx3_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
 
-	local_timer_setup(0);
-
 	BUILD_BUG_ON(SMP_MSG_NR >= 8);
 
 	for (i = 0; i < SMP_MSG_NR; i++)
-- 
2.7.0

