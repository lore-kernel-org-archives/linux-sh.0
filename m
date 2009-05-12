From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 10:25:54 +0000
Subject: [PATCH] sh: remove old TMU driver
Message-Id: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the old TMU driver (CONFIG_SH_TMU/timer-tmu.c)

As replacement, select the sh_tmu driver with CONFIG_SH_TIMER_TMU
and configure timer channel using platform data.

If multiple TMU channels are enabled using platform data, use the
earlytimer parameter on the kernel command line to select channel.
For instance, use "earlytimer=sh_tmu.0" to select the first channel.

To verify which timer is being used, look at printouts or the timer
irq count in /proc/interrupts.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                     |    9 -
 arch/sh/include/asm/timer.h         |    1 
 arch/sh/include/cpu-sh3/cpu/timer.h |   67 -------
 arch/sh/include/cpu-sh4/cpu/timer.h |   60 -------
 arch/sh/kernel/timers/Makefile      |    2 
 arch/sh/kernel/timers/timer-tmu.c   |  297 -----------------------------------
 arch/sh/kernel/timers/timer.c       |    3 
 7 files changed, 1 insertion(+), 438 deletions(-)

--- 0015/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-12 17:50:47.000000000 +0900
@@ -473,16 +473,9 @@ source "arch/sh/boards/Kconfig"
 
 menu "Timer and clock configuration"
 
-config SH_TMU
-	bool "TMU timer support"
-	depends on CPU_SH3 || CPU_SH4
-	default y
-	help
-	  This enables the use of the TMU as the system timer.
-
 config SH_TIMER_TMU
 	bool "TMU timer driver"
-	depends on !SH_TMU && SYS_SUPPORTS_TMU
+	depends on SYS_SUPPORTS_TMU
 	default y
 	help
 	  This enables the build of the TMU timer driver.
--- 0001/arch/sh/include/asm/timer.h
+++ work/arch/sh/include/asm/timer.h	2009-05-12 17:50:16.000000000 +0900
@@ -18,7 +18,6 @@ struct sys_timer {
 	struct sys_timer_ops	*ops;
 };
 
-extern struct sys_timer tmu_timer;
 extern struct sys_timer *sys_timer;
 
 /* arch/sh/kernel/timers/timer.c */
