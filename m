From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:56 +0000
Subject: [PATCH v2 26/40] clocksource: sh_tmu: Constify name argument to sh_tmu_register()
Message-Id: <1393603090-23144-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The name argument is assigned to const structure fields only, constify
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4779c97..2c64e3f 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -292,7 +292,7 @@ static void sh_tmu_clocksource_resume(struct clocksource *cs)
 }
 
 static int sh_tmu_register_clocksource(struct sh_tmu_channel *ch,
-				       char *name, unsigned long rating)
+				       const char *name, unsigned long rating)
 {
 	struct clocksource *cs = &ch->cs;
 
@@ -393,7 +393,7 @@ static void sh_tmu_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
-				       char *name, unsigned long rating)
+				       const char *name, unsigned long rating)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
@@ -424,7 +424,7 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 	}
 }
 
-static int sh_tmu_register(struct sh_tmu_channel *ch, char *name,
+static int sh_tmu_register(struct sh_tmu_channel *ch, const char *name,
 		    unsigned long clockevent_rating,
 		    unsigned long clocksource_rating)
 {
@@ -453,7 +453,7 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch,
 	ch->cs_enabled = false;
 	ch->enable_count = 0;
 
-	return sh_tmu_register(ch, (char *)dev_name(&tmu->pdev->dev),
+	return sh_tmu_register(ch, dev_name(&tmu->pdev->dev),
 			       cfg->clockevent_rating,
 			       cfg->clocksource_rating);
 }
-- 
1.8.3.2

