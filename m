From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 May 2015 13:41:15 +0000
Subject: [PATCH] drm: rcar-du: Use the drm atomic state duplication helpers for planes
Message-Id: <1432734075-32483-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Ensure that the duplicate and destroy plane state operations will always
be in sync with the DRM core implementation of the plane state by using
the __drm_atomic_helper_plane_duplicate_state() and
__drm_atomic_helper_plane_destroy_state() functions designed especially
for this purpose.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 3e30d84b798f..dd38484e8281 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -302,13 +302,15 @@ rcar_du_plane_atomic_duplicate_state(struct drm_plane *plane)
 	struct rcar_du_plane_state *state;
 	struct rcar_du_plane_state *copy;
 
+	if (WARN_ON(!plane->state))
+		return NULL;
+
 	state = to_rcar_plane_state(plane->state);
 	copy = kmemdup(state, sizeof(*state), GFP_KERNEL);
 	if (copy = NULL)
 		return NULL;
 
-	if (copy->state.fb)
-		drm_framebuffer_reference(copy->state.fb);
+	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
 
 	return &copy->state;
 }
@@ -316,9 +318,7 @@ rcar_du_plane_atomic_duplicate_state(struct drm_plane *plane)
 static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
 					       struct drm_plane_state *state)
 {
-	if (state->fb)
-		drm_framebuffer_unreference(state->fb);
-
+	__drm_atomic_helper_plane_destroy_state(plane, state);
 	kfree(to_rcar_plane_state(state));
 }
 
-- 
Regards,

Laurent Pinchart

