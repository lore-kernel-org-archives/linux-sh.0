From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:57:55 +0000
Subject: [PATCH v2 25/40] clocksource: sh_tmu: Split channel setup to separate function
Message-Id: <1393603090-23144-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the channel setup code from sh_tmu_setup to a new
sh_tmu_setup_channel function and call it from sh_tmu_setup.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 7013790..4779c97 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -436,6 +436,28 @@ static int sh_tmu_register(struct sh_tmu_channel *ch, char *name,
 	return 0;
 }
 
+static int sh_tmu_channel_setup(struct sh_tmu_channel *ch,
+				struct sh_tmu_device *tmu)
+{
+	struct sh_timer_config *cfg = tmu->pdev->dev.platform_data;
+
+	memset(ch, 0, sizeof(*ch));
+	ch->tmu = tmu;
+
+	ch->irq = platform_get_irq(tmu->pdev, 0);
+	if (ch->irq < 0) {
+		dev_err(&tmu->pdev->dev, "failed to get irq\n");
+		return ch->irq;
+	}
+
+	ch->cs_enabled = false;
+	ch->enable_count = 0;
+
+	return sh_tmu_register(ch, (char *)dev_name(&tmu->pdev->dev),
+			       cfg->clockevent_rating,
+			       cfg->clocksource_rating);
+}
+
 static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 {
 	struct sh_timer_config *cfg = pdev->dev.platform_data;
@@ -459,12 +481,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		goto err0;
 	}
 
-	tmu->channel.irq = platform_get_irq(tmu->pdev, 0);
-	if (tmu->channel.irq < 0) {
-		dev_err(&tmu->pdev->dev, "failed to get irq\n");
-		goto err0;
-	}
-
 	/* map memory, let mapbase point to our channel */
 	tmu->mapbase = ioremap_nocache(res->start, resource_size(res));
 	if (tmu->mapbase = NULL) {
@@ -484,13 +500,7 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	if (ret < 0)
 		goto err2;
 
-	tmu->channel.cs_enabled = false;
-	tmu->channel.enable_count = 0;
-	tmu->channel.tmu = tmu;
-
-	ret = sh_tmu_register(&tmu->channel, (char *)dev_name(&tmu->pdev->dev),
-			      cfg->clockevent_rating,
-			      cfg->clocksource_rating);
+	ret = sh_tmu_channel_setup(&tmu->channel, tmu);
 	if (ret < 0)
 		goto err3;
 
-- 
1.8.3.2

