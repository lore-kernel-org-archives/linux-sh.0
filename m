From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:39:58 +0000
Subject: [PATCH/RFC 20/48] v4l: vsp1: Add race condition FIXME comment
Message-Id: <1450341626-6695-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 50fc91a2f509..ec1394289659 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -821,6 +821,9 @@ vsp1_video_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	 *
 	 * Use the VSP1 pipeline object embedded in the first video object that
 	 * starts streaming.
+	 *
+	 * FIXME: This is racy, the ioctl is only protected by the video node
+	 * lock.
 	 */
 	pipe = video->video.entity.pipe
 	     ? to_vsp1_pipeline(&video->video.entity) : &video->pipe;
-- 
2.4.10

