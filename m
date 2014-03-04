From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:12 +0000
Subject: [PATCH 05/22] clocksource: sh_mtu2: Split channel setup to separate function
Message-Id: <1393955249-18736-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the channel setup code from sh_mtu2_setup to a new
sh_mtu2_setup_channel function and call it from sh_mtu2_setup.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 256621c..8fd7059 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -273,6 +273,24 @@ static int sh_mtu2_register(struct sh_mtu2_channel *ch, char *name,
 	return 0;
 }
 
+static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch,
+				 struct sh_mtu2_device *mtu)
+{
+	struct sh_timer_config *cfg = mtu->pdev->dev.platform_data;
+
+	memset(ch, 0, sizeof(*ch));
+	ch->mtu = mtu;
+
+	ch->irq = platform_get_irq(mtu->pdev, 0);
+	if (ch->irq < 0) {
+		dev_err(&mtu->pdev->dev, "failed to get irq\n");
+		return ch->irq;
+	}
+
+	return sh_mtu2_register(ch, (char *)dev_name(&mtu->pdev->dev),
+				cfg->clockevent_rating);
+}
+
 static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 			 struct platform_device *pdev)
 {
@@ -297,12 +315,6 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 		goto err0;
 	}
 
-	mtu->channel.irq = platform_get_irq(mtu->pdev, 0);
-	if (mtu->channel.irq < 0) {
-		dev_err(&mtu->pdev->dev, "failed to get irq\n");
-		goto err0;
-	}
-
 	/* map memory, let mapbase point to our channel */
 	mtu->mapbase = ioremap_nocache(res->start, resource_size(res));
 	if (mtu->mapbase = NULL) {
@@ -322,10 +334,7 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	if (ret < 0)
 		goto err2;
 
-	mtu->channel.mtu = mtu;
-
-	ret = sh_mtu2_register(&mtu->channel, (char *)dev_name(&mtu->pdev->dev),
-			       cfg->clockevent_rating);
+	ret = sh_mtu2_setup_channel(&mtu->channel, mtu);
 	if (ret < 0)
 		goto err3;
 
-- 
1.8.3.2

