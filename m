From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Dec 2015 08:29:04 +0000
Subject: [PATCH 1/8 v2] thermal: rcar: move rcar_thermal_dt_ids to upside
Message-Id: <87fuzifwhb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9jyfwj7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9jyfwj7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch is prepare for of-thermal support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 drivers/thermal/rcar_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 13d01ed..96707a6 100644
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
@@ -484,12 +490,6 @@ error_unregister:
 	return ret;
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

