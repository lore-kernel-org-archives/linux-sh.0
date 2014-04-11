From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 11 Apr 2014 15:04:14 +0000
Subject: [PATCH v3 31/52] clocksource: sh_tmu: Hardcode TMU clock event and source ratings to 200
Message-Id: <1397228675-11684-32-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All boards use clock event and clock source ratings of 200 for the TMU,
hardcode it in the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 63ed92d..fec9bed 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -300,12 +300,12 @@ static void sh_tmu_clocksource_resume(struct clocksource *cs)
 }
 
 static int sh_tmu_register_clocksource(struct sh_tmu_channel *ch,
-				       const char *name, unsigned long rating)
+				       const char *name)
 {
 	struct clocksource *cs = &ch->cs;
 
 	cs->name = name;
-	cs->rating = rating;
+	cs->rating = 200;
 	cs->read = sh_tmu_clocksource_read;
 	cs->enable = sh_tmu_clocksource_enable;
 	cs->disable = sh_tmu_clocksource_disable;
@@ -402,7 +402,7 @@ static void sh_tmu_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
-				       const char *name, unsigned long rating)
+				       const char *name)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
@@ -410,7 +410,7 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
-	ced->rating = rating;
+	ced->rating = 200;
 	ced->cpumask = cpumask_of(0);
 	ced->set_next_event = sh_tmu_clock_event_next;
 	ced->set_mode = sh_tmu_clock_event_mode;
@@ -433,13 +433,12 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 }
 
 static int sh_tmu_register(struct sh_tmu_channel *ch, const char *name,
-		    unsigned long clockevent_rating,
-		    unsigned long clocksource_rating)
+			   bool clockevent, bool clocksource)
 {
-	if (clockevent_rating)
-		sh_tmu_register_clockevent(ch, name, clockevent_rating);
-	else if (clocksource_rating)
-		sh_tmu_register_clocksource(ch, name, clocksource_rating);
+	if (clockevent)
+		sh_tmu_register_clockevent(ch, name);
+	else if (clocksource)
+		sh_tmu_register_clocksource(ch, name);
 
 	return 0;
 }
@@ -471,8 +470,8 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch,
 	ch->enable_count = 0;
 
 	return sh_tmu_register(ch, dev_name(&tmu->pdev->dev),
-			       cfg->clockevent_rating,
-			       cfg->clocksource_rating);
+			       cfg->clockevent_rating != 0,
+			       cfg->clocksource_rating != 0);
 }
 
 static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
-- 
1.8.3.2

