From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 18 Jul 2008 10:40:22 +0000
Subject: interval of TMU
Message-Id: <20080718.194022.68560338.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

It seems that TCOR register is set by current value of TCNT register, when tmu_set_mode() is called after the clock starts in tmu_timer_init(). Is this right?

I think that CLOCK_EVT_MODE_PERIODIC is to initialize the timer, not to change interval.

--- ./arch/sh/kernel/timers/timer-tmu.c.org	2008-04-17 11:49:44.000000000 +0900
+++ ./arch/sh/kernel/timers/timer-tmu.c	2008-07-18 18:51:22.000000000 +0900
@@ -68,17 +68,17 @@ static int tmu_set_next_event(unsigned l
 	return 0;
 }
 
 static void tmu_set_mode(enum clock_event_mode mode,
 			 struct clock_event_device *evt)
 {
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		ctrl_outl(ctrl_inl(TMU0_TCNT), TMU0_TCOR);
+		ctrl_outl(ctrl_inl(TMU0_TCOR), TMU0_TCNT);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		ctrl_outl(0, TMU0_TCOR);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
