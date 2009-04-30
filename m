From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Apr 2009 07:12:09 +0000
Subject: [PATCH] sh: remove old MTU2 driver
Message-Id: <20090430071209.26643.61045.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the old MTU2 driver (CONFIG_SH_MTU2/timer-mtu2.c)

As replacement, select the sh_cmt driver with CONFIG_SH_TIMER_MTU2
and configure timer channel using platform data.

If multiple MTU channels are enabled using platform data, use the
earlytimer parameter on the kernel command line to select channel.
For instance, use "earlytimer=sh_mtu2.0" to select the first channel.

To verify which timer is being used, look at printouts or the timer
irq count in /proc/interrupts.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                    |    9 -
 arch/sh/include/asm/timer.h        |    2 
 arch/sh/kernel/timers/Makefile     |    1 
 arch/sh/kernel/timers/timer-mtu2.c |  202 ------------------------------------
 arch/sh/kernel/timers/timer.c      |    3 
 5 files changed, 2 insertions(+), 215 deletions(-)

--- 0009/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-04-29 23:15:10.000000000 +0900
@@ -478,16 +478,9 @@ config SH_TIMER_CMT
 	help
 	  This enables build of the CMT timer driver.
 
-config SH_MTU2
-	bool "MTU2 timer support"
-	depends on CPU_SH2A && !GENERIC_TIME
-	default y
-	help
-	  This enables the use of the MTU2 as the system timer.
-
 config SH_TIMER_MTU2
 	bool "MTU2 timer driver"
-	depends on SYS_SUPPORTS_MTU2 && !SH_MTU2
+	depends on SYS_SUPPORTS_MTU2
 	default y
 	select GENERIC_CLOCKEVENTS
 	help
