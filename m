From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:21 +0000
Subject: [PATCH 01/38] drm/atomic: Rename drm_atomic_helper_commit_pre_planes() state argument
Message-Id: <1424901298-6829-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The argument contains a pointer to the old state, rename it to old_state
like in all other commit helper functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 7e3a52b97c7d..6c5bfa2bd18a 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -770,18 +770,18 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 /**
  * drm_atomic_helper_commit_pre_planes - modeset commit before plane updates
  * @dev: DRM device
- * @state: atomic state
+ * @old_state: atomic state object with old state structures
  *
  * This function commits the modeset changes that need to be committed before
  * updating planes. It shuts down all the outputs that need to be shut down and
  * prepares them (if required) with the new mode.
  */
 void drm_atomic_helper_commit_pre_planes(struct drm_device *dev,
-					 struct drm_atomic_state *state)
+					 struct drm_atomic_state *old_state)
 {
-	disable_outputs(dev, state);
-	set_routing_links(dev, state);
-	crtc_set_mode(dev, state);
+	disable_outputs(dev, old_state);
+	set_routing_links(dev, old_state);
+	crtc_set_mode(dev, old_state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_pre_planes);
 
-- 
2.0.5

