From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 15 Mar 2015 12:55:27 +0000
Subject: [PATCH 1/3] drm: rcar-du: Fix framebuffer reference leak through plane state
Message-Id: <1426424129-20746-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Plane state duplication takes a reference to the framebuffer stored in
the state, but state destroy doesn't release it. This causes a reference
leak. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 35a2f04ab799..210e5c3fd982 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -316,6 +316,9 @@ rcar_du_plane_atomic_duplicate_state(struct drm_plane *plane)
 static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
 					       struct drm_plane_state *state)
 {
+	if (state->fb)
+		drm_framebuffer_unreference(state->fb);
+
 	kfree(to_rcar_du_plane_state(state));
 }
 
-- 
2.0.5

