From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:13 +0000
Subject: [RFC 2/5] [media] rcar-vin: hookup a vb2queue
Message-Id: <1452778216-31978-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hookup a vb2queue to the skeleton. This is based of the pci skeleton
v4l2 driver from Documentation.
---
 drivers/media/platform/rcar-vin.c | 162 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin.c b/drivers/media/platform/rcar-vin.c
index 834ef2c..06616d4 100644
--- a/drivers/media/platform/rcar-vin.c
+++ b/drivers/media/platform/rcar-vin.c
@@ -40,6 +40,138 @@ struct rcar_vin {
 	struct platform_device *pdev;
 	struct v4l2_device v4l2_dev;
 	struct mutex lock;
+	struct v4l2_pix_format format;
+
+	struct vb2_queue queue;
+	struct vb2_alloc_ctx *alloc_ctx;
+
+	spinlock_t qlock;
+	struct list_head buf_list;
+	unsigned field;
+	unsigned sequence;
+};
+
+struct rcar_vin_buffer {
+	struct vb2_buffer vb;
+	struct list_head list;
+};
+#define vb_to_buffer(dev) container_of(dev, struct rcar_vin_buffer, vb)
+
+/* -----------------------------------------------------------------------------
+ * DMA functions
+ */
+
+static void return_all_buffers(struct rcar_vin *vin,
+		enum vb2_buffer_state state)
+{
+	struct rcar_vin_buffer *buf, *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vin->qlock, flags);
+	list_for_each_entry_safe(buf, node, &vin->buf_list, list) {
+		vb2_buffer_done(&buf->vb, state);
+		list_del(&buf->list);
+	}
+	spin_unlock_irqrestore(&vin->qlock, flags);
+}
+
+static int rcar_vin_queue_setup(struct vb2_queue *vq, const void *parg,
+		unsigned int *nbuffers, unsigned int *nplanes,
+		unsigned int sizes[], void *alloc_ctxs[])
+
+{
+	const struct v4l2_format *fmt = parg;
+	struct rcar_vin *vin = vb2_get_drv_priv(vq);
+
+	vin->field = vin->format.field;
+	if (vin->field = V4L2_FIELD_ALTERNATE) {
+		/*
+		 * You cannot use read() with FIELD_ALTERNATE since the field
+		 * information (TOP/BOTTOM) cannot be passed back to the user.
+		 */
+		if (vb2_fileio_is_active(vq))
+			return -EINVAL;
+		vin->field = V4L2_FIELD_TOP;
+	}
+
+	if (vq->num_buffers + *nbuffers < 3)
+		*nbuffers = 3 - vq->num_buffers;
+
+	if (fmt && fmt->fmt.pix.sizeimage < vin->format.sizeimage)
+		return -EINVAL;
+	*nplanes = 1;
+	sizes[0] = fmt ? fmt->fmt.pix.sizeimage : vin->format.sizeimage;
+	alloc_ctxs[0] = vin->alloc_ctx;
+	return 0;
+};
+
+static int rcar_vin_buffer_prepare(struct vb2_buffer *vb)
+{
+	struct rcar_vin *vin = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long size = vin->format.sizeimage;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(&vin->pdev->dev, "buffer too small (%lu < %lu)\n",
+				vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+	return 0;
+}
+
+static void rcar_vin_buffer_queue(struct vb2_buffer *vb)
+{
+	unsigned long flags;
+	struct rcar_vin *vin = vb2_get_drv_priv(vb->vb2_queue);
+	struct rcar_vin_buffer *buf = vb_to_buffer(vb);
+
+	spin_lock_irqsave(&vin->qlock, flags);
+	list_add_tail(&buf->list, &vin->buf_list);
+
+	/* TODO: Update any DMA pointers if necessary */
+
+	spin_unlock_irqrestore(&vin->qlock, flags);
+}
+
+static int rcar_vin_start_streaming(struct vb2_queue *vq, unsigned int count)
+{
+	struct rcar_vin *vin = vb2_get_drv_priv(vq);
+	int ret = 0;
+
+	vin->sequence = 0;
+
+	/* TODO: start DMA */
+
+	if (ret) {
+		/*
+		 * In case of an error, return all active buffers to the
+		 * QUEUED state
+		 */
+		return_all_buffers(vin, VB2_BUF_STATE_QUEUED);
+	}
+	return ret;
+}
+
+static void rcar_vin_stop_streaming(struct vb2_queue *vq)
+{
+	struct rcar_vin *vin = vb2_get_drv_priv(vq);
+
+	/* TODO: stop DMA */
+
+	/* Release all active buffers */
+	return_all_buffers(vin, VB2_BUF_STATE_ERROR);
+
+}
+
+static struct vb2_ops rcar_vin_qops = {
+	.queue_setup            = rcar_vin_queue_setup,
+	.buf_prepare            = rcar_vin_buffer_prepare,
+	.buf_queue              = rcar_vin_buffer_queue,
+	.start_streaming        = rcar_vin_start_streaming,
+	.stop_streaming         = rcar_vin_stop_streaming,
+	.wait_prepare           = vb2_ops_wait_prepare,
+	.wait_finish            = vb2_ops_wait_finish,
 };
 
 static irqreturn_t rcar_vin_irq(int irq, void *dev_id)
@@ -55,6 +187,7 @@ static irqreturn_t rcar_vin_irq(int irq, void *dev_id)
 static int rcar_vin_probe(struct platform_device *pdev)
 {
 	struct rcar_vin *vin;
+	struct vb2_queue *q;
 	struct resource *mem;
 	int irq, ret;
 
@@ -101,7 +234,31 @@ static int rcar_vin_probe(struct platform_device *pdev)
 	/* TODO */
 
 	/* Initialize the vb2 queue */
-	/* TODO */
+	q = &vin->queue;
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes = VB2_MMAP | VB2_USERPTR;
+	q->drv_priv = vin;
+	q->buf_struct_size = sizeof(struct rcar_vin_buffer);
+	q->ops = &rcar_vin_qops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &vin->lock;
+	/* Not set in soc-camera but in skel
+	 * q->min_buffers_needed = 2;
+	 * q->gfp_flags = GFP_DMA32;
+	 */
+	ret = vb2_queue_init(q);
+	if (ret)
+		goto free_hdl;
+
+	vin->alloc_ctx = vb2_dma_contig_init_ctx(&pdev->dev);
+	if (IS_ERR(vin->alloc_ctx)) {
+		dev_err(&pdev->dev, "Can't allocate buffer context");
+		ret = PTR_ERR(vin->alloc_ctx);
+		goto free_hdl;
+	}
+	INIT_LIST_HEAD(&vin->buf_list);
+	spin_lock_init(&vin->qlock);
 
 	/* Initialize the video_device structure */
 	/* TODO */
@@ -110,6 +267,8 @@ static int rcar_vin_probe(struct platform_device *pdev)
 
 	return 0;
 
+free_hdl:
+	v4l2_device_unregister(&vin->v4l2_dev);
 disable_dev:
 	return ret;
 }
@@ -118,6 +277,7 @@ static int rcar_vin_remove(struct platform_device *pdev)
 {
 	struct rcar_vin *vin = platform_get_drvdata(pdev);
 
+	vb2_dma_contig_cleanup_ctx(vin->alloc_ctx);
 	v4l2_device_unregister(&vin->v4l2_dev);
 	return 0;
 }
-- 
2.7.0

