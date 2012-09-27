From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:33 +0000
Subject: [PATCH 14/14] media: sh_mobile_ceu_camera: support all standard V4L2 DT properties
Message-Id: <1348754853-28619-15-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Additionally to the basic DT support, added to the driver in previous
patches, this patch implements complete interface configuration from DT.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |  126 ++++++++++++--------
 1 files changed, 78 insertions(+), 48 deletions(-)

diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 1fd03f6..78bcf23 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -37,6 +37,7 @@
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-dev.h>
+#include <media/v4l2-of.h>
 #include <media/soc_camera.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/sh_mobile_csi2.h>
@@ -784,50 +785,61 @@ static struct v4l2_subdev *find_bus_subdev(struct sh_mobile_ceu_dev *pcdev,
 static int sh_mobile_ceu_set_bus_param(struct soc_camera_device *icd)
 {
 	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct soc_camera_link *icl = icd->link;
 	struct sh_mobile_ceu_dev *pcdev = ici->priv;
 	struct v4l2_subdev *sd = find_bus_subdev(pcdev, icd);
 	struct sh_mobile_ceu_cam *cam = icd->host_priv;
-	struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_PARALLEL,};
-	unsigned long value, common_flags = CEU_BUS_FLAGS;
+	unsigned long value, common_flags;
 	u32 capsr = capture_save_reset(pcdev);
 	unsigned int yuv_lineskip;
 	int ret;
 
-	/*
-	 * If the client doesn't implement g_mbus_config, we just use our
-	 * platform data
-	 */
-	ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
-	if (!ret) {
-		common_flags = soc_mbus_config_compatible(&cfg,
-							  common_flags);
-		if (!common_flags)
-			return -EINVAL;
-	} else if (ret != -ENOIOCTLCMD) {
-		return ret;
-	}
+	if (icl->of_link) {
+		/*
+		 * OF configuration validity verified in
+		 * sh_mobile_ceu_try_bus_param()
+		 */
+		common_flags = icl->of_link->mbus_flags;
+	} else {
+		struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_PARALLEL,};
 
-	/* Make choises, based on platform preferences */
-	if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
-	    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
-		if (pcdev->flags & SH_CEU_FLAG_HSYNC_LOW)
-			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_HIGH;
-		else
-			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_LOW;
-	}
+		common_flags = CEU_BUS_FLAGS;
+		/*
+		 * If the client doesn't implement g_mbus_config, we just use
+		 * our platform data
+		 */
+		ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
+		if (!ret) {
+			common_flags = soc_mbus_config_compatible(&cfg,
+								  common_flags);
+			if (!common_flags)
+				return -EINVAL;
+		} else if (ret != -ENOIOCTLCMD) {
+			return ret;
+		}
 
-	if ((common_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) &&
-	    (common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)) {
-		if (pcdev->flags & SH_CEU_FLAG_VSYNC_LOW)
-			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_HIGH;
-		else
-			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_LOW;
-	}
+		/* Make choises, based on platform preferences */
+		if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
+		    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
+			if (pcdev->flags & SH_CEU_FLAG_HSYNC_LOW)
+				common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_HIGH;
+			else
+				common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_LOW;
+		}
 
-	cfg.flags = common_flags;
-	ret = v4l2_subdev_call(sd, video, s_mbus_config, &cfg);
-	if (ret < 0 && ret != -ENOIOCTLCMD)
-		return ret;
+		if ((common_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) &&
+		    (common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)) {
+			if (pcdev->flags & SH_CEU_FLAG_VSYNC_LOW)
+				common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_HIGH;
+			else
+				common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_LOW;
+		}
+
+		cfg.flags = common_flags;
+		ret = v4l2_subdev_call(sd, video, s_mbus_config, &cfg);
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			return ret;
+	}
 
 	if (icd->current_fmt->host_fmt->bits_per_sample > 8)
 		pcdev->is_16bit = 1;
@@ -877,7 +889,9 @@ static int sh_mobile_ceu_set_bus_param(struct soc_camera_device *icd)
 		value |= 3 << 12;
 	else if (pcdev->is_16bit)
 		value |= 1 << 12;
-	else if (pcdev->flags & SH_CEU_FLAG_LOWER_8BIT)
+	else if (pcdev->flags & SH_CEU_FLAG_LOWER_8BIT ||
+		 (icl->of_link &&
+		  !icl->of_link->parallel.data_shift))
 		value |= 2 << 12;
 
 	ceu_write(pcdev, CAMCR, value);
@@ -931,21 +945,36 @@ static int sh_mobile_ceu_try_bus_param(struct soc_camera_device *icd,
 				       unsigned char buswidth)
 {
 	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
-	struct sh_mobile_ceu_dev *pcdev = ici->priv;
-	struct v4l2_subdev *sd = find_bus_subdev(pcdev, icd);
-	unsigned long common_flags = CEU_BUS_FLAGS;
-	struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_PARALLEL,};
-	int ret;
+	struct soc_camera_link *icl = icd->link;
 
-	ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
-	if (!ret)
-		common_flags = soc_mbus_config_compatible(&cfg,
-							  common_flags);
-	else if (ret != -ENOIOCTLCMD)
-		return ret;
+	if (icl->of_link) {
+		unsigned int bus_width = icl->of_link->parallel.bus_width,
+			data_shift = icl->of_link->parallel.data_shift;
+		/*
+		 * CEU can use either lower (data shift = 0) or upper (data
+		 * shift = 8) data lines out of 16 available
+		 */
+		if (icl->of_link->mbus_flags & ~CEU_BUS_FLAGS ||
+		    bus_width < buswidth || bus_width > 16 ||
+		    (data_shift && (data_shift != 8 || bus_width > 8)))
+			return -EINVAL;
+	} else {
+		struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_PARALLEL,};
+		struct sh_mobile_ceu_dev *pcdev = ici->priv;
+		struct v4l2_subdev *sd = find_bus_subdev(pcdev, icd);
+		unsigned long common_flags = CEU_BUS_FLAGS;
+		int ret;
 
-	if (!common_flags || buswidth > 16)
-		return -EINVAL;
+		ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
+		if (!ret)
+			common_flags = soc_mbus_config_compatible(&cfg,
+								  common_flags);
+		else if (ret != -ENOIOCTLCMD)
+			return ret;
+
+		if (!common_flags || buswidth > 16)
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -2335,6 +2364,7 @@ MODULE_DEVICE_TABLE(of, sh_mobile_ceu_of_match);
 static struct platform_driver sh_mobile_ceu_driver = {
 	.driver 	= {
 		.name	= "sh_mobile_ceu",
+		.owner	= THIS_MODULE,
 		.pm	= &sh_mobile_ceu_dev_pm_ops,
 		.of_match_table = sh_mobile_ceu_of_match,
 	},
-- 
1.7.2.5

