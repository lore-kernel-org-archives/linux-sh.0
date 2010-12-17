From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Dec 2010 07:25:09 +0000
Subject: [PATCH] clocksource: sh_cmt: Remove nested spinlock fix
Message-Id: <20101217072509.32699.95165.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>

There are control flow that sh_cmt_set_next() does double
spin-lock. The callers sh_cmt_{start,stop}() already have
lock. But another callers sh_cmt_clock_event_{start,next}()
does not.
    
Now sh_cmt_set_next() does not lock by itself. All the
callers should hold spin-lock before calling it.

[damm@opensource.se: use __sh_cmt_set_next() to simplify code]
[damm@opensource.se: added stable, suitable for v2.6.35 + v2.6.36]
Cc: stable@kernel.org
Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- 0001/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2010-12-17 15:42:31.000000000 +0900
@@ -283,16 +283,21 @@ static void sh_cmt_clock_event_program_v
 	} while (delay);
 }
 
-static void sh_cmt_set_next(struct sh_cmt_priv *p, unsigned long delta)
+static void __sh_cmt_set_next(struct sh_cmt_priv *p, unsigned long delta)
 {
-	unsigned long flags;
-
 	if (delta > p->max_match_value)
 		dev_warn(&p->pdev->dev, "delta out of range\n");
 
-	spin_lock_irqsave(&p->lock, flags);
 	p->next_match_value = delta;
 	sh_cmt_clock_event_program_verify(p, 0);
+}
+
+static void sh_cmt_set_next(struct sh_cmt_priv *p, unsigned long delta)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->lock, flags);
+	__sh_cmt_set_next(p, delta);
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
@@ -359,7 +364,7 @@ static int sh_cmt_start(struct sh_cmt_pr
 
 	/* setup timeout if no clockevent */
 	if ((flag = FLAG_CLOCKSOURCE) && (!(p->flags & FLAG_CLOCKEVENT)))
-		sh_cmt_set_next(p, p->max_match_value);
+		__sh_cmt_set_next(p, p->max_match_value);
  out:
 	spin_unlock_irqrestore(&p->lock, flags);
 
@@ -381,7 +386,7 @@ static void sh_cmt_stop(struct sh_cmt_pr
 
 	/* adjust the timeout to maximum if only clocksource left */
 	if ((flag = FLAG_CLOCKEVENT) && (p->flags & FLAG_CLOCKSOURCE))
-		sh_cmt_set_next(p, p->max_match_value);
+		__sh_cmt_set_next(p, p->max_match_value);
 
 	spin_unlock_irqrestore(&p->lock, flags);
 }
