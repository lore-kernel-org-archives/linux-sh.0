From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:58:00 +0000
Subject: [PATCH v2 30/40] clocksource: sh_tmu: Allocate channels dynamically
Message-Id: <1393603090-23144-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This prepares the driver for multi-channel support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 05abfbe..baa3383 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -58,7 +58,8 @@ struct sh_tmu_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
-	struct sh_tmu_channel channel;
+	struct sh_tmu_channel *channels;
+	unsigned int num_channels;
 };
 
 static DEFINE_RAW_SPINLOCK(sh_tmu_lock);
@@ -468,6 +469,7 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 {
 	struct sh_timer_config *cfg = pdev->dev.platform_data;
 	struct resource *res;
+	void __iomem *base;
 	int ret;
 	ret = -ENXIO;
 
@@ -487,16 +489,16 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	}
 
 	/*
-	 * Map memory, let channel.base point to our channel and mapbase to the
+	 * Map memory, let base point to our channel and mapbase to the
 	 * start/stop shared register.
 	 */
-	tmu->channel.base = ioremap_nocache(res->start, resource_size(res));
-	if (tmu->channel.base = NULL) {
+	base = ioremap_nocache(res->start, resource_size(res));
+	if (base = NULL) {
 		dev_err(&tmu->pdev->dev, "failed to remap I/O memory\n");
 		goto err0;
 	}
 
-	tmu->mapbase = tmu->channel.base - cfg->channel_offset;
+	tmu->mapbase = base - cfg->channel_offset;
 
 	/* get hold of clock */
 	tmu->clk = clk_get(&tmu->pdev->dev, "tmu_fck");
@@ -510,18 +512,29 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	if (ret < 0)
 		goto err2;
 
-	ret = sh_tmu_channel_setup(&tmu->channel, tmu);
+	tmu->channels = kzalloc(sizeof(*tmu->channels), GFP_KERNEL);
+	if (tmu->channels = NULL) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	tmu->num_channels = 1;
+
+	tmu->channels[0].base = base;
+
+	ret = sh_tmu_channel_setup(&tmu->channels[0], tmu);
 	if (ret < 0)
 		goto err3;
 
 	return 0;
 
  err3:
+	kfree(tmu->channels);
 	clk_unprepare(tmu->clk);
  err2:
 	clk_put(tmu->clk);
  err1:
-	iounmap(tmu->mapbase);
+	iounmap(base);
  err0:
 	return ret;
 }
-- 
1.8.3.2

