From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:36 +0000
Subject: [PATCH v2 06/40] clocksource: sh_cmt: Constify name argument to sh_cmt_register()
Message-Id: <1393603090-23144-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The name argument is assigned to const structure fields only, constify
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 26f73cf..febd6bf 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -549,7 +549,7 @@ static void sh_cmt_clocksource_resume(struct clocksource *cs)
 }
 
 static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
-				       char *name, unsigned long rating)
+				       const char *name, unsigned long rating)
 {
 	struct clocksource *cs = &ch->cs;
 
@@ -660,7 +660,7 @@ static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
-				       char *name, unsigned long rating)
+				       const char *name, unsigned long rating)
 {
 	struct clock_event_device *ced = &ch->ced;
 
@@ -680,7 +680,7 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	clockevents_register_device(ced);
 }
 
-static int sh_cmt_register(struct sh_cmt_channel *ch, char *name,
+static int sh_cmt_register(struct sh_cmt_channel *ch, const char *name,
 			   unsigned long clockevent_rating,
 			   unsigned long clocksource_rating)
 {
@@ -717,7 +717,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch,
 	ch->match_value = ch->max_match_value;
 	raw_spin_lock_init(&ch->lock);
 
-	ret = sh_cmt_register(ch, (char *)dev_name(&cmt->pdev->dev),
+	ret = sh_cmt_register(ch, dev_name(&cmt->pdev->dev),
 			      cfg->clockevent_rating,
 			      cfg->clocksource_rating);
 	if (ret) {
-- 
1.8.3.2

