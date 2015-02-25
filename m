From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:31 +0000
Subject: [PATCH 11/38] drm: rcar-du: Wait for page flip completion when turning the CRTC off
Message-Id: <1424901298-6829-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Turning a CRTC off will prevent a queued page flip from ever completing,
potentially confusing userspace. Wait for queued page flips to complete
before turning the CRTC off to avoid this.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 35 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index e0562f2b3261..7f5ae0269a61 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -300,11 +300,39 @@ static void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc)
 
 	spin_lock_irqsave(&dev->event_lock, flags);
 	drm_send_vblank_event(dev, rcrtc->index, event);
+	wake_up(&rcrtc->flip_wait);
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
 	drm_vblank_put(dev, rcrtc->index);
 }
 
+static bool rcar_du_crtc_page_flip_pending(struct rcar_du_crtc *rcrtc)
+{
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+	bool pending;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	pending = rcrtc->event != NULL;
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	return pending;
+}
+
+static void rcar_du_crtc_wait_page_flip(struct rcar_du_crtc *rcrtc)
+{
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+
+	if (wait_event_timeout(rcrtc->flip_wait,
+			       !rcar_du_crtc_page_flip_pending(rcrtc),
+			       msecs_to_jiffies(50)))
+		return;
+
+	dev_warn(rcdu->dev, "page flip timeout\n");
+
+	rcar_du_crtc_finish_page_flip(rcrtc);
+}
+
 /* -----------------------------------------------------------------------------
  * Start/Stop and Suspend/Resume
  */
@@ -365,6 +393,11 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	if (!rcrtc->started)
 		return;
 
+	/* Wait for page flip completion before stopping the CRTC as userspace
+	 * excepts page flips to eventually complete.
+	 */
+	rcar_du_crtc_wait_page_flip(rcrtc);
+
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcrtc->plane->enabled = false;
 	rcar_du_crtc_update_planes(crtc);
@@ -644,6 +677,8 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 		return -EPROBE_DEFER;
 	}
 
+	init_waitqueue_head(&rcrtc->flip_wait);
+
 	rcrtc->group = rgrp;
 	rcrtc->mmio_offset = mmio_offsets[index];
 	rcrtc->index = index;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index d2f89f7d2e5e..fb39e040f17b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -15,6 +15,7 @@
 #define __RCAR_DU_CRTC_H__
 
 #include <linux/mutex.h>
+#include <linux/wait.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
@@ -32,6 +33,8 @@ struct rcar_du_crtc {
 	bool started;
 
 	struct drm_pending_vblank_event *event;
+	wait_queue_head_t flip_wait;
+
 	unsigned int outputs;
 	int dpms;
 
-- 
2.0.5

