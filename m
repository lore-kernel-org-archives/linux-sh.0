From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 12:47:07 +0000
Subject: [PATCH 03/07] soc_camera: Remove vbq_ops and msize
Message-Id: <20080701124707.30446.214.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org, akpm@linux-foundation.org, lethal@linux-sh.org, mchehab@infradead.org

The struct soc_camera_host members vbq_ops and msize are not needed
anymore since we now let the soc_camera host manage the videobuf queue.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/pxa_camera.c |    2 --
 include/media/soc_camera.h       |    2 --
 2 files changed, 4 deletions(-)

--- 0007/drivers/media/video/pxa_camera.c
+++ work/drivers/media/video/pxa_camera.c	2008-06-12 14:30:25.000000000 +0900
@@ -1018,8 +1018,6 @@ static struct soc_camera_host_ops pxa_so
 /* Should be allocated dynamically too, but we have only one. */
 static struct soc_camera_host pxa_soc_camera_host = {
 	.drv_name		= PXA_CAM_DRV_NAME,
-	.vbq_ops		= &pxa_videobuf_ops,
-	.msize			= sizeof(struct pxa_buffer),
 	.ops			= &pxa_soc_camera_host_ops,
 };
 
--- 0007/include/media/soc_camera.h
+++ work/include/media/soc_camera.h	2008-06-12 14:30:18.000000000 +0900
@@ -55,8 +55,6 @@ struct soc_camera_host {
 	struct list_head list;
 	struct device dev;
 	unsigned char nr;				/* Host number */
-	size_t msize;
-	struct videobuf_queue_ops *vbq_ops;
 	void *priv;
 	char *drv_name;
 	struct soc_camera_host_ops *ops;
