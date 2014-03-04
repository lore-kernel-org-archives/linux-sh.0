From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:20 +0000
Subject: [PATCH 13/22] clocksource: sh_mtu2: Hardcode MTU2 clock event rating to 200
Message-Id: <1393955249-18736-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All boards use clock event ratings of 200 for the MTU2, hardcode it in
the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 702ce60..14cc7b6 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -323,14 +323,14 @@ static void sh_mtu2_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
-					const char *name, unsigned long rating)
+					const char *name)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
 
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
-	ced->rating = rating;
+	ced->rating = 200;
 	ced->cpumask = cpu_possible_mask;
 	ced->set_mode = sh_mtu2_clock_event_mode;
 	ced->suspend = sh_mtu2_clock_event_suspend;
@@ -351,10 +351,10 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 }
 
 static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name,
-			    unsigned long clockevent_rating)
+			    bool clockevent)
 {
-	if (clockevent_rating)
-		sh_mtu2_register_clockevent(ch, name, clockevent_rating);
+	if (clockevent)
+		sh_mtu2_register_clockevent(ch, name);
 
 	return 0;
 }
@@ -375,7 +375,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
 	}
 
 	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev),
-				cfg->clockevent_rating);
+				cfg->clockevent_rating != 0);
 }
 
 static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
-- 
1.8.3.2

