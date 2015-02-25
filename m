From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:37 +0000
Subject: [PATCH 17/38] drm: rcar-du: Implement planes atomic operations
Message-Id: <1424901298-6829-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Implement the CRTC .atomic_begin() and .atomic_flush() operations, the
plane .atomic_check(), .atomic_update() and operations, and use the
transitional atomic helpers to implement the plane update and disable
operations on top of the new atomic operations.

The plane setup code can't be moved out of the CRTC start function
completely yet, as the atomic code paths are not taken every time the
CRTC needs to be started. This results in some code duplication that
will be fixed after switching to atomic updates completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  37 +++++++-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 152 ++++++++++++++++++++++----------
 2 files changed, 141 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index c2ca2a302f44..3d862a894b17 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -357,12 +357,21 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_set_display_timing(rcrtc);
 	rcar_du_group_set_routing(rcrtc->group);
 
+	/* FIXME: Commit the planes state. This is required here as the CRTC can
+	 * be started from the DPMS and system resume handler, which don't go
+	 * through .atomic_plane_update() and .atomic_flush() to commit plane
+	 * state. Similarly a mode set operation without any update to planes
+	 * will not go through atomic plane configuration either. Additionally,
+	 * given that the plane state atomic commit occurs between CRTC disable
+	 * and enable, the hardware state could also be lost due to runtime PM,
+	 * requiring a full commit here. This will be fixed later after
+	 * switching to atomic updates completely.
+	 */
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcrtc->plane->enabled = true;
 	rcar_du_crtc_update_planes(crtc);
 	mutex_unlock(&rcrtc->group->planes.lock);
 
-	/* Setup planes. */
 	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes.planes); ++i) {
 		struct rcar_du_plane *plane = &rcrtc->group->planes.planes[i];
 
@@ -570,6 +579,30 @@ static void rcar_du_crtc_disable(struct drm_crtc *crtc)
 	rcar_du_plane_release(rcrtc->plane);
 }
 
+static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
+{
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+	/* We need to access the hardware during atomic update, acquire a
+	 * reference to the CRTC.
+	 */
+	rcar_du_crtc_get(rcrtc);
+}
+
+static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc)
+{
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+	/* We're done, apply the configuration and drop the reference acquired
+	 * in .atomic_begin().
+	 */
+	mutex_lock(&rcrtc->group->planes.lock);
+	rcar_du_crtc_update_planes(crtc);
+	mutex_unlock(&rcrtc->group->planes.lock);
+
+	rcar_du_crtc_put(rcrtc);
+}
+
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.dpms = rcar_du_crtc_dpms,
 	.mode_fixup = rcar_du_crtc_mode_fixup,
@@ -578,6 +611,8 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.mode_set = rcar_du_crtc_mode_set,
 	.mode_set_base = rcar_du_crtc_mode_set_base,
 	.disable = rcar_du_crtc_disable,
+	.atomic_begin = rcar_du_crtc_atomic_begin,
+	.atomic_flush = rcar_du_crtc_atomic_flush,
 };
 
 static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 4a0669fd8176..03995c15bbe3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -16,6 +16,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_plane_helper.h>
 
 #include "rcar_du_drv.h"
 #include "rcar_du_kms.h"
@@ -45,6 +46,38 @@ static void rcar_du_plane_write(struct rcar_du_group *rgrp,
 		      data);
 }
 
+static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
+				       const struct rcar_du_format_info *format)
+{
+	struct rcar_du_group *rgrp = plane->group;
+	unsigned int free;
+	unsigned int i;
+	int ret;
+
+	mutex_lock(&rgrp->planes.lock);
+
+	free = rgrp->planes.free;
+
+	if (plane->hwindex != -1) {
+		free |= 1 << plane->hwindex;
+		if (plane->format->planes = 2)
+			free |= 1 << ((plane->hwindex + 1) % 8);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rgrp->planes.planes); ++i) {
+		if (!(free & (1 << i)))
+			continue;
+
+		if (format->planes = 1 || free & (1 << ((i + 1) % 8)))
+			break;
+	}
+
+	ret = i = ARRAY_SIZE(rgrp->planes.planes) ? -EBUSY : 0;
+
+	mutex_unlock(&rgrp->planes.lock);
+	return ret;
+}
+
 int rcar_du_plane_reserve(struct rcar_du_plane *plane,
 			  const struct rcar_du_format_info *format)
 {
@@ -281,12 +314,8 @@ void rcar_du_plane_setup(struct rcar_du_plane *plane)
 	rcar_du_plane_update_base(plane);
 }
 
