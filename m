From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:29 +0000
Subject: [PATCH 10/14] media: soc-camera: support OF cameras
Message-Id: <1348754853-28619-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

With OF we aren't getting platform data any more. To minimise changes we
create all the missing data ourselves, including compulsory struct
soc_camera_link objects. Host-client linking is now done, based on the OF
data. Media bus numbers also have to be assigned dynamically.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/soc_camera/soc_camera.c |  337 ++++++++++++++++++++++--
 include/media/soc_camera.h                     |    5 +
 2 files changed, 326 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index c2a5fa3..2a02215 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -23,6 +23,8 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -33,6 +35,7 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-dev.h>
+#include <media/v4l2-of.h>
 #include <media/videobuf-core.h>
 #include <media/videobuf2-core.h>
 #include <media/soc_mediabus.h>
@@ -46,12 +49,32 @@
 	 (icd)->vb_vidq.streaming :			\
 	 vb2_is_streaming(&(icd)->vb2_vidq))
 
+#define MAP_MAX_NUM 32
+static DECLARE_BITMAP(host_map, MAP_MAX_NUM);
+static DECLARE_BITMAP(device_map, MAP_MAX_NUM);
 static LIST_HEAD(hosts);
 static LIST_HEAD(devices);
-static DEFINE_MUTEX(list_lock);		/* Protects the list of hosts */
+/*
+ * Protects lists and bitmaps of hosts and devices.
+ * Lock nesting: Ok to take ->host_lock under list_lock.
+ */
+static DEFINE_MUTEX(list_lock);
+
+struct soc_camera_of_client {
+	struct soc_camera_link *icl;
+	struct v4l2_of_link of_link;
+	struct platform_device *pdev;
+	struct dev_archdata archdata;
+	struct device_node *link_node;
+	union {
+		struct i2c_board_info i2c_info;
+	};
+};
 
 static int soc_camera_video_start(struct soc_camera_device *icd);
 static int video_dev_create(struct soc_camera_device *icd);
