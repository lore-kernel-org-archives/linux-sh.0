From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 01 Jun 2014 03:39:26 +0000
Subject: [PATCH 07/18] v4l: vsp1: Propagate vsp1_device_get errors to the callers
Message-Id: <1401593977-30660-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401593977-30660-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1401593977-30660-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Modify the vsp1_device_get() function to return an error code instead of
a pointer to the VSP1 device, and use the return value in the callers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1.h       |  2 +-
 drivers/media/platform/vsp1/vsp1_drv.c   | 16 ++++++----------
 drivers/media/platform/vsp1/vsp1_video.c |  4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1.h b/drivers/media/platform/vsp1/vsp1.h
index 3cfa393..1246719 100644
--- a/drivers/media/platform/vsp1/vsp1.h
+++ b/drivers/media/platform/vsp1/vsp1.h
@@ -66,7 +66,7 @@ struct vsp1_device {
 	struct media_device media_dev;
 };
 
-struct vsp1_device *vsp1_device_get(struct vsp1_device *vsp1);
+int vsp1_device_get(struct vsp1_device *vsp1);
 void vsp1_device_put(struct vsp1_device *vsp1);
 
 static inline u32 vsp1_read(struct vsp1_device *vsp1, u32 reg)
diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 0c5e74c..3e6601b 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -345,36 +345,32 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
  * Increment the VSP1 reference count and initialize the device if the first
  * reference is taken.
  *
- * Return a pointer to the VSP1 device or NULL if an error occurred.
+ * Return 0 on success or a negative error code otherwise.
  */
-struct vsp1_device *vsp1_device_get(struct vsp1_device *vsp1)
+int vsp1_device_get(struct vsp1_device *vsp1)
 {
-	struct vsp1_device *__vsp1 = vsp1;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&vsp1->lock);
 	if (vsp1->ref_count > 0)
 		goto done;
 
 	ret = clk_prepare_enable(vsp1->clock);
-	if (ret < 0) {
-		__vsp1 = NULL;
+	if (ret < 0)
 		goto done;
-	}
 
 	ret = vsp1_device_init(vsp1);
 	if (ret < 0) {
 		clk_disable_unprepare(vsp1->clock);
-		__vsp1 = NULL;
 		goto done;
 	}
 
 done:
-	if (__vsp1)
+	if (!ret)
 		vsp1->ref_count++;
 
 	mutex_unlock(&vsp1->lock);
-	return __vsp1;
+	return ret;
 }
 
 /*
diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 677e3aa..b5bce10 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -948,8 +948,8 @@ static int vsp1_video_open(struct file *file)
 
 	file->private_data = vfh;
 
-	if (!vsp1_device_get(video->vsp1)) {
-		ret = -EBUSY;
+	ret = vsp1_device_get(video->vsp1);
+	if (ret < 0) {
 		v4l2_fh_del(vfh);
 		kfree(vfh);
 	}
-- 
1.8.5.5

