From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:26 +0000
Subject: [PATCH 07/14] media: soc-camera: support deferred probing of clients
Message-Id: <1348754853-28619-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Currently soc-camera doesn't work with independently registered I2C client
devices, it has to register them itself. This patch adds support for such
configurations, in which case client drivers have to request deferred
probing until their host becomes available and enables the data interface.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/soc_camera/soc_camera.c |  255 ++++++++++++++++++------
 include/media/soc_camera.h                     |    2 +
 2 files changed, 197 insertions(+), 60 deletions(-)

diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index b98e602..997be15 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -50,6 +50,9 @@ static LIST_HEAD(hosts);
 static LIST_HEAD(devices);
 static DEFINE_MUTEX(list_lock);		/* Protects the list of hosts */
 
+static int soc_camera_video_start(struct soc_camera_device *icd);
+static int video_dev_create(struct soc_camera_device *icd);
+
 static struct soc_camera_device *soc_camera_device_find(struct soc_camera_link *icl)
 {
 	struct soc_camera_device *icd;
@@ -1110,15 +1113,168 @@ static void scan_add_host(struct soc_camera_host *ici)
 	mutex_unlock(&ici->host_lock);
 }
 
+/*
+ * FIXME: with internally created (I2C) clients the whole host scanning process
+ * is happening synchronously, i.e. we return from the scanning routine and
+ * complete host probing only after all clients have been enumerated. This
+ * allows us to lock the ->host_lock for the whole scan duration and thus
+ * prevent the user-space from interfering with the probing between single
+ * clients. This locking is necessary, because otherwise on a host with multiple
+ * clients, after a video device node has been registered for one of them, a
+ * user-space process, triggered by hotplug can try to access the first client
+ * and thereby occupy the host, which will disturb probing of further clients.
+ * With externally registered clients (host_wait = true) we use (I2C) bus
+ * notifications to complete client probing. Those notifications are called
+ * asynchronously after the host probing routine has returned. Besides, it can
+ * happen, that the notification is called much later or never at all. In this
+ * case we cannot keep the host locked until all client notifications have been
+ * called.
+ */
+static int soc_camera_probe_finish(struct soc_camera_device *icd)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct v4l2_subdev *sd;
+	struct v4l2_mbus_framefmt mf;
+	int ret;
+
+	sd = soc_camera_to_subdev(icd);
+	sd->grp_id = soc_camera_grp_id(icd);
+	v4l2_set_subdev_hostdata(sd, icd);
+
+	ret = v4l2_ctrl_add_handler(&icd->ctrl_handler, sd->ctrl_handler);
+	if (ret < 0)
+		return ret;
+
+	/* At this point client .probe() should have run already */
+	ret = soc_camera_init_user_formats(icd);
+	if (ret < 0)
+		return ret;
+
+	icd->field = V4L2_FIELD_ANY;
+
+	/*
+	 * ..._video_start() will create a device node, video_register_device()
+	 * itself is protected against concurrent open() calls, but we also have
+	 * to protect our data.
+	 */
+	mutex_lock(&icd->video_lock);
+
+	ret = soc_camera_video_start(icd);
+	if (ret < 0)
+		goto evidstart;
+
+	/* Try to improve our guess of a reasonable window format */
+	ret = ici->ops->add(icd);
+	if (ret < 0)
+		goto eadd;
+	if (!v4l2_subdev_call(sd, video, g_mbus_fmt, &mf)) {
+		icd->user_width		= mf.width;
+		icd->user_height	= mf.height;
+		icd->colorspace		= mf.colorspace;
+		icd->field		= mf.field;
+	}
+
+	ici->ops->remove(icd);
+
+	mutex_unlock(&icd->video_lock);
+
+	return 0;
+
+eadd:
+	video_unregister_device(icd->vdev);
+	icd->vdev = NULL;
+evidstart:
+	mutex_unlock(&icd->video_lock);
+	soc_camera_free_user_formats(icd);
+
+	return ret;
+}
+
 #ifdef CONFIG_I2C_BOARDINFO
