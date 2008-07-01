From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 12:47:16 +0000
Subject: [PATCH 04/07] soc_camera: Remove unused file lock pointer
Message-Id: <20080701124716.30446.82032.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: akpm@linux-foundation.org, lethal@linux-sh.org, mchehab@infradead.org, linux-sh@vger.kernel.org

This icf->lock pointer is not needed anymore since we now let the
soc_camera host setup the videobuf queue.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/pxa_camera.c |    4 +---
 drivers/media/video/soc_camera.c |    2 --
 include/media/soc_camera.h       |    1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

--- 0008/drivers/media/video/pxa_camera.c
+++ work/drivers/media/video/pxa_camera.c	2008-06-12 14:36:07.000000000 +0900
@@ -990,12 +990,10 @@ static int pxa_camera_file_alloc(struct 
 		to_soc_camera_host(icf->icd->dev.parent);
 	struct pxa_camera_dev *pcdev = ici->priv;
 
-	icf->lock = &pcdev->lock;
-
 	/* We must pass NULL as dev pointer, then all pci_* dma operations
 	 * transform to normal dma_* ones. */
 	videobuf_queue_sg_init(&icf->vb_vidq, &pxa_videobuf_ops,
-			       NULL, icf->lock,
+			       NULL, &pcdev->lock,
 			       V4L2_BUF_TYPE_VIDEO_CAPTURE, V4L2_FIELD_NONE,
 			       sizeof(struct pxa_buffer), icf->icd);
 	return 0;
--- 0007/drivers/media/video/soc_camera.c
+++ work/drivers/media/video/soc_camera.c	2008-06-12 14:37:33.000000000 +0900
@@ -236,7 +236,6 @@ static int soc_camera_open(struct inode 
 eiciadd:
 	if (ici->ops->file_free)
 		ici->ops->file_free(icf);
-	icf->lock = NULL;
 esla:
 	module_put(ici->ops->owner);
 emgi:
@@ -260,7 +259,6 @@ static int soc_camera_close(struct inode
 		ici->ops->remove(icd);
 	if (ici->ops->file_free)
 		ici->ops->file_free(icf);
-	icf->lock = NULL;
 	module_put(icd->ops->owner);
 	module_put(ici->ops->owner);
 	mutex_unlock(&video_lock);
--- 0008/include/media/soc_camera.h
+++ work/include/media/soc_camera.h	2008-06-12 14:35:21.000000000 +0900
@@ -48,7 +48,6 @@ struct soc_camera_device {
 struct soc_camera_file {
 	struct soc_camera_device *icd;
 	struct videobuf_queue vb_vidq;
-	spinlock_t *lock;
 };
 
 struct soc_camera_host {
