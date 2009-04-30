From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Apr 2009 04:09:26 +0000
Subject: [PATCH] sh: remove old CMT driver
Message-Id: <20090430040926.25509.85290.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the old CMT driver (CONFIG_SH_CMT/timer-cmt.c)

As replacement, select the sh_cmt driver with CONFIG_SH_TIMER_CMT
and configure timer channel using platform data.

If multiple CMT channels are enabled using platform data, use the
earlytimer parameter on the kernel command line to select channel.
For instance, use "earlytimer=sh_cmt.0" to select the first channel.

To verify which timer is being used, look at printouts or the timer
irq count in /proc/interrupts.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                   |   18 ---
 arch/sh/include/asm/timer.h       |    2 
 arch/sh/kernel/timers/Makefile    |    1 
 arch/sh/kernel/timers/timer-cmt.c |  188 -------------------------------------
 arch/sh/kernel/timers/timer.c     |    3 
 5 files changed, 6 insertions(+), 206 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-04-29 19:41:37.000000000 +0900
@@ -462,22 +462,14 @@ config SH_TMU
 	help
 	  This enables the use of the TMU as the system timer.
 
-config SH_CMT
-	bool "CMT timer support"
-	depends on SYS_SUPPORTS_CMT && CPU_SH2
-	default y
-	help
-	  This enables the use of the CMT as the system timer.
-
-#
-# Support for the new-style CMT driver. This will replace SH_CMT
-# once its other dependencies are merged.
-#
 config SH_TIMER_CMT
-	bool "CMT clockevents driver"
-	depends on SYS_SUPPORTS_CMT && !SH_CMT
+	bool "CMT timer driver"
+	depends on SYS_SUPPORTS_CMT
+	default y
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_TIME
+	help
+	  This enables build of the CMT timer driver.
 
 config SH_MTU2
 	bool "MTU2 timer support"
