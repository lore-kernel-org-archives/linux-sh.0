From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Mon, 23 Dec 2013 20:28:06 +0000
Subject: [PATCH] media: soc_camera: rcar_vin: Add preliminary R-Car M2 support
Message-Id: <1387830486-10650-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Hans Verkuil <hans.verkuil@cisco.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This adds R-Car M2 (R8A7791) VIN support.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 6866bb4..8b79727 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -106,6 +106,7 @@
 #define VIN_MAX_HEIGHT		2048
 
 enum chip_id {
+	RCAR_M2,
 	RCAR_H2,
 	RCAR_H1,
 	RCAR_M1,
@@ -302,8 +303,8 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		dmr = 0;
 		break;
 	case V4L2_PIX_FMT_RGB32:
-		if (priv->chip = RCAR_H2 || priv->chip = RCAR_H1 ||
-		    priv->chip = RCAR_E1) {
+		if (priv->chip = RCAR_M2 || priv->chip = RCAR_H2 ||
+		    priv->chip = RCAR_H1 || priv->chip = RCAR_E1) {
 			dmr = VNDMR_EXRGB;
 			break;
 		}
@@ -1384,6 +1385,7 @@ static struct soc_camera_host_ops rcar_vin_host_ops = {
 };
 
 static struct platform_device_id rcar_vin_id_table[] = {
+	{ "r8a7791-vin",  RCAR_M2 },
 	{ "r8a7790-vin",  RCAR_H2 },
 	{ "r8a7779-vin",  RCAR_H1 },
 	{ "r8a7778-vin",  RCAR_M1 },
-- 
1.8.3.1

