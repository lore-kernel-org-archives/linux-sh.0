From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:22 +0000
Subject: [PATCH 02/38] drm/atomic-helper: Rename commmit_post/pre_planes
Message-Id: <1424901298-6829-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

These names only make sense because of backwards compatability with
the order used by the crtc helper library. There's not really any real
requirement in the ordering here.

So rename them to something more descriptive and update the kerneldoc
a bit. Motivated in a discussion with Laurent about how to restore
plane state for dpms for drivers with runtime pm.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 40 +++++++++++++++++++++++--------------
 drivers/gpu/drm/i915/intel_atomic.c |  4 ++--
 drivers/gpu/drm/msm/msm_atomic.c    |  4 ++--
 include/drm/drm_atomic_helper.h     |  6 +++---
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6c5bfa2bd18a..0a203a7a9a17 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -768,34 +768,44 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 }
 
 /**
- * drm_atomic_helper_commit_pre_planes - modeset commit before plane updates
+ * drm_atomic_helper_commit_modeset_disables - modeset commit to disable outputs
  * @dev: DRM device
  * @old_state: atomic state object with old state structures
  *
- * This function commits the modeset changes that need to be committed before
- * updating planes. It shuts down all the outputs that need to be shut down and
+ * This function shuts down all the outputs that need to be shut down and
  * prepares them (if required) with the new mode.
+ *
+ * For compatability with legacy crtc helpers this should be called before
+ * drm_atomic_helper_commit_planes(), which is what the default commit function
+ * does. But drivers with different needs can group the modeset commits together
+ * and do the plane commits at the end. This is useful for drivers doing runtime
+ * PM since planes updates then only happen when the CRTC is actually enabled.
  */
-void drm_atomic_helper_commit_pre_planes(struct drm_device *dev,
-					 struct drm_atomic_state *old_state)
+void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
+					       struct drm_atomic_state *old_state)
 {
 	disable_outputs(dev, old_state);
 	set_routing_links(dev, old_state);
 	crtc_set_mode(dev, old_state);
 }
-EXPORT_SYMBOL(drm_atomic_helper_commit_pre_planes);
+EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_disables);
 
 /**
- * drm_atomic_helper_commit_post_planes - modeset commit after plane updates
+ * drm_atomic_helper_commit_modeset_enables - modeset commit to enable outputs
  * @dev: DRM device
  * @old_state: atomic state object with old state structures
  *
- * This function commits the modeset changes that need to be committed after
- * updating planes: It enables all the outputs with the new configuration which
- * had to be turned off for the update.
+ * This function enables all the outputs with the new configuration which had to
+ * be turned off for the update.
+ *
+ * For compatability with legacy crtc helpers this should be called after
+ * drm_atomic_helper_commit_planes(), which is what the default commit function
+ * does. But drivers with different needs can group the modeset commits together
+ * and do the plane commits at the end. This is useful for drivers doing runtime
+ * PM since planes updates then only happen when the CRTC is actually enabled.
  */
-void drm_atomic_helper_commit_post_planes(struct drm_device *dev,
-					  struct drm_atomic_state *old_state)
+void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
+					      struct drm_atomic_state *old_state)
 {
 	int ncrtcs = old_state->dev->mode_config.num_crtc;
 	int i;
@@ -861,7 +871,7 @@ void drm_atomic_helper_commit_post_planes(struct drm_device *dev,
 			encoder->bridge->funcs->enable(encoder->bridge);
 	}
 }
-EXPORT_SYMBOL(drm_atomic_helper_commit_post_planes);
+EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
 static void wait_for_fences(struct drm_device *dev,
 			    struct drm_atomic_state *state)
@@ -1030,11 +1040,11 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 
 	wait_for_fences(dev, state);
 
-	drm_atomic_helper_commit_pre_planes(dev, state);
+	drm_atomic_helper_commit_modeset_disables(dev, state);
 
 	drm_atomic_helper_commit_planes(dev, state);
 
-	drm_atomic_helper_commit_post_planes(dev, state);
+	drm_atomic_helper_commit_modeset_enables(dev, state);
 
 	drm_atomic_helper_wait_for_vblanks(dev, state);
 
diff --git a/drivers/gpu/drm/i915/intel_atomic.c b/drivers/gpu/drm/i915/intel_atomic.c
index 19a9dd5408f3..011b8960fd75 100644
--- a/drivers/gpu/drm/i915/intel_atomic.c
+++ b/drivers/gpu/drm/i915/intel_atomic.c
@@ -134,9 +134,9 @@ int intel_atomic_commit(struct drm_device *dev,
 	 * FIXME:  The proper sequence here will eventually be:
 	 *
 	 * drm_atomic_helper_swap_state(dev, state)
-	 * drm_atomic_helper_commit_pre_planes(dev, state);
+	 * drm_atomic_helper_commit_modeset_disables(dev, state);
 	 * drm_atomic_helper_commit_planes(dev, state);
-	 * drm_atomic_helper_commit_post_planes(dev, state);
+	 * drm_atomic_helper_commit_modeset_enables(dev, state);
 	 * drm_atomic_helper_wait_for_vblanks(dev, state);
 	 * drm_atomic_helper_cleanup_planes(dev, state);
 	 * drm_atomic_state_free(state);
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 871aa2108dc6..7c412292a0ff 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -96,11 +96,11 @@ static void complete_commit(struct msm_commit *c)
 
 	kms->funcs->prepare_commit(kms, state);
 
-	drm_atomic_helper_commit_pre_planes(dev, state);
+	drm_atomic_helper_commit_modeset_disables(dev, state);
 
 	drm_atomic_helper_commit_planes(dev, state);
 
-	drm_atomic_helper_commit_post_planes(dev, state);
+	drm_atomic_helper_commit_modeset_enables(dev, state);
 
 	/* NOTE: _wait_for_vblanks() only waits for vblank on
 	 * enabled CRTCs.  So we end up faulting when disabling
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 8039d54a7441..829280b56874 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -43,9 +43,9 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 void drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 					struct drm_atomic_state *old_state);
 
-void drm_atomic_helper_commit_pre_planes(struct drm_device *dev,
-					 struct drm_atomic_state *state);
-void drm_atomic_helper_commit_post_planes(struct drm_device *dev,
+void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
+					       struct drm_atomic_state *state);
+void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 					  struct drm_atomic_state *old_state);
 
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
-- 
2.0.5

