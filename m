From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Dec 2015 01:18:13 +0000
Subject: [PATCH 4/8 v5] thermal: rcar: rcar_thermal_get_temp() return error if strange temp
Message-Id: <877fkgqzpt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4 -> v5

 - rcar_thermal_update_temp() has no change
 - "retern" -> "return" on Subject

 drivers/thermal/rcar_thermal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e9e4e39..30602f2 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -203,6 +203,7 @@ err_out_unlock:
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
+	int tmp;
 	int ret;
 
 	ret = rcar_thermal_update_temp(priv);
@@ -210,9 +211,18 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 		return ret;
 
 	mutex_lock(&priv->lock);
-	*temp =  MCELSIUS((priv->ctemp * 5) - 65);
+	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
 	mutex_unlock(&priv->lock);
 
+	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
+		struct device *dev = rcar_priv_to_dev(priv);
+
+		dev_err(dev, "it couldn't measure temperature correctly\n");
+		return -EIO;
+	}
+
+	*temp = tmp;
+
 	return 0;
 }
 
-- 
1.9.1

