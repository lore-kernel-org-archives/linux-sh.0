From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:40 +0000
Subject: [PATCH 20/38] drm: rcar-du: Remove private copy of plane size and position
Message-Id: <1424901298-6829-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The plane source and destination size and positions are stored in the
plane state, and a private copy is kept in the rcar_du_plane objects.
Remove the private copy as it just duplicates the state.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 25 ++++++++++---------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  8 --------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index c4e4fd293eee..f247b1fcf791 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -132,6 +132,8 @@ static void rcar_du_plane_release(struct rcar_du_plane *plane)
 void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 {
 	struct rcar_du_group *rgrp = plane->group;
+	unsigned int src_x = plane->plane.state->src_x >> 16;
+	unsigned int src_y = plane->plane.state->src_y >> 16;
 	unsigned int index = plane->hwindex;
 	bool interlaced;
 	u32 mwr;
@@ -163,8 +165,8 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	 * require a halved Y position value, in both progressive and interlaced
 	 * modes.
 	 */
-	rcar_du_plane_write(rgrp, index, PnSPXR, plane->src_x);
-	rcar_du_plane_write(rgrp, index, PnSPYR, plane->src_y *
+	rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
+	rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
 			    (!interlaced && plane->format->bpp = 32 ? 2 : 1));
 	rcar_du_plane_write(rgrp, index, PnDSA0R, plane->dma[0]);
 
@@ -173,8 +175,8 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 
 		rcar_du_plane_write(rgrp, index, PnMWR, plane->pitch);
 
-		rcar_du_plane_write(rgrp, index, PnSPXR, plane->src_x);
-		rcar_du_plane_write(rgrp, index, PnSPYR, plane->src_y *
+		rcar_du_plane_write(rgrp, index, PnSPXR, src_x);
+		rcar_du_plane_write(rgrp, index, PnSPYR, src_y *
 				    (plane->format->bpp = 16 ? 2 : 1) / 2);
 		rcar_du_plane_write(rgrp, index, PnDSA0R, plane->dma[1]);
 	}
@@ -294,10 +296,10 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	rcar_du_plane_write(rgrp, index, PnDDCR4, ddcr4);
 
 	/* Destination position and size */
-	rcar_du_plane_write(rgrp, index, PnDSXR, plane->width);
-	rcar_du_plane_write(rgrp, index, PnDSYR, plane->height);
-	rcar_du_plane_write(rgrp, index, PnDPXR, plane->dst_x);
-	rcar_du_plane_write(rgrp, index, PnDPYR, plane->dst_y);
+	rcar_du_plane_write(rgrp, index, PnDSXR, plane->plane.state->crtc_w);
+	rcar_du_plane_write(rgrp, index, PnDSYR, plane->plane.state->crtc_h);
+	rcar_du_plane_write(rgrp, index, PnDPXR, plane->plane.state->crtc_x);
+	rcar_du_plane_write(rgrp, index, PnDPYR, plane->plane.state->crtc_y);
 
 	/* Wrap-around and blinking, disabled */
 	rcar_du_plane_write(rgrp, index, PnWASPR, 0);
@@ -399,13 +401,6 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 	rplane->crtc = state->crtc;
 	rplane->format = format;
 
-	rplane->src_x = state->src_x >> 16;
-	rplane->src_y = state->src_y >> 16;
-	rplane->dst_x = state->crtc_x;
-	rplane->dst_y = state->crtc_y;
-	rplane->width = state->crtc_w;
-	rplane->height = state->crtc_h;
-
 	rcar_du_plane_compute_base(rplane, state->fb);
 	rcar_du_plane_setup(rplane);
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 55d2f55faece..3420ff07f2c6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -47,14 +47,6 @@ struct rcar_du_plane {
 
 	unsigned long dma[2];
 	unsigned int pitch;
-
-	unsigned int width;
-	unsigned int height;
-
-	unsigned int src_x;
-	unsigned int src_y;
-	unsigned int dst_x;
-	unsigned int dst_y;
 };
 
 struct rcar_du_planes {
-- 
2.0.5

