From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:52:12 +0000
Subject: [PATCH 2/5] drm/rcar-du: Update plane pitch in .mode_set_base() operation
Message-Id: <1384350735-4419-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

When setting a new frame buffer with the mode set base operation the
pitch value might change. Set the hardware plane pitch register at the
same time as the plane base address in the rcar_du_plane_update_base()
function to make sure the pitch value always matches the frame buffer.

Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 21 +++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index d2af2bc..fbf4be3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -371,7 +371,6 @@ static int rcar_du_crtc_mode_set(struct drm_crtc *crtc,
 		goto error;
 
 	rcrtc->plane->format = format;
-	rcrtc->plane->pitch = crtc->fb->pitches[0];
 
 	rcrtc->plane->src_x = x;
 	rcrtc->plane->src_y = y;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 5300064..3fb69d9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -104,6 +104,15 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 {
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int index = plane->hwindex;
+	u32 mwr;
+
+	/* Memory pitch (expressed in pixels) */
+	if (plane->format->planes = 2)
+		mwr = plane->pitch;
+	else
+		mwr = plane->pitch * 8 / plane->format->bpp;
+
+	rcar_du_plane_write(rgrp, index, PnMWR, mwr);
 
 	/* The Y position is expressed in raster line units and must be doubled
 	 * for 32bpp formats, according to the R8A7790 datasheet. No mention of
@@ -133,6 +142,8 @@ void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
 {
 	struct drm_gem_cma_object *gem;
 
+	plane->pitch = fb->pitches[0];
+
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 	plane->dma[0] = gem->paddr + fb->offsets[0];
 
@@ -209,7 +220,6 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	struct rcar_du_group *rgrp = plane->group;
 	u32 ddcr2 = PnDDCR2_CODE;
 	u32 ddcr4;
-	u32 mwr;
 
 	/* Data format
 	 *
@@ -240,14 +250,6 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	rcar_du_plane_write(rgrp, index, PnDDCR2, ddcr2);
 	rcar_du_plane_write(rgrp, index, PnDDCR4, ddcr4);
 
-	/* Memory pitch (expressed in pixels) */
-	if (plane->format->planes = 2)
-		mwr = plane->pitch;
-	else
-		mwr = plane->pitch * 8 / plane->format->bpp;
-
-	rcar_du_plane_write(rgrp, index, PnMWR, mwr);
-
 	/* Destination position and size */
 	rcar_du_plane_write(rgrp, index, PnDSXR, plane->width);
 	rcar_du_plane_write(rgrp, index, PnDSYR, plane->height);
@@ -309,7 +311,6 @@ rcar_du_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 
 	rplane->crtc = crtc;
 	rplane->format = format;
-	rplane->pitch = fb->pitches[0];
 
 	rplane->src_x = src_x >> 16;
 	rplane->src_y = src_y >> 16;
-- 
1.8.3.2

