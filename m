From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 29 May 2013 18:50:57 +0000
Subject: [PATCH v5] adv7180: add more subdev video ops
Message-Id: <201305292250.57801.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mchehab@redhat.com, linux-media@vger.kernel.org, hverkuil@xs4all.nl
Cc: vladimir.barinov@cogentembedded.com, linux-sh@vger.kernel.org, matsu@igel.co.jp

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add subdev video ops for ADV7180 video decoder.  This makes decoder usable on
the soc-camera drivers.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
[Sergei: renamed adv7180_try_mbus_fmt() to adv7180_mbus_fmt().]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'media_tree.git' repo.

Changes from version 4:
- renamed adv7180_try_mbus_fmt() to adv7180_mbus_fmt().

Changes from version 3:
- set the field format independent of a video standard in try_mbus_fmt() method;
- removed adv7180_g_mbus_fmt(), adv7180_g_mbus_fmt(), and the 'fmt' field from
  'struct adv7180_state', and so use adv7180_try_mbus_fmt()  to implement both
  g_mbus_fmt() and s_mbus_fmt() methods;
- removed cropcap() method.

Changes from version 2:
- set the field format depending on video standard in try_mbus_fmt() method;
- removed querystd() method calls from try_mbus_fmt() and cropcap() methods;
- removed g_crop() method.

 drivers/media/i2c/adv7180.c |   46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

Index: media_tree/drivers/media/i2c/adv7180.c
=================================--- media_tree.orig/drivers/media/i2c/adv7180.c
+++ media_tree/drivers/media/i2c/adv7180.c
@@ -1,6 +1,8 @@
 /*
  * adv7180.c Analog Devices ADV7180 video decoder driver
  * Copyright (c) 2009 Intel Corporation
+ * Copyright (C) 2013 Cogent Embedded, Inc.
+ * Copyright (C) 2013 Renesas Solutions Corp.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -397,10 +399,54 @@ static void adv7180_exit_controls(struct
 	v4l2_ctrl_handler_free(&state->ctrl_hdl);
 }
 
+static int adv7180_enum_mbus_fmt(struct v4l2_subdev *sd, unsigned int index,
+				 enum v4l2_mbus_pixelcode *code)
+{
+	if (index > 0)
+		return -EINVAL;
+
+	*code = V4L2_MBUS_FMT_YUYV8_2X8;
+
+	return 0;
+}
+
+static int adv7180_mbus_fmt(struct v4l2_subdev *sd,
+			    struct v4l2_mbus_framefmt *fmt)
+{
+	struct adv7180_state *state = to_state(sd);
+
+	fmt->code = V4L2_MBUS_FMT_YUYV8_2X8;
+	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
+	fmt->field = V4L2_FIELD_INTERLACED;
+	fmt->width = 720;
+	fmt->height = state->curr_norm & V4L2_STD_525_60 ? 480 : 576;
+
+	return 0;
+}
+
+static int adv7180_g_mbus_config(struct v4l2_subdev *sd,
+				 struct v4l2_mbus_config *cfg)
+{
+	/*
+	 * The ADV7180 sensor supports BT.601/656 output modes.
+	 * The BT.656 is default and not yet configurable by s/w.
+	 */
+	cfg->flags = V4L2_MBUS_MASTER | V4L2_MBUS_PCLK_SAMPLE_RISING |
+		     V4L2_MBUS_DATA_ACTIVE_HIGH;
+	cfg->type = V4L2_MBUS_BT656;
+
+	return 0;
+}
+
 static const struct v4l2_subdev_video_ops adv7180_video_ops = {
 	.querystd = adv7180_querystd,
 	.g_input_status = adv7180_g_input_status,
 	.s_routing = adv7180_s_routing,
+	.enum_mbus_fmt = adv7180_enum_mbus_fmt,
+	.try_mbus_fmt = adv7180_mbus_fmt,
+	.g_mbus_fmt = adv7180_mbus_fmt,
+	.s_mbus_fmt = adv7180_mbus_fmt,
+	.g_mbus_config = adv7180_g_mbus_config,
 };
 
 static const struct v4l2_subdev_core_ops adv7180_core_ops = {
