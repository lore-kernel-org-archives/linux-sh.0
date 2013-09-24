From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 24 Sep 2013 13:38:35 +0000
Subject: [PATCH 2/3] media: rcar_vin: Add preliminary r8a7790 H2 support
Message-Id: <1380029916-10331-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index d02a7e0..cf81e02 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -105,6 +105,7 @@
 #define VIN_MAX_HEIGHT		2048
 
 enum chip_id {
+	RCAR_H2,
 	RCAR_H1,
 	RCAR_M1,
 	RCAR_E1,
@@ -300,7 +301,8 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		dmr = 0;
 		break;
 	case V4L2_PIX_FMT_RGB32:
-		if (priv->chip = RCAR_H1 || priv->chip = RCAR_E1) {
+		if (priv->chip = RCAR_H2 || priv->chip = RCAR_H1 ||
+						priv->chip = RCAR_E1) {
 			dmr = VNDMR_EXRGB;
 			break;
 		}
@@ -1381,6 +1383,7 @@ static struct soc_camera_host_ops rcar_vin_host_ops = {
 };
 
 static struct platform_device_id rcar_vin_id_table[] = {
+	{ "r8a7790-vin",  RCAR_H2 },
 	{ "r8a7779-vin",  RCAR_H1 },
 	{ "r8a7778-vin",  RCAR_M1 },
 	{ "uPD35004-vin", RCAR_E1 },
-- 
1.8.3.1

