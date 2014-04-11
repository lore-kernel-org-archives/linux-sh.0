From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 11 Apr 2014 15:04:11 +0000
Subject: [PATCH v3 28/52] clocksource: sh_tmu: Replace kmalloc + memset with kzalloc
Message-Id: <1397228675-11684-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

One kzalloc a day keeps the bugs away.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index e304304..26a9f7d 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -397,8 +397,6 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
 
-	memset(ced, 0, sizeof(*ced));
-
 	ced->name = name;
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
@@ -441,7 +439,6 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch,
 {
 	struct sh_timer_config *cfg = tmu->pdev->dev.platform_data;
 
-	memset(ch, 0, sizeof(*ch));
 	ch->tmu = tmu;
 
 	/*
@@ -475,7 +472,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	int ret;
 	ret = -ENXIO;
 
-	memset(tmu, 0, sizeof(*tmu));
 	tmu->pdev = pdev;
 
 	if (!cfg) {
@@ -547,7 +543,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	tmu = kmalloc(sizeof(*tmu), GFP_KERNEL);
+	tmu = kzalloc(sizeof(*tmu), GFP_KERNEL);
 	if (tmu = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
-- 
1.8.3.2

