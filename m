From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 11 Apr 2014 15:04:16 +0000
Subject: [PATCH v3 33/52] clocksource: sh_tmu: Rename clock to "fck" in the non-legacy case
Message-Id: <1397228675-11684-34-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_tmu driver gets the TMU functional clock using a connection ID of
"tmu_fck". While all SH SoCs create clock lookup entries with a NULL
device ID and a "tmu_fck" connection ID, the ARM SoCs use the device ID
only with a NULL connection ID. This works on legacy platforms but will
break on ARM with DT boot.

Fix the situation by using a connection ID of "fck" in the non-legacy
platform data case. Clock lookup entries will be renamed to use the
device ID as well as the connection ID as platforms get moved to new
platform data. The legacy code will eventually be dropped, leaving us
with device ID based clock lookup, compatible with DT boot.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_tmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 0306d31..cf07797 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -568,7 +568,8 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	tmu->model = id->driver_data;
 
 	/* Get hold of clock. */
-	tmu->clk = clk_get(&tmu->pdev->dev, "tmu_fck");
+	tmu->clk = clk_get(&tmu->pdev->dev,
+			   tmu->model = SH_TMU_LEGACY ? "tmu_fck" : "fck");
 	if (IS_ERR(tmu->clk)) {
 		dev_err(&tmu->pdev->dev, "cannot get clock\n");
 		return PTR_ERR(tmu->clk);
-- 
1.8.3.2

