From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:34 +0000
Subject: [PATCH/RFT 1/7] v4l: subdev: Add pad config allocator and init
Message-Id: <1445263660-6945-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@linaro.org>

Add a new subdev operation to initialize a subdev pad config array, and
a helper function to allocate and initialize the array. This can be used
by bridge drivers to implement try format based on subdev pad
operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@linaro.org>
Acked-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 19 ++++++++++++++++++-
 include/media/v4l2-subdev.h           | 10 ++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 83615b8..951a9cf 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -35,7 +35,7 @@
 static int subdev_fh_init(struct v4l2_subdev_fh *fh, struct v4l2_subdev *sd)
 {
 #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
-	fh->pad = kzalloc(sizeof(*fh->pad) * sd->entity.num_pads, GFP_KERNEL);
+	fh->pad = v4l2_subdev_alloc_pad_config(sd);
 	if (fh->pad = NULL)
 		return -ENOMEM;
 #endif
@@ -569,6 +569,23 @@ int v4l2_subdev_link_validate(struct media_link *link)
 		sink, link, &source_fmt, &sink_fmt);
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate);
+
+struct v4l2_subdev_pad_config *v4l2_subdev_alloc_pad_config(struct v4l2_subdev *sd)
+{
+	struct v4l2_subdev_pad_config *cfg;
+
+	if (!sd->entity.num_pads)
+		return NULL;
+
+	cfg = kcalloc(sd->entity.num_pads, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return NULL;
+
+	v4l2_subdev_call(sd, pad, init_cfg, cfg);
+
+	return cfg;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_alloc_pad_config);
 #endif /* CONFIG_MEDIA_CONTROLLER */
 
 void v4l2_subdev_init(struct v4l2_subdev *sd, const struct v4l2_subdev_ops *ops)
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index b273cf9..e1e25fa 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -604,6 +604,8 @@ struct v4l2_subdev_pad_config {
  *                  may be adjusted by the subdev driver to device capabilities.
  */
 struct v4l2_subdev_pad_ops {
+	void (*init_cfg)(struct v4l2_subdev *sd,
+			 struct v4l2_subdev_pad_config *cfg);
 	int (*enum_mbus_code)(struct v4l2_subdev *sd,
 			      struct v4l2_subdev_pad_config *cfg,
 			      struct v4l2_subdev_mbus_code_enum *code);
@@ -798,7 +800,15 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_format *source_fmt,
 				      struct v4l2_subdev_format *sink_fmt);
 int v4l2_subdev_link_validate(struct media_link *link);
+
+struct v4l2_subdev_pad_config *v4l2_subdev_alloc_pad_config(struct v4l2_subdev *sd);
+
+static inline void v4l2_subdev_free_pad_config(struct v4l2_subdev_pad_config *cfg)
+{
+	kfree(cfg);
+}
 #endif /* CONFIG_MEDIA_CONTROLLER */
+
 void v4l2_subdev_init(struct v4l2_subdev *sd,
 		      const struct v4l2_subdev_ops *ops);
 
-- 
2.6.1

