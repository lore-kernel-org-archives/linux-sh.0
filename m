From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 05:27:10 +0000
Subject: [PATCH 1/8 v4] thermal: rcar: move rcar_thermal_dt_ids to upside
Message-Id: <87twnt5x80.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch is prepare for of-thermal support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - no change

 drivers/thermal/rcar_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5d4ae7d..ac8d1eb 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -81,6 +81,12 @@ struct rcar_thermal_priv {
 # define rcar_force_update_temp(priv)	0
 #endif
 
+static const struct of_device_id rcar_thermal_dt_ids[] = {
+	{ .compatible = "renesas,rcar-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
+
 /*
  *		basic functions
  */
@@ -491,12 +497,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id rcar_thermal_dt_ids[] = {
-	{ .compatible = "renesas,rcar-thermal", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
-
 static struct platform_driver rcar_thermal_driver = {
 	.driver	= {
 		.name	= "rcar_thermal",
-- 
1.9.1

