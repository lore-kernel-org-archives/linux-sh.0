From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Dec 2015 01:17:56 +0000
Subject: [PATCH 3/8 v5] thermal: rcar: check irq possibility in rcar_thermal_irq_xxx()
Message-Id: <878u4wqzq9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rcar thermal driver sometimes checks irq possibility when it
calls rcar_thermal_irq_enable/disable(), but sometimes not.
This patch checks it inside rcar_thermal_irq_enable/disable().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v4 -> v5

 - no change

 drivers/thermal/rcar_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 0b19743..e9e4e39 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -290,6 +290,9 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
 	unsigned long flags;
 	u32 mask = 0x3 << rcar_id_to_shift(priv); /* enable Rising/Falling */
 
+	if (!rcar_has_irq_support(priv))
+		return;
+
 	spin_lock_irqsave(&common->lock, flags);
 
 	rcar_thermal_common_bset(common, INTMSK, mask, enable ? 0 : mask);
@@ -441,8 +444,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		if (rcar_has_irq_support(priv))
-			rcar_thermal_irq_enable(priv);
+		rcar_thermal_irq_enable(priv);
 
 		list_move_tail(&priv->list, &common->head);
 
@@ -488,8 +490,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 
 	rcar_thermal_for_each_priv(priv, common) {
-		if (rcar_has_irq_support(priv))
-			rcar_thermal_irq_disable(priv);
+		rcar_thermal_irq_disable(priv);
 		thermal_zone_device_unregister(priv->zone);
 	}
 
-- 
1.9.1

