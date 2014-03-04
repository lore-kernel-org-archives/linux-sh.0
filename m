From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:13 +0000
Subject: [PATCH 06/22] clocksource: sh_mtu2: Constify name argument to sh_mtu2_register()
Message-Id: <1393955249-18736-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The name argument is assigned to const structure fields only, constify
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 8fd7059..2fe3ab4c 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -236,7 +236,7 @@ static void sh_mtu2_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
-				       char *name, unsigned long rating)
+					const char *name, unsigned long rating)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
@@ -264,7 +264,7 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 	}
 }
 
-static int sh_mtu2_register(struct sh_mtu2_channel *ch, char *name,
+static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name,
 			    unsigned long clockevent_rating)
 {
 	if (clockevent_rating)
@@ -287,7 +287,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
 		return ch->irq;
 	}
 
-	return sh_mtu2_register(ch, (char *)dev_name(&mtu->pdev->dev),
+	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev),
 				cfg->clockevent_rating);
 }
 
-- 
1.8.3.2

