From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 11 Jun 2013 08:23:29 +0000
Subject: [PATCH v10 02/21] soc-camera: add host clock callbacks to start and stop the master clock
Message-Id: <1370939028-8352-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370939028-8352-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370939028-8352-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Currently soc-camera uses a single camera host callback to activate the
interface master clock and to configure the interface for a specific
client. However, during probing we might not have the information about
a client, we just need to activate the clock. Add new camera host driver
callbacks to only start and stop the clock without and client-specific
configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/soc_camera/soc_camera.c |   19 +++++++++++++++++--
 include/media/soc_camera.h                     |    2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index 832f059..df90565 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -513,10 +513,23 @@ static int soc_camera_add_device(struct soc_camera_device *icd)
 	if (ici->icd)
 		return -EBUSY;
 
+	if (ici->ops->clock_start) {
+		ret = ici->ops->clock_start(ici);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = ici->ops->add(icd);
-	if (!ret)
-		ici->icd = icd;
+	if (ret < 0)
+		goto eadd;
+
+	ici->icd = icd;
 
+	return 0;
+
+eadd:
+	if (ici->ops->clock_stop)
+		ici->ops->clock_stop(ici);
 	return ret;
 }
 
@@ -528,6 +541,8 @@ static void soc_camera_remove_device(struct soc_camera_device *icd)
 		return;
 
 	ici->ops->remove(icd);
+	if (ici->ops->clock_stop)
+		ici->ops->clock_stop(ici);
 	ici->icd = NULL;
 }
 
diff --git a/include/media/soc_camera.h b/include/media/soc_camera.h
index 5a46ce2..64415ee 100644
--- a/include/media/soc_camera.h
+++ b/include/media/soc_camera.h
@@ -74,6 +74,8 @@ struct soc_camera_host_ops {
 	struct module *owner;
 	int (*add)(struct soc_camera_device *);
 	void (*remove)(struct soc_camera_device *);
+	int (*clock_start)(struct soc_camera_host *);
+	void (*clock_stop)(struct soc_camera_host *);
 	/*
 	 * .get_formats() is called for each client device format, but
 	 * .put_formats() is only called once. Further, if any of the calls to
-- 
1.7.2.5

