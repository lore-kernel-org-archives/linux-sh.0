From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:38:01 +0000
Subject: [PATCH 07/10] drm: rcar-du: Keep plane to CRTC associations when disabling a plane
Message-Id: <1430267884-20560-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Changing the plane to CRTC associations requires restarting the CRTC
group, creating visible flicker. Mitigate the issue by changing plane
association only when a plane becomes enabled, not when it get disabled.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 48 +++++++++++++++++++--------------
 drivers/gpu/drm/rcar-du/rcar_du_group.c |  6 +++++
 drivers/gpu/drm/rcar-du/rcar_du_group.h |  4 ++-
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 15f8d145a133..620a2c51185c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -208,9 +208,10 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 {
 	struct rcar_du_plane *planes[RCAR_DU_NUM_HW_PLANES];
 	unsigned int num_planes = 0;
+	unsigned int dptsr_planes;
+	unsigned int hwplanes = 0;
 	unsigned int prio = 0;
 	unsigned int i;
-	u32 dptsr = 0;
 	u32 dspr = 0;
 
 	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes); ++i) {
@@ -238,37 +239,44 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 
 		prio -= 4;
 		dspr |= (index + 1) << prio;
-		dptsr |= DPTSR_PnDK(index) |  DPTSR_PnTS(index);
+		hwplanes |= 1 << index;
 
 		if (plane_format(plane)->planes = 2) {
 			index = (index + 1) % 8;
 
 			prio -= 4;
 			dspr |= (index + 1) << prio;
-			dptsr |= DPTSR_PnDK(index) |  DPTSR_PnTS(index);
+			hwplanes |= 1 << index;
 		}
 	}
 
-	/* Select display timing and dot clock generator 2 for planes associated
-	 * with superposition controller 2.
+	/* Update the planes to display timing and dot clock generator
+	 * associations.
+	 *
+	 * Updating the DPTSR register requires restarting the CRTC group,
+	 * resulting in visible flicker. To mitigate the issue only update the
+	 * association if needed by enabled planes. Planes being disabled will
+	 * keep their current association.
+	 *
+	 * To mitigate the issue further we could pre-associate planes with
+	 * CRTCs, either with a fixed 4/4 split, or through a module parameter.
 	 */
-	if (rcrtc->index % 2) {
-		/* The DPTSR register is updated when the display controller is
-		 * stopped. We thus need to restart the DU. Once again, sorry
-		 * for the flicker. One way to mitigate the issue would be to
-		 * pre-associate planes with CRTCs (either with a fixed 4/4
-		 * split, or through a module parameter). Flicker would then
-		 * occur only if we need to break the pre-association.
-		 */
-		mutex_lock(&rcrtc->group->lock);
-		if (rcar_du_group_read(rcrtc->group, DPTSR) != dptsr) {
-			rcar_du_group_write(rcrtc->group, DPTSR, dptsr);
-			if (rcrtc->group->used_crtcs)
-				rcar_du_group_restart(rcrtc->group);
-		}
-		mutex_unlock(&rcrtc->group->lock);
+	mutex_lock(&rcrtc->group->lock);
+
+	dptsr_planes = rcrtc->index % 2 ? rcrtc->group->dptsr_planes | hwplanes
+		     : rcrtc->group->dptsr_planes & ~hwplanes;
+
+	if (dptsr_planes != rcrtc->group->dptsr_planes) {
+		rcar_du_group_write(rcrtc->group, DPTSR,
+				    (dptsr_planes << 16) | dptsr_planes);
+		rcrtc->group->dptsr_planes = dptsr_planes;
+
+		if (rcrtc->group->used_crtcs)
+			rcar_du_group_restart(rcrtc->group);
 	}
 
+	mutex_unlock(&rcrtc->group->lock);
+
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR,
 			    dspr);
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 1bdc0ee0c248..7fd39a7d91c8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -85,6 +85,12 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
 	 */
 	rcar_du_group_write(rgrp, DORCR, DORCR_PG1D_DS1 | DORCR_DPRS);
+
+	/* Apply planes to CRTCs association. */
+	mutex_lock(&rgrp->lock);
+	rcar_du_group_write(rgrp, DPTSR, (rgrp->dptsr_planes << 16) |
+			    rgrp->dptsr_planes);
+	mutex_unlock(&rgrp->lock);
 }
 
 /*
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index ea02bb02f3e1..4f6c37c8d336 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -27,7 +27,8 @@ struct rcar_du_device;
  * @index: group index
  * @use_count: number of users of the group (rcar_du_group_(get|put))
  * @used_crtcs: number of CRTCs currently in use
- * @lock: protects the DPTSR register
+ * @lock: protects the dptsr_planes field and the DPTSR register
+ * @dptsr_planes: bitmask of planes driven by dot-clock and timing generator 1
  * @planes: planes handled by the group
  */
 struct rcar_du_group {
@@ -39,6 +40,7 @@ struct rcar_du_group {
 	unsigned int used_crtcs;
 
 	struct mutex lock;
+	unsigned int dptsr_planes;
 
 	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
 };
-- 
2.0.5

