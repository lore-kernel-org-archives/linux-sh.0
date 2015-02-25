From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:57 +0000
Subject: [PATCH 37/38] drm: rcar-du: Move group locking inside rcar_du_crtc_update_planes()
Message-Id: <1424901298-6829-38-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Only the planes to CRTCs association control register DPTSR needs to be
protected by custom locking, don't hold the mutex around the whole code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 29bbb44eecc9..8459aaee8add 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -252,8 +252,6 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 	 * with superposition controller 2.
 	 */
 	if (rcrtc->index % 2) {
-		u32 value = rcar_du_group_read(rcrtc->group, DPTSR);
-
 		/* The DPTSR register is updated when the display controller is
 		 * stopped. We thus need to restart the DU. Once again, sorry
 		 * for the flicker. One way to mitigate the issue would be to
@@ -261,11 +259,13 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 		 * split, or through a module parameter). Flicker would then
 		 * occur only if we need to break the pre-association.
 		 */
-		if (value != dptsr) {
+		mutex_lock(&rcrtc->group->planes.lock);
+		if (rcar_du_group_read(rcrtc->group, DPTSR) != dptsr) {
 			rcar_du_group_write(rcrtc->group, DPTSR, dptsr);
 			if (rcrtc->group->used_crtcs)
 				rcar_du_group_restart(rcrtc->group);
 		}
+		mutex_unlock(&rcrtc->group->planes.lock);
 	}
 
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR,
@@ -435,9 +435,7 @@ void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc)
 		rcar_du_plane_setup(plane);
 	}
 
-	mutex_lock(&rcrtc->group->planes.lock);
 	rcar_du_crtc_update_planes(rcrtc);
-	mutex_unlock(&rcrtc->group->planes.lock);
 }
 
 /* -----------------------------------------------------------------------------
@@ -501,9 +499,7 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
-	mutex_lock(&rcrtc->group->planes.lock);
 	rcar_du_crtc_update_planes(rcrtc);
-	mutex_unlock(&rcrtc->group->planes.lock);
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
-- 
2.0.5

