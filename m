From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 14:30:44 +0000
Subject: [PATCH v2 1/2] clocksource: sh_mtu2: Release clock when sh_mtu2_register() fails
Message-Id: <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Fix the probe error path to release the clock resource when the
sh_mtu2_register() call fails.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 4aac9ee..e6cfb32 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -313,8 +313,15 @@ static int sh_mtu2_setup(struct sh_mtu2_priv *p, struct platform_device *pdev)
 		goto err1;
 	}
 
-	return sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
-				cfg->clockevent_rating);
+	ret = sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
+			       cfg->clockevent_rating);
+	if (ret < 0)
+		goto err2;
+
+	return 0;
+
+ err2:
+	clk_put(p->clk);
  err1:
 	iounmap(p->mapbase);
  err0:
-- 
1.8.1.5

