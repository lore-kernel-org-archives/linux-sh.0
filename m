From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:45 +0000
Subject: [PATCH v2 15/40] clocksource: sh_cmt: Hardcode CMT clock event rating to 125
Message-Id: <1393603090-23144-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All boards use or should use a clock event rating of 125 for the CMT,
hardcode it in the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 926abe2..75b1f83 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -768,14 +768,14 @@ static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
-				       const char *name, unsigned long rating)
+				       const char *name)
 {
 	struct clock_event_device *ced = &ch->ced;
 
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
-	ced->rating = rating;
+	ced->rating = 125;
 	ced->cpumask = cpu_possible_mask;
 	ced->set_next_event = sh_cmt_clock_event_next;
 	ced->set_mode = sh_cmt_clock_event_mode;
@@ -788,11 +788,10 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 }
 
 static int sh_cmt_register(struct sh_cmt_channel *ch, const char *name,
-			   unsigned long clockevent_rating,
-			   unsigned long clocksource_rating)
+			   bool clockevent, unsigned long clocksource_rating)
 {
-	if (clockevent_rating)
-		sh_cmt_register_clockevent(ch, name, clockevent_rating);
+	if (clockevent)
+		sh_cmt_register_clockevent(ch, name);
 
 	if (clocksource_rating)
 		sh_cmt_register_clocksource(ch, name, clocksource_rating);
@@ -827,7 +826,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 	raw_spin_lock_init(&ch->lock);
 
 	ret = sh_cmt_register(ch, dev_name(&cmt->pdev->dev),
-			      cfg->clockevent_rating,
+			      cfg->clockevent_rating != 0,
 			      cfg->clocksource_rating);
 	if (ret) {
 		dev_err(&cmt->pdev->dev, "ch%u: registration failed\n",
-- 
1.8.3.2

