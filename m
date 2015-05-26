From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 May 2015 15:01:54 +0000
Subject: [PATCH 1/3] drm: rcar-du: Fix crash with groups that have less than 9 planes
Message-Id: <1432652516-15085-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Cao Minh Hiep <cm-hiep@jinso.co.jp>

Commit 917de180379d ("drm: rcar-du: Implement universal plane support")
made the number of planes per group dynamic, but didn't update all loops
over the planes array, resulting in out-of-bound accesses on DU
instances that have an odd number of CRTCs (such as the R8A7790). Fix
it.

Fixes: 917de180379d ("drm: rcar-du: Implement universal plane support")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_group.h | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 5 ++---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index a40085806f5b..65d6ba6621ac 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -214,7 +214,7 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 	unsigned int i;
 	u32 dspr = 0;
 
-	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes); ++i) {
+	for (i = 0; i < rcrtc->group->num_planes; ++i) {
 		struct rcar_du_plane *plane = &rcrtc->group->planes[i];
 		unsigned int j;
 
@@ -445,7 +445,7 @@ void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_start(rcrtc);
 
 	/* Commit the planes state. */
-	for (i = 0; i < ARRAY_SIZE(rcrtc->group->planes); ++i) {
+	for (i = 0; i < rcrtc->group->num_planes; ++i) {
 		struct rcar_du_plane *plane = &rcrtc->group->planes[i];
 
 		if (plane->plane.state->crtc != &rcrtc->crtc)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 7b414b31c3be..d7318e1a6b00 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -30,6 +30,7 @@ struct rcar_du_device;
  * @used_crtcs: number of CRTCs currently in use
  * @lock: protects the dptsr_planes field and the DPTSR register
  * @dptsr_planes: bitmask of planes driven by dot-clock and timing generator 1
+ * @num_planes: number of planes in the group
  * @planes: planes handled by the group
  */
 struct rcar_du_group {
@@ -44,6 +45,7 @@ struct rcar_du_group {
 	struct mutex lock;
 	unsigned int dptsr_planes;
 
+	unsigned int num_planes;
 	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 20859aae882e..4bb5af4bc474 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -336,7 +336,7 @@ static int rcar_du_atomic_check(struct drm_device *dev,
 		dev_dbg(rcdu->dev, "%s: finding free planes for group %u\n",
 			__func__, index);
 
-		for (i = 0; i < RCAR_DU_NUM_KMS_PLANES; ++i) {
+		for (i = 0; i < group->num_planes; ++i) {
 			struct rcar_du_plane *plane = &group->planes[i];
 			struct rcar_du_plane_state *plane_state;
 			struct drm_plane_state *s;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 3e30d84b798f..d90dc428e3fd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -390,7 +390,6 @@ static const uint32_t formats[] = {
 int rcar_du_planes_init(struct rcar_du_group *rgrp)
 {
 	struct rcar_du_device *rcdu = rgrp->dev;
-	unsigned int num_planes;
 	unsigned int crtcs;
 	unsigned int i;
 	int ret;
@@ -398,11 +397,11 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 	 /* Create one primary plane per CRTC in this group and seven overlay
 	  * planes.
 	  */
-	num_planes = rgrp->num_crtcs + 7;
+	rgrp->num_planes = rgrp->num_crtcs + 7;
 
 	crtcs = ((1 << rcdu->num_crtcs) - 1) & (3 << (2 * rgrp->index));
 
-	for (i = 0; i < num_planes; ++i) {
+	for (i = 0; i < rgrp->num_planes; ++i) {
 		enum drm_plane_type type = i < rgrp->num_crtcs
 					 ? DRM_PLANE_TYPE_PRIMARY
 					 : DRM_PLANE_TYPE_OVERLAY;
-- 
2.3.6

