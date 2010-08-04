From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Aug 2010 04:31:38 +0000
Subject: [PATCH] clocksource: sh_cmt: One-off clockevent fix V2
Message-Id: <20100804043138.28089.32443.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100802092930.30883.59203.sendpatchset@t400s>
In-Reply-To: <20100802092930.30883.59203.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix a one-off error in the CMT driver V2. The match register
should be programmed with the period minus one.

Many thanks to Eiraku-san for tracking down this issue.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - the clocksource counter need to be adjusted as well

 drivers/clocksource/sh_cmt.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- 0006/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2010-08-04 13:21:21.000000000 +0900
@@ -308,7 +308,7 @@ static irqreturn_t sh_cmt_interrupt(int 
 	 * isr before we end up here.
 	 */
 	if (p->flags & FLAG_CLOCKSOURCE)
-		p->total_cycles += p->match_value;
+		p->total_cycles += p->match_value + 1;
 
 	if (!(p->flags & FLAG_REPROGRAM))
 		p->next_match_value = p->max_match_value;
@@ -403,7 +403,7 @@ static cycle_t sh_cmt_clocksource_read(s
 	raw = sh_cmt_get_counter(p, &has_wrapped);
 
 	if (unlikely(has_wrapped))
-		raw += p->match_value;
+		raw += p->match_value + 1;
 	spin_unlock_irqrestore(&p->lock, flags);
 
 	return value + raw;
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
