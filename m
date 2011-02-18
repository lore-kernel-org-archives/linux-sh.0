From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 Feb 2011 08:13:45 +0000
Subject: [PATCH 4/4] V4l: sh_mobile_ceu_camera: fix cropping offset calculation
Message-Id: <Pine.LNX.4.64.1102180911430.1851@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1102180857360.1851@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102180857360.1851@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

Use the correct scales to calculate cropping offsets.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This one is unrelated to vb2, but it touches the same file.

 drivers/media/video/sh_mobile_ceu_camera.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/video/sh_mobile_ceu_camera.c b/drivers/media/video/sh_mobile_ceu_camera.c
index 325f50d..61f3701 100644
--- a/drivers/media/video/sh_mobile_ceu_camera.c
+++ b/drivers/media/video/sh_mobile_ceu_camera.c
@@ -1348,7 +1348,7 @@ static int sh_mobile_ceu_set_crop(struct soc_camera_device *icd,
 	struct device *dev = icd->dev.parent;
 	struct v4l2_mbus_framefmt mf;
 	unsigned int scale_cam_h, scale_cam_v, scale_ceu_h, scale_ceu_v,
-		out_width, out_height, scale_h, scale_v;
+		out_width, out_height;
 	int interm_width, interm_height;
 	u32 capsr, cflcr;
 	int ret;
@@ -1406,10 +1406,6 @@ static int sh_mobile_ceu_set_crop(struct soc_camera_device *icd,
 	scale_ceu_h	= calc_scale(interm_width, &out_width);
 	scale_ceu_v	= calc_scale(interm_height, &out_height);
 
-	/* Calculate camera scales */
-	scale_h		= calc_generic_scale(cam_rect->width, out_width);
-	scale_v		= calc_generic_scale(cam_rect->height, out_height);
-
 	dev_geo(dev, "5: CEU scales %u:%u\n", scale_ceu_h, scale_ceu_v);
 
 	/* Apply CEU scales. */
@@ -1421,8 +1417,8 @@ static int sh_mobile_ceu_set_crop(struct soc_camera_device *icd,
 
 	icd->user_width	 = out_width;
 	icd->user_height = out_height;
-	cam->ceu_left	 = scale_down(rect->left - cam_rect->left, scale_h) & ~1;
-	cam->ceu_top	 = scale_down(rect->top - cam_rect->top, scale_v) & ~1;
+	cam->ceu_left	 = scale_down(rect->left - cam_rect->left, scale_cam_h) & ~1;
+	cam->ceu_top	 = scale_down(rect->top - cam_rect->top, scale_cam_v) & ~1;
 
 	/* 6. Use CEU cropping to crop to the new window. */
 	sh_mobile_ceu_set_rect(icd);
@@ -1433,7 +1429,7 @@ static int sh_mobile_ceu_set_crop(struct soc_camera_device *icd,
 		icd->user_width, icd->user_height,
 		cam->ceu_left, cam->ceu_top);
 
-	/* Restore capture */
+	/* Restore capture. The CE bit can be cleared by the hardware */
 	if (pcdev->active)
 		capsr |= 1;
 	capture_restore(pcdev, capsr);
-- 
1.7.2.3