-static int soc_camera_init_i2c(struct soc_camera_device *icd,
+static int soc_camera_i2c_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct soc_camera_device *icd = container_of(nb, struct soc_camera_device, notifier);
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct soc_camera_link *icl = to_soc_camera_link(icd);
+	struct i2c_adapter *adap = NULL;
+	struct v4l2_subdev *subdev;
+	int ret;
+
+	if (client->addr != icl->board_info->addr ||
+	    client->adapter->nr != icl->i2c_adapter_id)
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		client->dev.platform_data = icl;
+
+		return NOTIFY_OK;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		adap = i2c_get_adapter(icl->i2c_adapter_id);
+		if (!adap)
+			break;
+
+		if (!try_module_get(dev->driver->owner))
+			/* clean up */
+			break;
+
+		subdev = i2c_get_clientdata(client);
+
+		if (v4l2_device_register_subdev(&ici->v4l2_dev, subdev))
+			subdev = NULL;
+
+		module_put(client->driver->driver.owner);
+
+		if (!subdev)
+			break;
+		client = v4l2_get_subdevdata(subdev);
+		icd->control = &client->dev;
+		mutex_lock(&ici->host_lock);
+		ret = soc_camera_probe_finish(icd);
+		mutex_unlock(&ici->host_lock);
+		if (ret < 0)
+			break;
+
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	if (adap)
+		i2c_put_adapter(adap);
+	if (icd->vdev) {
+		video_device_release(icd->vdev);
+		icd->vdev = NULL;
+	}
+	regulator_bulk_free(icl->num_regulators, icl->regulators);
+	v4l2_ctrl_handler_free(&icd->ctrl_handler);
+
+	return NOTIFY_DONE;
+}
+
+static int soc_camera_i2c_init(struct soc_camera_device *icd,
 			       struct soc_camera_link *icl)
 {
 	struct i2c_client *client;
-	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
-	struct i2c_adapter *adap = i2c_get_adapter(icl->i2c_adapter_id);
+	struct soc_camera_host *ici;
+	struct i2c_adapter *adap;
 	struct v4l2_subdev *subdev;
 
+	if (icl->host_wait) {
+		int ret;
+		icd->notifier.notifier_call = soc_camera_i2c_notify;
+		ret = bus_register_notifier(&i2c_bus_type, &icd->notifier);
+		if (!ret)
+			return -EPROBE_DEFER;
+		return ret;
+	}
+
+	ici = to_soc_camera_host(icd->parent);
+	adap = i2c_get_adapter(icl->i2c_adapter_id);
+
 	if (!adap) {
 		dev_err(icd->pdev, "Cannot get I2C adapter #%d. No driver?\n",
 			icl->i2c_adapter_id);
@@ -1144,7 +1300,7 @@ ei2cga:
 	return -ENODEV;
 }
 
-static void soc_camera_free_i2c(struct soc_camera_device *icd)
+static void soc_camera_i2c_free(struct soc_camera_device *icd)
 {
 	struct i2c_client *client  		to_i2c_client(to_soc_camera_control(icd));
@@ -1155,21 +1311,38 @@ static void soc_camera_free_i2c(struct soc_camera_device *icd)
 	i2c_unregister_device(client);
 	i2c_put_adapter(adap);
 }
+
+static void soc_camera_i2c_reprobe(struct soc_camera_device *icd)
+{
+	struct i2c_client *client +		to_i2c_client(to_soc_camera_control(icd));
+	struct i2c_adapter *adap;
+
+	if (icd->notifier.notifier_call = soc_camera_i2c_notify)
+		bus_unregister_notifier(&i2c_bus_type, &icd->notifier);
+
+	if (!icd->control)
+		return;
+
+	adap = client->adapter;
+
+	icd->control = NULL;
+	v4l2_device_unregister_subdev(i2c_get_clientdata(client));
+	/* Put device back in deferred-probing state */
+	i2c_unregister_device(client);
+	i2c_new_device(adap, icd->link->board_info);
+}
 #else
-#define soc_camera_init_i2c(icd, icl)	(-ENODEV)
-#define soc_camera_free_i2c(icd)	do {} while (0)
+#define soc_camera_i2c_init(icd, icl)	(-ENODEV)
+#define soc_camera_i2c_free(icd)	do {} while (0)
+#define soc_camera_i2c_reprobe(icd)	do {} while (0)
 #endif
 
-static int soc_camera_video_start(struct soc_camera_device *icd);
-static int video_dev_create(struct soc_camera_device *icd);
 /* Called during host-driver probe */
 static int soc_camera_probe(struct soc_camera_device *icd)
 {
-	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
 	struct soc_camera_link *icl = to_soc_camera_link(icd);
 	struct device *control = NULL;
-	struct v4l2_subdev *sd;
-	struct v4l2_mbus_framefmt mf;
 	int ret;
 
 	dev_info(icd->pdev, "Probing %s\n", dev_name(icd->pdev));
@@ -1201,7 +1374,9 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 
 	/* Non-i2c cameras, e.g., soc_camera_platform, have no board_info */
 	if (icl->board_info) {
-		ret = soc_camera_init_i2c(icd, icl);
+		ret = soc_camera_i2c_init(icd, icl);
+		if (ret = -EPROBE_DEFER)
+			return 0;
 		if (ret < 0)
 			goto eadddev;
 	} else if (!icl->add_device || !icl->del_device) {
@@ -1228,58 +1403,15 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 		}
 	}
 
-	sd = soc_camera_to_subdev(icd);
-	sd->grp_id = soc_camera_grp_id(icd);
-	v4l2_set_subdev_hostdata(sd, icd);
-
-	if (v4l2_ctrl_add_handler(&icd->ctrl_handler, sd->ctrl_handler))
-		goto ectrl;
-
-	/* At this point client .probe() should have run already */
-	ret = soc_camera_init_user_formats(icd);
-	if (ret < 0)
-		goto eiufmt;
-
-	icd->field = V4L2_FIELD_ANY;
-
-	/*
-	 * ..._video_start() will create a device node, video_register_device()
-	 * itself is protected against concurrent open() calls, but we also have
-	 * to protect our data.
-	 */
-	mutex_lock(&icd->video_lock);
-
-	ret = soc_camera_video_start(icd);
-	if (ret < 0)
-		goto evidstart;
-
-	/* Try to improve our guess of a reasonable window format */
-	ret = ici->ops->add(icd);
+	ret = soc_camera_probe_finish(icd);
 	if (ret < 0)
-		goto eadd;
-	if (!v4l2_subdev_call(sd, video, g_mbus_fmt, &mf)) {
-		icd->user_width		= mf.width;
-		icd->user_height	= mf.height;
-		icd->colorspace		= mf.colorspace;
-		icd->field		= mf.field;
-	}
-
-	ici->ops->remove(icd);
-
-	mutex_unlock(&icd->video_lock);
+		goto efinish;
 
 	return 0;
 
-eadd:
-	video_unregister_device(icd->vdev);
-	icd->vdev = NULL;
-evidstart:
-	mutex_unlock(&icd->video_lock);
-	soc_camera_free_user_formats(icd);
-eiufmt:
-ectrl:
+efinish:
 	if (icl->board_info) {
-		soc_camera_free_i2c(icd);
+		soc_camera_i2c_free(icd);
 	} else {
 		icl->del_device(icd);
 		module_put(control->driver->owner);
@@ -1315,7 +1447,10 @@ static int soc_camera_remove(struct soc_camera_device *icd)
 	}
 
 	if (icl->board_info) {
-		soc_camera_free_i2c(icd);
+		if (icl->host_wait)
+			soc_camera_i2c_reprobe(icd);
+		else
+			soc_camera_i2c_free(icd);
 	} else {
 		struct device_driver *drv = to_soc_camera_control(icd)->driver;
 		if (drv) {
diff --git a/include/media/soc_camera.h b/include/media/soc_camera.h
index 72342fe..1d4e3c5 100644
--- a/include/media/soc_camera.h
+++ b/include/media/soc_camera.h
@@ -50,6 +50,7 @@ struct soc_camera_device {
 	int use_count;
 	struct mutex video_lock;	/* Protects device data */
 	struct file *streamer;		/* stream owner */
+	struct notifier_block notifier;	/* Bus-event notifier */
 	union {
 		struct videobuf_queue vb_vidq;
 		struct vb2_queue vb2_vidq;
@@ -125,6 +126,7 @@ struct soc_camera_link {
 	int i2c_adapter_id;
 	struct i2c_board_info *board_info;
 	const char *module_name;
+	bool host_wait;
 	void *priv;
 
 	/* Optional regulators that have to be managed on power on/off events */
-- 
1.7.2.5

