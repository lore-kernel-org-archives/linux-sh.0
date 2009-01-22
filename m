From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jan 2009 09:55:31 +0000
Subject: [PATCH 01/05] sh: rework clocksource and sched_clock
Message-Id: <20090122095531.31653.60916.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework and simplify the sched_clock and clocksource code. Instead
of registering the clocksource in a shared file we move it into the
tmu driver. Also, add code to handle sched_clock in the case of no
clocksource.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/timer.h       |    4 +-
 arch/sh/kernel/time_32.c          |   59 +++++--------------------------------
 arch/sh/kernel/timers/timer-tmu.c |   10 +++++-
 3 files changed, 19 insertions(+), 54 deletions(-)

--- 0001/arch/sh/include/asm/timer.h
+++ work/arch/sh/include/asm/timer.h	2009-01-22 13:22:25.000000000 +0900
@@ -9,7 +9,6 @@ struct sys_timer_ops {
 	int (*init)(void);
 	int (*start)(void);
 	int (*stop)(void);
-	cycle_t (*read)(void);
 #ifndef CONFIG_GENERIC_TIME
 	unsigned long (*get_offset)(void);
 #endif
@@ -39,6 +38,7 @@ struct sys_timer *get_sys_timer(void);
 
 /* arch/sh/kernel/time.c */
 void handle_timer_tick(void);
-extern unsigned long sh_hpt_frequency;
+
+extern struct clocksource clocksource_sh;
 
 #endif /* __ASM_SH_TIMER_H */
--- 0001/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2009-01-22 13:23:11.000000000 +0900
@@ -41,14 +41,6 @@ static int null_rtc_set_time(const time_
 	return 0;
 }
 
-/*
- * Null high precision timer functions for systems lacking one.
- */
-static cycle_t null_hpt_read(void)
-{
-	return 0;
-}
-
 void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
 int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
 
@@ -200,42 +192,21 @@ device_initcall(timer_init_sysfs);
 
 void (*board_time_init)(void);
 
-/*
- * Shamelessly based on the MIPS and Sparc64 work.
- */
-static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
-unsigned long sh_hpt_frequency = 0;
-
-#define NSEC_PER_CYC_SHIFT	10
-
-static struct clocksource clocksource_sh = {
+struct clocksource clocksource_sh = {
 	.name		= "SuperH",
-	.rating		= 200,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.read		= null_hpt_read,
-	.shift		= 16,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init init_sh_clocksource(void)
-{
-	if (!sh_hpt_frequency || clocksource_sh.read = null_hpt_read)
-		return;
-
-	clocksource_sh.mult = clocksource_hz2mult(sh_hpt_frequency,
-						  clocksource_sh.shift);
-
-	timer_ticks_per_nsec_quotient -		clocksource_hz2mult(sh_hpt_frequency, NSEC_PER_CYC_SHIFT);
-
-	clocksource_register(&clocksource_sh);
-}
-
 #ifdef CONFIG_GENERIC_TIME
 unsigned long long sched_clock(void)
 {
-	unsigned long long ticks = clocksource_sh.read();
-	return (ticks * timer_ticks_per_nsec_quotient) >> NSEC_PER_CYC_SHIFT;
+	unsigned long long cycles;
+
+	/* jiffies based sched_clock if no clocksource is installed */
+	if (!clocksource_sh.rating)
+		return (unsigned long long)jiffies * (NSEC_PER_SEC / HZ);
+
+	cycles = clocksource_sh.read();
+	return cyc2ns(&clocksource_sh, cycles);
 }
 #endif
 
@@ -260,16 +231,4 @@ void __init time_init(void)
 	 */
 	sys_timer = get_sys_timer();
 	printk(KERN_INFO "Using %s for system timer\n", sys_timer->name);
-
-
-	if (sys_timer->ops->read)
-		clocksource_sh.read = sys_timer->ops->read;
-
-	init_sh_clocksource();
-
-	if (sh_hpt_frequency)
-		printk("Using %lu.%03lu MHz high precision timer.\n",
-		       ((sh_hpt_frequency + 500) / 1000) / 1000,
-		       ((sh_hpt_frequency + 500) / 1000) % 1000);
-
 }
--- 0001/arch/sh/kernel/timers/timer-tmu.c
+++ work/arch/sh/kernel/timers/timer-tmu.c	2009-01-22 13:22:12.000000000 +0900
@@ -254,7 +254,14 @@ static int tmu_timer_init(void)
 
 	_tmu_start(TMU1);
 
-	sh_hpt_frequency = clk_get_rate(&tmu1_clk);
+	clocksource_sh.rating = 200;
+	clocksource_sh.mask = CLOCKSOURCE_MASK(32);
+	clocksource_sh.read = tmu_timer_read;
+	clocksource_sh.shift = 10;
+	clocksource_sh.mult = clocksource_hz2mult(clk_get_rate(&tmu1_clk),
+						  clocksource_sh.shift);
+	clocksource_sh.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	clocksource_register(&clocksource_sh);
 
 	tmu0_clockevent.mult = div_sc(frequency, NSEC_PER_SEC,
 				      tmu0_clockevent.shift);
@@ -274,7 +281,6 @@ static struct sys_timer_ops tmu_timer_op
 	.init		= tmu_timer_init,
 	.start		= tmu_timer_start,
 	.stop		= tmu_timer_stop,
-	.read		= tmu_timer_read,
 };
 
 struct sys_timer tmu_timer = {
