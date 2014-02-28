From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:59 +0000
Subject: [PATCH v2 29/40] clocksource: sh_tmu: Replace kmalloc + memset with kzalloc
Message-Id: <1393603090-23144-30-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
index 10d68b4..05abfbe 100644
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
@@ -474,7 +471,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	int ret;
 	ret = -ENXIO;
 
-	memset(tmu, 0, sizeof(*tmu));
 	tmu->pdev = pdev;
 
 	if (!cfg) {
@@ -546,7 +542,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	tmu = kmalloc(sizeof(*tmu), GFP_KERNEL);
+	tmu = kzalloc(sizeof(*tmu), GFP_KERNEL);
 	if (tmu = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
-- 
1.8.3.2

