From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:55 +0000
Subject: [PATCH 35/38] drm: rcar-du: Move plane format to plane state
Message-Id: <1424901298-6829-36-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The format stored in the rcar_du_plane structure is part of the plane
state. Move it to the rcar_du_plane_state structure and precompute it in
the .atomic_check() handler.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  10 ++-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 107 ++++++++++++++++++--------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |   6 +-
 3 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index c70f73036056..98f770622b2d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -198,6 +198,12 @@ static unsigned int plane_zpos(struct rcar_du_plane *plane)
 	return to_rcar_du_plane_state(plane->plane.state)->zpos;
 }
 
+static const struct rcar_du_format_info *
+plane_format(struct rcar_du_plane *plane)
+{
+	return to_rcar_du_plane_state(plane->plane.state)->format;
+}
+
 static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
@@ -223,7 +229,7 @@ static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 		}
 
 		planes[j] = plane;
-		prio += plane->format->planes * 4;
+		prio += plane_format(plane)->planes * 4;
 	}
 
 	for (i = 0; i < num_planes; ++i) {
@@ -234,7 +240,7 @@ static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 		dspr |= (index + 1) << prio;
 		dptsr |= DPTSR_PnDK(index) |  DPTSR_PnTS(index);
 
-		if (plane->format->planes = 2) {
+		if (plane_format(plane)->planes = 2) {
 			index = (index + 1) % 8;
 
 			prio -= 4;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index c5cb2ade2722..58b9e02e6910 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -48,7 +48,8 @@ static void rcar_du_plane_write(struct rcar_du_group *rgrp,
 }
 
 static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
-				       const struct rcar_du_format_info *format)
+		const struct rcar_du_format_info *cur_format,
+		const struct rcar_du_format_info *new_format)
 {
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int free;
@@ -61,7 +62,7 @@ static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
 
 	if (plane->hwindex != -1) {
 		free |= 1 << plane->hwindex;
-		if (plane->format->planes = 2)
+		if (cur_format->planes = 2)
 			free |= 1 << ((plane->hwindex + 1) % 8);
 	}
 
@@ -69,7 +70,7 @@ static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
 		if (!(free & (1 << i)))
 			continue;
 
-		if (format->planes = 1 || free & (1 << ((i + 1) % 8)))
+		if (new_format->planes = 1 || free & (1 << ((i + 1) % 8)))
 			break;
 	}
 
@@ -113,7 +114,8 @@ done:
 	return ret;
 }
 
-static void rcar_du_plane_release(struct rcar_du_plane *plane)
+static void rcar_du_plane_release(struct rcar_du_plane *plane,
+				  const struct rcar_du_format_info *format)
 {
 	struct rcar_du_group *rgrp = plane->group;
 
@@ -122,7 +124,7 @@ static void rcar_du_plane_release(struct rcar_du_plane *plane)
 
 	mutex_lock(&rgrp->planes.lock);
 	rgrp->planes.free |= 1 << plane->hwindex;
-	if (plane->format->planes = 2)
+	if (format->planes = 2)
 		rgrp->planes.free |= 1 << ((plane->hwindex + 1) % 8);
 	mutex_unlock(&rgrp->planes.lock);
 
@@ -131,27 +133,29 @@ static void rcar_du_plane_release(struct rcar_du_plane *plane)
 
 static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 {
+	struct rcar_du_plane_state *state +		to_rcar_du_plane_state(plane->plane.state);
 	struct drm_framebuffer *fb = plane->plane.state->fb;
 	struct rcar_du_group *rgrp = plane->group;
-	unsigned int src_x = plane->plane.state->src_x >> 16;
-	unsigned int src_y = plane->plane.state->src_y >> 16;
+	unsigned int src_x = state->state.src_x >> 16;
+	unsigned int src_y = state->state.src_y >> 16;
 	unsigned int index = plane->hwindex;
 	struct drm_gem_cma_object *gem;
 	bool interlaced;
 	u32 mwr;
 
-	interlaced = plane->plane.state->crtc->state->adjusted_mode.flags
+	interlaced = state->state.crtc->state->adjusted_mode.flags
 		   & DRM_MODE_FLAG_INTERLACE;
 
 	/* Memory pitch (expressed in pixels). Must be doubled for interlaced
 	 * operation with 32bpp formats.
 	 */
-	if (plane->format->planes = 2)
+	if (state->format->planes = 2)
 		mwr = fb->pitches[0];
 	else
-		mwr = fb->pitches[0] * 8 / plane->format->bpp;
+		mwr = fb->pitches[0] * 8 / state->format->bpp;
 
-	if (interlaced && plane->format->bpp = 32)
+	if (interlaced && state->format->bpp = 32)
 		mwr *= 2;
 
 	rcar_du_plane_write(rgrp, index, PnMWR, mwr);
@@ -170,19 +174,19 @@ static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 	 */
 	rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
 	rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
-			    (!interlaced && plane->format->bpp = 32 ? 2 : 1));
+			    (!interlaced && state->format->bpp = 32 ? 2 : 1));
 
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 	rcar_du_plane_write(rgrp, index, PnDSA0R, gem->paddr + fb->offsets[0]);
 