--- 0001/arch/sh/include/asm/timer.h
+++ work/arch/sh/include/asm/timer.h	2009-04-29 19:39:33.000000000 +0900
@@ -23,7 +23,7 @@ struct sys_timer {
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern struct sys_timer tmu_timer, cmt_timer, mtu2_timer;
+extern struct sys_timer tmu_timer, mtu2_timer;
 extern struct sys_timer *sys_timer;
 
 #ifndef CONFIG_GENERIC_TIME
--- 0001/arch/sh/kernel/timers/Makefile
+++ work/arch/sh/kernel/timers/Makefile	2009-04-29 19:39:33.000000000 +0900
@@ -6,6 +6,5 @@ obj-y	:= timer.o
 
 obj-$(CONFIG_SH_TMU)		+= timer-tmu.o
 obj-$(CONFIG_SH_MTU2)		+= timer-mtu2.o
-obj-$(CONFIG_SH_CMT)		+= timer-cmt.o
 
 obj-$(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)	+= timer-broadcast.o
--- 0001/arch/sh/kernel/timers/timer-cmt.c
+++ /dev/null	2009-04-29 10:17:59.254032074 +0900
@@ -1,188 +0,0 @@
-/*
- * arch/sh/kernel/timers/timer-cmt.c - CMT Timer Support
- *
- *  Copyright (C) 2005  Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/seqlock.h>
-#include <asm/timer.h>
-#include <asm/rtc.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/clock.h>
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7619)
-#define CMT_CMSTR	0xf84a0070
-#define CMT_CMCSR_0	0xf84a0072
-#define CMT_CMCNT_0	0xf84a0074
-#define CMT_CMCOR_0	0xf84a0076
-#define CMT_CMCSR_1	0xf84a0078
-#define CMT_CMCNT_1	0xf84a007a
-#define CMT_CMCOR_1	0xf84a007c
-
-#define STBCR3		0xf80a0000
-#define cmt_clock_enable() do {	ctrl_outb(ctrl_inb(STBCR3) & ~0x10, STBCR3); } while(0)
-#define CMT_CMCSR_INIT	0x0040
-#define CMT_CMCSR_CALIB	0x0000
-#elif defined(CONFIG_CPU_SUBTYPE_SH7203) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7206) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7263)
-#define CMT_CMSTR	0xfffec000
-#define CMT_CMCSR_0	0xfffec002
-#define CMT_CMCNT_0	0xfffec004
-#define CMT_CMCOR_0	0xfffec006
-
-#define STBCR4		0xfffe040c
-#define cmt_clock_enable() do {	ctrl_outb(ctrl_inb(STBCR4) & ~0x04, STBCR4); } while(0)
-#define CMT_CMCSR_INIT	0x0040
-#define CMT_CMCSR_CALIB	0x0000
-#else
-#error "Unknown CPU SUBTYPE"
-#endif
-
-static unsigned long cmt_timer_get_offset(void)
-{
-	int count;
-	static unsigned short count_p = 0xffff;    /* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off.
-	 */
-	unsigned long jiffies_t;
-
-	/* timer count may underflow right here */
-	count =  ctrl_inw(CMT_CMCOR_0);
-	count -= ctrl_inw(CMT_CMCNT_0);
-
-	jiffies_t = jiffies;
-
-	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there is one kind of problem that must be avoided here:
-	 *  1. the timer counter underflows
-	 */
-
-	if (jiffies_t = jiffies_p) {
-		if (count > count_p) {
-			/* the nutcase */
-			if (ctrl_inw(CMT_CMCSR_0) & 0x80) { /* Check CMF bit */
-				count -= LATCH;
-			} else {
-				printk("%s (): hardware timer problem?\n",
-				       __func__);
-			}
-		}
-	} else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
-
-	return count;
-}
-
-static irqreturn_t cmt_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long timer_status;
-
-	/* Clear CMF bit */
-	timer_status = ctrl_inw(CMT_CMCSR_0);
-	timer_status &= ~0x80;
-	ctrl_outw(timer_status, CMT_CMCSR_0);
-
-	handle_timer_tick();
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction cmt_irq = {
-	.name		= "timer",
-	.handler	= cmt_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-};
-
-static void cmt_clk_init(struct clk *clk)
-{
-	u8 divisor = CMT_CMCSR_INIT & 0x3;
-	ctrl_inw(CMT_CMCSR_0);
-	ctrl_outw(CMT_CMCSR_INIT, CMT_CMCSR_0);
-	clk->parent = clk_get(NULL, "module_clk");
-	clk->rate = clk->parent->rate / (8 << (divisor << 1));
-}
-
-static void cmt_clk_recalc(struct clk *clk)
-{
-	u8 divisor = ctrl_inw(CMT_CMCSR_0) & 0x3;
-	clk->rate = clk->parent->rate / (8 << (divisor << 1));
-}
-
-static struct clk_ops cmt_clk_ops = {
-	.init		= cmt_clk_init,
-	.recalc		= cmt_clk_recalc,
-};
-
-static struct clk cmt0_clk = {
-	.name		= "cmt0_clk",
-	.ops		= &cmt_clk_ops,
-};
-
-static int cmt_timer_start(void)
-{
-	ctrl_outw(ctrl_inw(CMT_CMSTR) | 0x01, CMT_CMSTR);
-	return 0;
-}
-
-static int cmt_timer_stop(void)
-{
-	ctrl_outw(ctrl_inw(CMT_CMSTR) & ~0x01, CMT_CMSTR);
-	return 0;
-}
-
-static int cmt_timer_init(void)
-{
-	unsigned long interval;
-
-	cmt_clock_enable();
-
-	setup_irq(CONFIG_SH_TIMER_IRQ, &cmt_irq);
-
-	cmt0_clk.parent = clk_get(NULL, "module_clk");
-
-	cmt_timer_stop();
-
-	interval = cmt0_clk.parent->rate / 8 / HZ;
-	printk(KERN_INFO "Interval = %ld\n", interval);
-
-	ctrl_outw(interval, CMT_CMCOR_0);
-
-	clk_register(&cmt0_clk);
-	clk_enable(&cmt0_clk);
-
-	cmt_timer_start();
-
-	return 0;
-}
-
-static struct sys_timer_ops cmt_timer_ops = {
-	.init		= cmt_timer_init,
-	.start		= cmt_timer_start,
-	.stop		= cmt_timer_stop,
-#ifndef CONFIG_GENERIC_TIME
-	.get_offset	= cmt_timer_get_offset,
-#endif
-};
-
-struct sys_timer cmt_timer = {
-	.name	= "cmt",
-	.ops	= &cmt_timer_ops,
-};
--- 0001/arch/sh/kernel/timers/timer.c
+++ work/arch/sh/kernel/timers/timer.c	2009-04-29 19:39:33.000000000 +0900
@@ -20,9 +20,6 @@ static struct sys_timer *sys_timers[] = 
 #ifdef CONFIG_SH_MTU2
 	&mtu2_timer,
 #endif
-#ifdef CONFIG_SH_CMT
-	&cmt_timer,
-#endif
 	NULL,
 };
 
