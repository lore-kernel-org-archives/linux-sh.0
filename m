From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:40:11 +0000
Subject: [PATCH/RFC 33/48] vb2: Add helper function to check for request buffers
Message-Id: <1450341626-6695-34-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The vb2_queue_has_request() function will check whether a buffer has
been prepared for the given request ID.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/v4l2-core/videobuf2-v4l2.c | 17 +++++++++++++++++
 include/media/videobuf2-v4l2.h           |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-v4l2.c b/drivers/media/v4l2-core/videobuf2-v4l2.c
index 2c8776891535..0db7d67092ab 100644
--- a/drivers/media/v4l2-core/videobuf2-v4l2.c
+++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
@@ -753,6 +753,23 @@ void vb2_queue_release(struct vb2_queue *q)
 }
 EXPORT_SYMBOL_GPL(vb2_queue_release);
 
+bool vb2_queue_has_request(struct vb2_queue *q, unsigned int request)
+{
+	unsigned int i;
+
+	for (i = 0; i < q->num_buffers; i++) {
+		struct vb2_buffer *vb = q->bufs[i];
+		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+		if (vb->state = VB2_BUF_STATE_PREPARED &&
+		    vbuf->request = request)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(vb2_queue_has_request);
+
 /**
  * vb2_poll() - implements poll userspace operation
  * @q:		videobuf2 queue
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 48d6a34dcdb4..7cb428fc66ad 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -68,6 +68,8 @@ int vb2_streamoff(struct vb2_queue *q, enum v4l2_buf_type type);
 int __must_check vb2_queue_init(struct vb2_queue *q);
 void vb2_queue_release(struct vb2_queue *q);
 
+bool vb2_queue_has_request(struct vb2_queue *q, unsigned int request);
+
 unsigned int vb2_poll(struct vb2_queue *q, struct file *file, poll_table *wait);
 size_t vb2_read(struct vb2_queue *q, char __user *data, size_t count,
 		loff_t *ppos, int nonblock);
-- 
2.4.10

