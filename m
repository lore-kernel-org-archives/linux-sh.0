From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:15 +0000
Subject: [RFC 4/5] [media] rcar-vin: add video_device
Message-Id: <1452778216-31978-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a struct video_device with some basic ioctls. The ioctls to handle
the format settings are at this stage incomplete.
---
 drivers/media/platform/rcar-vin.c | 167 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin.c b/drivers/media/platform/rcar-vin.c
index a062287..810e6e4 100644
--- a/drivers/media/platform/rcar-vin.c
+++ b/drivers/media/platform/rcar-vin.c
@@ -45,6 +45,7 @@ struct rcar_vin {
 
 	struct platform_device *pdev;
 	struct v4l2_device v4l2_dev;
+	struct video_device vdev;
 	struct mutex lock;
 	struct v4l2_pix_format format;
 
@@ -240,12 +241,154 @@ const struct rcar_vin_format *rcar_vin_get_format_by_fourcc(u32 fourcc)
 }
 
 /* -----------------------------------------------------------------------------
+ * V4L2 ioctls
+ */
+
+static int rcar_vin_querycap(struct file *file, void *priv,
+		struct v4l2_capability *cap)
+{
+	struct rcar_vin *vin = video_drvdata(file);
+
+	strlcpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
+	strlcpy(cap->card, "R_Car_VIN", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+			dev_name(&vin->pdev->dev));
+	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
+	return 0;
+}
+
+static int rcar_vin_try_fmt_vid_cap(struct file *file, void *priv,
+		struct v4l2_format *f)
+{
+	struct rcar_vin *vin = video_drvdata(file);
+	struct v4l2_pix_format *pix = &f->fmt.pix;
+	const struct rcar_vin_format *format;
+
+	/* Only single-plane capture is supported so far */
+	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	format = rcar_vin_get_format_by_fourcc(pix->pixelformat);
+	if (IS_ERR(format))
+		return -EINVAL;
+
+	/* TODO */
+
+	return 0;
+
+}
+
+static int rcar_vin_s_fmt_vid_cap(struct file *file, void *priv,
+		struct v4l2_format *f)
+{
+	struct rcar_vin *vin = video_drvdata(file);
+	int ret;
+
+	ret = rcar_vin_try_fmt_vid_cap(file, priv, f);
+	if (ret)
+		return ret;
+
+	if (vb2_is_busy(&vin->queue))
+		return -EBUSY;
+
+	/* TODO: change format */
+	vin->format = f->fmt.pix;
+
+	return 0;
+}
+
+static int rcar_vin_g_fmt_vid_cap(struct file *file, void *priv,
+		struct v4l2_format *f)
+{
+	struct rcar_vin *vin = video_drvdata(file);
+
+	f->fmt.pix = vin->format;
+	return 0;
+}
+
+static int rcar_vin_enum_fmt_vid_cap(struct file *file, void *priv,
+		struct v4l2_fmtdesc *f)
+{
+	if (f->index >= ARRAY_SIZE(rcar_vin_formats))
+		return -EINVAL;
+
+	f->pixelformat = rcar_vin_formats[f->index].fourcc;
+	strlcpy(f->description, rcar_vin_formats[f->index].description,
+			sizeof(f->description));
+	return 0;
+}
+
+static int rcar_vin_enum_input(struct file *file, void *priv,
+		struct v4l2_input *i)
+{
+	if (i->index != 0)
+		return -EINVAL;
+
+	i->type = V4L2_INPUT_TYPE_CAMERA;
+	strlcpy(i->name, "Camera", sizeof(i->name));
+
+	return 0;
+}
+
+static int rcar_vin_g_input(struct file *file, void *priv, unsigned int *i)
+{
+	*i = 0;
+
+	return 0;
+}
+
+static int rcar_vin_s_input(struct file *file, void *priv, unsigned int i)
+{
+	if (i > 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops rcar_vin_ioctl_ops = {
+	.vidioc_querycap		= rcar_vin_querycap,
+	.vidioc_try_fmt_vid_cap		= rcar_vin_try_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap		= rcar_vin_g_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap		= rcar_vin_s_fmt_vid_cap,
+	.vidioc_enum_fmt_vid_cap	= rcar_vin_enum_fmt_vid_cap,
+
+	.vidioc_enum_input		= rcar_vin_enum_input,
+	.vidioc_g_input			= rcar_vin_g_input,
+	.vidioc_s_input			= rcar_vin_s_input,
+
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+
+	.vidioc_log_status = v4l2_ctrl_log_status,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static const struct v4l2_file_operations rcar_vin_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= video_ioctl2,
+	.open		= v4l2_fh_open,
+	.release	= vb2_fop_release,
+	.poll		= vb2_fop_poll,
+	.mmap		= vb2_fop_mmap,
+};
+
+
+/* -----------------------------------------------------------------------------
  * Platform Device Driver
  */
 
 static int rcar_vin_probe(struct platform_device *pdev)
 {
 	struct rcar_vin *vin;
+	struct video_device *vdev;
 	struct vb2_queue *q;
 	struct resource *mem;
 	int irq, ret;
@@ -320,12 +463,30 @@ static int rcar_vin_probe(struct platform_device *pdev)
 	spin_lock_init(&vin->qlock);
 
 	/* Initialize the video_device structure */
-	/* TODO */
+	vdev = &vin->vdev;
+	strlcpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
+
+	/* FIXME: is empty releas OK */
+	vdev->release = video_device_release_empty;
+	vdev->fops = &rcar_vin_fops;
+	vdev->ioctl_ops = &rcar_vin_ioctl_ops;
+	vdev->lock = &vin->lock;
+	vdev->queue = q;
+	vdev->v4l2_dev = &vin->v4l2_dev;
+	video_set_drvdata(vdev, vin);
+
+	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	if (ret)
+		goto free_ctx;
 
 	platform_set_drvdata(pdev, vin);
 
+	v4l2_info(&vin->v4l2_dev, "Device registered as /dev/video%d\n",
+			vdev->num);
 	return 0;
 
+free_ctx:
+	vb2_dma_contig_cleanup_ctx(vin->alloc_ctx);
 free_hdl:
 	v4l2_device_unregister(&vin->v4l2_dev);
 disable_dev:
@@ -336,6 +497,10 @@ static int rcar_vin_remove(struct platform_device *pdev)
 {
 	struct rcar_vin *vin = platform_get_drvdata(pdev);
 
+	v4l2_info(&vin->v4l2_dev, "Removing /dev/video%d\n", vin->vdev.num);
+
+	video_unregister_device(&vin->vdev);
+
 	vb2_dma_contig_cleanup_ctx(vin->alloc_ctx);
 	v4l2_device_unregister(&vin->v4l2_dev);
 	return 0;
-- 
2.7.0

