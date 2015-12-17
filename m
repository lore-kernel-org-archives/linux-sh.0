From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:39:57 +0000
Subject: [PATCH/RFC 19/48] v4l: vsp1: Fix BRU try compose rectangle storage
Message-Id: <1450341626-6695-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Fix a typo that stored the try compose rectangle in the crop rectangle.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_bru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_bru.c b/drivers/media/platform/vsp1/vsp1_bru.c
index 2ca80d3dda1f..d8b7bdeb5af5 100644
--- a/drivers/media/platform/vsp1/vsp1_bru.c
+++ b/drivers/media/platform/vsp1/vsp1_bru.c
@@ -228,7 +228,8 @@ static struct v4l2_rect *bru_get_compose(struct vsp1_bru *bru,
 {
 	switch (which) {
 	case V4L2_SUBDEV_FORMAT_TRY:
-		return v4l2_subdev_get_try_crop(&bru->entity.subdev, cfg, pad);
+		return v4l2_subdev_get_try_compose(&bru->entity.subdev, cfg,
+						   pad);
 	case V4L2_SUBDEV_FORMAT_ACTIVE:
 		return &bru->inputs[pad].compose;
 	default:
-- 
2.4.10

