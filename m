From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:44 +0000
Subject: [PATCH 24/38] drm: rcar-du: Rework CRTC enable/disable for atomic updates
Message-Id: <1424901298-6829-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

When using atomic updates the CRTC .enable() and .disable() helper
operations are preferred over the (then legacy) .prepare() and .commit()
operations. Implement .enable() and rework .disable() to not depend on
DPMS, easing DPMS removal later on.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 59 ++++++++++++++++++++--------------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  2 +-
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 6e7266c1a47b..7fdb968756ba 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -431,7 +431,7 @@ void rcar_du_crtc_suspend(struct rcar_du_crtc *rcrtc)
 
 void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc)
 {
-	if (rcrtc->dpms != DRM_MODE_DPMS_ON)
+	if (!rcrtc->enabled)
 		return;
 
 	rcar_du_crtc_get(rcrtc);
@@ -450,25 +450,38 @@ static void rcar_du_crtc_update_base(struct rcar_du_crtc *rcrtc)
  * CRTC Functions
  */
 
-static void rcar_du_crtc_dpms(struct drm_crtc *crtc, int mode)
+static void rcar_du_crtc_enable(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	if (mode != DRM_MODE_DPMS_ON)
-		mode = DRM_MODE_DPMS_OFF;
+	if (rcrtc->enabled)
+		return;
+
+	rcar_du_crtc_get(rcrtc);
+	rcar_du_crtc_start(rcrtc);
+
+	rcrtc->enabled = true;
+}
+
+static void rcar_du_crtc_disable(struct drm_crtc *crtc)
+{
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	if (rcrtc->dpms = mode)
+	if (!rcrtc->enabled)
 		return;
 
-	if (mode = DRM_MODE_DPMS_ON) {
-		rcar_du_crtc_get(rcrtc);
-		rcar_du_crtc_start(rcrtc);
-	} else {
-		rcar_du_crtc_stop(rcrtc);
-		rcar_du_crtc_put(rcrtc);
-	}
+	rcar_du_crtc_stop(rcrtc);
+	rcar_du_crtc_put(rcrtc);
 
-	rcrtc->dpms = mode;
+	rcrtc->enabled = false;
+}
+
+static void rcar_du_crtc_dpms(struct drm_crtc *crtc, int mode)
+{
+	if (mode = DRM_MODE_DPMS_ON)
+		rcar_du_crtc_enable(crtc);
+	else
+		rcar_du_crtc_disable(crtc);
 }
 
 static bool rcar_du_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -488,10 +501,10 @@ static void rcar_du_crtc_mode_prepare(struct drm_crtc *crtc)
 	 */
 	rcar_du_crtc_get(rcrtc);
 
-	/* Stop the CRTC, force the DPMS mode to off as a result. */
+	/* Stop the CRTC, force enabled to false as a result. */
 	rcar_du_crtc_stop(rcrtc);
 
-	rcrtc->dpms = DRM_MODE_DPMS_OFF;
+	rcrtc->enabled = false;
 	rcrtc->outputs = 0;
 }
 
@@ -508,17 +521,12 @@ static void rcar_du_crtc_mode_commit(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	/* We're done, restart the CRTC and set the DPMS mode to on. The
-	 * reference to the DU acquired at prepare() time will thus be released
-	 * by the DPMS handler (possibly called by the disable() handler).
+	/* We're done, restart the CRTC and set enabled to true. The reference
+	 * to the DU acquired at prepare() time will thus be released by the
+	 * disable() handler.
 	 */
 	rcar_du_crtc_start(rcrtc);
-	rcrtc->dpms = DRM_MODE_DPMS_ON;
-}
-
-static void rcar_du_crtc_disable(struct drm_crtc *crtc)
-{
-	rcar_du_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+	rcrtc->enabled = true;
 }
 
 static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
@@ -554,6 +562,7 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.mode_set_nofb = rcar_du_crtc_mode_set_nofb,
 	.mode_set_base = drm_helper_crtc_mode_set_base,
 	.disable = rcar_du_crtc_disable,
+	.enable = rcar_du_crtc_enable,
 	.atomic_begin = rcar_du_crtc_atomic_begin,
 	.atomic_flush = rcar_du_crtc_atomic_flush,
 };
@@ -670,7 +679,7 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 	rcrtc->group = rgrp;
 	rcrtc->mmio_offset = mmio_offsets[index];
 	rcrtc->index = index;
-	rcrtc->dpms = DRM_MODE_DPMS_OFF;
+	rcrtc->enabled = false;
 	rcrtc->plane = &rgrp->planes.planes[index % 2];
 
 	rcrtc->plane->crtc = crtc;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index fb39e040f17b..f50fbafd609f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -36,7 +36,7 @@ struct rcar_du_crtc {
 	wait_queue_head_t flip_wait;
 
 	unsigned int outputs;
-	int dpms;
+	bool enabled;
 
 	struct rcar_du_group *group;
 	struct rcar_du_plane *plane;
-- 
2.0.5

