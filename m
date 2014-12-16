From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Dec 2014 09:48:54 +0000
Subject: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <20141216094854.22639.69181.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Update the TMU driver to use cpu_possible_mask as cpumask to make
r8a7779 SMP work as expected with or without the ARM TWD timer.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clocksource/sh_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/clocksource/sh_tmu.c
+++ work/drivers/clocksource/sh_tmu.c	2014-12-16 17:49:49.000000000 +0900
@@ -428,7 +428,7 @@ static void sh_tmu_register_clockevent(s
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
 	ced->rating = 200;
-	ced->cpumask = cpumask_of(0);
+	ced->cpumask = cpu_possible_mask;
 	ced->set_next_event = sh_tmu_clock_event_next;
 	ced->set_mode = sh_tmu_clock_event_mode;
 	ced->suspend = sh_tmu_clock_event_suspend;