-	if (plane->format->planes = 2) {
+	if (state->format->planes = 2) {
 		index = (index + 1) % 8;
 
 		rcar_du_plane_write(rgrp, index, PnMWR, fb->pitches[0]);
 
 		rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
 		rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
-				    (plane->format->bpp = 16 ? 2 : 1) / 2);
+				    (state->format->bpp = 16 ? 2 : 1) / 2);
 
 		gem = drm_fb_cma_get_gem_obj(fb, 1);
 		rcar_du_plane_write(rgrp, index, PnDSA0R,
@@ -208,13 +212,13 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 	 * For XRGB, set the alpha value to the plane-wide alpha value and
 	 * enable alpha-blending regardless of the X bit value.
 	 */
-	if (plane->format->fourcc != DRM_FORMAT_XRGB1555)
+	if (state->format->fourcc != DRM_FORMAT_XRGB1555)
 		rcar_du_plane_write(rgrp, index, PnALPHAR, PnALPHAR_ABIT_0);
 	else
 		rcar_du_plane_write(rgrp, index, PnALPHAR,
 				    PnALPHAR_ABIT_X | state->alpha);
 
-	pnmr = PnMR_BM_MD | plane->format->pnmr;
+	pnmr = PnMR_BM_MD | state->format->pnmr;
 
 	/* Disable color keying when requested. YUV formats have the
 	 * PnMR_SPIM_TP_OFF bit set in their pnmr field, disabling color keying
@@ -224,12 +228,12 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 		pnmr |= PnMR_SPIM_TP_OFF;
 
 	/* For packed YUV formats we need to select the U/V order. */
-	if (plane->format->fourcc = DRM_FORMAT_YUYV)
+	if (state->format->fourcc = DRM_FORMAT_YUYV)
 		pnmr |= PnMR_YCDF_YUYV;
 
 	rcar_du_plane_write(rgrp, index, PnMR, pnmr);
 
-	switch (plane->format->fourcc) {
+	switch (state->format->fourcc) {
 	case DRM_FORMAT_RGB565:
 		colorkey = ((state->colorkey & 0xf80000) >> 8)
 			 | ((state->colorkey & 0x00fc00) >> 5)
@@ -256,6 +260,8 @@ static void rcar_du_plane_setup_mode(struct rcar_du_plane *plane,
 static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 				  unsigned int index)
 {
+	struct rcar_du_plane_state *state +		to_rcar_du_plane_state(plane->plane.state);
 	struct rcar_du_group *rgrp = plane->group;
 	u32 ddcr2 = PnDDCR2_CODE;
 	u32 ddcr4;
@@ -267,17 +273,17 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	 */
 	ddcr4 = rcar_du_plane_read(rgrp, index, PnDDCR4);
 	ddcr4 &= ~PnDDCR4_EDF_MASK;
-	ddcr4 |= plane->format->edf | PnDDCR4_CODE;
+	ddcr4 |= state->format->edf | PnDDCR4_CODE;
 
 	rcar_du_plane_setup_mode(plane, index);
 
-	if (plane->format->planes = 2) {
+	if (state->format->planes = 2) {
 		if (plane->hwindex != index) {
-			if (plane->format->fourcc = DRM_FORMAT_NV12 ||
-			    plane->format->fourcc = DRM_FORMAT_NV21)
+			if (state->format->fourcc = DRM_FORMAT_NV12 ||
+			    state->format->fourcc = DRM_FORMAT_NV21)
 				ddcr2 |= PnDDCR2_Y420;
 
-			if (plane->format->fourcc = DRM_FORMAT_NV21)
+			if (state->format->fourcc = DRM_FORMAT_NV21)
 				ddcr2 |= PnDDCR2_NV21;
 
 			ddcr2 |= PnDDCR2_DIVU;
@@ -304,8 +310,11 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 
 void rcar_du_plane_setup(struct rcar_du_plane *plane)
 {
+	struct rcar_du_plane_state *state +		to_rcar_du_plane_state(plane->plane.state);
+
 	__rcar_du_plane_setup(plane, plane->hwindex);
-	if (plane->format->planes = 2)
+	if (state->format->planes = 2)
 		__rcar_du_plane_setup(plane, (plane->hwindex + 1) % 8);
 
 	rcar_du_plane_setup_fb(plane);
@@ -314,10 +323,11 @@ void rcar_du_plane_setup(struct rcar_du_plane *plane)
 static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 				      struct drm_plane_state *state)
 {
+	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 	struct rcar_du_device *rcdu = rplane->group->dev;
-	const struct rcar_du_format_info *format;
-	unsigned int nplanes;
+	const struct rcar_du_format_info *cur_format;
+	const struct rcar_du_format_info *new_format;
 	int ret;
 
 	if (!state->fb || !state->crtc)
@@ -329,20 +339,20 @@ static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	format = rcar_du_format_info(state->fb->pixel_format);
-	if (format = NULL) {
+	cur_format = to_rcar_du_plane_state(plane->state)->format;
+	new_format = rcar_du_format_info(state->fb->pixel_format);
+	if (new_format = NULL) {
 		dev_dbg(rcdu->dev, "%s: unsupported format %08x\n", __func__,
 			state->fb->pixel_format);
 		return -EINVAL;
 	}
 
-	nplanes = rplane->format ? rplane->format->planes : 0;
-
 	/* If the number of required planes has changed we will need to
 	 * reallocate hardware planes. Ensure free planes are available.
 	 */
-	if (format->planes != nplanes) {
-		ret = rcar_du_plane_reserve_check(rplane, format);
+	if (!cur_format || new_format->planes != cur_format->planes) {
+		ret = rcar_du_plane_reserve_check(rplane, cur_format,
+						  new_format);
 		if (ret < 0) {
 			dev_dbg(rcdu->dev, "%s: no available hardware plane\n",
 				__func__);
@@ -350,17 +360,23 @@ static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 		}
 	}
 
+	rstate->format = new_format;
+
 	return 0;
 }
 
-static void rcar_du_plane_disable(struct rcar_du_plane *rplane)
+static void rcar_du_plane_disable(struct rcar_du_plane *rplane,
+				  const struct rcar_du_format_info *cur_format)
 {
+	struct rcar_du_plane_state *rstate +		to_rcar_du_plane_state(rplane->plane.state);
+
 	if (!rplane->plane.state->crtc)
 		return;
 
-	rcar_du_plane_release(rplane);
+	rcar_du_plane_release(rplane, cur_format);
 
-	rplane->format = NULL;
+	rstate->format = NULL;
 }
 
 static void rcar_du_plane_atomic_update(struct drm_plane *plane,
@@ -368,27 +384,26 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 {
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 	struct drm_plane_state *state = plane->state;
-	const struct rcar_du_format_info *format;
-	unsigned int nplanes;
+	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
+	const struct rcar_du_format_info *cur_format;
+	const struct rcar_du_format_info *new_format;
+
+	cur_format = to_rcar_du_plane_state(old_state)->format;
+	new_format = rstate->format;
 
 	if (!state->crtc) {
-		rcar_du_plane_disable(rplane);
+		rcar_du_plane_disable(rplane, cur_format);
 		return;
 	}
 
-	format = rcar_du_format_info(state->fb->pixel_format);
-	nplanes = rplane->format ? rplane->format->planes : 0;
-
 	/* Reallocate hardware planes if the number of required planes has
 	 * changed.
 	 */
-	if (format->planes != nplanes) {
-		rcar_du_plane_release(rplane);
-		rcar_du_plane_reserve(rplane, format);
+	if (!cur_format || new_format->planes != cur_format->planes) {
+		rcar_du_plane_release(rplane, cur_format);
+		rcar_du_plane_reserve(rplane, new_format);
 	}
 
-	rplane->format = format;
-
 	rcar_du_plane_setup(rplane);
 }
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 7050fc1e11ec..0941c4830edd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -32,12 +32,8 @@ struct rcar_du_group;
 
 struct rcar_du_plane {
 	struct drm_plane plane;
-
 	struct rcar_du_group *group;
-
 	int hwindex;		/* 0-based, -1 means unused */
-
-	const struct rcar_du_format_info *format;
 };
 
 struct rcar_du_planes {
@@ -53,6 +49,8 @@ struct rcar_du_planes {
 struct rcar_du_plane_state {
 	struct drm_plane_state state;
 
+	const struct rcar_du_format_info *format;
+
 	unsigned int alpha;
 	unsigned int colorkey;
 	unsigned int zpos;
-- 
2.0.5

