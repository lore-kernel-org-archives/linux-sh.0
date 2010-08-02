From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 Aug 2010 09:29:30 +0000
Subject: [PATCH] clocksource: sh_cmt: One-off clockevent fix
Message-Id: <20100802092930.30883.59203.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix a one-off error in the clockevent part of the CMT
driver. The match register should be programmed with
the period minus one.

Many thanks to Eiraku-san for tracking down this issue.

Reported-by: Hideki EIRAKU <hdk@igel.co.jp>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0006/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2010-08-02 17:43:08.000000000 +0900
@@ -478,7 +478,7 @@ static void sh_cmt_clock_event_start(str
 	ced->min_delta_ns = clockevent_delta2ns(0x1f, ced);
 
 	if (periodic)
-		sh_cmt_set_next(p, (p->rate + HZ/2) / HZ);
+		sh_cmt_set_next(p, ((p->rate + HZ/2) / HZ) - 1);
 	else
 		sh_cmt_set_next(p, p->max_match_value);
 }
@@ -523,9 +523,9 @@ static int sh_cmt_clock_event_next(unsig
 
 	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
 	if (likely(p->flags & FLAG_IRQCONTEXT))
-		p->next_match_value = delta;
+		p->next_match_value = delta - 1;
 	else
-		sh_cmt_set_next(p, delta);
+		sh_cmt_set_next(p, delta - 1);
 
 	return 0;
 }
