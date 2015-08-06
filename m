From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 06 Aug 2015 00:23:00 +0000
Subject: [PATCH] drm: rcar-du: Fix plane state free in plane reset handler
Message-Id: <1438820580-14301-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The plane reset handler frees the plane state and allocates a new
default state, but when doing so attempt to free the plane state using
the base plane state pointer instead of casting it to the
driver-specific state object that has been allocated. Fix it by using
the rcar_du_plane_atomic_destroy_state() function to destroy the plane
state instead of duplicating the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 45 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

Should the DRM core free the atomic state before calling the reset operation ?
That would simplify drivers.

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index c66986414bb4..ffa583712cd9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -273,29 +273,6 @@ static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
 	.atomic_update = rcar_du_plane_atomic_update,
 };
 
-static void rcar_du_plane_reset(struct drm_plane *plane)
-{
-	struct rcar_du_plane_state *state;
-
-	if (plane->state && plane->state->fb)
-		drm_framebuffer_unreference(plane->state->fb);
-
-	kfree(plane->state);
-	plane->state = NULL;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (state = NULL)
-		return;
-
-	state->hwindex = -1;
-	state->alpha = 255;
-	state->colorkey = RCAR_DU_COLORKEY_NONE;
-	state->zpos = plane->type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
-
-	plane->state = &state->state;
-	plane->state->plane = plane;
-}
-
 static struct drm_plane_state *
 rcar_du_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
@@ -322,6 +299,28 @@ static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
 	kfree(to_rcar_plane_state(state));
 }
 
+static void rcar_du_plane_reset(struct drm_plane *plane)
+{
+	struct rcar_du_plane_state *state;
+
+	if (plane->state) {
+		rcar_du_plane_atomic_destroy_state(plane, plane->state);
+		plane->state = NULL;
+	}
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state = NULL)
+		return;
+
+	state->hwindex = -1;
+	state->alpha = 255;
+	state->colorkey = RCAR_DU_COLORKEY_NONE;
+	state->zpos = plane->type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
+
+	plane->state = &state->state;
+	plane->state->plane = plane;
+}
+
 static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
 					     struct drm_plane_state *state,
 					     struct drm_property *property,
-- 
2.4.6

