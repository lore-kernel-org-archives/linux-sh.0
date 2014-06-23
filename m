From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 23 Jun 2014 23:54:21 +0000
Subject: [PATCH v2 15/23] v4l: vsp1: wpf: Simplify cast to pipeline structure
Message-Id: <1403567669-18539-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Use the subdev pointer directly to_vsp1_pipeline() macro instead of
casting from the subdev to the wpf object and back to the subdev.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_wpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 36c4793..591f09c 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -44,9 +44,8 @@ static inline void vsp1_wpf_write(struct vsp1_rwpf *wpf, u32 reg, u32 data)
 
 static int wpf_s_stream(struct v4l2_subdev *subdev, int enable)
 {
+	struct vsp1_pipeline *pipe = to_vsp1_pipeline(&subdev->entity);
 	struct vsp1_rwpf *wpf = to_rwpf(subdev);
-	struct vsp1_pipeline *pipe -		to_vsp1_pipeline(&wpf->entity.subdev.entity);
 	struct vsp1_device *vsp1 = wpf->entity.vsp1;
 	const struct v4l2_rect *crop = &wpf->crop;
 	unsigned int i;
-- 
1.8.5.5

