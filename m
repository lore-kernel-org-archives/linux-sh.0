From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 14 May 2013 23:00:32 +0000
Subject: [PATCH] thermal: rcar: Fix typo in probe information message
Message-Id: <1368572432-3943-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 28f0919..6138949 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -452,7 +452,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, common);
 
-	dev_info(dev, "%d sensor proved\n", i);
+	dev_info(dev, "%d sensor probed\n", i);
 
 	return 0;
 
-- 
Regards,

Laurent Pinchart

