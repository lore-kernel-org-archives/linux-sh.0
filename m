From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:38 +0000
Subject: [PATCH 18/38] drm: rcar-du: Handle primary plane config through atomic plane ops
Message-Id: <1424901298-6829-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Use the new CRTC atomic transitional helpers drm_helper_crtc_mode_set()
and drm_helper_crtc_mode_set_base() to implement the CRTC .mode_set and
.mode_set_base operations. This delegates primary plane configuration to
the plane .atomic_update and .atomic_disable operations, removing
duplicate code from the CRTC implementation.

There is now no code path available to the driver in which to drop the
reference to the CRTC acquired in the .prepare() operation if an error
then occurs. The driver thus now leaks a reference if an error occurs
during mode set. So be it, this will be fixed in a further step of the
atomic update transition.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 81 +++++----------------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.c |  8 ++--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  3 --
 3 files changed, 14 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 3d862a894b17..169558a3ab40 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -105,7 +105,7 @@ static void rcar_du_crtc_put(struct rcar_du_crtc *rcrtc)
 
 static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 {
-	const struct drm_display_mode *mode = &rcrtc->crtc.mode;
+	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
 	unsigned long mode_clock = mode->clock * 1000;
 	unsigned long clk;
 	u32 value;
@@ -368,7 +368,6 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	 * switching to atomic updates completely.
 	 */
 	mutex_lock(&rcrtc->group->planes.lock);
-	rcrtc->plane->enabled = true;
 	rcar_du_crtc_update_planes(crtc);
 	mutex_unlock(&rcrtc->group->planes.lock);
 
@@ -412,11 +411,6 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_wait_page_flip(rcrtc);
 	drm_crtc_vblank_off(crtc);
 
-	mutex_lock(&rcrtc->group->planes.lock);
-	rcrtc->plane->enabled = false;
-	rcar_du_crtc_update_planes(crtc);
-	mutex_unlock(&rcrtc->group->planes.lock);
-
 	/* Select switch sync mode. This stops display operation and configures
 	 * the HSYNC and VSYNC signals as inputs.
 	 */
@@ -492,58 +486,20 @@ static void rcar_du_crtc_mode_prepare(struct drm_crtc *crtc)
 	 */
 	rcar_du_crtc_get(rcrtc);
 
-	/* Stop the CRTC and release the plane. Force the DPMS mode to off as a
-	 * result.
-	 */
+	/* Stop the CRTC, force the DPMS mode to off as a result. */
 	rcar_du_crtc_stop(rcrtc);
-	rcar_du_plane_release(rcrtc->plane);
 
 	rcrtc->dpms = DRM_MODE_DPMS_OFF;
+	rcrtc->outputs = 0;
 }
 
-static int rcar_du_crtc_mode_set(struct drm_crtc *crtc,
-				 struct drm_display_mode *mode,
-				 struct drm_display_mode *adjusted_mode,
-				 int x, int y,
-				 struct drm_framebuffer *old_fb)
+static void rcar_du_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-	struct rcar_du_device *rcdu = rcrtc->group->dev;
-	const struct rcar_du_format_info *format;
-	int ret;
-
-	format = rcar_du_format_info(crtc->primary->fb->pixel_format);
-	if (format = NULL) {
-		dev_dbg(rcdu->dev, "mode_set: unsupported format %08x\n",
-			crtc->primary->fb->pixel_format);
-		ret = -EINVAL;
-		goto error;
-	}
-
-	ret = rcar_du_plane_reserve(rcrtc->plane, format);
-	if (ret < 0)
-		goto error;
-
-	rcrtc->plane->format = format;
-
-	rcrtc->plane->src_x = x;
-	rcrtc->plane->src_y = y;
-	rcrtc->plane->width = mode->hdisplay;
-	rcrtc->plane->height = mode->vdisplay;
-
-	rcar_du_plane_compute_base(rcrtc->plane, crtc->primary->fb);
-
-	rcrtc->outputs = 0;
-
-	return 0;
-
-error:
-	/* There's no rollback/abort operation to clean up in case of error. We
-	 * thus need to release the reference to the CRTC acquired in prepare()
-	 * here.
+	/* No-op. We should configure the display timings here, but as we're
+	 * called with the CRTC disabled clocks might be off, and we thus can't
+	 * access the hardware. Let's just configure everything when enabling
+	 * the CRTC.
 	 */
