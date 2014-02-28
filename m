From: Patrick Titiano <ptitiano@baylibre.com>
Date: Fri, 28 Feb 2014 13:10:03 +0000
Subject: [PATCH 1/2] thermal: rcar-thermal: fix same mask applied twice
Message-Id: <1393593004-16285-2-git-send-email-ptitiano@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
In-Reply-To: <1393593004-16285-1-git-send-email-ptitiano@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Patrick Titiano <ptitiano@baylibre.com>

Mask is already applied preceding the if statement.
Remove the second mask.

Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e2bb589..6ea8c5c 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -316,7 +316,7 @@ static u32 rcar_thermal_had_changed(struct rcar_thermal_priv *priv, u32 status)
 
 	status = (status >> rcar_id_to_shift(priv)) & 0x3;
 
-	if (status & 0x3) {
+	if (status) {
 		dev_dbg(dev, "thermal%d %s%s\n",
 			priv->id,
 			(status & 0x2) ? "Rising " : "",
-- 
1.8.3.2

