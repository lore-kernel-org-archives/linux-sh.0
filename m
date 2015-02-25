From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:51 +0000
Subject: [PATCH 31/38] drm: rcar-du: Switch plane set_property to atomic helpers
Message-Id: <1424901298-6829-32-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Allow setting up plane properties atomically using the plane
set_property atomic helper. The properties are now stored in the plane
state (requiring subclassing it) and applied when updating the planes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |   9 ++-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h  |   1 -
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 125 +++++++++++++++++++-------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  17 ++++-
 4 files changed, 95 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 2a1119b52c2a..faa46ed23a62 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -193,7 +193,12 @@ void rcar_du_crtc_route_output(struct drm_crtc *crtc,
 		rcdu->dpad0_source = rcrtc->index;
 }
 
-void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
+static unsigned int plane_zpos(struct rcar_du_plane *plane)
+{
+	return to_rcar_du_plane_state(plane->plane.state)->zpos;
+}
+
+static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_du_plane *planes[RCAR_DU_NUM_HW_PLANES];
@@ -212,7 +217,7 @@ void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 
 		/* Insert the plane in the sorted planes array. */
 		for (j = num_planes++; j > 0; --j) {
-			if (planes[j-1]->zpos <= plane->zpos)
+			if (plane_zpos(planes[j-1]) <= plane_zpos(plane))
 				break;
 			planes[j] = planes[j-1];
 		}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index f50fbafd609f..0a3dcca58fd7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -62,6 +62,5 @@ void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc);
 
 void rcar_du_crtc_route_output(struct drm_crtc *crtc,
 			       enum rcar_du_output output);
-void rcar_du_crtc_update_planes(struct drm_crtc *crtc);
 
 #endif /* __RCAR_DU_CRTC_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 9176ac451438..7e0e2731ea27 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -201,6 +201,8 @@ static void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
 static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 				     unsigned int index)
 {
+	struct rcar_du_plane_state *state +		to_rcar_du_plane_state(plane->plane.state);
 	struct rcar_du_group *rgrp = plane->group;
 	u32 colorkey;
 	u32 pnmr;
@@ -218,7 +220,7 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 		rcar_du_plane_write(rgrp, index, PnALPHAR, PnALPHAR_ABIT_0);
 	else
 		rcar_du_plane_write(rgrp, index, PnALPHAR,
-				    PnALPHAR_ABIT_X | plane->alpha);
+				    PnALPHAR_ABIT_X | state->alpha);
 
 	pnmr = PnMR_BM_MD | plane->format->pnmr;
 
@@ -226,7 +228,7 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 	 * PnMR_SPIM_TP_OFF bit set in their pnmr field, disabling color keying
 	 * automatically.
 	 */
-	if ((plane->colorkey & RCAR_DU_COLORKEY_MASK) = RCAR_DU_COLORKEY_NONE)
+	if ((state->colorkey & RCAR_DU_COLORKEY_MASK) = RCAR_DU_COLORKEY_NONE)
 		pnmr |= PnMR_SPIM_TP_OFF;
 
 	/* For packed YUV formats we need to select the U/V order. */
@@ -237,24 +239,24 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 
 	switch (plane->format->fourcc) {
 	case DRM_FORMAT_RGB565:
-		colorkey = ((plane->colorkey & 0xf80000) >> 8)
-			 | ((plane->colorkey & 0x00fc00) >> 5)
-			 | ((plane->colorkey & 0x0000f8) >> 3);
+		colorkey = ((state->colorkey & 0xf80000) >> 8)
+			 | ((state->colorkey & 0x00fc00) >> 5)
+			 | ((state->colorkey & 0x0000f8) >> 3);
 		rcar_du_plane_write(rgrp, index, PnTC2R, colorkey);
 		break;
 
 	case DRM_FORMAT_ARGB1555:
 	case DRM_FORMAT_XRGB1555:
-		colorkey = ((plane->colorkey & 0xf80000) >> 9)
-			 | ((plane->colorkey & 0x00f800) >> 6)
-			 | ((plane->colorkey & 0x0000f8) >> 3);
+		colorkey = ((state->colorkey & 0xf80000) >> 9)
+			 | ((state->colorkey & 0x00f800) >> 6)
+			 | ((state->colorkey & 0x0000f8) >> 3);
 		rcar_du_plane_write(rgrp, index, PnTC2R, colorkey);
 		break;
 
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
 		rcar_du_plane_write(rgrp, index, PnTC3R,
-				    PnTC3R_CODE | (plane->colorkey & 0xffffff));
+				    PnTC3R_CODE | (state->colorkey & 0xffffff));
 		break;
 	}
 }
@@ -414,65 +416,87 @@ static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
 	.atomic_update = rcar_du_plane_atomic_update,
 };
 
-/* Both the .set_property and the .update_plane operations are called with the
- * mode_config lock held. There is this no need to explicitly protect access to
- * the alpha and colorkey fields and the mode register.
- */
-static void rcar_du_plane_set_alpha(struct rcar_du_plane *plane, u32 alpha)
+static void rcar_du_plane_reset(struct drm_plane *plane)
 {
-	if (plane->alpha = alpha)
-		return;
+	struct rcar_du_plane_state *state;
+
+	if (plane->state && plane->state->fb)
+		drm_framebuffer_unreference(plane->state->fb);
 
-	plane->alpha = alpha;
-	if (!plane->enabled || plane->format->fourcc != DRM_FORMAT_XRGB1555)
+	kfree(plane->state);
+	plane->state = NULL;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state = NULL)
 		return;
 
