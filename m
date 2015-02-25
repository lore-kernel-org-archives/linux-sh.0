From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:58 +0000
Subject: [PATCH 38/38] drm: rcar-du: Fix race condition in hardware plane allocator
Message-Id: <1424901298-6829-39-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The plane allocator has been inherently racy since the beginning of the
transition to atomic updates, as the allocator lock is released between
free plane check (at .atomic_check() time) and the reservation (at
.atomic_update() time).

To fix it, create a new allocator solely based on the atomic plane
states without keeping any external state and perform allocation in the
.atomic_check() handler. The core idea is to replace the free planes
bitmask with a collective knowledge based on the allocated hardware
plane(s) for each KMS plane. The allocator then loops over all plane
states to compute the free planes bitmask, allocates hardware planes
based on that bitmask, and stores the result back in the plane states.

For this to work we need to access the current state of planes not
touched by the atomic update. To ensure that it won't be modified, we
need to lock all planes using drm_atomic_get_plane_state(). This
effectively serializes atomic updates from .atomic_check() up to
completion, either when swapping the states if the check step has
succeeded, or when freeing the states if the check step has failed.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |   7 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.h |   5 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 203 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 166 ++------------------------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h |  11 +-
 5 files changed, 228 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 8459aaee8add..9e72133bb64b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -233,7 +233,8 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 
 	for (i = 0; i < num_planes; ++i) {
 		struct rcar_du_plane *plane = planes[i];
-		unsigned int index = plane->hwindex;
+		struct drm_plane_state *state = plane->plane.state;
+		unsigned int index = to_rcar_du_plane_state(state)->hwindex;
 
 		prio -= 4;
 		dspr |= (index + 1) << prio;
@@ -259,13 +260,13 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 		 * split, or through a module parameter). Flicker would then
 		 * occur only if we need to break the pre-association.
 		 */
-		mutex_lock(&rcrtc->group->planes.lock);
+		mutex_lock(&rcrtc->group->lock);
 		if (rcar_du_group_read(rcrtc->group, DPTSR) != dptsr) {
 			rcar_du_group_write(rcrtc->group, DPTSR, dptsr);
 			if (rcrtc->group->used_crtcs)
 				rcar_du_group_restart(rcrtc->group);
 		}
-		mutex_unlock(&rcrtc->group->planes.lock);
+		mutex_unlock(&rcrtc->group->lock);
 	}
 
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 0c38cdcda4ca..ed36433fbe84 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -14,6 +14,8 @@
 #ifndef __RCAR_DU_GROUP_H__
 #define __RCAR_DU_GROUP_H__
 
+#include <linux/mutex.h>
+
 #include "rcar_du_plane.h"
 
 struct rcar_du_device;
@@ -25,6 +27,7 @@ struct rcar_du_device;
  * @index: group index
  * @use_count: number of users of the group (rcar_du_group_(get|put))
  * @used_crtcs: number of CRTCs currently in use
