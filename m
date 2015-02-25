From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:53 +0000
Subject: [PATCH 33/38] drm: rcar-du: Replace plane crtc and enabled fields by plane state
Message-Id: <1424901298-6829-34-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The crtc and enabled fields duplicates information stored in the plane
state. Use the plane state instead and remove the fields.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  6 ++----
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 15 +++------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  3 ---
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index faa46ed23a62..3f64707412e6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -212,7 +212,7 @@ static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 		struct rcar_du_plane *plane = &rcrtc->group->planes.planes[i];
 		unsigned int j;
 
-		if (plane->crtc != &rcrtc->crtc || !plane->enabled)
+		if (plane->plane.state->crtc != &rcrtc->crtc)
 			continue;
 
 		/* Insert the plane in the sorted planes array. */
@@ -379,7 +379,7 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes.planes); ++i) {
 		struct rcar_du_plane *plane = &rcrtc->group->planes.planes[i];
 
-		if (plane->crtc != crtc || !plane->enabled)
+		if (plane->plane.state->crtc != crtc)
 			continue;
 
 		rcar_du_plane_setup(plane);
@@ -608,8 +608,6 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 	rcrtc->enabled = false;
 	rcrtc->plane = &rgrp->planes.planes[index % 2];
 
-	rcrtc->plane->crtc = crtc;
-
 	ret = drm_crtc_init_with_planes(rcdu->ddev, crtc, &rcrtc->plane->plane,
 					NULL, &crtc_funcs);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index f28d13dc6fc9..c5cb2ade2722 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -140,7 +140,8 @@ static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 	bool interlaced;
 	u32 mwr;
 
-	interlaced = plane->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE;
+	interlaced = plane->plane.state->crtc->state->adjusted_mode.flags
+		   & DRM_MODE_FLAG_INTERLACE;
 
 	/* Memory pitch (expressed in pixels). Must be doubled for interlaced
 	 * operation with 32bpp formats.
@@ -354,16 +355,11 @@ static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 
 static void rcar_du_plane_disable(struct rcar_du_plane *rplane)
 {
-	if (!rplane->enabled)
+	if (!rplane->plane.state->crtc)
 		return;
 
-	mutex_lock(&rplane->group->planes.lock);
-	rplane->enabled = false;
-	mutex_unlock(&rplane->group->planes.lock);
-
 	rcar_du_plane_release(rplane);
 
-	rplane->crtc = NULL;
 	rplane->format = NULL;
 }
 
@@ -391,14 +387,9 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 		rcar_du_plane_reserve(rplane, format);
 	}
 
-	rplane->crtc = state->crtc;
 	rplane->format = format;
 
 	rcar_du_plane_setup(rplane);
-
-	mutex_lock(&rplane->group->planes.lock);
-	rplane->enabled = true;
-	mutex_unlock(&rplane->group->planes.lock);
 }
 
 static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 012f2185ca1f..7050fc1e11ec 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -34,9 +34,6 @@ struct rcar_du_plane {
 	struct drm_plane plane;
 
 	struct rcar_du_group *group;
-	struct drm_crtc *crtc;
-
-	bool enabled;
 
 	int hwindex;		/* 0-based, -1 means unused */
 
-- 
2.0.5

