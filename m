From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:35 +0000
Subject: [PATCH/RFT 2/7] media: soc_camera pad-aware driver initialisation
Message-Id: <1445263660-6945-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: William Towle <william.towle@codethink.co.uk>

Add detection of source pad number for drivers aware of the media
controller API, so that the combination of soc_camera and rcar_vin
can create device nodes to support modern drivers such as adv7604.c
(for HDMI on Lager) and the converted adv7180.c (for composite)
underneath.

Building rcar_vin gains a dependency on CONFIG_MEDIA_CONTROLLER, in
line with requirements for building the drivers associated with it.

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
---
 drivers/media/platform/soc_camera/Kconfig      |  1 +
 drivers/media/platform/soc_camera/rcar_vin.c   |  1 +
 drivers/media/platform/soc_camera/soc_camera.c | 20 +++++++++++++++++++-
 include/media/soc_camera.h                     |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/soc_camera/Kconfig b/drivers/media/platform/soc_camera/Kconfig
index f2776cd..5c45c83 100644
--- a/drivers/media/platform/soc_camera/Kconfig
+++ b/drivers/media/platform/soc_camera/Kconfig
@@ -38,6 +38,7 @@ config VIDEO_RCAR_VIN
 	depends on VIDEO_DEV && SOC_CAMERA
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	depends on HAS_DMA
+	depends on MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_CONTIG
 	select SOC_CAMERA_SCALE_CROP
 	---help---
diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 71dd71c..43615c1 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1362,6 +1362,7 @@ static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned int idx,
 		struct device *dev = icd->parent;
 		int shift;
 
+		fmt.pad = icd->src_pad_idx;
 		ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index 9087fed..fa459c0 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -1303,6 +1303,10 @@ static int soc_camera_probe_finish(struct soc_camera_device *icd)
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
 	};
 	struct v4l2_mbus_framefmt *mf = &fmt.format;
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	struct media_pad pad;
+	int pad_idx;
+#endif
 	int ret;
 
 	sd->grp_id = soc_camera_grp_id(icd);
@@ -1321,9 +1325,23 @@ static int soc_camera_probe_finish(struct soc_camera_device *icd)
 	}
 
 	/* At this point client .probe() should have run already */
+	icd->src_pad_idx = 0;
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	for (pad_idx = 0; pad_idx < sd->entity.num_pads; pad_idx++)
+		if (sd->entity.pads[pad_idx].flags
+				= MEDIA_PAD_FL_SOURCE)
+			break;
+	if (pad_idx >= sd->entity.num_pads)
+		goto eusrfmt;
+
+	icd->src_pad_idx = pad_idx;
+#endif
+
 	ret = soc_camera_init_user_formats(icd);
-	if (ret < 0)
+	if (ret < 0) {
+		icd->src_pad_idx = -1;
 		goto eusrfmt;
+	}
 
 	icd->field = V4L2_FIELD_ANY;
 
diff --git a/include/media/soc_camera.h b/include/media/soc_camera.h
index 2f6261f..30193cf 100644
--- a/include/media/soc_camera.h
+++ b/include/media/soc_camera.h
@@ -42,6 +42,7 @@ struct soc_camera_device {
 	unsigned char devnum;		/* Device number per host */
 	struct soc_camera_sense *sense;	/* See comment in struct definition */
 	struct video_device *vdev;
+	int src_pad_idx;		/* For media-controller drivers */
 	struct v4l2_ctrl_handler ctrl_handler;
 	const struct soc_camera_format_xlate *current_fmt;
 	struct soc_camera_format_xlate *user_formats;
-- 
2.6.1

