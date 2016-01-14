From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:16 +0000
Subject: [RFC 5/5] [media] rcar-vin: hookup subdeivce using v4l2-async
Message-Id: <1452778216-31978-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reuse the bindings from soc_camera and for deferred registration of
subdevices. Also defer registration of the video_device itself until all
subdeivce are found.

The parsing is a bit more complex than it needs at this point. I plan to
extend it later to support more then one subdevice.
---
 drivers/media/platform/rcar-vin.c | 172 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rcar-vin.c b/drivers/media/platform/rcar-vin.c
index 810e6e4..a851d30 100644
--- a/drivers/media/platform/rcar-vin.c
+++ b/drivers/media/platform/rcar-vin.c
@@ -40,6 +40,14 @@ struct rcar_vin_format {
 	u8 bpp;
 };
 
+struct rcar_vin_graph_entity {
+	struct device_node *node;
+	struct media_entity *entity;
+
+	struct v4l2_async_subdev asd;
+	struct v4l2_subdev *subdev;
+};
+
 struct rcar_vin {
 	void __iomem *base;
 
@@ -56,7 +64,11 @@ struct rcar_vin {
 	struct list_head buf_list;
 	unsigned field;
 	unsigned sequence;
+	struct v4l2_async_notifier notifier;
+	struct rcar_vin_graph_entity entity;
+	unsigned int num_subdevs;
 };
+#define notifier_to_vin(n) container_of(n, struct rcar_vin, notifier)
 
 struct rcar_vin_buffer {
 	struct vb2_buffer vb;
@@ -385,6 +397,159 @@ static const struct v4l2_file_operations rcar_vin_fops = {
  * Platform Device Driver
  */
 
+static int rcar_vin_graph_notify_complete(struct v4l2_async_notifier *notifier)
+{
+	struct rcar_vin *vin = notifier_to_vin(notifier);
+	int ret;
+
+
+	dev_dbg(&vin->pdev->dev, "notify complete, all subdevs registered\n");
+
+	ret = v4l2_device_register_subdev_nodes(&vin->v4l2_dev);
+	if (ret < 0) {
+		dev_err(&vin->pdev->dev, "failed to register subdev nodes\n");
+		return ret;
+	}
+
+	ret = video_register_device(&vin->vdev, VFL_TYPE_GRABBER, -1);
+	if (ret) {
+		dev_err(&vin->pdev->dev, "failed to register video device\n");
+		vb2_dma_contig_cleanup_ctx(vin->alloc_ctx);
+		v4l2_device_unregister(&vin->v4l2_dev);
+		return ret;
+	}
+
+	v4l2_info(&vin->v4l2_dev, "Device registered as /dev/video%d\n",
+			vin->vdev.num);
+	return 0;
+}
+
+static int rcar_vin_graph_notify_bound(struct v4l2_async_notifier *notifier,
+		struct v4l2_subdev *subdev,
+		struct v4l2_async_subdev *asd)
+{
+	struct rcar_vin *vin = notifier_to_vin(notifier);
+
+	dev_dbg(&vin->pdev->dev, "subdev %s bound\n", subdev->name);
+	vin->entity.entity = &subdev->entity;
+	vin->entity.subdev = subdev;
+	return 0;
+}
+
+static int rcar_vin_graph_parse_one(struct rcar_vin *vin,
+		struct device_node *node)
+{
+	struct device_node *remote;
+	struct device_node *ep = NULL;
+	struct device_node *next;
+	int ret = 0;
+
+	dev_dbg(vin->v4l2_dev.dev, "parsing node %s\n", node->full_name);
+
+	while (1) {
+		next = of_graph_get_next_endpoint(node, ep);
+		if (!next)
+			break;
+
+		of_node_put(ep);
+		ep = next;
+
+		dev_dbg(vin->v4l2_dev.dev, "handling endpoint %s\n",
+				ep->full_name);
+
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			ret = -EINVAL;
+			break;
+		}
+
+
+		/* Skip entities that we have already processed. */
+		if (remote = vin->pdev->dev.of_node) {
+			of_node_put(remote);
+			continue;
+		}
+
+		/* so we now have a remote node to connect */
+
+		/* TODO: Support more than one subdev */
+		if (!vin->entity.node) {
+			vin->entity.node = remote;
+			vin->entity.asd.match_type = V4L2_ASYNC_MATCH_OF;
+			vin->entity.asd.match.of.node = remote;
+			vin->num_subdevs++;
+		}
+	}
+	of_node_put(ep);
+	return ret;
+}
+
+static int rcar_vin_graph_parse(struct rcar_vin *vin)
+{
+	return rcar_vin_graph_parse_one(vin, vin->pdev->dev.of_node);
+}
+
+static void rcar_vin_graph_cleanup(struct rcar_vin *vin)
+{
+	v4l2_async_notifier_unregister(&vin->notifier);
+
+	of_node_put(vin->entity.node);
+}
+
+static int rcar_vin_graph_init(struct rcar_vin *vin)
+{
+	struct v4l2_async_subdev **subdevs = NULL;
+	unsigned int num_subdevs;
+	int ret;
+
+	/* Parse the graph to extract a list of subdevice DT nodes. */
+	ret = rcar_vin_graph_parse(vin);
+	if (ret < 0) {
+		dev_err(&vin->pdev->dev, "graph parsing failed\n");
+		goto done;
+	}
+
+	if (!vin->num_subdevs) {
+		dev_err(&vin->pdev->dev, "no subdev found in graph\n");
+		goto done;
+	}
+
+	if (vin->num_subdevs != 1) {
+		dev_err(&vin->pdev->dev, "more then one subdev found in graph\n");
+		goto done;
+	}
+
+	/* Register the subdevices notifier. */
+	num_subdevs = vin->num_subdevs;
+	subdevs = devm_kzalloc(&vin->pdev->dev, sizeof(*subdevs) * num_subdevs,
+			GFP_KERNEL);
+	if (subdevs = NULL) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	subdevs[0] = &vin->entity.asd;
+
+	vin->notifier.subdevs = subdevs;
+	vin->notifier.num_subdevs = num_subdevs;
+	vin->notifier.bound = rcar_vin_graph_notify_bound;
+	vin->notifier.complete = rcar_vin_graph_notify_complete;
+
+	ret = v4l2_async_notifier_register(&vin->v4l2_dev, &vin->notifier);
+	if (ret < 0) {
+		dev_err(&vin->pdev->dev, "notifier registration failed\n");
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	if (ret < 0)
+		rcar_vin_graph_cleanup(vin);
+
+	return ret;
+}
+
 static int rcar_vin_probe(struct platform_device *pdev)
 {
 	struct rcar_vin *vin;
@@ -475,14 +640,13 @@ static int rcar_vin_probe(struct platform_device *pdev)
 	vdev->v4l2_dev = &vin->v4l2_dev;
 	video_set_drvdata(vdev, vin);
 
-	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
-	if (ret)
+	/* Parse and defer subdeivce registration */
+	ret = rcar_vin_graph_init(vin);
+	if (ret < 0)
 		goto free_ctx;
 
 	platform_set_drvdata(pdev, vin);
 
-	v4l2_info(&vin->v4l2_dev, "Device registered as /dev/video%d\n",
-			vdev->num);
 	return 0;
 
 free_ctx:
-- 
2.7.0