-static int
-rcar_du_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
-		       struct drm_framebuffer *fb, int crtc_x, int crtc_y,
-		       unsigned int crtc_w, unsigned int crtc_h,
-		       uint32_t src_x, uint32_t src_y,
-		       uint32_t src_w, uint32_t src_h)
+static int rcar_du_plane_atomic_check(struct drm_plane *plane,
+				      struct drm_plane_state *state)
 {
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 	struct rcar_du_device *rcdu = rplane->group->dev;
@@ -294,63 +323,43 @@ rcar_du_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 	unsigned int nplanes;
 	int ret;
 
-	if (plane->type != DRM_PLANE_TYPE_OVERLAY)
-		return -EINVAL;
+	if (!state->fb || !state->crtc)
+		return 0;
 
-	format = rcar_du_format_info(fb->pixel_format);
-	if (format = NULL) {
-		dev_dbg(rcdu->dev, "%s: unsupported format %08x\n", __func__,
-			fb->pixel_format);
+	if (state->src_w >> 16 != state->crtc_w ||
+	    state->src_h >> 16 != state->crtc_h) {
+		dev_dbg(rcdu->dev, "%s: scaling not supported\n", __func__);
 		return -EINVAL;
 	}
 
-	if (src_w >> 16 != crtc_w || src_h >> 16 != crtc_h) {
-		dev_dbg(rcdu->dev, "%s: scaling not supported\n", __func__);
+	format = rcar_du_format_info(state->fb->pixel_format);
+	if (format = NULL) {
+		dev_dbg(rcdu->dev, "%s: unsupported format %08x\n", __func__,
+			state->fb->pixel_format);
 		return -EINVAL;
 	}
 
 	nplanes = rplane->format ? rplane->format->planes : 0;
 
-	/* Reallocate hardware planes if the number of required planes has
-	 * changed.
+	/* If the number of required planes has changed we will need to
+	 * reallocate hardware planes. Ensure free planes are available.
 	 */
 	if (format->planes != nplanes) {
-		rcar_du_plane_release(rplane);
-		ret = rcar_du_plane_reserve(rplane, format);
-		if (ret < 0)
+		ret = rcar_du_plane_reserve_check(rplane, format);
+		if (ret < 0) {
+			dev_dbg(rcdu->dev, "%s: no available hardware plane\n",
+				__func__);
 			return ret;
+		}
 	}
 
-	rplane->crtc = crtc;
-	rplane->format = format;
-
-	rplane->src_x = src_x >> 16;
-	rplane->src_y = src_y >> 16;
-	rplane->dst_x = crtc_x;
-	rplane->dst_y = crtc_y;
-	rplane->width = crtc_w;
-	rplane->height = crtc_h;
-
-	rcar_du_plane_compute_base(rplane, fb);
-	rcar_du_plane_setup(rplane);
-
-	mutex_lock(&rplane->group->planes.lock);
-	rplane->enabled = true;
-	rcar_du_crtc_update_planes(rplane->crtc);
-	mutex_unlock(&rplane->group->planes.lock);
-
 	return 0;
 }
 
-static int rcar_du_plane_disable(struct drm_plane *plane)
+static void rcar_du_plane_disable(struct rcar_du_plane *rplane)
 {
-	struct rcar_du_plane *rplane = to_rcar_plane(plane);
-
-	if (plane->type != DRM_PLANE_TYPE_OVERLAY)
-		return -EINVAL;
-
 	if (!rplane->enabled)
-		return 0;
+		return;
 
 	mutex_lock(&rplane->group->planes.lock);
 	rplane->enabled = false;
@@ -361,10 +370,56 @@ static int rcar_du_plane_disable(struct drm_plane *plane)
 
 	rplane->crtc = NULL;
 	rplane->format = NULL;
+}
 
-	return 0;
+static void rcar_du_plane_atomic_update(struct drm_plane *plane,
+					struct drm_plane_state *old_state)
+{
+	struct rcar_du_plane *rplane = to_rcar_plane(plane);
+	struct drm_plane_state *state = plane->state;
+	const struct rcar_du_format_info *format;
+	unsigned int nplanes;
+
+	if (!state->crtc) {
+		rcar_du_plane_disable(rplane);
+		return;
+	}
+
+	format = rcar_du_format_info(state->fb->pixel_format);
+	nplanes = rplane->format ? rplane->format->planes : 0;
+
+	/* Reallocate hardware planes if the number of required planes has
+	 * changed.
+	 */
+	if (format->planes != nplanes) {
+		rcar_du_plane_release(rplane);
+		rcar_du_plane_reserve(rplane, format);
+	}
+
+	rplane->crtc = state->crtc;
+	rplane->format = format;
+
+	rplane->src_x = state->src_x >> 16;
+	rplane->src_y = state->src_y >> 16;
+	rplane->dst_x = state->crtc_x;
+	rplane->dst_y = state->crtc_y;
+	rplane->width = state->crtc_w;
+	rplane->height = state->crtc_h;
+
+	rcar_du_plane_compute_base(rplane, state->fb);
+	rcar_du_plane_setup(rplane);
+
+	mutex_lock(&rplane->group->planes.lock);
+	rplane->enabled = true;
+	rcar_du_crtc_update_planes(rplane->crtc);
+	mutex_unlock(&rplane->group->planes.lock);
 }
 
+static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
+	.atomic_check = rcar_du_plane_atomic_check,
+	.atomic_update = rcar_du_plane_atomic_update,
+};
+
 /* Both the .set_property and the .update_plane operations are called with the
  * mode_config lock held. There is this no need to explicitly protect access to
  * the alpha and colorkey fields and the mode register.
@@ -431,8 +486,8 @@ static int rcar_du_plane_set_property(struct drm_plane *plane,
 }
 
 static const struct drm_plane_funcs rcar_du_plane_funcs = {
-	.update_plane = rcar_du_plane_update,
-	.disable_plane = rcar_du_plane_disable,
+	.update_plane = drm_plane_helper_update,
+	.disable_plane = drm_plane_helper_disable,
 	.set_property = rcar_du_plane_set_property,
 	.destroy = drm_plane_cleanup,
 };
@@ -509,6 +564,9 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 		if (ret < 0)
 			return ret;
 
+		drm_plane_helper_add(&plane->plane,
+				     &rcar_du_plane_helper_funcs);
+
 		if (type = DRM_PLANE_TYPE_PRIMARY)
 			continue;
 
-- 
2.0.5

