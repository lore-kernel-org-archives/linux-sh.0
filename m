From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:36 +0000
Subject: [PATCH/RFT 3/7] media: rcar_vin: Use correct pad number in try_fmt
Message-Id: <1445263660-6945-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: William Towle <william.towle@codethink.co.uk>

Fix rcar_vin_try_fmt's use of an inappropriate pad number when calling
the subdev set_fmt function - for the ADV7612, IDs should be non-zero.

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Reviewed-by: Rob Taylor <rob.taylor@codethink.co.uk>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 43615c1..f4e611b 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1700,7 +1700,7 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
 	const struct soc_camera_format_xlate *xlate;
 	struct v4l2_pix_format *pix = &f->fmt.pix;
 	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
-	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_pad_config *pad_cfg;
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_TRY,
 	};
@@ -1709,6 +1709,10 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
 	int width, height;
 	int ret;
 
+	pad_cfg = v4l2_subdev_alloc_pad_config(sd);
+	if (pad_cfg = NULL)
+		return -ENOMEM;
+
 	xlate = soc_camera_xlate_by_fourcc(icd, pixfmt);
 	if (!xlate) {
 		xlate = icd->current_fmt;
@@ -1737,10 +1741,11 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
 	mf->code = xlate->code;
 	mf->colorspace = pix->colorspace;
 
+	format.pad = icd->src_pad_idx;
 	ret = v4l2_device_call_until_err(sd->v4l2_dev, soc_camera_grp_id(icd),
-					 pad, set_fmt, &pad_cfg, &format);
+					 pad, set_fmt, pad_cfg, &format);
 	if (ret < 0)
-		return ret;
+		goto cleanup;
 
 	/* Adjust only if VIN cannot scale */
 	if (pix->width > mf->width * 2)
@@ -1764,12 +1769,12 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
 			mf->height = VIN_MAX_HEIGHT;
 			ret = v4l2_device_call_until_err(sd->v4l2_dev,
 							 soc_camera_grp_id(icd),
-							 pad, set_fmt, &pad_cfg,
+							 pad, set_fmt, pad_cfg,
 							 &format);
 			if (ret < 0) {
 				dev_err(icd->parent,
 					"client try_fmt() = %d\n", ret);
-				return ret;
+				goto cleanup;
 			}
 		}
 		/* We will scale exactly */
@@ -1779,6 +1784,8 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
 			pix->height = height;
 	}
 
+cleanup:
+	v4l2_subdev_free_pad_config(pad_cfg);
 	return ret;
 }
 
-- 
2.6.1

