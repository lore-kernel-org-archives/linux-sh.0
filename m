From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 08 Jul 2014 09:41:12 +0000
Subject: [PATCH 2/4] media: rcar_vin: Ensure all in-flight buffers are returned to error state before stoppin
Message-Id: <1404812474-7627-3-git-send-email-ian.molton@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ian.molton@codethink.co.uk, g.liakhovetski@gmx.de, m.chehab@samsung.com, vladimir.barinov@cogentembedded.com, magnus.damm@gmail.com, horms@verge.net.au, linux-sh@vger.kernel.org

Videobuf2 complains about buffers that are still marked ACTIVE (in use by the driver) following a call to stop_streaming().

This patch returns all active buffers to state ERROR prior to stopping.

Note: this introduces a (non fatal) race condition as the stream is not guaranteed to be stopped at this point.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: William Towle <william.towle@codethink.co.uk>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 7154500..06ce705 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -513,8 +513,14 @@ static void rcar_vin_stop_streaming(struct vb2_queue *vq)
 	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
 	struct rcar_vin_priv *priv = ici->priv;
 	struct list_head *buf_head, *tmp;
+	int i;
 
 	spin_lock_irq(&priv->lock);
+
+	for (i = 0; i < vq->num_buffers; ++i)
+		if (vq->bufs[i]->state = VB2_BUF_STATE_ACTIVE)
+			vb2_buffer_done(vq->bufs[i], VB2_BUF_STATE_ERROR);
+
 	list_for_each_safe(buf_head, tmp, &priv->capture)
 		list_del_init(buf_head);
 	spin_unlock_irq(&priv->lock);
-- 
1.9.1

