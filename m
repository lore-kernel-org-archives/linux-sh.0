From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 23 Jun 2014 23:54:27 +0000
Subject: [PATCH v2 21/23] v4l: vsp1: bru: Support non-premultiplied colors at the BRU output
Message-Id: <1403567669-18539-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The BRU outputs premultiplied colors, enable color data normalization
when the format configured at the output of the pipeline isn't
premultiplied.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_bru.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_bru.c b/drivers/media/platform/vsp1/vsp1_bru.c
index d8d49fb..86b32bc 100644
--- a/drivers/media/platform/vsp1/vsp1_bru.c
+++ b/drivers/media/platform/vsp1/vsp1_bru.c
@@ -43,8 +43,10 @@ static inline void vsp1_bru_write(struct vsp1_bru *bru, u32 reg, u32 data)
 
 static int bru_s_stream(struct v4l2_subdev *subdev, int enable)
 {
+	struct vsp1_pipeline *pipe = to_vsp1_pipeline(&subdev->entity);
 	struct vsp1_bru *bru = to_bru(subdev);
 	struct v4l2_mbus_framefmt *format;
+	unsigned int flags;
 	unsigned int i;
 
 	if (!enable)
@@ -58,8 +60,13 @@ static int bru_s_stream(struct v4l2_subdev *subdev, int enable)
 	 * to sane default values for now.
 	 */
 
-	/* Disable both color data normalization and dithering. */
-	vsp1_bru_write(bru, VI6_BRU_INCTRL, 0);
+	/* Disable dithering and enable color data normalization unless the
+	 * format at the pipeline output is premultiplied.
+	 */
+	flags = pipe->output ? pipe->output->video.format.flags : 0;
+	vsp1_bru_write(bru, VI6_BRU_INCTRL,
+		       flags & V4L2_PIX_FMT_FLAG_PREMUL_ALPHA ?
+		       0 : VI6_BRU_INCTRL_NRM);
 
 	/* Set the background position to cover the whole output image and
 	 * set its color to opaque black.
-- 
1.8.5.5

