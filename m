From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:56 +0000
Subject: [PATCH 36/38] drm: rcar-du: Move plane commit code from CRTC start to CRTC resume
Message-Id: <1424901298-6829-37-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

As the DRM core will commit plane states when performing atomic updates,
those don't need to be committed manually when the CRTC is started except
in the system resume code path.

However, the atomic plane commit step is currently performed between
mode set disable and mode set enable to mimick the legacy mode setting
operations order. This causes the device clocks to be disabled after
applying plane settings and reenabled when enabling the CRTC,
potentially losing hardware in between.

Reorder the operations to enable the CRTC first and only then apply
plane settings, removing the need to manage clocks in the atomic begin
and flush handlers. We can then move the plane state commit code out of
the CRTC start handler to the system resume handler.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 54 +++++++++++++---------------------
 drivers/gpu/drm/rcar-du/rcar_du_kms.c  |  2 +-
 2 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 98f770622b2d..29bbb44eecc9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -204,9 +204,8 @@ plane_format(struct rcar_du_plane *plane)
 	return to_rcar_du_plane_state(plane->plane.state)->format;
 }
 
-static void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
+static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 {
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_du_plane *planes[RCAR_DU_NUM_HW_PLANES];
 	unsigned int num_planes = 0;
 	unsigned int prio = 0;
@@ -354,7 +353,6 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
 	bool interlaced;
-	unsigned int i;
 
 	if (rcrtc->started)
 		return;
@@ -367,26 +365,8 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_set_display_timing(rcrtc);
 	rcar_du_group_set_routing(rcrtc->group);
 
-	/* FIXME: Commit the planes state. This is required here as the CRTC can
-	 * be started from the system resume handler, which don't go
-	 * through .atomic_plane_update() and .atomic_flush() to commit plane
-	 * state. Additionally, given that the plane state atomic commit occurs
-	 * between CRTC disable and enable, the hardware state could also be
-	 * lost due to runtime PM, requiring a full commit here. This will be
-	 * fixed later after switching to atomic updates completely.
-	 */
-	mutex_lock(&rcrtc->group->planes.lock);
-	rcar_du_crtc_update_planes(crtc);
-	mutex_unlock(&rcrtc->group->planes.lock);
-
-	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes.planes); ++i) {
-		struct rcar_du_plane *plane = &rcrtc->group->planes.planes[i];
-
-		if (plane->plane.state->crtc != crtc)
-			continue;
-
-		rcar_du_plane_setup(plane);
-	}
+	/* Start with all planes disabled. */
+	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
 
 	/* Select master sync mode. This enables display operation in master
 	 * sync mode (with the HSYNC and VSYNC signals configured as outputs and
@@ -437,11 +417,27 @@ void rcar_du_crtc_suspend(struct rcar_du_crtc *rcrtc)
 
 void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc)
 {
+	unsigned int i;
+
 	if (!rcrtc->enabled)
 		return;
 
 	rcar_du_crtc_get(rcrtc);
 	rcar_du_crtc_start(rcrtc);
+
+	/* Commit the planes state. */
+	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes.planes); ++i) {
+		struct rcar_du_plane *plane = &rcrtc->group->planes.planes[i];
+
+		if (plane->plane.state->crtc != &rcrtc->crtc)
+			continue;
+
+		rcar_du_plane_setup(plane);
+	}
+
+	mutex_lock(&rcrtc->group->planes.lock);
+	rcar_du_crtc_update_planes(rcrtc);
+	mutex_unlock(&rcrtc->group->planes.lock);
 }
 
 /* -----------------------------------------------------------------------------
@@ -490,11 +486,6 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
 	struct drm_device *dev = rcrtc->crtc.dev;
 	unsigned long flags;
 
-	/* We need to access the hardware during atomic update, acquire a
-	 * reference to the CRTC.
-	 */
-	rcar_du_crtc_get(rcrtc);
-
 	if (event) {
 		event->pipe = rcrtc->index;
 
@@ -510,14 +501,9 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	/* We're done, apply the configuration and drop the reference acquired
-	 * in .atomic_begin().
-	 */
 	mutex_lock(&rcrtc->group->planes.lock);
-	rcar_du_crtc_update_planes(crtc);
+	rcar_du_crtc_update_planes(rcrtc);
 	mutex_unlock(&rcrtc->group->planes.lock);
-
-	rcar_du_crtc_put(rcrtc);
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index cec35e405248..8bc7242ba979 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -207,8 +207,8 @@ static void rcar_du_atomic_complete(struct rcar_du_commit *commit)
 
 	/* Apply the atomic update. */
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
-	drm_atomic_helper_commit_planes(dev, old_state);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+	drm_atomic_helper_commit_planes(dev, old_state);
 
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
-- 
2.0.5

