From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 26 Dec 2013 15:31:49 +0000
Subject: [PATCH V2] media: soc_camera: rcar_vin: Add preliminary R-Car M2 support
Message-Id: <1388071909-12207-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Hans Verkuil <hans.verkuil@cisco.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This adds R-Car M2 (R8A7791) VIN support. Both H2 and M2
variants look the same from the driver's point of view,
so use GEN2 id for both.

Changes in V2:
* Used the same (RCAR_GEN2) id for both H2 and M2 variants
  since they are no different from the driver's point of view.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 6866bb4..3b1c05a 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -106,7 +106,7 @@
 #define VIN_MAX_HEIGHT		2048
 
 enum chip_id {
-	RCAR_H2,
+	RCAR_GEN2,
 	RCAR_H1,
 	RCAR_M1,
 	RCAR_E1,
@@ -302,7 +302,7 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		dmr = 0;
 		break;
 	case V4L2_PIX_FMT_RGB32:
-		if (priv->chip = RCAR_H2 || priv->chip = RCAR_H1 ||
+		if (priv->chip = RCAR_GEN2 || priv->chip = RCAR_H1 ||
 		    priv->chip = RCAR_E1) {
 			dmr = VNDMR_EXRGB;
 			break;
@@ -1384,7 +1384,8 @@ static struct soc_camera_host_ops rcar_vin_host_ops = {
 };
 
 static struct platform_device_id rcar_vin_id_table[] = {
-	{ "r8a7790-vin",  RCAR_H2 },
+	{ "r8a7791-vin",  RCAR_GEN2 },
+	{ "r8a7790-vin",  RCAR_GEN2 },
 	{ "r8a7779-vin",  RCAR_H1 },
 	{ "r8a7778-vin",  RCAR_M1 },
 	{ "uPD35004-vin", RCAR_E1 },
-- 
1.8.3.1

