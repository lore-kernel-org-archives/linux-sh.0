From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 21 Oct 2014 05:10:29 +0000
Subject: [PATCH v3 3/3] media: soc_camera: rcar_vin: Add NV16 horizontal scaling-up support
Message-Id: <1413868229-22205-4-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413868229-22205-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1413868229-22205-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Up until now scaling has been forbidden for the NV16 capture format.
This patch adds support for horizontal scaling-up for NV16. Vertical
scaling-up for NV16 is forbidden by the H/W specification.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
v3 [Yoshihiro Kaneko]
* no changes

v2 [Yoshihiro Kaneko]
* Updated change log text from Simon Horman
* Code-style fixes as suggested by Sergei Shtylyov

 drivers/media/platform/soc_camera/rcar_vin.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index ecdbd48..fd2207a 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -644,7 +644,7 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 	/* output format */
 	switch (icd->current_fmt->host_fmt->fourcc) {
 	case V4L2_PIX_FMT_NV16:
-		iowrite32(ALIGN(ALIGN(cam->width, 0x20) * cam->height, 0x80),
+		iowrite32(ALIGN((cam->out_width * cam->out_height), 0x80),
 			  priv->base + VNUVAOF_REG);
 		dmr = VNDMR_DTMD_YCSEP;
 		output_is_yuv = true;
@@ -1614,9 +1614,17 @@ static int rcar_vin_set_fmt(struct soc_camera_device *icd,
 	 * At the time of NV16 capture format, the user has to specify the
 	 * width of the multiple of 32 for H/W specification.
 	 */
-	if ((pixfmt = V4L2_PIX_FMT_NV16) && (pix->width & 0x1F)) {
-		dev_err(icd->parent, "Specified width error in NV16 format.\n");
-		return -EINVAL;
+	if (pixfmt = V4L2_PIX_FMT_NV16) {
+		if (pix->width & 0x1F) {
+			dev_err(icd->parent,
+				"Specified width error in NV16 format. Please specify the multiple of 32.\n");
+			return -EINVAL;
+		}
+		if (pix->height != cam->height) {
+			dev_err(icd->parent,
+				"Vertical scaling-up error in NV16 format. Please specify input height size.\n");
+			return -EINVAL;
+		}
 	}
 
 	switch (pix->field) {
@@ -1661,6 +1669,7 @@ static int rcar_vin_set_fmt(struct soc_camera_device *icd,
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_RGB565:
 	case V4L2_PIX_FMT_RGB555X:
+	case V4L2_PIX_FMT_NV16: /* horizontal scaling-up only is supported */
 		can_scale = true;
 		break;
 	default:
-- 
1.9.1