-	rcar_du_crtc_put(rcrtc);
-	return ret;
 }
 
 static void rcar_du_crtc_mode_commit(struct drm_crtc *crtc)
@@ -558,25 +514,9 @@ static void rcar_du_crtc_mode_commit(struct drm_crtc *crtc)
 	rcrtc->dpms = DRM_MODE_DPMS_ON;
 }
 
-static int rcar_du_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
-				      struct drm_framebuffer *old_fb)
-{
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-
-	rcrtc->plane->src_x = x;
-	rcrtc->plane->src_y = y;
-
-	rcar_du_crtc_update_base(rcrtc);
-
-	return 0;
-}
-
 static void rcar_du_crtc_disable(struct drm_crtc *crtc)
 {
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-
 	rcar_du_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
-	rcar_du_plane_release(rcrtc->plane);
 }
 
 static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
@@ -608,8 +548,9 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.mode_fixup = rcar_du_crtc_mode_fixup,
 	.prepare = rcar_du_crtc_mode_prepare,
 	.commit = rcar_du_crtc_mode_commit,
-	.mode_set = rcar_du_crtc_mode_set,
-	.mode_set_base = rcar_du_crtc_mode_set_base,
+	.mode_set = drm_helper_crtc_mode_set,
+	.mode_set_nofb = rcar_du_crtc_mode_set_nofb,
+	.mode_set_base = drm_helper_crtc_mode_set_base,
 	.disable = rcar_du_crtc_disable,
 	.atomic_begin = rcar_du_crtc_atomic_begin,
 	.atomic_flush = rcar_du_crtc_atomic_flush,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 03995c15bbe3..d4682ac7db03 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -78,8 +78,8 @@ static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
 	return ret;
 }
 
-int rcar_du_plane_reserve(struct rcar_du_plane *plane,
-			  const struct rcar_du_format_info *format)
+static int rcar_du_plane_reserve(struct rcar_du_plane *plane,
+				 const struct rcar_du_format_info *format)
 {
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int i;
@@ -112,7 +112,7 @@ done:
 	return ret;
 }
 
-void rcar_du_plane_release(struct rcar_du_plane *plane)
+static void rcar_du_plane_release(struct rcar_du_plane *plane)
 {
 	struct rcar_du_group *rgrp = plane->group;
 
@@ -363,7 +363,6 @@ static void rcar_du_plane_disable(struct rcar_du_plane *rplane)
 
 	mutex_lock(&rplane->group->planes.lock);
 	rplane->enabled = false;
-	rcar_du_crtc_update_planes(rplane->crtc);
 	mutex_unlock(&rplane->group->planes.lock);
 
 	rcar_du_plane_release(rplane);
@@ -411,7 +410,6 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 
 	mutex_lock(&rplane->group->planes.lock);
 	rplane->enabled = true;
-	rcar_du_crtc_update_planes(rplane->crtc);
 	mutex_unlock(&rplane->group->planes.lock);
 }
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 813b3212392a..55d2f55faece 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -73,8 +73,5 @@ void rcar_du_plane_setup(struct rcar_du_plane *plane);
 void rcar_du_plane_update_base(struct rcar_du_plane *plane);
 void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
 				struct drm_framebuffer *fb);
-int rcar_du_plane_reserve(struct rcar_du_plane *plane,
-			  const struct rcar_du_format_info *format);
-void rcar_du_plane_release(struct rcar_du_plane *plane);
 
 #endif /* __RCAR_DU_PLANE_H__ */
-- 
2.0.5

