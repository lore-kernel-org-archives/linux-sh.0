From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 31 Oct 2014 15:06:38 +0000
Subject: [PATCH v4] media: soc_camera: rcar_vin: Add BT.709 24-bit RGB888 input support
Message-Id: <1414767998-8508-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against master branch of linuxtv.org/media_tree.git.

v4 [Yoshihiro Kaneko]
* indent with a tab, not with spaces

v3 [Yoshihiro Kaneko]
* fixes the detection of RGB input

v2 [Yoshihiro Kaneko]
* remove unused definition as suggested by Sergei Shtylyov
* use VNMC_INF_RGB888 directly instead of VNMC_INF_RGB_MASK as a bit-field
  mask

 drivers/media/platform/soc_camera/rcar_vin.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 20defcb..7becec0 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -74,6 +74,7 @@
 #define VNMC_INF_YUV10_BT656	(2 << 16)
 #define VNMC_INF_YUV10_BT601	(3 << 16)
 #define VNMC_INF_YUV16		(5 << 16)
+#define VNMC_INF_RGB888		(6 << 16)
 #define VNMC_VUP		(1 << 10)
 #define VNMC_IM_ODD		(0 << 3)
 #define VNMC_IM_ODD_EVEN	(1 << 3)
@@ -272,6 +273,10 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 
 	/* input interface */
 	switch (icd->current_fmt->code) {
+	case V4L2_MBUS_FMT_RGB888_1X24:
+		/* BT.601/BT.709 24-bit RGB-888 */
+		vnmc |= VNMC_INF_RGB888;
+		break;
 	case V4L2_MBUS_FMT_YUYV8_1X16:
 		/* BT.601/BT.1358 16bit YCbCr422 */
 		vnmc |= VNMC_INF_YUV16;
@@ -331,6 +336,15 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 	if (output_is_yuv)
 		vnmc |= VNMC_BPS;
 
+	/*
+	 * The above assumes YUV input, toggle BPS for RGB input.
+	 * RGB inputs can be detected by checking that the most-significant
+	 * two bits of INF are set. This corresponds to the bits
+	 * set in VNMC_INF_RGB888.
+	 */
+	if ((vnmc & VNMC_INF_RGB888) = VNMC_INF_RGB888)
+		vnmc ^= VNMC_BPS;
+
 	/* progressive or interlaced mode */
 	interrupts = progressive ? VNIE_FIE | VNIE_EFE : VNIE_EFE;
 
@@ -1013,6 +1027,7 @@ static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned int idx,
 	case V4L2_MBUS_FMT_YUYV8_1X16:
 	case V4L2_MBUS_FMT_YUYV8_2X8:
 	case V4L2_MBUS_FMT_YUYV10_2X10:
+	case V4L2_MBUS_FMT_RGB888_1X24:
 		if (cam->extra_fmt)
 			break;
 
-- 
1.9.1

