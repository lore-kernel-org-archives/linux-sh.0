From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:25 +0000
Subject: [PATCH 06/14] media: soc-camera: prepare for asynchronous client probing
Message-Id: <1348754853-28619-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Currently the soc-camera core uses the fact, that client's .probe() method
is run inside of soc_camera_probe(). In such a case, the core can first
attach the client to a host, then trigger client's probing, check its
result and detach the client from the host to allow further clients to be
probed and / or used with it. However, if a client probes at a different
time, there is no way to know when to attach it to and when to detach it
from the host. To solve this we allow the client to decide itself, when it
hae to be attached and detached.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/i2c/soc_camera/mt9t112.c         |   13 ++++-
 drivers/media/platform/soc_camera/soc_camera.c |   70 +++++++++++++++++++++---
 include/media/soc_camera.h                     |    3 +
 3 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/soc_camera/mt9t112.c b/drivers/media/i2c/soc_camera/mt9t112.c
index de7cd83..dfa03f0 100644
--- a/drivers/media/i2c/soc_camera/mt9t112.c
+++ b/drivers/media/i2c/soc_camera/mt9t112.c
@@ -1036,17 +1036,22 @@ static struct v4l2_subdev_ops mt9t112_subdev_ops = {
 	.video	= &mt9t112_subdev_video_ops,
 };
 
-static int mt9t112_camera_probe(struct i2c_client *client)
+static int mt9t112_camera_probe(struct i2c_client *client,
+				struct soc_camera_link *icl)
 {
 	struct mt9t112_priv *priv = to_mt9t112(client);
 	const char          *devname;
 	int                  chipid;
 	int		     ret;
 
-	ret = mt9t112_s_power(&priv->subdev, 1);
+	ret = soc_camera_device_attach(icl);
 	if (ret < 0)
 		return ret;
 
+	ret = mt9t112_s_power(&priv->subdev, 1);
+	if (ret < 0)
+		goto detach;
+
 	/*
 	 * check and show chip ID
 	 */
@@ -1071,6 +1076,8 @@ static int mt9t112_camera_probe(struct i2c_client *client)
 
 done:
 	mt9t112_s_power(&priv->subdev, 0);
+detach:
+	soc_camera_device_detach(icl);
 	return ret;
 }
 
@@ -1100,7 +1107,7 @@ static int mt9t112_probe(struct i2c_client *client,
 
 	v4l2_i2c_subdev_init(&priv->subdev, client, &mt9t112_subdev_ops);
 
-	ret = mt9t112_camera_probe(client);
+	ret = mt9t112_camera_probe(client, icl);
 	if (ret) {
 		kfree(priv);
 		return ret;
diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index 2f31ca0..b98e602 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -50,6 +50,58 @@ static LIST_HEAD(hosts);
 static LIST_HEAD(devices);
 static DEFINE_MUTEX(list_lock);		/* Protects the list of hosts */
 
+static struct soc_camera_device *soc_camera_device_find(struct soc_camera_link *icl)
+{
+	struct soc_camera_device *icd;
+
+	mutex_lock(&list_lock);
+
+	list_for_each_entry(icd, &devices, list)
+		if (icd->link = icl)
+			break;
+
+	mutex_unlock(&list_lock);
+
+	if (&icd->list = &devices)
+		return NULL;
+
+	return icd;
+}
+
+int soc_camera_device_attach(struct soc_camera_link *icl)
+{
+	struct soc_camera_device *icd = soc_camera_device_find(icl);
+	if (icd) {
+		struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+		bool must_lock = icd->vdev != NULL && video_is_registered(icd->vdev);
+		int ret;
+
+		if (must_lock)
+			mutex_lock(&ici->host_lock);
+		/* device must be linked to a host by now */
+		ret = ici->ops->add(icd);
+		if (must_lock)
+			mutex_unlock(&ici->host_lock);
+		return ret;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(soc_camera_device_attach);
+
+void soc_camera_device_detach(struct soc_camera_link *icl)
+{
+	struct soc_camera_device *icd = soc_camera_device_find(icl);
+
+	if (icd) {
+		struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+
+		/* device must be linked to a host by now */
+		ici->ops->remove(icd);
+	}
+}
+EXPORT_SYMBOL(soc_camera_device_detach);
+
 int soc_camera_power_on(struct device *dev, struct soc_camera_link *icl)
 {
 	int ret = regulator_bulk_enable(icl->num_regulators,
@@ -1142,10 +1194,6 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 	if (icl->reset)
 		icl->reset(icd->pdev);
 
-	ret = ici->ops->add(icd);
-	if (ret < 0)
-		goto eadd;
-
 	/* Must have icd->vdev before registering the device */
 	ret = video_dev_create(icd);
 	if (ret < 0)
@@ -1206,6 +1254,9 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 		goto evidstart;
 
 	/* Try to improve our guess of a reasonable window format */
+	ret = ici->ops->add(icd);
+	if (ret < 0)
+		goto eadd;
 	if (!v4l2_subdev_call(sd, video, g_mbus_fmt, &mf)) {
 		icd->user_width		= mf.width;
 		icd->user_height	= mf.height;
@@ -1219,6 +1270,9 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 
 	return 0;
 
+eadd:
+	video_unregister_device(icd->vdev);
+	icd->vdev = NULL;
 evidstart:
 	mutex_unlock(&icd->video_lock);
 	soc_camera_free_user_formats(icd);
@@ -1232,11 +1286,11 @@ ectrl:
 	}
 enodrv:
 eadddev:
-	video_device_release(icd->vdev);
-	icd->vdev = NULL;
+	if (icd->vdev) {
+		video_device_release(icd->vdev);
+		icd->vdev = NULL;
+	}
 evdc:
-	ici->ops->remove(icd);
-eadd:
 	regulator_bulk_free(icl->num_regulators, icl->regulators);
 ereg:
 	v4l2_ctrl_handler_free(&icd->ctrl_handler);
diff --git a/include/media/soc_camera.h b/include/media/soc_camera.h
index 6442edc..72342fe 100644
--- a/include/media/soc_camera.h
+++ b/include/media/soc_camera.h
@@ -259,6 +259,9 @@ unsigned long soc_camera_apply_board_flags(struct soc_camera_link *icl,
 int soc_camera_power_on(struct device *dev, struct soc_camera_link *icl);
 int soc_camera_power_off(struct device *dev, struct soc_camera_link *icl);
 
+int soc_camera_device_attach(struct soc_camera_link *icl);
+void soc_camera_device_detach(struct soc_camera_link *icl);
+
 static inline int soc_camera_set_power(struct device *dev,
 				       struct soc_camera_link *icl, bool on)
 {
-- 
1.7.2.5