+static void soc_camera_of_i2c_info(struct device_node *node,
+				   struct soc_camera_of_client *sofc);
 
 static struct soc_camera_device *soc_camera_device_find(struct soc_camera_link *icl)
 {
@@ -1099,6 +1122,7 @@ static void scan_add_host(struct soc_camera_host *ici)
 {
 	struct soc_camera_device *icd;
 
+	mutex_lock(&list_lock);
 	mutex_lock(&ici->host_lock);
 
 	list_for_each_entry(icd, &devices, list) {
@@ -1107,10 +1131,146 @@ static void scan_add_host(struct soc_camera_host *ici)
 
 			icd->parent = ici->v4l2_dev.dev;
 			ret = soc_camera_probe(icd);
+			/*
+			 * We could in principle destroy icd in the error case
+			 * here - it is useless, if it failed to probe
+			 */
 		}
 	}
 
 	mutex_unlock(&ici->host_lock);
+	mutex_unlock(&list_lock);
+}
+
+static struct soc_camera_of_client *soc_camera_of_alloc_client(const struct soc_camera_host *ici,
+							       struct device_node *node)
+{
+	struct soc_camera_of_client *sofc = devm_kzalloc(ici->v4l2_dev.dev,
+						sizeof(*sofc), GFP_KERNEL);
+	struct soc_camera_link icl = {.host_wait = true,};
+	int i, ret;
+
+	if (!sofc)
+		return NULL;
+
+	mutex_lock(&list_lock);
+	i = find_first_zero_bit(device_map, MAP_MAX_NUM);
+	if (i < MAP_MAX_NUM)
+		set_bit(i, device_map);
+	mutex_unlock(&list_lock);
+	if (i >= MAP_MAX_NUM)
+		return NULL;
+	sofc->pdev = platform_device_alloc("soc-camera-pdrv", i);
+	if (!sofc->pdev)
+		return NULL;
+
+	icl.of_link = &sofc->of_link;
+	icl.bus_id = ici->nr;
+
+	ret = platform_device_add_data(sofc->pdev, &icl, sizeof(icl));
+	if (ret < 0)
+		return NULL;
+	sofc->icl = sofc->pdev->dev.platform_data;
+
+	soc_camera_of_i2c_info(node, sofc);
+
+	return sofc;
+}
+
+static int soc_camera_of_register_client(struct soc_camera_of_client *sofc)
+{
+	return platform_device_add(sofc->pdev);
+}
+
+struct soc_camera_wait_pdev {
+	struct notifier_block nb;
+	struct completion complete;
+	struct soc_camera_link *link;
+};
+
+static int wait_complete(struct notifier_block *nb,
+			 unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct soc_camera_wait_pdev *wait = container_of(nb,
+					struct soc_camera_wait_pdev, nb);
+
+	if (dev->platform_data = wait->link &&
+	    action = BUS_NOTIFY_BOUND_DRIVER) {
+		complete(&wait->complete);
+		return NOTIFY_OK;
+	}
+	return NOTIFY_DONE;
+}
+
+static void scan_of_host(struct soc_camera_host *ici)
+{
+	struct soc_camera_of_client *sofc;
+	struct soc_camera_device *icd;
+	struct device_node *node = NULL;
+
+	for (;;) {
+		struct soc_camera_wait_pdev wait = {
+			.nb.notifier_call = wait_complete,
+		};
+		int ret;
+
+		node = v4l2_of_get_next_link(ici->v4l2_dev.dev->of_node,
+					       node);
+		if (!node)
+			break;
+
+		if (ici->ops->of_node_internal &&
+		    ici->ops->of_node_internal(node)) {
+			/* No icd is needed for this link */
+			of_node_put(node);
+			continue;
+		}
+
+		sofc = soc_camera_of_alloc_client(ici, node);
+		if (!sofc) {
+			dev_err(ici->v4l2_dev.dev,
+				"%s(): failed to create a client device\n",
+				__func__);
+			of_node_put(node);
+			break;
+		}
+		v4l2_of_parse_link(node, &sofc->of_link);
+
+		init_completion(&wait.complete);
+		wait.link = sofc->icl;
+		bus_register_notifier(&platform_bus_type, &wait.nb);
+
+		ret = soc_camera_of_register_client(sofc);
+		if (ret < 0) {
+			/* Useless thing, but keep trying */
+			platform_device_put(sofc->pdev);
+			of_node_put(node);
+			continue;
+		}
+
+		wait_for_completion(&wait.complete);
+		/* soc_camera_pdrv_probe() probed successfully */
+		bus_unregister_notifier(&platform_bus_type, &wait.nb);
+
+		icd = platform_get_drvdata(sofc->pdev);
+		if (!icd) {
+			/* Cannot be... */
+			platform_device_put(sofc->pdev);
+			of_node_put(node);
+			continue;
+		}
+
+		mutex_lock(&ici->host_lock);
+		icd->parent = ici->v4l2_dev.dev;
+		ret = soc_camera_probe(icd);
+		mutex_unlock(&ici->host_lock);
+		sofc->link_node = node;
+		/*
+		 * We could destroy the icd in there error case here, but the
+		 * non-OF version doesn't do that, so, we can keep it around too
+		 */
+	}
 }
 
 /*
@@ -1191,6 +1351,77 @@ evidstart:
 }
 
 #ifdef CONFIG_I2C_BOARDINFO
+static void soc_camera_of_i2c_ifill(struct soc_camera_of_client *sofc,
+				    struct i2c_client *client)
+{
+	struct i2c_board_info *info = &sofc->i2c_info;
+	struct soc_camera_link *icl = sofc->icl;
+
+	/* on OF I2C devices platform_data = NULL */
+	info->flags = client->flags;
+	info->addr = client->addr;
+	info->irq = client->irq;
+	info->archdata = &sofc->archdata;
+
+	/* archdata is always empty on OF I2C devices */
+	strlcpy(info->type, client->name, sizeof(info->type));
+
+	icl->i2c_adapter_id = client->adapter->nr;
+}
+
+static void soc_camera_of_i2c_info(struct device_node *node,
+				   struct soc_camera_of_client *sofc)
+{
+	struct i2c_client *client;
+	struct soc_camera_link *icl = sofc->icl;
+	struct i2c_board_info *info = &sofc->i2c_info;
+	struct device_node *remote = v4l2_of_get_remote(node), *parent;
+
+	if (!remote)
+		return;
+
+	/* Check the bus */
+	parent = of_get_parent(remote);
+
+	if (of_node_cmp(parent->name, "i2c")) {
+		of_node_put(remote);
+		of_node_put(parent);
+		return;
+	}
+
+	info->of_node = remote;
+	icl->board_info = info;
+
+	client = of_find_i2c_device_by_node(remote);
+	/*
+	 * of_i2c_register_devices() took a reference to the OF node, it is not
+	 * dropped, when the I2C device is removed, so, we don't need an
+	 * additional reference.
+	 */
+	of_node_put(remote);
+	if (client) {
+		soc_camera_of_i2c_ifill(sofc, client);
+		put_device(&client->dev);
+	}
+
+	/* client hasn't attached to I2C yet */
+}
+
+static bool soc_camera_i2c_client_match(struct soc_camera_link *icl,
+					struct i2c_client *client)
+{
+	if (icl->of_link) {
+		struct i2c_client *expected = of_find_i2c_device_by_node(icl->board_info->of_node);
+
+		put_device(&expected->dev);
+
+		return expected = client;
+	}
+
+	return client->addr = icl->board_info->addr &&
+		client->adapter->nr = icl->i2c_adapter_id;
+}
+
 static int soc_camera_i2c_notify(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -1203,13 +1434,20 @@ static int soc_camera_i2c_notify(struct notifier_block *nb,
 	struct v4l2_subdev *subdev;
 	int ret;
 
-	if (client->addr != icl->board_info->addr ||
-	    client->adapter->nr != icl->i2c_adapter_id)
+	dev_dbg(dev, "%s(%lu): %x on %u\n", __func__, action,
+		client->addr, client->adapter->nr);
+
+	if (!soc_camera_i2c_client_match(icl, client))
 		return NOTIFY_DONE;
 
 	switch (action) {
 	case BUS_NOTIFY_BIND_DRIVER:
 		client->dev.platform_data = icl;
+		if (icl->of_link) {
+			struct soc_camera_of_client *sofc = container_of(icl->of_link,
+						struct soc_camera_of_client, of_link);
+			soc_camera_of_i2c_ifill(sofc, client);
+		}
 
 		return NOTIFY_OK;
 	case BUS_NOTIFY_BOUND_DRIVER:
@@ -1335,9 +1573,13 @@ static void soc_camera_i2c_reprobe(struct soc_camera_device *icd)
 #define soc_camera_i2c_init(icd, icl)	(-ENODEV)
 #define soc_camera_i2c_free(icd)	do {} while (0)
 #define soc_camera_i2c_reprobe(icd)	do {} while (0)
+static void soc_camera_of_i2c_info(struct device_node *node,
+				   struct soc_camera_of_client *sofc)
+{
+}
 #endif
 
-/* Called during host-driver probe */
+/* Called during host-driver probe with .host_lock held */
 static int soc_camera_probe(struct soc_camera_device *icd)
 {
 	struct soc_camera_link *icl = to_soc_camera_link(icd);
@@ -1458,6 +1700,18 @@ static int soc_camera_remove(struct soc_camera_device *icd)
 	}
 	soc_camera_free_user_formats(icd);
 
+	if (icl->of_link) {
+		struct soc_camera_of_client *sofc = container_of(icl->of_link,
+					struct soc_camera_of_client, of_link);
+		struct device_node *link = sofc->link_node;
+		/* Don't dead-lock: remove the device here under the lock */
+		clear_bit(sofc->pdev->id, device_map);
+		list_del(&icd->list);
+		if (link)
+			of_node_put(link);
+		platform_device_unregister(sofc->pdev);
+	}
+
 	return 0;
 }
 
@@ -1551,23 +1805,44 @@ int soc_camera_host_register(struct soc_camera_host *ici)
 	if (!ici->ops->enum_framesizes)
 		ici->ops->enum_framesizes = default_enum_framesizes;
 
+	mutex_init(&ici->host_lock);
+
 	mutex_lock(&list_lock);
-	list_for_each_entry(ix, &hosts, list) {
-		if (ix->nr = ici->nr) {
+	if (ici->nr = (unsigned char)-1) {
+		/* E.g. OF host: dynamic number */
+		/* TODO: consider using IDR */
+		ici->nr = find_first_zero_bit(host_map, MAP_MAX_NUM);
+		if (ici->nr >= MAP_MAX_NUM) {
 			ret = -EBUSY;
 			goto edevreg;
 		}
+	} else {
+		if (ici->nr >= MAP_MAX_NUM) {
+			ret = -EINVAL;
+			goto edevreg;
+		}
+
+		list_for_each_entry(ix, &hosts, list) {
+			if (ix->nr = ici->nr) {
+				ret = -EBUSY;
+				goto edevreg;
+			}
+		}
 	}
 
 	ret = v4l2_device_register(ici->v4l2_dev.dev, &ici->v4l2_dev);
 	if (ret < 0)
 		goto edevreg;
 
+	set_bit(ici->nr, host_map);
+
 	list_add_tail(&ici->list, &hosts);
 	mutex_unlock(&list_lock);
 
-	mutex_init(&ici->host_lock);
-	scan_add_host(ici);
+	if (!ici->v4l2_dev.dev->of_node)
+		scan_add_host(ici);
+	else
+		scan_of_host(ici);
 
 	return 0;
 
@@ -1580,15 +1855,18 @@ EXPORT_SYMBOL(soc_camera_host_register);
 /* Unregister all clients! */
 void soc_camera_host_unregister(struct soc_camera_host *ici)
 {
-	struct soc_camera_device *icd;
+	struct soc_camera_device *icd, *tmp;
 
 	mutex_lock(&list_lock);
 
+	clear_bit(ici->nr, host_map);
 	list_del(&ici->list);
-	list_for_each_entry(icd, &devices, list)
-		if (icd->iface = ici->nr && to_soc_camera_control(icd))
-			soc_camera_remove(icd);
 
+	list_for_each_entry_safe(icd, tmp, &devices, list)
+		if (icd->iface = ici->nr &&
+		    icd->parent = ici->v4l2_dev.dev &&
+		    (to_soc_camera_control(icd) || icd->link->host_wait))
+			soc_camera_remove(icd);
 	mutex_unlock(&list_lock);
 
 	v4l2_device_unregister(&ici->v4l2_dev);
@@ -1601,6 +1879,7 @@ static int soc_camera_device_register(struct soc_camera_device *icd)
 	struct soc_camera_device *ix;
 	int num = -1, i;
 
+	mutex_lock(&list_lock);
 	for (i = 0; i < 256 && num < 0; i++) {
 		num = i;
 		/* Check if this index is available on this interface */
@@ -1611,6 +1890,7 @@ static int soc_camera_device_register(struct soc_camera_device *icd)
 			}
 		}
 	}
+	mutex_unlock(&list_lock);
 
 	if (num < 0)
 		/*
@@ -1619,12 +1899,27 @@ static int soc_camera_device_register(struct soc_camera_device *icd)
 		 */
 		return -ENOMEM;
 
-	icd->devnum		= num;
-	icd->use_count		= 0;
-	icd->host_priv		= NULL;
+	icd->devnum	= num;
+	icd->use_count	= 0;
+	icd->host_priv	= NULL;
 	mutex_init(&icd->video_lock);
 
+	mutex_lock(&list_lock);
+	/*
+	 * Dynamically allocated devices set the bit earlier, but it doesn't hurt setting
+	 * it again
+	 */
+	i = to_platform_device(icd->pdev)->id;
+	if (i < 0)
+		/* One static (legacy) soc-camera platform device */
+		i = 0;
+	if (i >= MAP_MAX_NUM) {
+		mutex_unlock(&list_lock);
+		return -EBUSY;
+	}
+	set_bit(i, device_map);
 	list_add_tail(&icd->list, &devices);
+	mutex_unlock(&list_lock);
 
 	return 0;
 }
@@ -1741,11 +2036,21 @@ static int __devinit soc_camera_pdrv_probe(struct platform_device *pdev)
 static int __devexit soc_camera_pdrv_remove(struct platform_device *pdev)
 {
 	struct soc_camera_device *icd = platform_get_drvdata(pdev);
+	int i;
 
 	if (!icd)
 		return -EINVAL;
 
-	list_del(&icd->list);
+	i = pdev->id;
+	if (i < 0)
+		i = 0;
+
+	if (test_bit(i, device_map)) {
+		mutex_lock(&list_lock);
+		clear_bit(i, device_map);
+		list_del(&icd->list);
+		mutex_unlock(&list_lock);
+	}
 
 	return 0;
 }
diff --git a/include/media/soc_camera.h b/include/media/soc_camera.h
index 1d4e3c5..fbf6903 100644
--- a/include/media/soc_camera.h
+++ b/include/media/soc_camera.h
@@ -71,6 +71,8 @@ struct soc_camera_host {
 	struct soc_camera_host_ops *ops;
 };
 
+struct device_node;
+
 struct soc_camera_host_ops {
 	struct module *owner;
 	int (*add)(struct soc_camera_device *);
@@ -107,6 +109,7 @@ struct soc_camera_host_ops {
 	int (*set_parm)(struct soc_camera_device *, struct v4l2_streamparm *);
 	int (*enum_framesizes)(struct soc_camera_device *, struct v4l2_frmsizeenum *);
 	unsigned int (*poll)(struct file *, poll_table *);
+	bool (*of_node_internal)(const struct device_node *);
 };
 
 #define SOCAM_SENSOR_INVERT_PCLK	(1 << 0)
@@ -117,6 +120,7 @@ struct soc_camera_host_ops {
 
 struct i2c_board_info;
 struct regulator_bulk_data;
+struct v4l2_of_link;
 
 struct soc_camera_link {
 	/* Camera bus id, used to match a camera and a bus */
@@ -125,6 +129,7 @@ struct soc_camera_link {
 	unsigned long flags;
 	int i2c_adapter_id;
 	struct i2c_board_info *board_info;
+	struct v4l2_of_link *of_link;
 	const char *module_name;
 	bool host_wait;
 	void *priv;
-- 
1.7.2.5

