From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:50:59 +0000
Subject: [PATCH 12/22] drm: rcar-du: Fix compile warning on 64-bit platforms
Message-Id: <1442184669-30990-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Use %tu instead of %u to print difference between pointers.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 4a38ced4b952..7d2e301df042 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -153,7 +153,7 @@ int rcar_du_atomic_check_planes(struct drm_device *dev,
 		plane = to_rcar_plane(state->planes[i]);
 		plane_state = to_rcar_plane_state(state->plane_states[i]);
 
-		dev_dbg(rcdu->dev, "%s: checking plane (%u,%u)\n", __func__,
+		dev_dbg(rcdu->dev, "%s: checking plane (%u,%tu)\n", __func__,
 			plane->group->index, plane - plane->group->planes);
 
 		/* If the plane is being disabled we don't need to go through
@@ -221,7 +221,7 @@ int rcar_du_atomic_check_planes(struct drm_device *dev,
 			 */
 			if (group_freed_planes[index] & (1 << i)) {
 				dev_dbg(rcdu->dev,
-					"%s: plane (%u,%u) has been freed, skipping\n",
+					"%s: plane (%u,%tu) has been freed, skipping\n",
 					__func__, plane->group->index,
 					plane - plane->group->planes);
 				continue;
@@ -231,7 +231,7 @@ int rcar_du_atomic_check_planes(struct drm_device *dev,
 			used_planes |= rcar_du_plane_hwmask(plane_state);
 
 			dev_dbg(rcdu->dev,
-				"%s: plane (%u,%u) uses %u hwplanes (index %d)\n",
+				"%s: plane (%u,%tu) uses %u hwplanes (index %d)\n",
 				__func__, plane->group->index,
 				plane - plane->group->planes,
 				plane_state->format ?
@@ -260,7 +260,7 @@ int rcar_du_atomic_check_planes(struct drm_device *dev,
 		plane = to_rcar_plane(state->planes[i]);
 		plane_state = to_rcar_plane_state(state->plane_states[i]);
 
-		dev_dbg(rcdu->dev, "%s: allocating plane (%u,%u)\n", __func__,
+		dev_dbg(rcdu->dev, "%s: allocating plane (%u,%tu)\n", __func__,
 			plane->group->index, plane - plane->group->planes);
 
 		/* Skip planes that are being disabled or don't need to be
-- 
2.4.6