--- 0001/arch/sh/include/cpu-sh3/cpu/timer.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,67 +0,0 @@
-/*
- * include/asm-sh/cpu-sh3/timer.h
- *
- * Copyright (C) 2004 Lineo Solutions, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef __ASM_CPU_SH3_TIMER_H
-#define __ASM_CPU_SH3_TIMER_H
-
-/*
- * ---------------------------------------------------------------------------
- * TMU Common definitions for SH3 processors
- *	SH7706
- *	SH7709S
- *	SH7727
- *	SH7729R
- *	SH7710
- *	SH7720
- *	SH7710
- * ---------------------------------------------------------------------------
- */
-
-#if  !defined(CONFIG_CPU_SUBTYPE_SH7720) && !defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define TMU_TOCR	0xfffffe90	/* Byte access */
-#endif
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7710) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define TMU_012_TSTR	0xa412fe92	/* Byte access */
-
-#define TMU0_TCOR	0xa412fe94	/* Long access */
-#define TMU0_TCNT	0xa412fe98	/* Long access */
-#define TMU0_TCR	0xa412fe9c	/* Word access */
-
-#define TMU1_TCOR	0xa412fea0	/* Long access */
-#define TMU1_TCNT	0xa412fea4	/* Long access */
-#define TMU1_TCR	0xa412fea8	/* Word access */
-
-#define TMU2_TCOR	0xa412feac	/* Long access */
-#define TMU2_TCNT	0xa412feb0	/* Long access */
-#define TMU2_TCR	0xa412feb4	/* Word access */
-
-#else
-#define TMU_012_TSTR	0xfffffe92	/* Byte access */
-
-#define TMU0_TCOR	0xfffffe94	/* Long access */
-#define TMU0_TCNT	0xfffffe98	/* Long access */
-#define TMU0_TCR	0xfffffe9c	/* Word access */
-
-#define TMU1_TCOR	0xfffffea0	/* Long access */
-#define TMU1_TCNT	0xfffffea4	/* Long access */
-#define TMU1_TCR	0xfffffea8	/* Word access */
-
-#define TMU2_TCOR	0xfffffeac	/* Long access */
-#define TMU2_TCNT	0xfffffeb0	/* Long access */
-#define TMU2_TCR	0xfffffeb4	/* Word access */
-#if !defined(CONFIG_CPU_SUBTYPE_SH7720) && !defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define TMU2_TCPR2	0xfffffeb8	/* Long access */
-#endif
-#endif
-
-#endif /* __ASM_CPU_SH3_TIMER_H */
-
--- 0001/arch/sh/include/cpu-sh4/cpu/timer.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,60 +0,0 @@
-/*
- * include/asm-sh/cpu-sh4/timer.h
- *
- * Copyright (C) 2004 Lineo Solutions, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef __ASM_CPU_SH4_TIMER_H
-#define __ASM_CPU_SH4_TIMER_H
-
-/*
- * ---------------------------------------------------------------------------
- * TMU Common definitions for SH4 processors
- *	SH7750S/SH7750R
- *	SH7751/SH7751R
- *	SH7760
- *	SH-X3
- * ---------------------------------------------------------------------------
- */
-#ifdef CONFIG_CPU_SUBTYPE_SHX3
-#define TMU_012_BASE	0xffc10000
-#define TMU_345_BASE	0xffc20000
-#else
-#define TMU_012_BASE	0xffd80000
-#define TMU_345_BASE	0xfe100000
-#endif
-
-#define TMU_TOCR	TMU_012_BASE	/* Not supported on all CPUs */
-
-#define TMU_012_TSTR	(TMU_012_BASE + 0x04)
-#define TMU_345_TSTR	(TMU_345_BASE + 0x04)
-
-#define TMU0_TCOR	(TMU_012_BASE + 0x08)
-#define TMU0_TCNT	(TMU_012_BASE + 0x0c)
-#define TMU0_TCR	(TMU_012_BASE + 0x10)
-
-#define TMU1_TCOR       (TMU_012_BASE + 0x14)
-#define TMU1_TCNT       (TMU_012_BASE + 0x18)
-#define TMU1_TCR        (TMU_012_BASE + 0x1c)
-
-#define TMU2_TCOR       (TMU_012_BASE + 0x20)
-#define TMU2_TCNT       (TMU_012_BASE + 0x24)
-#define TMU2_TCR	(TMU_012_BASE + 0x28)
-#define TMU2_TCPR	(TMU_012_BASE + 0x2c)
-
-#define TMU3_TCOR	(TMU_345_BASE + 0x08)
-#define TMU3_TCNT	(TMU_345_BASE + 0x0c)
-#define TMU3_TCR	(TMU_345_BASE + 0x10)
-
-#define TMU4_TCOR	(TMU_345_BASE + 0x14)
-#define TMU4_TCNT	(TMU_345_BASE + 0x18)
-#define TMU4_TCR	(TMU_345_BASE + 0x1c)
-
-#define TMU5_TCOR	(TMU_345_BASE + 0x20)
-#define TMU5_TCNT	(TMU_345_BASE + 0x24)
-#define TMU5_TCR	(TMU_345_BASE + 0x28)
-
-#endif /* __ASM_CPU_SH4_TIMER_H */
--- 0001/arch/sh/kernel/timers/Makefile
+++ work/arch/sh/kernel/timers/Makefile	2009-05-12 17:50:31.000000000 +0900
@@ -3,5 +3,3 @@
 #
 
 obj-y	:= timer.o
