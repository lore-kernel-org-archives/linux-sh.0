From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:37:57 +0000
Subject: [PATCH 03/10] drm: rcar-du: Move properties from rcar_du_planes to rcar_du_device
Message-Id: <1430267884-20560-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The plane property objects are instantiated once per CRTC group, while
they should be instantiated once globally for the device. Fix this and
move them to the rcar_du_device structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  6 +++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 29 +++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 46 +++++++++------------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  4 ---
 4 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index c7c538dd2e68..9f34fc86436a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -83,6 +83,12 @@ struct rcar_du_device {
 
 	struct rcar_du_group groups[RCAR_DU_MAX_GROUPS];
 
+	struct {
+		struct drm_property *alpha;
+		struct drm_property *colorkey;
+		struct drm_property *zpos;
+	} props;
+
 	unsigned int dpad0_source;
 	struct rcar_du_lvdsenc *lvds[RCAR_DU_MAX_LVDS];
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 93117f159a3b..5fd6f8c07ec2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -648,6 +648,31 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 	return num_encoders;
 }
 
+static int rcar_du_properties_init(struct rcar_du_device *rcdu)
+{
+	rcdu->props.alpha +		drm_property_create_range(rcdu->ddev, 0, "alpha", 0, 255);
+	if (rcdu->props.alpha = NULL)
+		return -ENOMEM;
+
+	/* The color key is expressed as an RGB888 triplet stored in a 32-bit
+	 * integer in XRGB8888 format. Bit 24 is used as a flag to disable (0)
+	 * or enable source color keying (1).
+	 */
+	rcdu->props.colorkey +		drm_property_create_range(rcdu->ddev, 0, "colorkey",
+					  0, 0x01ffffff);
+	if (rcdu->props.colorkey = NULL)
+		return -ENOMEM;
+
+	rcdu->props.zpos +		drm_property_create_range(rcdu->ddev, 0, "zpos", 1, 7);
+	if (rcdu->props.zpos = NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 {
 	static const unsigned int mmio_offsets[] = {
@@ -672,6 +697,10 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	rcdu->num_crtcs = rcdu->info->num_crtcs;
 
+	ret = rcar_du_properties_init(rcdu);
+	if (ret < 0)
+		return ret;
+
 	/* Initialize the groups. */
 	num_groups = DIV_ROUND_UP(rcdu->num_crtcs, 2);
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 210e5c3fd982..b5565417f673 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -328,14 +328,13 @@ static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
 					     uint64_t val)
 {
 	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
-	struct rcar_du_plane *rplane = to_rcar_plane(plane);
-	struct rcar_du_group *rgrp = rplane->group;
+	struct rcar_du_device *rcdu = to_rcar_plane(plane)->group->dev;
 
-	if (property = rgrp->planes.alpha)
+	if (property = rcdu->props.alpha)
 		rstate->alpha = val;
-	else if (property = rgrp->planes.colorkey)
+	else if (property = rcdu->props.colorkey)
 		rstate->colorkey = val;
-	else if (property = rgrp->planes.zpos)
+	else if (property = rcdu->props.zpos)
 		rstate->zpos = val;
 	else
 		return -EINVAL;
@@ -349,14 +348,13 @@ static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
 {
 	const struct rcar_du_plane_state *rstate  		container_of(state, const struct rcar_du_plane_state, state);
-	struct rcar_du_plane *rplane = to_rcar_plane(plane);
-	struct rcar_du_group *rgrp = rplane->group;
+	struct rcar_du_device *rcdu = to_rcar_plane(plane)->group->dev;
 
-	if (property = rgrp->planes.alpha)
+	if (property = rcdu->props.alpha)
 		*val = rstate->alpha;
-	else if (property = rgrp->planes.colorkey)
+	else if (property = rcdu->props.colorkey)
 		*val = rstate->colorkey;
-	else if (property = rgrp->planes.zpos)
+	else if (property = rcdu->props.zpos)
 		*val = rstate->zpos;
 	else
 		return -EINVAL;
@@ -399,27 +397,7 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 	unsigned int i;
 	int ret;
 
-	planes->alpha -		drm_property_create_range(rcdu->ddev, 0, "alpha", 0, 255);
-	if (planes->alpha = NULL)
-		return -ENOMEM;
-
-	/* The color key is expressed as an RGB888 triplet stored in a 32-bit
-	 * integer in XRGB8888 format. Bit 24 is used as a flag to disable (0)
-	 * or enable source color keying (1).
-	 */
-	planes->colorkey -		drm_property_create_range(rcdu->ddev, 0, "colorkey",
-					  0, 0x01ffffff);
-	if (planes->colorkey = NULL)
-		return -ENOMEM;
-
-	planes->zpos -		drm_property_create_range(rcdu->ddev, 0, "zpos", 1, 7);
-	if (planes->zpos = NULL)
-		return -ENOMEM;
-
-	 /* Create one primary plane per in this group CRTC and seven overlay
+	 /* Create one primary plane per CRTC in this group and seven overlay
 	  * planes.
 	  */
 	num_crtcs = min(rcdu->num_crtcs - 2 * rgrp->index, 2U);
@@ -448,12 +426,12 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 			continue;
 
 		drm_object_attach_property(&plane->plane.base,
-					   planes->alpha, 255);
+					   rcdu->props.alpha, 255);
 		drm_object_attach_property(&plane->plane.base,
-					   planes->colorkey,
+					   rcdu->props.colorkey,
 					   RCAR_DU_COLORKEY_NONE);
 		drm_object_attach_property(&plane->plane.base,
-					   planes->zpos, 1);
+					   rcdu->props.zpos, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 5d2b764919d8..9e8d13a27fc0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -40,10 +40,6 @@ static inline struct rcar_du_plane *to_rcar_plane(struct drm_plane *plane)
 
 struct rcar_du_planes {
 	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
-
-	struct drm_property *alpha;
-	struct drm_property *colorkey;
-	struct drm_property *zpos;
 };
 
 /*
-- 
2.0.5

