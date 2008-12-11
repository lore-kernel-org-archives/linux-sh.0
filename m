From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Dec 2008 12:52:49 +0000
Subject: [PATCH 01/03] sh: CONFIG_SH_TIMER support
Message-Id: <20081211125249.19369.59783.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

SuperH timer V5 base code supporting:
- early platform drivers
- hardware configuration kept as platform data
- compile time CONFIG_SH_TIMER switch

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig             |   13 +++++++++----
 arch/sh/include/asm/timer.h |    4 ++++
 arch/sh/kernel/time_32.c    |   41 +++++++++++++++++++++++++++++++----------
 3 files changed, 44 insertions(+), 14 deletions(-)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-11 19:54:15.000000000 +0900
@@ -395,33 +395,38 @@ source "arch/sh/boards/Kconfig"
 
 menu "Timer and clock configuration"
 
+config SH_TIMER
+	def_bool n
+	select GENERIC_CLOCKEVENTS
+
 config SH_TMU
 	def_bool y
 	prompt "TMU timer support"
-	depends on CPU_SH3 || CPU_SH4
+	depends on !SH_TIMER && (CPU_SH3 || CPU_SH4)
 	select GENERIC_CLOCKEVENTS
 	help
 	  This enables the use of the TMU as the system timer.
 
 config ARCH_USES_GETTIMEOFFSET
 	def_bool y
-	depends on !SH_TMU
+	depends on !SH_TMU && !SH_TIMER
 
 config SH_CMT
 	def_bool y
 	prompt "CMT timer support"
-	depends on CPU_SH2 && !CPU_SUBTYPE_MXG
+	depends on !SH_TIMER && CPU_SH2 && !CPU_SUBTYPE_MXG
 	help
 	  This enables the use of the CMT as the system timer.
 
 config SH_MTU2
 	def_bool n
 	prompt "MTU2 timer support"
-	depends on CPU_SH2A
+	depends on !SH_TIMER && CPU_SH2A
 	help
 	  This enables the use of the MTU2 as the system timer.
 
 config SH_TIMER_IRQ
+	depends on !SH_TIMER
 	int
 	default "28" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785 || \
 			CPU_SUBTYPE_SH7763
--- 0005/arch/sh/include/asm/timer.h
+++ work/arch/sh/include/asm/timer.h	2008-12-11 19:54:15.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <linux/sysdev.h>
 #include <linux/clocksource.h>
+#include <linux/platform_device.h>
 #include <cpu/timer.h>
 
 struct sys_timer_ops {
@@ -41,4 +42,7 @@ struct sys_timer *get_sys_timer(void);
 void handle_timer_tick(void);
 extern unsigned long sh_hpt_frequency;
 
+void sh_timer_register(struct platform_device **pdevs, int nr_pdevs);
+void plat_timer_setup(void);
+
 #endif /* __ASM_SH_TIMER_H */
--- 0005/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2008-12-11 19:55:21.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
@@ -41,14 +42,6 @@ static int null_rtc_set_time(const time_
 	return 0;
 }
 
-/*
- * Null high precision timer functions for systems lacking one.
- */
-static cycle_t null_hpt_read(struct clocksource *cs)
-{
-	return 0;
-}
-
 void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
 int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
 
@@ -133,6 +126,21 @@ int timer_resume(struct sys_device *dev)
 #define timer_resume NULL
 #endif
 
+void (*board_time_init)(void);
+
+#ifdef CONFIG_SH_TIMER
+
+static struct platform_device **sh_timer_pdevs;
+static int sh_timer_nr_pdevs;
+
+void sh_timer_register(struct platform_device **pdevs, int nr_pdevs)
+{
+	sh_timer_pdevs = pdevs;
+	sh_timer_nr_pdevs = nr_pdevs;
+}
+
+#else
+
 static struct sysdev_class timer_sysclass = {
 	.name	 = "timer",
 	.suspend = timer_suspend,
@@ -150,8 +158,6 @@ static int __init timer_init_sysfs(void)
 }
 device_initcall(timer_init_sysfs);
 
-void (*board_time_init)(void);
-
 /*
  * Shamelessly based on the MIPS and Sparc64 work.
  */
@@ -160,6 +166,14 @@ unsigned long sh_hpt_frequency = 0;
 
 #define NSEC_PER_CYC_SHIFT	10
 
+/*
+ * Null high precision timer functions for systems lacking one.
+ */
+static cycle_t null_hpt_read(struct clocksource *cs)
+{
+	return 0;
+}
+
 static struct clocksource clocksource_sh = {
 	.name		= "SuperH",
 	.rating		= 200,
@@ -190,6 +204,7 @@ unsigned long long sched_clock(void)
 	return (ticks * timer_ticks_per_nsec_quotient) >> NSEC_PER_CYC_SHIFT;
 }
 #endif
+#endif
 
 void __init time_init(void)
 {
@@ -206,6 +221,11 @@ void __init time_init(void)
 	local_timer_setup(smp_processor_id());
 #endif
 
+#ifdef CONFIG_SH_TIMER
+	plat_timer_setup();
+	platform_device_setup_early("earlytimer",
+				    sh_timer_pdevs, sh_timer_nr_pdevs);
+#else
 	/*
 	 * Find the timer to use as the system timer, it will be
 	 * initialized for us.
@@ -224,6 +244,7 @@ void __init time_init(void)
 		       ((sh_hpt_frequency + 500) / 1000) / 1000,
 		       ((sh_hpt_frequency + 500) / 1000) % 1000);
 
+#endif
 #if defined(CONFIG_SH_KGDB)
 	/*
 	 * Set up kgdb as requested. We do it here because the serial