+ * @lock: protects the DPTSR register
  * @planes: planes handled by the group
  */
 struct rcar_du_group {
@@ -35,6 +38,8 @@ struct rcar_du_group {
 	unsigned int use_count;
 	unsigned int used_crtcs;
 
+	struct mutex lock;
+
 	struct rcar_du_planes planes;
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 8bc7242ba979..fb052bca574f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -189,9 +189,206 @@ static void rcar_du_output_poll_changed(struct drm_device *dev)
 }
 
 /* -----------------------------------------------------------------------------
- * Atomic Updates
+ * Atomic Check and Update
  */
 
+/*
+ * Atomic hardware plane allocator
+ *
+ * The hardware plane allocator is solely based on the atomic plane states
+ * without keeping any external state to avoid races between .atomic_check()
+ * and .atomic_commit().
+ *
+ * The core idea is to avoid using a free planes bitmask that would need to be
+ * shared between check and commit handlers with a collective knowledge based on
+ * the allocated hardware plane(s) for each KMS plane. The allocator then loops
+ * over all plane states to compute the free planes bitmask, allocates hardware
+ * planes based on that bitmask, and stores the result back in the plane states.
+ *
+ * For this to work we need to access the current state of planes not touched by
+ * the atomic update. To ensure that it won't be modified, we need to lock all
+ * planes using drm_atomic_get_plane_state(). This effectively serializes atomic
+ * updates from .atomic_check() up to completion (when swapping the states if
+ * the check step has succeeded) or rollback (when freeing the states if the
+ * check step has failed).
+ *
+ * Allocation is performed in the .atomic_check() handler and applied
+ * automatically when the core swaps the old and new states.
+ */
+
+static bool rcar_du_plane_needs_realloc(struct rcar_du_plane *plane,
+					struct rcar_du_plane_state *state)
+{
+	const struct rcar_du_format_info *cur_format;
+
+	cur_format = to_rcar_du_plane_state(plane->plane.state)->format;
+
+	/* Lowering the number of planes doesn't strictly require reallocation
+	 * as the extra hardware plane will be freed when committing, but doing
+	 * so could lead to more fragmentation.
+	 */
+	return !cur_format || cur_format->planes != state->format->planes;
+}
+
+static unsigned int rcar_du_plane_hwmask(struct rcar_du_plane_state *state)
+{
+	unsigned int mask;
+
+	if (state->hwindex = -1)
+		return 0;
+
+	mask = 1 << state->hwindex;
+	if (state->format->planes = 2)
+		mask |= 1 << ((state->hwindex + 1) % 8);
+
+	return mask;
+}
+
+static int rcar_du_plane_hwalloc(unsigned int num_planes, unsigned int free)
+{
+	unsigned int i;
+
+	for (i = 0; i < RCAR_DU_NUM_HW_PLANES; ++i) {
+		if (!(free & (1 << i)))
+			continue;
+
+		if (num_planes = 1 || free & (1 << ((i + 1) % 8)))
+			break;
+	}
+
+	return i = RCAR_DU_NUM_HW_PLANES ? -EBUSY : i;
+}
+
+static int rcar_du_atomic_check(struct drm_device *dev,
+				struct drm_atomic_state *state)
+{
+	struct rcar_du_device *rcdu = dev->dev_private;
+	unsigned int group_freed_planes[RCAR_DU_MAX_GROUPS] = { 0, };
+	unsigned int group_free_planes[RCAR_DU_MAX_GROUPS] = { 0, };
+	bool needs_realloc = false;
+	unsigned int groups = 0;
+	unsigned int i;
+	int ret;
+
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret < 0)
+		return ret;
+
+	/* Check if hardware planes need to be reallocated. */
+	for (i = 0; i < dev->mode_config.num_total_plane; ++i) {
+		struct rcar_du_plane_state *plane_state;
+		struct rcar_du_plane *plane;
+		unsigned int index;
+
+		if (!state->planes[i])
+			continue;
+
+		plane = to_rcar_plane(state->planes[i]);
+		plane_state = to_rcar_du_plane_state(state->plane_states[i]);
+
+		/* If the plane is being disabled we don't need to go through
+		 * the full reallocation procedure. Just mark the hardware
+		 * plane(s) as freed.
+		 */
+		if (!plane_state->format) {
+			index = plane - plane->group->planes.planes;
+			group_freed_planes[plane->group->index] |= 1 << index;
+			plane_state->hwindex = -1;
+			continue;
+		}
+
+		/* If the plane needs to be reallocated mark it as such, and
+		 * mark the hardware plane(s) as free.
+		 */
+		if (rcar_du_plane_needs_realloc(plane, plane_state)) {
+			groups |= 1 << plane->group->index;
+			needs_realloc = true;
+
+			index = plane - plane->group->planes.planes;
+			group_freed_planes[plane->group->index] |= 1 << index;
+			plane_state->hwindex = -1;
+		}
+	}
+
+	if (!needs_realloc)
+		return 0;
+
+	/* Grab all plane states for the groups that need reallocation to ensure
+	 * locking and avoid racy updates. This serializes the update operation,
+	 * but there's not much we can do about it as that's the hardware
+	 * design.
+	 *
+	 * Compute the used planes mask for each group at the same time to avoid
+	 * looping over the planes separately later.
+	 */
+	while (groups) {
+		unsigned int index = ffs(groups) - 1;
+		struct rcar_du_group *group = &rcdu->groups[index];
+		unsigned int used_planes = 0;
+
+		for (i = 0; i < RCAR_DU_NUM_KMS_PLANES; ++i) {
+			struct rcar_du_plane *plane = &group->planes.planes[i];
+			struct rcar_du_plane_state *plane_state;
+			struct drm_plane_state *s;
+
+			s = drm_atomic_get_plane_state(state, &plane->plane);
+			if (IS_ERR(s))
+				return PTR_ERR(s);
+
+			/* If the plane has been freed in the above loop its
+			 * hardware planes must not be added to the used planes
+			 * bitmask. However, the current state doesn't reflect
+			 * the free state yet, as we've modified the new state
+			 * above. Use the local freed planes list to check for
+			 * that condition instead.
+			 */
+			if (group_freed_planes[index] & (1 << i))
+				continue;
+
+			plane_state = to_rcar_du_plane_state(plane->plane.state);
+			used_planes |= rcar_du_plane_hwmask(plane_state);
+		}
+
+		group_free_planes[index] = 0xff & ~used_planes;
+		groups &= ~(1 << index);
+	}
+
+	/* Reallocate hardware planes for each plane that needs it. */
+	for (i = 0; i < dev->mode_config.num_total_plane; ++i) {
+		struct rcar_du_plane_state *plane_state;
+		struct rcar_du_plane *plane;
+		int idx;
+
+		if (!state->planes[i])
+			continue;
+
+		plane = to_rcar_plane(state->planes[i]);
+		plane_state = to_rcar_du_plane_state(state->plane_states[i]);
+
+		/* Skip planes that are being disabled or don't need to be
+		 * reallocated.
+		 */
+		if (!plane_state->format ||
+		    !rcar_du_plane_needs_realloc(plane, plane_state))
+			continue;
+
+		idx = rcar_du_plane_hwalloc(plane_state->format->planes,
+					group_free_planes[plane->group->index]);
+		if (idx < 0) {
+			dev_dbg(rcdu->dev, "%s: no available hardware plane\n",
+				__func__);
+			return idx;
+		}
+
+		plane_state->hwindex = idx;
+
+		group_free_planes[plane->group->index] &+			~rcar_du_plane_hwmask(plane_state);
+	}
+
+	return 0;
+}
+
 struct rcar_du_commit {
 	struct work_struct work;
 	struct drm_device *dev;
@@ -292,7 +489,7 @@ static int rcar_du_atomic_commit(struct drm_device *dev,
 static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.fb_create = rcar_du_fb_create,
 	.output_poll_changed = rcar_du_output_poll_changed,
-	.atomic_check = drm_atomic_helper_check,
+	.atomic_check = rcar_du_atomic_check,
 	.atomic_commit = rcar_du_atomic_commit,
 };
 
@@ -498,6 +695,8 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	for (i = 0; i < num_groups; ++i) {
 		struct rcar_du_group *rgrp = &rcdu->groups[i];
 
+		mutex_init(&rgrp->lock);
+
 		rgrp->dev = rcdu;
 		rgrp->mmio_offset = mmio_offsets[i];
 		rgrp->index = i;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 58b9e02e6910..35a2f04ab799 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -28,11 +28,6 @@
 #define RCAR_DU_COLORKEY_SOURCE		(1 << 24)
 #define RCAR_DU_COLORKEY_MASK		(1 << 24)
 
-static inline struct rcar_du_plane *to_rcar_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct rcar_du_plane, plane);
-}
-
 static u32 rcar_du_plane_read(struct rcar_du_group *rgrp,
 			      unsigned int index, u32 reg)
 {
@@ -47,90 +42,6 @@ static void rcar_du_plane_write(struct rcar_du_group *rgrp,
 		      data);
 }
 
