From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:39:40 +0000
Subject: [PATCH/RFC 02/48] v4l: vsp1: Always setup the display list
Message-Id: <1450341626-6695-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Make sure display list usage is correctly disabled by always setting up
the corresponding registers, including when the display list feature
isn't used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_dl.c  | 7 +++----
 drivers/media/platform/vsp1/vsp1_drv.c | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_dl.c b/drivers/media/platform/vsp1/vsp1_dl.c
index 1e5cff590e87..caf20f5f31f3 100644
--- a/drivers/media/platform/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/vsp1/vsp1_dl.c
@@ -243,15 +243,14 @@ done:
 
 void vsp1_dl_setup(struct vsp1_device *vsp1)
 {
-	u32 ctrl = (256 << VI6_DL_CTRL_AR_WAIT_SHIFT)
-		 | VI6_DL_CTRL_DC2 | VI6_DL_CTRL_DC1 | VI6_DL_CTRL_DC0
-		 | VI6_DL_CTRL_DLE;
+	u32 ctrl = (256 << VI6_DL_CTRL_AR_WAIT_SHIFT);
 
 	/* The DRM pipeline operates with header-less display lists in
 	 * Continuous Frame Mode.
 	 */
 	if (vsp1->drm)
-		ctrl |= VI6_DL_CTRL_CFM0 | VI6_DL_CTRL_NH0;
+		ctrl |= VI6_DL_CTRL_DC2 | VI6_DL_CTRL_DC1 | VI6_DL_CTRL_DC0
+		     |  VI6_DL_CTRL_DLE | VI6_DL_CTRL_CFM0 | VI6_DL_CTRL_NH0;
 
 	vsp1_write(vsp1, VI6_DL_CTRL, ctrl);
 	vsp1_write(vsp1, VI6_DL_SWAP, VI6_DL_SWAP_LWS);
diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index cf469bd76f43..871cbeea5695 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -458,8 +458,7 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
 	vsp1_write(vsp1, VI6_DPR_HGT_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
 		   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
 
-	if (!vsp1->info->uapi)
-		vsp1_dl_setup(vsp1);
+	vsp1_dl_setup(vsp1);
 
 	return 0;
 }
-- 
2.4.10

