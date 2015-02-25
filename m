From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:52 +0000
Subject: [PATCH 32/38] drm: rcar-du: Rework plane setup code
Message-Id: <1424901298-6829-33-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Now that the plane setup code isn't called outside of the plane
implementation, it can be simplified by merging the
rcar_du_plane_compute_base() and rcar_du_plane_update_base() functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 34 ++++++++++++---------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  3 ---
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 7e0e2731ea27..f28d13dc6fc9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -129,12 +129,14 @@ static void rcar_du_plane_release(struct rcar_du_plane *plane)
 	plane->hwindex = -1;
 }
 
-static void rcar_du_plane_update_base(struct rcar_du_plane *plane)
+static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 {
+	struct drm_framebuffer *fb = plane->plane.state->fb;
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int src_x = plane->plane.state->src_x >> 16;
 	unsigned int src_y = plane->plane.state->src_y >> 16;
 	unsigned int index = plane->hwindex;
+	struct drm_gem_cma_object *gem;
 	bool interlaced;
 	u32 mwr;
 
@@ -144,9 +146,9 @@ static void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	 * operation with 32bpp formats.
 	 */
 	if (plane->format->planes = 2)
-		mwr = plane->pitch;
+		mwr = fb->pitches[0];
 	else
-		mwr = plane->pitch * 8 / plane->format->bpp;
+		mwr = fb->pitches[0] * 8 / plane->format->bpp;
 
 	if (interlaced && plane->format->bpp = 32)
 		mwr *= 2;
@@ -168,33 +170,22 @@ static void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
 	rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
 			    (!interlaced && plane->format->bpp = 32 ? 2 : 1));
-	rcar_du_plane_write(rgrp, index, PnDSA0R, plane->dma[0]);
+
+	gem = drm_fb_cma_get_gem_obj(fb, 0);
+	rcar_du_plane_write(rgrp, index, PnDSA0R, gem->paddr + fb->offsets[0]);
 
 	if (plane->format->planes = 2) {
 		index = (index + 1) % 8;
 
-		rcar_du_plane_write(rgrp, index, PnMWR, plane->pitch);
+		rcar_du_plane_write(rgrp, index, PnMWR, fb->pitches[0]);
 
 		rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
 		rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
 				    (plane->format->bpp = 16 ? 2 : 1) / 2);
-		rcar_du_plane_write(rgrp, index, PnDSA0R, plane->dma[1]);
-	}
-}
-
-static void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
-				       struct drm_framebuffer *fb)
-{
-	struct drm_gem_cma_object *gem;
-
-	plane->pitch = fb->pitches[0];
 
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-	plane->dma[0] = gem->paddr + fb->offsets[0];
-
-	if (plane->format->planes = 2) {
 		gem = drm_fb_cma_get_gem_obj(fb, 1);
-		plane->dma[1] = gem->paddr + fb->offsets[1];
+		rcar_du_plane_write(rgrp, index, PnDSA0R,
+				    gem->paddr + fb->offsets[1]);
 	}
 }
 
@@ -316,7 +307,7 @@ void rcar_du_plane_setup(struct rcar_du_plane *plane)
 	if (plane->format->planes = 2)
 		__rcar_du_plane_setup(plane, (plane->hwindex + 1) % 8);
 
-	rcar_du_plane_update_base(plane);
+	rcar_du_plane_setup_fb(plane);
 }
 
 static int rcar_du_plane_atomic_check(struct drm_plane *plane,
@@ -403,7 +394,6 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 	rplane->crtc = state->crtc;
 	rplane->format = format;
 
-	rcar_du_plane_compute_base(rplane, state->fb);
 	rcar_du_plane_setup(rplane);
 
 	mutex_lock(&rplane->group->planes.lock);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index d291e85896ef..012f2185ca1f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -41,9 +41,6 @@ struct rcar_du_plane {
 	int hwindex;		/* 0-based, -1 means unused */
 
 	const struct rcar_du_format_info *format;
-
-	unsigned long dma[2];
-	unsigned int pitch;
 };
 
 struct rcar_du_planes {
-- 
2.0.5

