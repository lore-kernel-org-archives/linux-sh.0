From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:31 +0000
Subject: [PATCH 12/14] media: sh-mobile-ceu-camera: add primitive OF support
Message-Id: <1348754853-28619-13-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Add an OF hook to sh_mobile_ceu_camera.c, no properties so far. Booting
with DT also requires platform data to be optional.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |   34 ++++++++++++++------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 41e4664..61ee459 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -118,6 +119,7 @@ struct sh_mobile_ceu_dev {
 
 	enum v4l2_field field;
 	int sequence;
+	unsigned long flags;
 
 	unsigned int image_mode:1;
 	unsigned int is_16bit:1;
@@ -704,7 +706,7 @@ static void sh_mobile_ceu_set_rect(struct soc_camera_device *icd)
 	}
 
 	/* CSI2 special configuration */
-	if (pcdev->pdata->csi2) {
+	if (pcdev->csi2_pdev) {
 		in_width = ((in_width - 2) * 2);
 		left_offset *= 2;
 	}
@@ -808,7 +810,7 @@ static int sh_mobile_ceu_set_bus_param(struct soc_camera_device *icd)
 	/* Make choises, based on platform preferences */
 	if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
 	    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
-		if (pcdev->pdata->flags & SH_CEU_FLAG_HSYNC_LOW)
+		if (pcdev->flags & SH_CEU_FLAG_HSYNC_LOW)
 			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_HIGH;
 		else
 			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_LOW;
@@ -816,7 +818,7 @@ static int sh_mobile_ceu_set_bus_param(struct soc_camera_device *icd)
 
 	if ((common_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) &&
 	    (common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)) {
-		if (pcdev->pdata->flags & SH_CEU_FLAG_VSYNC_LOW)
+		if (pcdev->flags & SH_CEU_FLAG_VSYNC_LOW)
 			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_HIGH;
 		else
 			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_LOW;
@@ -871,11 +873,11 @@ static int sh_mobile_ceu_set_bus_param(struct soc_camera_device *icd)
 	value |= common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW ? 1 << 1 : 0;
 	value |= common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW ? 1 << 0 : 0;
 
-	if (pcdev->pdata->csi2) /* CSI2 mode */
+	if (pcdev->csi2_pdev) /* CSI2 mode */
 		value |= 3 << 12;
 	else if (pcdev->is_16bit)
 		value |= 1 << 12;
-	else if (pcdev->pdata->flags & SH_CEU_FLAG_LOWER_8BIT)
+	else if (pcdev->flags & SH_CEU_FLAG_LOWER_8BIT)
 		value |= 2 << 12;
 
 	ceu_write(pcdev, CAMCR, value);
@@ -1050,7 +1052,7 @@ static int sh_mobile_ceu_get_formats(struct soc_camera_device *icd, unsigned int
 		return 0;
 	}
 
-	if (!pcdev->pdata->csi2) {
+	if (!pcdev->csi2_pdev) {
 		/* Are there any restrictions in the CSI-2 case? */
 		ret = sh_mobile_ceu_try_bus_param(icd, fmt->bits_per_sample);
 		if (ret < 0)
@@ -2103,14 +2105,19 @@ static int __devinit sh_mobile_ceu_probe(struct platform_device *pdev)
 	init_completion(&pcdev->complete);
 
 	pcdev->pdata = pdev->dev.platform_data;
-	if (!pcdev->pdata) {
+	if (!pcdev->pdata && !pdev->dev.of_node) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "CEU platform data not set.\n");
 		goto exit_kfree;
 	}
 
-	pcdev->max_width = pcdev->pdata->max_width ? : 2560;
-	pcdev->max_height = pcdev->pdata->max_height ? : 1920;
+	/* TODO: implement per-device bus flags */
+
+	if (pcdev->pdata) {
+		pcdev->max_width = pcdev->pdata->max_width;
+		pcdev->max_height = pcdev->pdata->max_height;
+		pcdev->flags = pcdev->pdata->flags;
+	}
 
 	base = ioremap_nocache(res->start, resource_size(res));
 	if (!base) {
@@ -2169,7 +2176,7 @@ static int __devinit sh_mobile_ceu_probe(struct platform_device *pdev)
 		goto exit_free_ctx;
 
 	/* CSI2 interfacing */
-	csi2 = pcdev->pdata->csi2;
+	csi2 = pcdev->pdata ? pcdev->pdata->csi2 : NULL;
 	if (csi2) {
 		struct platform_device *csi2_pdev  			platform_device_alloc("sh-mobile-csi2", csi2->id);
@@ -2300,10 +2307,17 @@ static const struct dev_pm_ops sh_mobile_ceu_dev_pm_ops = {
 	.runtime_resume = sh_mobile_ceu_runtime_nop,
 };
 
+static const struct of_device_id sh_mobile_ceu_of_match[] = {
+	{ .compatible = "renesas,sh-mobile-ceu" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_ceu_of_match);
+
 static struct platform_driver sh_mobile_ceu_driver = {
 	.driver 	= {
 		.name	= "sh_mobile_ceu",
 		.pm	= &sh_mobile_ceu_dev_pm_ops,
+		.of_match_table = sh_mobile_ceu_of_match,
 	},
 	.probe		= sh_mobile_ceu_probe,
 	.remove		= __devexit_p(sh_mobile_ceu_remove),
-- 
1.7.2.5

