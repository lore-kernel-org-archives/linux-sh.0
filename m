From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sun, 07 Jun 2015 08:57:58 +0000
Subject: [PATCHv2 04/11] sh-vou: use v4l2_fh
Message-Id: <1433667485-35711-5-git-send-email-hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
In-Reply-To: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

This allows us to drop the use_count and you get free G/S_PRIORITY support.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/sh_vou.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index d7a72a9..4994b7b 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -63,7 +63,6 @@ enum sh_vou_status {
 struct sh_vou_device {
 	struct v4l2_device v4l2_dev;
 	struct video_device vdev;
-	atomic_t use_count;
 	struct sh_vou_pdata *pdata;
 	spinlock_t lock;
 	void __iomem *base;
@@ -79,6 +78,7 @@ struct sh_vou_device {
 };
 
 struct sh_vou_file {
+	struct v4l2_fh fh;
 	struct videobuf_queue vbq;
 };
 
@@ -1173,20 +1173,24 @@ static int sh_vou_open(struct file *file)
 
 	dev_dbg(vou_dev->v4l2_dev.dev, "%s()\n", __func__);
 
+	v4l2_fh_init(&vou_file->fh, &vou_dev->vdev);
 	if (mutex_lock_interruptible(&vou_dev->fop_lock)) {
 		kfree(vou_file);
 		return -ERESTARTSYS;
 	}
-	if (atomic_inc_return(&vou_dev->use_count) = 1) {
+	v4l2_fh_add(&vou_file->fh);
+	if (v4l2_fh_is_singular(&vou_file->fh)) {
 		int ret;
+
 		/* First open */
 		vou_dev->status = SH_VOU_INITIALISING;
 		pm_runtime_get_sync(vou_dev->v4l2_dev.dev);
 		ret = sh_vou_hw_init(vou_dev);
 		if (ret < 0) {
-			atomic_dec(&vou_dev->use_count);
 			pm_runtime_put(vou_dev->v4l2_dev.dev);
 			vou_dev->status = SH_VOU_IDLE;
+			v4l2_fh_del(&vou_file->fh);
+			v4l2_fh_exit(&vou_file->fh);
 			mutex_unlock(&vou_dev->fop_lock);
 			kfree(vou_file);
 			return ret;
@@ -1213,14 +1217,16 @@ static int sh_vou_release(struct file *file)
 
 	dev_dbg(vou_dev->v4l2_dev.dev, "%s()\n", __func__);
 
-	if (!atomic_dec_return(&vou_dev->use_count)) {
-		mutex_lock(&vou_dev->fop_lock);
+	mutex_lock(&vou_dev->fop_lock);
+	if (v4l2_fh_is_singular(&vou_file->fh)) {
 		/* Last close */
 		vou_dev->status = SH_VOU_IDLE;
 		sh_vou_reg_a_set(vou_dev, VOUER, 0, 0x101);
 		pm_runtime_put(vou_dev->v4l2_dev.dev);
-		mutex_unlock(&vou_dev->fop_lock);
 	}
+	v4l2_fh_del(&vou_file->fh);
+	v4l2_fh_exit(&vou_file->fh);
+	mutex_unlock(&vou_dev->fop_lock);
 
 	file->private_data = NULL;
 	kfree(vou_file);
@@ -1321,7 +1327,6 @@ static int sh_vou_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&vou_dev->queue);
 	spin_lock_init(&vou_dev->lock);
 	mutex_init(&vou_dev->fop_lock);
-	atomic_set(&vou_dev->use_count, 0);
 	vou_dev->pdata = vou_pdata;
 	vou_dev->status = SH_VOU_IDLE;
 
-- 
2.1.4

