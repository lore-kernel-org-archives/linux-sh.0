From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:17 +0000
Subject: [PATCH 10/22] clocksource: sh_mtu2: Allocate channels dynamically
Message-Id: <1393955249-18736-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This prepares the driver for multi-channel support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 94a5342..45e1e85 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -52,7 +52,8 @@ struct sh_mtu2_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 
-	struct sh_mtu2_channel channel;
+	struct sh_mtu2_channel *channels;
+	unsigned int num_channels;
 };
 
 static DEFINE_RAW_SPINLOCK(sh_mtu2_lock);
@@ -296,6 +297,7 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 {
 	struct sh_timer_config *cfg = pdev->dev.platform_data;
 	struct resource *res;
+	void __iomem *base;
 	int ret;
 	ret = -ENXIO;
 
@@ -315,16 +317,16 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/*
-	 * Map memory, let channel.base point to our channel and mapbase to the
+	 * Map memory, let base point to our channel and mapbase to the
 	 * start/stop shared register.
 	 */
-	mtu->channel.base = ioremap_nocache(res->start, resource_size(res));
-	if (mtu->channel.base = NULL) {
+	base = ioremap_nocache(res->start, resource_size(res));
+	if (base = NULL) {
 		dev_err(&mtu->pdev->dev, "failed to remap I/O memory\n");
 		goto err0;
 	}
 
-	mtu->mapbase = mtu->channel.base + cfg->channel_offset;
+	mtu->mapbase = base + cfg->channel_offset;
 
 	/* get hold of clock */
 	mtu->clk = clk_get(&mtu->pdev->dev, "mtu2_fck");
@@ -338,17 +340,28 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	if (ret < 0)
 		goto err2;
 
-	ret = sh_mtu2_setup_channel(&mtu->channel, mtu);
+	mtu->channels = kzalloc(sizeof(*mtu->channels), GFP_KERNEL);
+	if (mtu->channels = NULL) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	mtu->num_channels = 1;
+
+	mtu->channels[0].base = base;
+
+	ret = sh_mtu2_setup_channel(&mtu->channels[0], mtu);
 	if (ret < 0)
 		goto err3;
 
 	return 0;
  err3:
+	kfree(mtu->channels);
 	clk_unprepare(mtu->clk);
  err2:
 	clk_put(mtu->clk);
  err1:
-	iounmap(mtu->channel.base);
+	iounmap(base);
  err0:
 	return ret;
 }
-- 
1.8.3.2

