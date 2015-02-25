From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:46 +0000
Subject: [PATCH 26/38] drm: rcar-du: Switch mode config to atomic helpers
Message-Id: <1424901298-6829-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

This removes the legacy mode config code. The CRTC and encoder prepare
and commit operations are not used anymore, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 55 ++++---------------------------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 12 -------
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 12 -------
 3 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 7fdb968756ba..f82893884a8a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -362,12 +362,10 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	/* FIXME: Commit the planes state. This is required here as the CRTC can
 	 * be started from the DPMS and system resume handler, which don't go
 	 * through .atomic_plane_update() and .atomic_flush() to commit plane
-	 * state. Similarly a mode set operation without any update to planes
-	 * will not go through atomic plane configuration either. Additionally,
-	 * given that the plane state atomic commit occurs between CRTC disable
-	 * and enable, the hardware state could also be lost due to runtime PM,
-	 * requiring a full commit here. This will be fixed later after
-	 * switching to atomic updates completely.
+	 * state. Additionally, given that the plane state atomic commit occurs
+	 * between CRTC disable and enable, the hardware state could also be
+	 * lost due to runtime PM, requiring a full commit here. This will be
+	 * fixed later after switching to atomic updates completely.
 	 */
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcar_du_crtc_update_planes(crtc);
@@ -474,6 +472,7 @@ static void rcar_du_crtc_disable(struct drm_crtc *crtc)
 	rcar_du_crtc_put(rcrtc);
 
 	rcrtc->enabled = false;
+	rcrtc->outputs = 0;
 }
 
 static void rcar_du_crtc_dpms(struct drm_crtc *crtc, int mode)
@@ -492,43 +491,6 @@ static bool rcar_du_crtc_mode_fixup(struct drm_crtc *crtc,
 	return true;
 }
 
-static void rcar_du_crtc_mode_prepare(struct drm_crtc *crtc)
-{
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-
-	/* We need to access the hardware during mode set, acquire a reference
-	 * to the CRTC.
-	 */
-	rcar_du_crtc_get(rcrtc);
-
-	/* Stop the CRTC, force enabled to false as a result. */
-	rcar_du_crtc_stop(rcrtc);
-
-	rcrtc->enabled = false;
-	rcrtc->outputs = 0;
-}
-
-static void rcar_du_crtc_mode_set_nofb(struct drm_crtc *crtc)
-{
-	/* No-op. We should configure the display timings here, but as we're
-	 * called with the CRTC disabled clocks might be off, and we thus can't
-	 * access the hardware. Let's just configure everything when enabling
-	 * the CRTC.
-	 */
-}
-
-static void rcar_du_crtc_mode_commit(struct drm_crtc *crtc)
-{
-	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
-
-	/* We're done, restart the CRTC and set enabled to true. The reference
-	 * to the DU acquired at prepare() time will thus be released by the
-	 * disable() handler.
-	 */
-	rcar_du_crtc_start(rcrtc);
-	rcrtc->enabled = true;
-}
-
 static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
@@ -556,11 +518,6 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc)
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.dpms = rcar_du_crtc_dpms,
 	.mode_fixup = rcar_du_crtc_mode_fixup,
-	.prepare = rcar_du_crtc_mode_prepare,
-	.commit = rcar_du_crtc_mode_commit,
-	.mode_set = drm_helper_crtc_mode_set,
-	.mode_set_nofb = rcar_du_crtc_mode_set_nofb,
-	.mode_set_base = drm_helper_crtc_mode_set_base,
 	.disable = rcar_du_crtc_disable,
 	.enable = rcar_du_crtc_enable,
 	.atomic_begin = rcar_du_crtc_atomic_begin,
@@ -602,7 +559,7 @@ static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
 static const struct drm_crtc_funcs crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
-	.set_config = drm_crtc_helper_set_config,
+	.set_config = drm_atomic_helper_set_config,
 	.page_flip = rcar_du_crtc_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 74a744f5dfdb..76b201f2f75e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -118,16 +118,6 @@ static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
-static void rcar_du_encoder_mode_prepare(struct drm_encoder *encoder)
-{
-	rcar_du_encoder_disable(encoder);
-}
-
-static void rcar_du_encoder_mode_commit(struct drm_encoder *encoder)
-{
-	rcar_du_encoder_enable(encoder);
-}
-
 static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
 				     struct drm_display_mode *mode,
 				     struct drm_display_mode *adjusted_mode)
@@ -140,8 +130,6 @@ static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.dpms = rcar_du_encoder_dpms,
 	.mode_fixup = rcar_du_encoder_mode_fixup,
-	.prepare = rcar_du_encoder_mode_prepare,
-	.commit = rcar_du_encoder_mode_commit,
 	.mode_set = rcar_du_encoder_mode_set,
 	.disable = rcar_du_encoder_disable,
 	.enable = rcar_du_encoder_enable,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 04e21b5f96d4..a88ef2d6800e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -96,16 +96,6 @@ static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
 	return sfuncs->mode_fixup(encoder, mode, adjusted_mode);
 }
 
-static void rcar_du_hdmienc_mode_prepare(struct drm_encoder *encoder)
-{
-	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_OFF);
-}
-
-static void rcar_du_hdmienc_mode_commit(struct drm_encoder *encoder)
-{
-	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_ON);
-}
-
 static void rcar_du_hdmienc_mode_set(struct drm_encoder *encoder,
 				     struct drm_display_mode *mode,
 				     struct drm_display_mode *adjusted_mode)
@@ -122,8 +112,6 @@ static void rcar_du_hdmienc_mode_set(struct drm_encoder *encoder,
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.dpms = rcar_du_hdmienc_dpms,
 	.mode_fixup = rcar_du_hdmienc_mode_fixup,
-	.prepare = rcar_du_hdmienc_mode_prepare,
-	.commit = rcar_du_hdmienc_mode_commit,
 	.mode_set = rcar_du_hdmienc_mode_set,
 	.disable = rcar_du_hdmienc_disable,
 	.enable = rcar_du_hdmienc_enable,
-- 
2.0.5

