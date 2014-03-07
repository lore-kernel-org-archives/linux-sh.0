From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 13:01:37 +0000
Subject: [PATCH 3/5] media: soc_camera: rcar_vin: Add support for 10-bit YUV cameras
Message-Id: <1394197299-17528-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Phil Edworthy <phil.edworthy@renesas.com>

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 3b1c05a..702dc47 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -68,6 +68,8 @@
 #define VNMC_YCAL		(1 << 19)
 #define VNMC_INF_YUV8_BT656	(0 << 16)
 #define VNMC_INF_YUV8_BT601	(1 << 16)
+#define VNMC_INF_YUV10_BT656	(2 << 16)
+#define VNMC_INF_YUV10_BT601	(3 << 16)
 #define VNMC_INF_YUV16		(5 << 16)
 #define VNMC_VUP		(1 << 10)
 #define VNMC_IM_ODD		(0 << 3)
@@ -275,6 +277,12 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		/* BT.656 8bit YCbCr422 or BT.601 8bit YCbCr422 */
 		vnmc |= priv->pdata->flags & RCAR_VIN_BT656 ?
 			VNMC_INF_YUV8_BT656 : VNMC_INF_YUV8_BT601;
+		break;
+	case V4L2_MBUS_FMT_YUYV10_2X10:
+		/* BT.656 10bit YCbCr422 or BT.601 10bit YCbCr422 */
+		vnmc |= priv->pdata->flags & RCAR_VIN_BT656 ?
+			VNMC_INF_YUV10_BT656 : VNMC_INF_YUV10_BT601;
+		break;
 	default:
 		break;
 	}
@@ -1003,6 +1011,7 @@ static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned int idx,
 	switch (code) {
 	case V4L2_MBUS_FMT_YUYV8_1X16:
 	case V4L2_MBUS_FMT_YUYV8_2X8:
+	case V4L2_MBUS_FMT_YUYV10_2X10:
 		if (cam->extra_fmt)
 			break;
 
-- 
1.9.0

