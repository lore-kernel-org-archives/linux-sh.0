From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 11 Jan 2016 19:10:18 +0000
Subject: [PATCH 3/3 v2] media: soc_camera: rcar_vin: Add ARGB8888 caputre format support
Message-Id: <1452539418-28480-4-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452539418-28480-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1452539418-28480-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

This patch adds ARGB8888 capture format support for R-Car Gen3.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

v2 [Yoshihiro Kaneko]
* As suggested by Sergei Shtylyov
  - fix the coding style of the braces.

 drivers/media/platform/soc_camera/rcar_vin.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index f72de0b..9883629 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -124,7 +124,7 @@
 #define VNDMR_EXRGB		(1 << 8)
 #define VNDMR_BPSM		(1 << 4)
 #define VNDMR_DTMD_YCSEP	(1 << 1)
-#define VNDMR_DTMD_ARGB1555	(1 << 0)
+#define VNDMR_DTMD_ARGB		(1 << 0)
 
 /* Video n Data Mode Register 2 bits */
 #define VNDMR2_VPS		(1 << 30)
@@ -643,7 +643,7 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		output_is_yuv = true;
 		break;
 	case V4L2_PIX_FMT_RGB555X:
-		dmr = VNDMR_DTMD_ARGB1555;
+		dmr = VNDMR_DTMD_ARGB;
 		break;
 	case V4L2_PIX_FMT_RGB565:
 		dmr = 0;
@@ -654,6 +654,14 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 			dmr = VNDMR_EXRGB;
 			break;
 		}
+	case V4L2_PIX_FMT_ARGB32:
+		if (priv->chip = RCAR_GEN3) {
+			dmr = VNDMR_EXRGB | VNDMR_DTMD_ARGB;
+		} else {
+			dev_err(icd->parent, "Not support format\n");
+			return -EINVAL;
+		}
+		break;
 	default:
 		dev_warn(icd->parent, "Invalid fourcc format (0x%x)\n",
 			 icd->current_fmt->host_fmt->fourcc);
@@ -1304,6 +1312,14 @@ static const struct soc_mbus_pixelfmt rcar_vin_formats[] = {
 		.order			= SOC_MBUS_ORDER_LE,
 		.layout			= SOC_MBUS_LAYOUT_PACKED,
 	},
+	{
+		.fourcc			= V4L2_PIX_FMT_ARGB32,
+		.name			= "ARGB8888",
+		.bits_per_sample	= 32,
+		.packing		= SOC_MBUS_PACKING_NONE,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
 };
 
 static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned int idx,
@@ -1611,6 +1627,7 @@ static int rcar_vin_set_fmt(struct soc_camera_device *icd,
 	case V4L2_PIX_FMT_RGB32:
 		can_scale = priv->chip != RCAR_E1;
 		break;
+	case V4L2_PIX_FMT_ARGB32:
 	case V4L2_PIX_FMT_UYVY:
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_RGB565:
-- 
1.9.1

