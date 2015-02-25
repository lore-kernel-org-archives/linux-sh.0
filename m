From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:35 +0000
Subject: [PATCH 15/38] drm: rcar-du: Implement universal plane support
Message-Id: <1424901298-6829-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Explicitly create the CRTC primary plane instead of relying on the core
helpers to do so. This simplifies the plane logic by merging the KMS and
software planes.

Reject plane API operations on the primary planes for now, as that code
will anyway be refactored when implementing support for atomic updates.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  3 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   |  7 ----
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 65 +++++++++++++++------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h | 17 ++++-----
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 5cf2cac75146..c2ca2a302f44 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -692,7 +692,8 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 
 	rcrtc->plane->crtc = crtc;
 
-	ret = drm_crtc_init(rcdu->ddev, crtc, &crtc_funcs);
+	ret = drm_crtc_init_with_planes(rcdu->ddev, crtc, &rcrtc->plane->plane,
+					NULL, &crtc_funcs);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 888df404932e..413145de3db3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -439,13 +439,6 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-	/* Now that the CRTCs have been initialized register the planes. */
-	for (i = 0; i < num_groups; ++i) {
-		ret = rcar_du_planes_register(&rcdu->groups[i]);
-		if (ret < 0)
-			return ret;
-	}
-
 	drm_kms_helper_poll_init(dev);
 
 	if (dev->mode_config.num_connector) {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 50f2f2b20d39..242db1e1a1e4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -26,14 +26,9 @@
 #define RCAR_DU_COLORKEY_SOURCE		(1 << 24)
 #define RCAR_DU_COLORKEY_MASK		(1 << 24)
 
-struct rcar_du_kms_plane {
-	struct drm_plane plane;
-	struct rcar_du_plane *hwplane;
-};
-
 static inline struct rcar_du_plane *to_rcar_plane(struct drm_plane *plane)
 {
-	return container_of(plane, struct rcar_du_kms_plane, plane)->hwplane;
+	return container_of(plane, struct rcar_du_plane, plane);
 }
 
 static u32 rcar_du_plane_read(struct rcar_du_group *rgrp,
@@ -299,6 +294,9 @@ rcar_du_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 	unsigned int nplanes;
 	int ret;
 
+	if (plane->type != DRM_PLANE_TYPE_OVERLAY)
+		return -EINVAL;
+
 	format = rcar_du_format_info(fb->pixel_format);
 	if (format = NULL) {
 		dev_dbg(rcdu->dev, "%s: unsupported format %08x\n", __func__,
@@ -348,6 +346,9 @@ static int rcar_du_plane_disable(struct drm_plane *plane)
 {
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 
+	if (plane->type != DRM_PLANE_TYPE_OVERLAY)
+		return -EINVAL;
+
 	if (!rplane->enabled)
 		return 0;
 
@@ -453,7 +454,11 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 {
 	struct rcar_du_planes *planes = &rgrp->planes;
 	struct rcar_du_device *rcdu = rgrp->dev;
+	unsigned int num_planes;
+	unsigned int num_crtcs;
+	unsigned int crtcs;
 	unsigned int i;
+	int ret;
 
 	mutex_init(&planes->lock);
 	planes->free = 0xff;
@@ -478,45 +483,35 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 	if (planes->zpos = NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(planes->planes); ++i) {
+	 /* Create one primary plane per in this group CRTC and seven overlay
+	  * planes.
+	  */
+	num_crtcs = min(rcdu->num_crtcs - 2 * rgrp->index, 2U);
+	num_planes = num_crtcs + 7;
+
+	crtcs = ((1 << rcdu->num_crtcs) - 1) & (3 << (2 * rgrp->index));
+
+	for (i = 0; i < num_planes; ++i) {
+		enum drm_plane_type type = i < num_crtcs
+					 ? DRM_PLANE_TYPE_PRIMARY
+					 : DRM_PLANE_TYPE_OVERLAY;
 		struct rcar_du_plane *plane = &planes->planes[i];
 
 		plane->group = rgrp;
 		plane->hwindex = -1;
 		plane->alpha = 255;
 		plane->colorkey = RCAR_DU_COLORKEY_NONE;
-		plane->zpos = 0;
-	}
-
-	return 0;
-}
+		plane->zpos = type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
 
-int rcar_du_planes_register(struct rcar_du_group *rgrp)
-{
-	struct rcar_du_planes *planes = &rgrp->planes;
-	struct rcar_du_device *rcdu = rgrp->dev;
-	unsigned int crtcs;
-	unsigned int i;
-	int ret;
-
-	crtcs = ((1 << rcdu->num_crtcs) - 1) & (3 << (2 * rgrp->index));
-
-	for (i = 0; i < RCAR_DU_NUM_KMS_PLANES; ++i) {
-		struct rcar_du_kms_plane *plane;
-
-		plane = devm_kzalloc(rcdu->dev, sizeof(*plane), GFP_KERNEL);
-		if (plane = NULL)
-			return -ENOMEM;
-
-		plane->hwplane = &planes->planes[i + 2];
-		plane->hwplane->zpos = 1;
-
-		ret = drm_plane_init(rcdu->ddev, &plane->plane, crtcs,
-				     &rcar_du_plane_funcs, formats,
-				     ARRAY_SIZE(formats), false);
+		ret = drm_universal_plane_init(rcdu->ddev, &plane->plane, crtcs,
+					       &rcar_du_plane_funcs, formats,
+					       ARRAY_SIZE(formats), type);
 		if (ret < 0)
 			return ret;
 
+		if (type = DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
 		drm_object_attach_property(&plane->plane.base,
 					   planes->alpha, 255);
 		drm_object_attach_property(&plane->plane.base,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 3021288b1a89..813b3212392a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -22,17 +22,17 @@
 struct rcar_du_format_info;
 struct rcar_du_group;
 
-/* The RCAR DU has 8 hardware planes, shared between KMS planes and CRTCs. As
- * using KMS planes requires at least one of the CRTCs being enabled, no more
- * than 7 KMS planes can be available. We thus create 7 KMS planes and
- * 9 software planes (one for each KMS planes and one for each CRTC).
+/* The RCAR DU has 8 hardware planes, shared between primary and overlay planes.
+ * As using overlay planes requires at least one of the CRTCs being enabled, no
+ * more than 7 overlay planes can be available. We thus create 1 primary plane
+ * per CRTC and 7 overlay planes, for a total of up to 9 KMS planes.
  */
-
-#define RCAR_DU_NUM_KMS_PLANES		7
+#define RCAR_DU_NUM_KMS_PLANES		9
 #define RCAR_DU_NUM_HW_PLANES		8
-#define RCAR_DU_NUM_SW_PLANES		9
 
 struct rcar_du_plane {
+	struct drm_plane plane;
+
 	struct rcar_du_group *group;
 	struct drm_crtc *crtc;
 
@@ -58,7 +58,7 @@ struct rcar_du_plane {
 };
 
 struct rcar_du_planes {
-	struct rcar_du_plane planes[RCAR_DU_NUM_SW_PLANES];
+	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
 	unsigned int free;
 	struct mutex lock;
 
@@ -68,7 +68,6 @@ struct rcar_du_planes {
 };
 
 int rcar_du_planes_init(struct rcar_du_group *rgrp);
-int rcar_du_planes_register(struct rcar_du_group *rgrp);
 
 void rcar_du_plane_setup(struct rcar_du_plane *plane);
 void rcar_du_plane_update_base(struct rcar_du_plane *plane);
-- 
2.0.5

