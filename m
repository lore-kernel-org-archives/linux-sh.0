From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 23 Sep 2011 05:53:00 +0000
Subject: [PATCH 03/03] ARM: mach-shmobile: sh7372 sleep warning fixes
Message-Id: <20110923055300.4013.94354.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7372 sleep code to build parts of the
code only when SUSPEND and/or CPU_IDLE are set.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c    |    5 ++++-
 arch/arm/mach-shmobile/sleep-sh7372.S |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-09-23 14:23:29.000000000 +0900
@@ -189,6 +189,7 @@ struct sh7372_pm_domain sh7372_a3sg = {
 
 #endif /* CONFIG_PM */
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
 static int sh7372_do_idle_core_standby(unsigned long unused)
 {
 	cpu_do_idle(); /* WFI when SYSTBCR = 0x10 -> Core Standby */
@@ -209,7 +210,9 @@ static void sh7372_enter_core_standby(vo
 	 /* disable reset vector translation */
 	__raw_writel(0, SBAR);
 }
+#endif
 
+#ifdef CONFIG_SUSPEND
 static void sh7372_enter_a3sm_common(int pllc0_on)
 {
 	/* set reset vector, translate 4k */
@@ -351,7 +354,7 @@ static void sh7372_setup_a3sm(unsigned l
 	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR3);
 	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR4);
 }
-
+#endif
 
 #ifdef CONFIG_CPU_IDLE
 
--- 0003/arch/arm/mach-shmobile/sleep-sh7372.S
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2011-09-23 14:23:38.000000000 +0900
@@ -34,6 +34,7 @@
 #include <asm/memory.h>
 #include <asm/assembler.h>
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
 	.align	12
 	.text
 	.global sh7372_resume_core_standby_a3sm
@@ -91,3 +92,4 @@ sh7372_do_idle_a3sm:
 
 kernel_flush:
 	.word v7_flush_dcache_all
+#endif