-static int rcar_du_plane_reserve_check(struct rcar_du_plane *plane,
-		const struct rcar_du_format_info *cur_format,
-		const struct rcar_du_format_info *new_format)
-{
-	struct rcar_du_group *rgrp = plane->group;
-	unsigned int free;
-	unsigned int i;
-	int ret;
-
-	mutex_lock(&rgrp->planes.lock);
-
-	free = rgrp->planes.free;
-
-	if (plane->hwindex != -1) {
-		free |= 1 << plane->hwindex;
-		if (cur_format->planes = 2)
-			free |= 1 << ((plane->hwindex + 1) % 8);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(rgrp->planes.planes); ++i) {
-		if (!(free & (1 << i)))
-			continue;
-
-		if (new_format->planes = 1 || free & (1 << ((i + 1) % 8)))
-			break;
-	}
-
-	ret = i = ARRAY_SIZE(rgrp->planes.planes) ? -EBUSY : 0;
-
-	mutex_unlock(&rgrp->planes.lock);
-	return ret;
-}
-
-static int rcar_du_plane_reserve(struct rcar_du_plane *plane,
-				 const struct rcar_du_format_info *format)
-{
-	struct rcar_du_group *rgrp = plane->group;
-	unsigned int i;
-	int ret = -EBUSY;
-
-	mutex_lock(&rgrp->planes.lock);
-
-	for (i = 0; i < RCAR_DU_NUM_HW_PLANES; ++i) {
-		if (!(rgrp->planes.free & (1 << i)))
-			continue;
-
-		if (format->planes = 1 ||
-		    rgrp->planes.free & (1 << ((i + 1) % 8)))
-			break;
-	}
-
-	if (i = RCAR_DU_NUM_HW_PLANES)
-		goto done;
-
-	rgrp->planes.free &= ~(1 << i);
-	if (format->planes = 2)
-		rgrp->planes.free &= ~(1 << ((i + 1) % 8));
-
-	plane->hwindex = i;
-
-	ret = 0;
-
-done:
-	mutex_unlock(&rgrp->planes.lock);
-	return ret;
-}
-
-static void rcar_du_plane_release(struct rcar_du_plane *plane,
-				  const struct rcar_du_format_info *format)
-{
-	struct rcar_du_group *rgrp = plane->group;
-
-	if (plane->hwindex = -1)
-		return;
-
-	mutex_lock(&rgrp->planes.lock);
-	rgrp->planes.free |= 1 << plane->hwindex;
-	if (format->planes = 2)
-		rgrp->planes.free |= 1 << ((plane->hwindex + 1) % 8);
-	mutex_unlock(&rgrp->planes.lock);
-
-	plane->hwindex = -1;
-}
-
 static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 {
 	struct rcar_du_plane_state *state @@ -139,7 +50,7 @@ static void rcar_du_plane_setup_fb(struct rcar_du_plane *plane)
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int src_x = state->state.src_x >> 16;
 	unsigned int src_y = state->state.src_y >> 16;
-	unsigned int index = plane->hwindex;
+	unsigned int index = state->hwindex;
 	struct drm_gem_cma_object *gem;
 	bool interlaced;
 	u32 mwr;
@@ -278,7 +189,7 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	rcar_du_plane_setup_mode(plane, index);
 
 	if (state->format->planes = 2) {
-		if (plane->hwindex != index) {
+		if (state->hwindex != index) {
 			if (state->format->fourcc = DRM_FORMAT_NV12 ||
 			    state->format->fourcc = DRM_FORMAT_NV21)
 				ddcr2 |= PnDDCR2_Y420;
@@ -313,9 +224,9 @@ void rcar_du_plane_setup(struct rcar_du_plane *plane)
 	struct rcar_du_plane_state *state  		to_rcar_du_plane_state(plane->plane.state);
 
-	__rcar_du_plane_setup(plane, plane->hwindex);
+	__rcar_du_plane_setup(plane, state->hwindex);
 	if (state->format->planes = 2)
-		__rcar_du_plane_setup(plane, (plane->hwindex + 1) % 8);
+		__rcar_du_plane_setup(plane, (state->hwindex + 1) % 8);
 
 	rcar_du_plane_setup_fb(plane);
 }
@@ -326,12 +237,11 @@ static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
 	struct rcar_du_device *rcdu = rplane->group->dev;
-	const struct rcar_du_format_info *cur_format;
-	const struct rcar_du_format_info *new_format;
-	int ret;
 
-	if (!state->fb || !state->crtc)
+	if (!state->fb || !state->crtc) {
+		rstate->format = NULL;
 		return 0;
+	}
 
 	if (state->src_w >> 16 != state->crtc_w ||
 	    state->src_h >> 16 != state->crtc_h) {
@@ -339,72 +249,23 @@ static int rcar_du_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	cur_format = to_rcar_du_plane_state(plane->state)->format;
-	new_format = rcar_du_format_info(state->fb->pixel_format);
-	if (new_format = NULL) {
+	rstate->format = rcar_du_format_info(state->fb->pixel_format);
+	if (rstate->format = NULL) {
 		dev_dbg(rcdu->dev, "%s: unsupported format %08x\n", __func__,
 			state->fb->pixel_format);
 		return -EINVAL;
 	}
 
-	/* If the number of required planes has changed we will need to
-	 * reallocate hardware planes. Ensure free planes are available.
-	 */
-	if (!cur_format || new_format->planes != cur_format->planes) {
-		ret = rcar_du_plane_reserve_check(rplane, cur_format,
-						  new_format);
-		if (ret < 0) {
-			dev_dbg(rcdu->dev, "%s: no available hardware plane\n",
-				__func__);
-			return ret;
-		}
-	}
-
-	rstate->format = new_format;
-
 	return 0;
 }
 
-static void rcar_du_plane_disable(struct rcar_du_plane *rplane,
-				  const struct rcar_du_format_info *cur_format)
-{
-	struct rcar_du_plane_state *rstate -		to_rcar_du_plane_state(rplane->plane.state);
-
-	if (!rplane->plane.state->crtc)
-		return;
-
-	rcar_du_plane_release(rplane, cur_format);
-
-	rstate->format = NULL;
-}
-
 static void rcar_du_plane_atomic_update(struct drm_plane *plane,
 					struct drm_plane_state *old_state)
 {
 	struct rcar_du_plane *rplane = to_rcar_plane(plane);
-	struct drm_plane_state *state = plane->state;
-	struct rcar_du_plane_state *rstate = to_rcar_du_plane_state(state);
-	const struct rcar_du_format_info *cur_format;
-	const struct rcar_du_format_info *new_format;
 
-	cur_format = to_rcar_du_plane_state(old_state)->format;
-	new_format = rstate->format;
-
-	if (!state->crtc) {
-		rcar_du_plane_disable(rplane, cur_format);
-		return;
-	}
-
-	/* Reallocate hardware planes if the number of required planes has
-	 * changed.
-	 */
-	if (!cur_format || new_format->planes != cur_format->planes) {
-		rcar_du_plane_release(rplane, cur_format);
-		rcar_du_plane_reserve(rplane, new_format);
-	}
-
-	rcar_du_plane_setup(rplane);
+	if (plane->state->crtc)
+		rcar_du_plane_setup(rplane);
 }
 
 static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
@@ -426,6 +287,7 @@ static void rcar_du_plane_reset(struct drm_plane *plane)
 	if (state = NULL)
 		return;
 
+	state->hwindex = -1;
 	state->alpha = 255;
 	state->colorkey = RCAR_DU_COLORKEY_NONE;
 	state->zpos = plane->type = DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
@@ -534,9 +396,6 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 	unsigned int i;
 	int ret;
 
-	mutex_init(&planes->lock);
-	planes->free = 0xff;
-
 	planes->alpha  		drm_property_create_range(rcdu->ddev, 0, "alpha", 0, 255);
 	if (planes->alpha = NULL)
@@ -572,7 +431,6 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 		struct rcar_du_plane *plane = &planes->planes[i];
 
 		plane->group = rgrp;
-		plane->hwindex = -1;
 
 		ret = drm_universal_plane_init(rcdu->ddev, &plane->plane, crtcs,
 					       &rcar_du_plane_funcs, formats,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 0941c4830edd..abff0ebeb195 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -14,8 +14,6 @@
 #ifndef __RCAR_DU_PLANE_H__
 #define __RCAR_DU_PLANE_H__
 
-#include <linux/mutex.h>
-
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 
@@ -33,13 +31,15 @@ struct rcar_du_group;
 struct rcar_du_plane {
 	struct drm_plane plane;
 	struct rcar_du_group *group;
-	int hwindex;		/* 0-based, -1 means unused */
 };
 
+static inline struct rcar_du_plane *to_rcar_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct rcar_du_plane, plane);
+}
+
 struct rcar_du_planes {
 	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
-	unsigned int free;
-	struct mutex lock;
 
 	struct drm_property *alpha;
 	struct drm_property *colorkey;
@@ -50,6 +50,7 @@ struct rcar_du_plane_state {
 	struct drm_plane_state state;
 
 	const struct rcar_du_format_info *format;
+	int hwindex;		/* 0-based, -1 means unused */
 
 	unsigned int alpha;
 	unsigned int colorkey;
-- 
2.0.5