--- 0007/arch/sh/include/asm/timer.h
+++ work/arch/sh/include/asm/timer.h	2009-04-29 23:15:59.000000000 +0900
@@ -23,7 +23,7 @@ struct sys_timer {
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern struct sys_timer tmu_timer, mtu2_timer;
+extern struct sys_timer tmu_timer;
 extern struct sys_timer *sys_timer;
 
 #ifndef CONFIG_GENERIC_TIME
--- 0007/arch/sh/kernel/timers/Makefile
+++ work/arch/sh/kernel/timers/Makefile	2009-04-29 23:15:31.000000000 +0900
@@ -5,6 +5,5 @@
 obj-y	:= timer.o
 
 obj-$(CONFIG_SH_TMU)		+= timer-tmu.o
-obj-$(CONFIG_SH_MTU2)		+= timer-mtu2.o
 
 obj-$(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)	+= timer-broadcast.o
--- 0001/arch/sh/kernel/timers/timer-mtu2.c
+++ /dev/null	2009-04-29 10:17:59.254032074 +0900
@@ -1,202 +0,0 @@
-/*
- * arch/sh/kernel/timers/timer-mtu2.c - MTU2 Timer Support
- *
- *  Copyright (C) 2005  Paul Mundt
- *
- * Based off of arch/sh/kernel/timers/timer-tmu.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/seqlock.h>
-#include <asm/timer.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/clock.h>
-
-/*
- * We use channel 1 for our lowly system timer. Channel 2 would be the other
- * likely candidate, but we leave it alone as it has higher divisors that
- * would be of more use to other more interesting applications.
- *
- * TODO: Presently we only implement a 16-bit single-channel system timer.
- * However, we can implement channel cascade if we go the overflow route and
- * get away with using 2 MTU2 channels as a 32-bit timer.
- */
-#define MTU2_TSTR	0xfffe4280
-#define MTU2_TCR_1	0xfffe4380
-#define MTU2_TMDR_1	0xfffe4381
-#define MTU2_TIOR_1	0xfffe4382
-#define MTU2_TIER_1	0xfffe4384
-#define MTU2_TSR_1	0xfffe4385
-#define MTU2_TCNT_1	0xfffe4386	/* 16-bit counter */
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7201) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7203)
-#define MTU2_TGRA_1	0xfffe4388
-#else
-#define MTU2_TGRA_1	0xfffe438a
-#endif
-
-#define STBCR3		0xfffe0408
-
-#define MTU2_TSTR_CST1	(1 << 1)	/* Counter Start 1 */
-
-#define MTU2_TSR_TGFA	(1 << 0)	/* GRA compare match */
-
-#define MTU2_TIER_TGIEA	(1 << 0)	/* GRA compare match  interrupt enable */
-
-#define MTU2_TCR_INIT	0x22
-
-#define MTU2_TCR_CALIB  0x00
-
-static unsigned long mtu2_timer_get_offset(void)
-{
-	int count;
-	static int count_p = 0x7fff;	/* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off.
-	 */
-	unsigned long jiffies_t;
-
-	/* timer count may underflow right here */
-	count = ctrl_inw(MTU2_TCNT_1);	/* read the latched count */
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
-			if (ctrl_inb(MTU2_TSR_1) & MTU2_TSR_TGFA) {
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
-static irqreturn_t mtu2_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long timer_status;
-
-	/* Clear TGFA bit */
-	timer_status = ctrl_inb(MTU2_TSR_1);
-	timer_status &= ~MTU2_TSR_TGFA;
-	ctrl_outb(timer_status, MTU2_TSR_1);
-
-	/* Do timer tick */
-	handle_timer_tick();
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction mtu2_irq = {
-	.name		= "timer",
-	.handler	= mtu2_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-};
-
-static unsigned int divisors[] = { 1, 4, 16, 64, 1, 1, 256 };
-
-static void mtu2_clk_init(struct clk *clk)
-{
-	u8 idx = MTU2_TCR_INIT & 0x7;
-
-	clk->rate = clk->parent->rate / divisors[idx];
-	/* Start TCNT counting */
-	ctrl_outb(ctrl_inb(MTU2_TSTR) | MTU2_TSTR_CST1, MTU2_TSTR);
-
-}
-
-static void mtu2_clk_recalc(struct clk *clk)
-{
-	u8 idx = ctrl_inb(MTU2_TCR_1) & 0x7;
-	clk->rate = clk->parent->rate / divisors[idx];
-}
-
-static struct clk_ops mtu2_clk_ops = {
-	.init		= mtu2_clk_init,
-	.recalc		= mtu2_clk_recalc,
-};
-
-static struct clk mtu2_clk1 = {
-	.name		= "mtu2_clk1",
-	.ops		= &mtu2_clk_ops,
-};
-
-static int mtu2_timer_start(void)
-{
-	ctrl_outb(ctrl_inb(MTU2_TSTR) | MTU2_TSTR_CST1, MTU2_TSTR);
-	return 0;
-}
-
-static int mtu2_timer_stop(void)
-{
-	ctrl_outb(ctrl_inb(MTU2_TSTR) & ~MTU2_TSTR_CST1, MTU2_TSTR);
-	return 0;
-}
-
-static int mtu2_timer_init(void)
-{
-	unsigned long interval;
-
-	setup_irq(CONFIG_SH_TIMER_IRQ, &mtu2_irq);
-
-	mtu2_clk1.parent = clk_get(NULL, "module_clk");
-
-	ctrl_outb(ctrl_inb(STBCR3) & (~0x20), STBCR3);
-
-	/* Normal operation */
-	ctrl_outb(0, MTU2_TMDR_1);
-	ctrl_outb(MTU2_TCR_INIT, MTU2_TCR_1);
-	ctrl_outb(0x01, MTU2_TIOR_1);
-
-	/* Enable underflow interrupt */
-	ctrl_outb(ctrl_inb(MTU2_TIER_1) | MTU2_TIER_TGIEA, MTU2_TIER_1);
-
-	interval = CONFIG_SH_PCLK_FREQ / 16 / HZ;
-	printk(KERN_INFO "Interval = %ld\n", interval);
-
-	ctrl_outw(interval, MTU2_TGRA_1);
-	ctrl_outw(0, MTU2_TCNT_1);
-
-	clk_register(&mtu2_clk1);
-	clk_enable(&mtu2_clk1);
-
-	return 0;
-}
-
-struct sys_timer_ops mtu2_timer_ops = {
-	.init		= mtu2_timer_init,
-	.start		= mtu2_timer_start,
-	.stop		= mtu2_timer_stop,
-#ifndef CONFIG_GENERIC_TIME
-	.get_offset	= mtu2_timer_get_offset,
-#endif
-};
-
-struct sys_timer mtu2_timer = {
-	.name	= "mtu2",
-	.ops	= &mtu2_timer_ops,
-};
--- 0007/arch/sh/kernel/timers/timer.c
+++ work/arch/sh/kernel/timers/timer.c	2009-04-29 23:15:40.000000000 +0900
@@ -17,9 +17,6 @@ static struct sys_timer *sys_timers[] = 
 #ifdef CONFIG_SH_TMU
 	&tmu_timer,
 #endif
-#ifdef CONFIG_SH_MTU2
-	&mtu2_timer,
-#endif
 	NULL,
 };
 
