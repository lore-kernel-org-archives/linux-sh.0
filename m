From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jan 2009 09:55:40 +0000
Subject: [PATCH 02/05] sh: tmu disable support
Message-Id: <20090122095540.31653.65134.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add TMU disable support so we can use other clockevents.
Also, setup the clockevent rating.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/timers/timer-tmu.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- 0015/arch/sh/kernel/timers/timer-tmu.c
+++ work/arch/sh/kernel/timers/timer-tmu.c	2009-01-22 17:58:50.000000000 +0900
@@ -146,7 +146,14 @@ static irqreturn_t tmu_timer_interrupt(i
 	_tmu_clear_status(TMU0);
 	_tmu_set_irq(TMU0,tmu0_clockevent.mode != CLOCK_EVT_MODE_ONESHOT);
 
-	evt->event_handler(evt);
+	switch (tmu0_clockevent.mode) {
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_PERIODIC:
+		evt->event_handler(evt);
+		break;
+	default:
+		break;
+	}
 
 	return IRQ_HANDLED;
 }
@@ -271,6 +278,7 @@ static int tmu_timer_init(void)
 			clockevent_delta2ns(1, &tmu0_clockevent);
 
 	tmu0_clockevent.cpumask = cpumask_of(0);
+	tmu0_clockevent.rating = 100;
 
 	clockevents_register_device(&tmu0_clockevent);
 
