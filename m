From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 14 Jun 2013 19:08:21 +0000
Subject: [PATCH v11 11/21] soc-camera: don't attach the client to the host during probing
Message-Id: <1371236911-15131-12-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1371236911-15131-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1371236911-15131-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

During client probing we only have to turn on the host's clock, no need to
actually attach the client to the host.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/soc_camera/soc_camera.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index e503f03..ac98bcb 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -1207,7 +1207,7 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 		ssdd->reset(icd->pdev);
 
 	mutex_lock(&ici->host_lock);
-	ret = soc_camera_add_device(icd);
+	ret = ici->ops->clock_start(ici);
 	mutex_unlock(&ici->host_lock);
 	if (ret < 0)
 		goto eadd;
@@ -1280,7 +1280,7 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 		icd->field		= mf.field;
 	}
 
-	soc_camera_remove_device(icd);
+	ici->ops->clock_stop(ici);
 
 	mutex_unlock(&ici->host_lock);
 
@@ -1303,7 +1303,7 @@ eadddev:
 	icd->vdev = NULL;
 evdc:
 	mutex_lock(&ici->host_lock);
-	soc_camera_remove_device(icd);
+	ici->ops->clock_stop(ici);
 	mutex_unlock(&ici->host_lock);
 eadd:
 	v4l2_ctrl_handler_free(&icd->ctrl_handler);
-- 
1.7.2.5

