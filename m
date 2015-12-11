From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 11 Dec 2015 16:04:51 +0000
Subject: [PATCH 1/3] media: adv7604: implement g_crop
Message-Id: <1449849893-14865-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449849893-14865-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1449849893-14865-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

The rcar_vin driver relies on this.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/media/i2c/adv7604.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 129009f..d30e7cc 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1885,6 +1885,17 @@ static int adv76xx_get_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int adv76xx_g_crop(struct v4l2_subdev *sd, struct v4l2_crop *a)
+{
+	struct adv76xx_state *state = to_state(sd);
+
+	a->c.height = state->timings.bt.height;
+	a->c.width  = state->timings.bt.width;
+	a->type	    = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+	return 0;
+}
+
 static int adv76xx_set_format(struct v4l2_subdev *sd,
 			      struct v4l2_subdev_pad_config *cfg,
 			      struct v4l2_subdev_format *format)
@@ -2407,6 +2418,7 @@ static const struct v4l2_subdev_core_ops adv76xx_core_ops = {
 
 static const struct v4l2_subdev_video_ops adv76xx_video_ops = {
 	.s_routing = adv76xx_s_routing,
+	.g_crop = adv76xx_g_crop,
 	.g_input_status = adv76xx_g_input_status,
 	.s_dv_timings = adv76xx_s_dv_timings,
 	.g_dv_timings = adv76xx_g_dv_timings,
-- 
2.6.3