-	rcar_du_plane_setup_mode(plane, plane->hwindex);
+	state->alpha = 255;
+	state->colorkey = RCAR_DU_COLORKEY_NONE;
+	state->zpos = plane->type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
+
+	plane->state = &state->state;
+	plane->state->plane = plane;
 }
 
-static void rcar_du_plane_set_colorkey(struct rcar_du_plane *plane,
-				       u32 colorkey)
+static struct drm_plane_state *
+rcar_du_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
-	if (plane->colorkey = colorkey)
-		return;
+	struct rcar_du_plane_state *state;
+	struct rcar_du_plane_state *copy;
 
-	plane->colorkey = colorkey;
-	if (!plane->enabled)
-		return;
+	state = to_rcar_du_plane_state(plane->state);
+	copy = kmemdup(state, sizeof(*state), GFP_KERNEL);
+	if (copy = NULL)
+		return NULL;
+
+	if (copy->state.fb)
+		drm_framebuffer_reference(copy->state.fb);
 
-	rcar_du_plane_setup_mode(plane, plane->hwindex);
+	return &copy->state;
 }
 
-static void rcar_du_plane_set_zpos(struct rcar_du_plane *plane,
-				   unsigned int zpos)
+static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state)
 {
-	mutex_lock(&plane->group->planes.lock);
-	if (plane->zpos = zpos)
-		goto done;
+	kfree(to_rcar_du_plane_state(state));
+}
 
-	plane->zpos = zpos;
-	if (!plane->enabled)
-		goto done;
+static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
+					     struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t val)
+{
+	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
+	struct rcar_du_plane *rplane = to_rcar_plane(plane);
+	struct rcar_du_group *rgrp = rplane->group;
 
-	rcar_du_crtc_update_planes(plane->crtc);
+	if (property = rgrp->planes.alpha)
+		rstate->alpha = val;
+	else if (property = rgrp->planes.colorkey)
+		rstate->colorkey = val;
+	else if (property = rgrp->planes.zpos)
+		rstate->zpos = val;
+	else
+		return -EINVAL;
 
-done:
-	mutex_unlock(&plane->group->planes.lock);
+	return 0;
 }
 
-static int rcar_du_plane_set_property(struct drm_plane *plane,
-				      struct drm_property *property,
-				      uint64_t value)
+static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
+	const struct drm_plane_state *state, struct drm_property *property,
+	uint64_t *val)
 {
+	const struct rcar_du_plane_state *rstate +		container_of(state, const struct rcar_du_plane_state, state);
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 	struct rcar_du_group *rgrp = rplane->group;
 
 	if (property = rgrp->planes.alpha)
-		rcar_du_plane_set_alpha(rplane, value);
+		*val = rstate->alpha;
 	else if (property = rgrp->planes.colorkey)
-		rcar_du_plane_set_colorkey(rplane, value);
+		*val = rstate->colorkey;
 	else if (property = rgrp->planes.zpos)
-		rcar_du_plane_set_zpos(rplane, value);
+		*val = rstate->zpos;
 	else
 		return -EINVAL;
 
@@ -482,11 +506,13 @@ static int rcar_du_plane_set_property(struct drm_plane *plane,
 static const struct drm_plane_funcs rcar_du_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.reset = drm_atomic_helper_plane_reset,
-	.set_property = rcar_du_plane_set_property,
+	.reset = rcar_du_plane_reset,
+	.set_property = drm_atomic_helper_plane_set_property,
 	.destroy = drm_plane_cleanup,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.atomic_duplicate_state = rcar_du_plane_atomic_duplicate_state,
+	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
+	.atomic_set_property = rcar_du_plane_atomic_set_property,
+	.atomic_get_property = rcar_du_plane_atomic_get_property,
 };
 
 static const uint32_t formats[] = {
@@ -551,9 +577,6 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 
 		plane->group = rgrp;
 		plane->hwindex = -1;
-		plane->alpha = 255;
-		plane->colorkey = RCAR_DU_COLORKEY_NONE;
-		plane->zpos = type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
 
 		ret = drm_universal_plane_init(rcdu->ddev, &plane->plane, crtcs,
 					       &rcar_du_plane_funcs, formats,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 9b77a638863f..d291e85896ef 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -39,9 +39,6 @@ struct rcar_du_plane {
 	bool enabled;
 
 	int hwindex;		/* 0-based, -1 means unused */
-	unsigned int alpha;
-	unsigned int colorkey;
-	unsigned int zpos;
 
 	const struct rcar_du_format_info *format;
 
@@ -59,6 +56,20 @@ struct rcar_du_planes {
 	struct drm_property *zpos;
 };
 
+struct rcar_du_plane_state {
+	struct drm_plane_state state;
+
+	unsigned int alpha;
+	unsigned int colorkey;
+	unsigned int zpos;
+};
+
+static inline struct rcar_du_plane_state *
+to_rcar_du_plane_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct rcar_du_plane_state, state);
+}
+
 int rcar_du_planes_init(struct rcar_du_group *rgrp);
 
 void rcar_du_plane_setup(struct rcar_du_plane *plane);
-- 
2.0.5

