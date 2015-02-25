From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:23 +0000
Subject: [PATCH 03/38] drm/atomic-helpers: make mode_set hooks optional
Message-Id: <1424901298-6829-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

With runtime PM the hw might still be off while doing the ->mode_set
callbacks - runtime PM get/put should only happen in the
enable/disable hooks to properly support DPMS. Which essentially makes
these callbacks useless for drivers support runtime PM, so make them
optional. Again motivated by discussions with Laurent.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
 include/drm/drm_crtc_helper.h       | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 0a203a7a9a17..caafc237c28b 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -723,7 +723,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 
 		funcs = crtc->helper_private;
 
-		if (crtc->state->enable) {
+		if (crtc->state->enable && funcs->mode_set_nofb) {
 			DRM_DEBUG_KMS("modeset on [CRTC:%d]\n",
 				      crtc->base.id);
 
@@ -759,7 +759,8 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call call mode_set hooks twice.
 		 */
-		funcs->mode_set(encoder, mode, adjusted_mode);
+		if (funcs->mode_set)
+			funcs->mode_set(encoder, mode, adjusted_mode);
 
 		if (encoder->bridge && encoder->bridge->funcs->mode_set)
 			encoder->bridge->funcs->mode_set(encoder->bridge,
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index c250a22b39ab..92d5135b55d2 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -89,6 +89,7 @@ struct drm_crtc_helper_funcs {
 	int (*mode_set)(struct drm_crtc *crtc, struct drm_display_mode *mode,
 			struct drm_display_mode *adjusted_mode, int x, int y,
 			struct drm_framebuffer *old_fb);
+	/* Actually set the mode for atomic helpers, optional */
 	void (*mode_set_nofb)(struct drm_crtc *crtc);
 
 	/* Move the crtc on the current fb to the given position *optional* */
@@ -119,7 +120,7 @@ struct drm_crtc_helper_funcs {
  * @mode_fixup: try to fixup proposed mode for this connector
  * @prepare: part of the disable sequence, called before the CRTC modeset
  * @commit: called after the CRTC modeset
- * @mode_set: set this mode
+ * @mode_set: set this mode, optional for atomic helpers
  * @get_crtc: return CRTC that the encoder is currently attached to
  * @detect: connection status detection
  * @disable: disable encoder when not in use (overrides DPMS off)
-- 
2.0.5

