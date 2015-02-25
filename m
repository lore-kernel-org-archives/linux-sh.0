From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:50 +0000
Subject: [PATCH 30/38] drm: rcar-du: Switch page flip to atomic helpers
Message-Id: <1424901298-6829-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The atomic page flip helper implements the page flip operation using
asynchronous commits.

As the legacy page flip was the last CRTC operation that needed direct
access to plane setup, the plane setup functions can now become private
to the plane implementation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 55 +++++++++------------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.c |  6 ++--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  3 --
 3 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 8a44d37f1716..2a1119b52c2a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -436,14 +436,6 @@ void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_start(rcrtc);
 }
 
-static void rcar_du_crtc_update_base(struct rcar_du_crtc *rcrtc)
-{
-	struct drm_crtc *crtc = &rcrtc->crtc;
-
-	rcar_du_plane_compute_base(rcrtc->plane, crtc->primary->fb);
-	rcar_du_plane_update_base(rcrtc->plane);
-}
-
 /* -----------------------------------------------------------------------------
  * CRTC Functions
  */
@@ -485,12 +477,25 @@ static bool rcar_du_crtc_mode_fixup(struct drm_crtc *crtc,
 
 static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
 {
+	struct drm_pending_vblank_event *event = crtc->state->event;
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+	struct drm_device *dev = rcrtc->crtc.dev;
+	unsigned long flags;
 
 	/* We need to access the hardware during atomic update, acquire a
 	 * reference to the CRTC.
 	 */
 	rcar_du_crtc_get(rcrtc);
+
+	if (event) {
+		event->pipe = rcrtc->index;
+
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		rcrtc->event = event;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
 }
 
 static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc)
@@ -515,43 +520,11 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.atomic_flush = rcar_du_crtc_atomic_flush,
 };
 
-static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
-				  struct drm_framebuffer *fb,
-				  struct drm_pending_vblank_event *event,
-				  uint32_t page_flip_flags)
-{
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-	struct drm_device *dev = rcrtc->crtc.dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-	if (rcrtc->event != NULL) {
-		spin_unlock_irqrestore(&dev->event_lock, flags);
-		return -EBUSY;
-	}
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-
-	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
-
-	crtc->primary->fb = fb;
-	rcar_du_crtc_update_base(rcrtc);
-
-	if (event) {
-		event->pipe = rcrtc->index;
-		drm_crtc_vblank_get(crtc);
-		spin_lock_irqsave(&dev->event_lock, flags);
-		rcrtc->event = event;
-		spin_unlock_irqrestore(&dev->event_lock, flags);
-	}
-
-	return 0;
-}
-
 static const struct drm_crtc_funcs crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
-	.page_flip = rcar_du_crtc_page_flip,
+	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index ff087f7de88e..9176ac451438 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -129,7 +129,7 @@ static void rcar_du_plane_release(struct rcar_du_plane *plane)
 	plane->hwindex = -1;
 }
 
-void rcar_du_plane_update_base(struct rcar_du_plane *plane)
+static void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 {
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int src_x = plane->plane.state->src_x >> 16;
@@ -182,8 +182,8 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	}
 }
 
-void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
-				struct drm_framebuffer *fb)
+static void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
+				       struct drm_framebuffer *fb)
 {
 	struct drm_gem_cma_object *gem;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 3420ff07f2c6..9b77a638863f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -62,8 +62,5 @@ struct rcar_du_planes {
 int rcar_du_planes_init(struct rcar_du_group *rgrp);
 
 void rcar_du_plane_setup(struct rcar_du_plane *plane);
-void rcar_du_plane_update_base(struct rcar_du_plane *plane);
-void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
-				struct drm_framebuffer *fb);
 
 #endif /* __RCAR_DU_PLANE_H__ */
-- 
2.0.5

