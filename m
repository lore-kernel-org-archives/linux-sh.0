From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:38:03 +0000
Subject: [PATCH 09/10] drm: rcar-du: Store the number of CRTCs per group in the group structure
Message-Id: <1430267884-20560-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The number of CRTCs in a group is only used to implement plane
initialization for now, but is also needed to implement pre-association
of planes to CRTCs. Store it in the group structure instead of computing
it on demand.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_group.h | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 1 +
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 6 ++----
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 4f6c37c8d336..7b414b31c3be 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -25,6 +25,7 @@ struct rcar_du_device;
  * @dev: the DU device
  * @mmio_offset: registers offset in the device memory map
  * @index: group index
+ * @num_crtcs: number of CRTCs in this group (1 or 2)
  * @use_count: number of users of the group (rcar_du_group_(get|put))
  * @used_crtcs: number of CRTCs currently in use
  * @lock: protects the dptsr_planes field and the DPTSR register
@@ -36,6 +37,7 @@ struct rcar_du_group {
 	unsigned int mmio_offset;
 	unsigned int index;
 
+	unsigned int num_crtcs;
 	unsigned int use_count;
 	unsigned int used_crtcs;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 2c6cf691d163..fec5f4d794da 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -763,6 +763,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		rgrp->dev = rcdu;
 		rgrp->mmio_offset = mmio_offsets[i];
 		rgrp->index = i;
+		rgrp->num_crtcs = min(rcdu->num_crtcs - 2 * i, 2U);
 
 		/* Pre-associate all hardware planes with the first CRTC in the
 		 * group.
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index d3ed528fa56d..3e30d84b798f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -391,7 +391,6 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 {
 	struct rcar_du_device *rcdu = rgrp->dev;
 	unsigned int num_planes;
-	unsigned int num_crtcs;
 	unsigned int crtcs;
 	unsigned int i;
 	int ret;
@@ -399,13 +398,12 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 	 /* Create one primary plane per CRTC in this group and seven overlay
 	  * planes.
 	  */
-	num_crtcs = min(rcdu->num_crtcs - 2 * rgrp->index, 2U);
-	num_planes = num_crtcs + 7;
+	num_planes = rgrp->num_crtcs + 7;
 
 	crtcs = ((1 << rcdu->num_crtcs) - 1) & (3 << (2 * rgrp->index));
 
 	for (i = 0; i < num_planes; ++i) {
-		enum drm_plane_type type = i < num_crtcs
+		enum drm_plane_type type = i < rgrp->num_crtcs
 					 ? DRM_PLANE_TYPE_PRIMARY
 					 : DRM_PLANE_TYPE_OVERLAY;
 		struct rcar_du_plane *plane = &rgrp->planes[i];
-- 
2.0.5