-
-obj-$(CONFIG_SH_TMU)		+= timer-tmu.o
--- 0001/arch/sh/kernel/timers/timer-tmu.c
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,297 +0,0 @@
-/*
- * arch/sh/kernel/timers/timer-tmu.c - TMU Timer Support
- *
- *  Copyright (C) 2005 - 2007  Paul Mundt
- *
- * TMU handling code hacked out of arch/sh/kernel/time.c
- *
- *  Copyright (C) 1999  Tetsuya Okada & Niibe Yutaka
- *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
- *  Copyright (C) 2002, 2003, 2004  Paul Mundt
- *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/seqlock.h>
-#include <linux/clockchips.h>
-#include <asm/timer.h>
-#include <asm/rtc.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/clock.h>
-
-#define TMU_TOCR_INIT	0x00
-#define TMU_TCR_INIT	0x0020
-
-#define TMU0		(0)
-#define TMU1		(1)
-
-static inline void _tmu_start(int tmu_num)
-{
-	ctrl_outb(ctrl_inb(TMU_012_TSTR) | (0x1<<tmu_num), TMU_012_TSTR);
-}
-
-static inline void _tmu_set_irq(int tmu_num, int enabled)
-{
-	register unsigned long tmu_tcr = TMU0_TCR + (0xc*tmu_num);
-	ctrl_outw( (enabled ? ctrl_inw(tmu_tcr) | (1<<5) : ctrl_inw(tmu_tcr) & ~(1<<5)), tmu_tcr);
-}
-
-static inline void _tmu_stop(int tmu_num)
-{
-	ctrl_outb(ctrl_inb(TMU_012_TSTR) & ~(0x1<<tmu_num), TMU_012_TSTR);
-}
-
-static inline void _tmu_clear_status(int tmu_num)
-{
-	register unsigned long tmu_tcr = TMU0_TCR + (0xc*tmu_num);
-	/* Clear UNF bit */
-	ctrl_outw(ctrl_inw(tmu_tcr) & ~0x100, tmu_tcr);
-}
-
-static inline unsigned long _tmu_read(int tmu_num)
-{
-        return ctrl_inl(TMU0_TCNT+0xC*tmu_num);
-}
-
-static int tmu_timer_start(void)
-{
-	_tmu_start(TMU0);
-	_tmu_start(TMU1);
-	_tmu_set_irq(TMU0,1);
-	return 0;
-}
-
-static int tmu_timer_stop(void)
-{
-	_tmu_stop(TMU0);
-	_tmu_stop(TMU1);
-	_tmu_clear_status(TMU0);
-	return 0;
-}
-
-/*
- * also when the module_clk is scaled the TMU1
- * will show the same frequency
- */
-static int tmus_are_scaled;
-
-static cycle_t tmu_timer_read(struct clocksource *cs)
-{
-	return ((cycle_t)(~_tmu_read(TMU1)))<<tmus_are_scaled;
-}
-
-
-static unsigned long tmu_latest_interval[3];
-static void tmu_timer_set_interval(int tmu_num, unsigned long interval, unsigned int reload)
-{
-	unsigned long tmu_tcnt = TMU0_TCNT + tmu_num*0xC;
-	unsigned long tmu_tcor = TMU0_TCOR + tmu_num*0xC;
-
-	_tmu_stop(tmu_num);
-
-	ctrl_outl(interval, tmu_tcnt);
-	tmu_latest_interval[tmu_num] = interval;
-
-	/*
-	 * TCNT reloads from TCOR on underflow, clear it if we don't
-	 * intend to auto-reload
-	 */
-	ctrl_outl( reload ? interval : 0 , tmu_tcor);
-
-	_tmu_start(tmu_num);
-}
-
-static int tmu_set_next_event(unsigned long cycles,
-			      struct clock_event_device *evt)
-{
-	tmu_timer_set_interval(TMU0,cycles, evt->mode = CLOCK_EVT_MODE_PERIODIC);
-	_tmu_set_irq(TMU0,1);
-	return 0;
-}
-
-static void tmu_set_mode(enum clock_event_mode mode,
-			 struct clock_event_device *evt)
-{
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		ctrl_outl(tmu_latest_interval[TMU0], TMU0_TCOR);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		ctrl_outl(0, TMU0_TCOR);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
-}
-
-static struct clock_event_device tmu0_clockevent = {
-	.name		= "tmu0",
-	.shift		= 32,
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= tmu_set_mode,
-	.set_next_event	= tmu_set_next_event,
-};
-
-static irqreturn_t tmu_timer_interrupt(int irq, void *dummy)
-{
-	struct clock_event_device *evt = &tmu0_clockevent;
-	_tmu_clear_status(TMU0);
-	_tmu_set_irq(TMU0,tmu0_clockevent.mode != CLOCK_EVT_MODE_ONESHOT);
-
-	switch (tmu0_clockevent.mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-	case CLOCK_EVT_MODE_PERIODIC:
-		evt->event_handler(evt);
-		break;
-	default:
-		break;
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction tmu0_irq = {
-	.name		= "periodic/oneshot timer",
-	.handler	= tmu_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-};
-
-static void __init tmu_clk_init(struct clk *clk)
-{
-	u8 divisor  = TMU_TCR_INIT & 0x7;
-	int tmu_num = clk->name[3]-'0';
-	ctrl_outw(TMU_TCR_INIT, TMU0_TCR+(tmu_num*0xC));
-	clk->rate = clk_get_rate(clk->parent) / (4 << (divisor << 1));
-}
-
-static void tmu_clk_recalc(struct clk *clk)
-{
-	int tmu_num = clk->name[3]-'0';
-	unsigned long prev_rate = clk_get_rate(clk);
-	unsigned long flags;
-	u8 divisor = ctrl_inw(TMU0_TCR+tmu_num*0xC) & 0x7;
-	clk->rate  = clk_get_rate(clk->parent) / (4 << (divisor << 1));
-
-	if(prev_rate=clk_get_rate(clk))
-		return;
-
-	if(tmu_num)
-		return; /* No more work on TMU1 */
-
-	local_irq_save(flags);
-	tmus_are_scaled = (prev_rate > clk->rate);
-
-	_tmu_stop(TMU0);
-
-	tmu0_clockevent.mult = div_sc(clk->rate, NSEC_PER_SEC,
-				tmu0_clockevent.shift);
-	tmu0_clockevent.max_delta_ns -			clockevent_delta2ns(-1, &tmu0_clockevent);
-	tmu0_clockevent.min_delta_ns -			clockevent_delta2ns(1, &tmu0_clockevent);
-
-	if (tmus_are_scaled)
-		tmu_latest_interval[TMU0] >>= 1;
-	else
-		tmu_latest_interval[TMU0] <<= 1;
-
-	tmu_timer_set_interval(TMU0,
-		tmu_latest_interval[TMU0],
-		tmu0_clockevent.mode = CLOCK_EVT_MODE_PERIODIC);
-
-	_tmu_start(TMU0);
-
-	local_irq_restore(flags);
-}
-
-static struct clk_ops tmu_clk_ops = {
-	.init		= tmu_clk_init,
-	.recalc		= tmu_clk_recalc,
-};
-
-static struct clk tmu0_clk = {
-	.name		= "tmu0_clk",
-	.ops		= &tmu_clk_ops,
-};
-
-static struct clk tmu1_clk = {
-	.name		= "tmu1_clk",
-	.ops		= &tmu_clk_ops,
-};
-
-static int tmu_timer_init(void)
-{
-	unsigned long interval;
-	unsigned long frequency;
-
-	setup_irq(CONFIG_SH_TIMER_IRQ, &tmu0_irq);
-
-	tmu0_clk.parent = clk_get(NULL, "module_clk");
-	tmu1_clk.parent = clk_get(NULL, "module_clk");
-
-	tmu_timer_stop();
-
-#if !defined(CONFIG_CPU_SUBTYPE_SH7720) && \
-    !defined(CONFIG_CPU_SUBTYPE_SH7721) && \
-    !defined(CONFIG_CPU_SUBTYPE_SH7760) && \
-    !defined(CONFIG_CPU_SUBTYPE_SH7785) && \
-    !defined(CONFIG_CPU_SUBTYPE_SH7786) && \
-    !defined(CONFIG_CPU_SUBTYPE_SHX3)
-	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
-#endif
-
-	clk_register(&tmu0_clk);
-	clk_register(&tmu1_clk);
-	clk_enable(&tmu0_clk);
-	clk_enable(&tmu1_clk);
-
-	frequency = clk_get_rate(&tmu0_clk);
-	interval = (frequency + HZ / 2) / HZ;
-
-	tmu_timer_set_interval(TMU0,interval, 1);
-	tmu_timer_set_interval(TMU1,~0,1);
-
-	_tmu_start(TMU1);
-
-	clocksource_sh.rating = 200;
-	clocksource_sh.mask = CLOCKSOURCE_MASK(32);
-	clocksource_sh.read = tmu_timer_read;
-	clocksource_sh.shift = 10;
-	clocksource_sh.mult = clocksource_hz2mult(clk_get_rate(&tmu1_clk),
-						  clocksource_sh.shift);
-	clocksource_sh.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-	clocksource_register(&clocksource_sh);
-
-	tmu0_clockevent.mult = div_sc(frequency, NSEC_PER_SEC,
-				      tmu0_clockevent.shift);
-	tmu0_clockevent.max_delta_ns -			clockevent_delta2ns(-1, &tmu0_clockevent);
-	tmu0_clockevent.min_delta_ns -			clockevent_delta2ns(1, &tmu0_clockevent);
-
-	tmu0_clockevent.cpumask = cpumask_of(0);
-	tmu0_clockevent.rating = 100;
-
-	clockevents_register_device(&tmu0_clockevent);
-
-	return 0;
-}
-
-static struct sys_timer_ops tmu_timer_ops = {
-	.init		= tmu_timer_init,
-	.start		= tmu_timer_start,
-	.stop		= tmu_timer_stop,
-};
-
-struct sys_timer tmu_timer = {
-	.name	= "tmu",
-	.ops	= &tmu_timer_ops,
-};
--- 0001/arch/sh/kernel/timers/timer.c
+++ work/arch/sh/kernel/timers/timer.c	2009-05-12 17:51:40.000000000 +0900
@@ -14,9 +14,6 @@
 #include <asm/timer.h>
 
 static struct sys_timer *sys_timers[] = {
-#ifdef CONFIG_SH_TMU
-	&tmu_timer,
-#endif
 	NULL,
 };
 
