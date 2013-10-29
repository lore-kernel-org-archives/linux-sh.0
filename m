From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 14:31:37 +0000
Subject: [PATCH v2 2/2] clocksource: sh_tmu: Add clk_prepare/unprepare support
Message-Id: <1383057097-22689-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Prepare the clock at probe time, as there is no other appropriate place
in the driver where we're allowed to sleep.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 1597837..63557cd 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -472,6 +472,11 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
+
+	ret = clk_prepare(p->clk);
+	if (ret < 0)
+		goto err2;
+
 	p->cs_enabled = false;
 	p->enable_count = 0;
 
@@ -479,10 +484,12 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
 			      cfg->clockevent_rating,
 			      cfg->clocksource_rating);
 	if (ret < 0)
-		goto err2;
+		goto err3;
 
 	return 0;
 
+ err3:
+	clk_unprepare(p->clk);
  err2:
 	clk_put(p->clk);
  err1:
-- 
1.8.1.5

