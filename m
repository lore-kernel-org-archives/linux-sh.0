From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Mar 2015 01:21:56 +0000
Subject: [PATCH] drm/rcar-du: Avoid restarting when shutting down
Message-Id: <20150317012156.3466.18403.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is a prototype patch that removes one DU restart operation
from the shutdown sequence. With this in place both the required
time for mode switching is reduced and so is the amount of flicker.

Needs to be reworked to fit on top of atomic update support.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- 0001/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_crtc.c	2015-03-16 12:43:00.127684181 +0900
@@ -187,7 +187,7 @@ void rcar_du_crtc_route_output(struct dr
 		rcdu->dpad0_source = rcrtc->index;
 }
 
-void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
+static void __rcar_du_crtc_update_planes(struct drm_crtc *crtc, bool restart)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_du_plane *planes[RCAR_DU_NUM_HW_PLANES];
@@ -247,7 +247,7 @@ void rcar_du_crtc_update_planes(struct d
 		 */
 		if (value != dptsr) {
 			rcar_du_group_write(rcrtc->group, DPTSR, dptsr);
-			if (rcrtc->group->used_crtcs)
+			if (restart && rcrtc->group->used_crtcs)
 				rcar_du_group_restart(rcrtc->group);
 		}
 	}
@@ -256,6 +256,11 @@ void rcar_du_crtc_update_planes(struct d
 			    dspr);
 }
 
+void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
+{
+	__rcar_du_crtc_update_planes(crtc, true);
+}
+
 static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
@@ -314,7 +319,7 @@ static void rcar_du_crtc_stop(struct rca
 
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcrtc->plane->enabled = false;
-	rcar_du_crtc_update_planes(crtc);
+	__rcar_du_crtc_update_planes(crtc, false);
 	mutex_unlock(&rcrtc->group->planes.lock);
 
 	/* Select switch sync mode. This stops display operation and configures
