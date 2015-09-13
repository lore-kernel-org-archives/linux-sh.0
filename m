From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:50:53 +0000
Subject: [PATCH 06/22] drm: rcar-du: Add VSP1 support to the planes allocator
Message-Id: <1442184669-30990-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The R8A7790 DU can source frames directly from the VSP1 devices VSPD0
and VSPD1. VSPD0 feeds DU0/1 plane 0, and VSPD1 feeds either DU2 plane 0
or DU0/1 plane 1.

Allocate the correct fixed plane when sourcing frames from VSPD0 or
VSPD1, and allocate planes in reverse index order otherwise to ensure
maximum availability of planes 0 and 1.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 42 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/rcar-du/rcar_du_plane.c |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  7 ++++++
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 20813582fbf1..455f7e466181 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -244,11 +244,41 @@ static unsigned int rcar_du_plane_hwmask(struct rcar_du_plane_state *state)
 	return mask;
 }
 
-static int rcar_du_plane_hwalloc(unsigned int num_planes, unsigned int free)
+/*
+ * The R8A7790 DU can source frames directly from the VSP1 devices VSPD0 and
+ * VSPD1. VSPD0 feeds DU0/1 plane 0, and VSPD1 feeds either DU2 plane 0 or
+ * DU0/1 plane 1.
+ *
+ * Allocate the correct fixed plane when sourcing frames from VSPD0 or VSPD1,
+ * and allocate planes in reverse index order otherwise to ensure maximum
+ * availability of planes 0 and 1.
+ *
+ * The caller is responsible for ensuring that the requested source is
+ * compatible with the DU revision.
+ */
+static int rcar_du_plane_hwalloc(struct rcar_du_plane *plane,
+				 struct rcar_du_plane_state *state,
+				 unsigned int free)
 {
-	unsigned int i;
+	unsigned int num_planes = state->format->planes;
+	int fixed = -1;
+	int i;
+
+	if (state->source = RCAR_DU_PLANE_VSPD0) {
+		/* VSPD0 feeds plane 0 on DU0/1. */
+		if (plane->group->index != 0)
+			return -EINVAL;
+
+		fixed = 0;
+	} else if (state->source = RCAR_DU_PLANE_VSPD1) {
+		/* VSPD1 feeds plane 1 on DU0/1 or plane 0 on DU2. */
+		fixed = plane->group->index = 0 ? 1 : 0;
+	}
+
+	if (fixed >= 0)
+		return free & (1 << fixed) ? fixed : -EBUSY;
 
-	for (i = 0; i < RCAR_DU_NUM_HW_PLANES; ++i) {
+	for (i = RCAR_DU_NUM_HW_PLANES - 1; i >= 0; --i) {
 		if (!(free & (1 << i)))
 			continue;
 
@@ -256,7 +286,7 @@ static int rcar_du_plane_hwalloc(unsigned int num_planes, unsigned int free)
 			break;
 	}
 
-	return i = RCAR_DU_NUM_HW_PLANES ? -EBUSY : i;
+	return i < 0 ? -EBUSY : i;
 }
 
 static int rcar_du_atomic_check(struct drm_device *dev,
@@ -413,10 +443,10 @@ static int rcar_du_atomic_check(struct drm_device *dev,
 			    : ~plane->group->dptsr_planes;
 		free = group_free_planes[plane->group->index];
 
-		idx = rcar_du_plane_hwalloc(plane_state->format->planes,
+		idx = rcar_du_plane_hwalloc(plane, plane_state,
 					    free & crtc_planes);
 		if (idx < 0)
-			idx = rcar_du_plane_hwalloc(plane_state->format->planes,
+			idx = rcar_du_plane_hwalloc(plane, plane_state,
 						    free);
 		if (idx < 0) {
 			dev_dbg(rcdu->dev, "%s: no available hardware plane\n",
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index d64b23027749..f301c15934cc 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -309,6 +309,7 @@ static void rcar_du_plane_reset(struct drm_plane *plane)
 		return;
 
 	state->hwindex = -1;
+	state->source = RCAR_DU_PLANE_MEMORY;
 	state->alpha = 255;
 	state->colorkey = RCAR_DU_COLORKEY_NONE;
 	state->zpos = plane->type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 9732bff1911b..e24e45828d6a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -28,6 +28,12 @@ struct rcar_du_group;
 #define RCAR_DU_NUM_KMS_PLANES		9
 #define RCAR_DU_NUM_HW_PLANES		8
 
+enum rcar_du_plane_source {
+	RCAR_DU_PLANE_MEMORY,
+	RCAR_DU_PLANE_VSPD0,
+	RCAR_DU_PLANE_VSPD1,
+};
+
 struct rcar_du_plane {
 	struct drm_plane plane;
 	struct rcar_du_group *group;
@@ -52,6 +58,7 @@ struct rcar_du_plane_state {
 
 	const struct rcar_du_format_info *format;
 	int hwindex;
+	enum rcar_du_plane_source source;
 
 	unsigned int alpha;
 	unsigned int colorkey;
-- 
2.4.6

