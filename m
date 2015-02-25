From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:30 +0000
Subject: [PATCH 10/38] drm: rcar-du: Reorder CRTC functions
Message-Id: <1424901298-6829-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The next commit will need functions to be reordered to avoid forward
declarations. Do it separately to help review.

This only moves functions without any change to the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 142 +++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 25c7a998fc2c..e0562f2b3261 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -99,6 +99,10 @@ static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
 	clk_disable_unprepare(rcrtc->clock);
 }
 
+/* -----------------------------------------------------------------------------
+ * Hardware Setup
+ */
+
 static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 {
 	const struct drm_display_mode *mode = &rcrtc->crtc.mode;
@@ -256,6 +260,55 @@ void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 			    dspr);
 }
 
+/* -----------------------------------------------------------------------------
+ * Page Flip
+ */
+
+void rcar_du_crtc_cancel_page_flip(struct rcar_du_crtc *rcrtc,
+				   struct drm_file *file)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+
+	/* Destroy the pending vertical blanking event associated with the
+	 * pending page flip, if any, and disable vertical blanking interrupts.
+	 */
+	spin_lock_irqsave(&dev->event_lock, flags);
+	event = rcrtc->event;
+	if (event && event->base.file_priv = file) {
+		rcrtc->event = NULL;
+		event->base.destroy(&event->base);
+		drm_vblank_put(dev, rcrtc->index);
+	}
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc)
+{
+	struct drm_pending_vblank_event *event;
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	event = rcrtc->event;
+	rcrtc->event = NULL;
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	if (event = NULL)
+		return;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	drm_send_vblank_event(dev, rcrtc->index, event);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	drm_vblank_put(dev, rcrtc->index);
+}
+
+/* -----------------------------------------------------------------------------
+ * Start/Stop and Suspend/Resume
+ */
+
 static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
@@ -350,6 +403,10 @@ static void rcar_du_crtc_update_base(struct rcar_du_crtc *rcrtc)
 	rcar_du_plane_update_base(rcrtc->plane);
 }
 
+/* -----------------------------------------------------------------------------
+ * CRTC Functions
+ */
+
 static void rcar_du_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
@@ -485,65 +542,6 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.disable = rcar_du_crtc_disable,
 };
 
-void rcar_du_crtc_cancel_page_flip(struct rcar_du_crtc *rcrtc,
-				   struct drm_file *file)
-{
-	struct drm_pending_vblank_event *event;
-	struct drm_device *dev = rcrtc->crtc.dev;
-	unsigned long flags;
-
-	/* Destroy the pending vertical blanking event associated with the
-	 * pending page flip, if any, and disable vertical blanking interrupts.
-	 */
-	spin_lock_irqsave(&dev->event_lock, flags);
-	event = rcrtc->event;
-	if (event && event->base.file_priv = file) {
-		rcrtc->event = NULL;
-		event->base.destroy(&event->base);
-		drm_vblank_put(dev, rcrtc->index);
-	}
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-}
-
-static void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc)
-{
-	struct drm_pending_vblank_event *event;
-	struct drm_device *dev = rcrtc->crtc.dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-	event = rcrtc->event;
-	rcrtc->event = NULL;
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-
-	if (event = NULL)
-		return;
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-	drm_send_vblank_event(dev, rcrtc->index, event);
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-
-	drm_vblank_put(dev, rcrtc->index);
-}
-
-static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
-{
-	struct rcar_du_crtc *rcrtc = arg;
-	irqreturn_t ret = IRQ_NONE;
-	u32 status;
-
-	status = rcar_du_crtc_read(rcrtc, DSSR);
-	rcar_du_crtc_write(rcrtc, DSRCR, status & DSRCR_MASK);
-
-	if (status & DSSR_FRM) {
-		drm_handle_vblank(rcrtc->crtc.dev, rcrtc->index);
-		rcar_du_crtc_finish_page_flip(rcrtc);
-		ret = IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
 static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
 				  struct drm_framebuffer *fb,
 				  struct drm_pending_vblank_event *event,
@@ -580,6 +578,32 @@ static const struct drm_crtc_funcs crtc_funcs = {
 	.page_flip = rcar_du_crtc_page_flip,
 };
 
+/* -----------------------------------------------------------------------------
+ * Interrupt Handling
+ */
+
+static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
+{
+	struct rcar_du_crtc *rcrtc = arg;
+	irqreturn_t ret = IRQ_NONE;
+	u32 status;
+
+	status = rcar_du_crtc_read(rcrtc, DSSR);
+	rcar_du_crtc_write(rcrtc, DSRCR, status & DSRCR_MASK);
+
+	if (status & DSSR_FRM) {
+		drm_handle_vblank(rcrtc->crtc.dev, rcrtc->index);
+		rcar_du_crtc_finish_page_flip(rcrtc);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
 int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 {
 	static const unsigned int mmio_offsets[] = {
-- 
2.0.5

