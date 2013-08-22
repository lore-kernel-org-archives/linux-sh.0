From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 22 Aug 2013 23:27:41 +0000
Subject: [PATCH] v4l: vsp1: Fix mutex double lock at streamon time
Message-Id: <1377214061-16484-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

A mutex_lock() was left when the driver was converted to use the vb2
ioctl helpers, resulting in a deadlock at streamon time. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 2 --
 1 file changed, 2 deletions(-)

Yet another v3.12 fix for the VSP1 driver. I'm not sure how I've managed to let
this bug slip in. This should hopefully be the last one, sorry for the noise :-/

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index f51f842..714c53e 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -839,8 +839,6 @@ vsp1_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	struct vsp1_pipeline *pipe;
 	int ret;
 
-	mutex_lock(&video->lock);
-
 	if (video->queue.owner && video->queue.owner != file->private_data)
 		return -EBUSY;
 
-- 
Regards,

Laurent Pinchart

