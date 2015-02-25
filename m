From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:49 +0000
Subject: [PATCH 29/38] drm: rcar-du: Implement asynchronous commit support
Message-Id: <1424901298-6829-30-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Implement a custom .atomic_commit() handler that supports asynchronous
commits using a work queue. This can be used for userspace-driven
asynchronous commits, as well as for an atomic page flip implementation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c |   3 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.h |   6 ++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 105 +++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 8ab4c69c599b..1d9e4f8568ae 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -163,6 +164,8 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 		return -ENOMEM;
 	}
 
+	init_waitqueue_head(&rcdu->commit.wait);
+
 	rcdu->dev = &pdev->dev;
 	rcdu->info = np ? of_match_device(rcar_du_of_table, rcdu->dev)->data
 		   : (void *)platform_get_device_id(pdev)->driver_data;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index d1ede13cb1d5..c7c538dd2e68 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -15,6 +15,7 @@
 #define __RCAR_DU_DRV_H__
 
 #include <linux/kernel.h>
+#include <linux/wait.h>
 
 #include "rcar_du_crtc.h"
 #include "rcar_du_group.h"
@@ -84,6 +85,11 @@ struct rcar_du_device {
 
 	unsigned int dpad0_source;
 	struct rcar_du_lvdsenc *lvds[RCAR_DU_MAX_LVDS];
+
+	struct {
+		wait_queue_head_t wait;
+		u32 pending;
+	} commit;
 };
 
 static inline bool rcar_du_has(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 2b36f4f2980f..cec35e405248 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
@@ -19,6 +20,7 @@
 #include <drm/drm_gem_cma_helper.h>
 
 #include <linux/of_graph.h>
+#include <linux/wait.h>
 
 #include "rcar_du_crtc.h"
 #include "rcar_du_drv.h"
@@ -186,11 +188,112 @@ static void rcar_du_output_poll_changed(struct drm_device *dev)
 	drm_fbdev_cma_hotplug_event(rcdu->fbdev);
 }
 
+/* -----------------------------------------------------------------------------
+ * Atomic Updates
+ */
+
+struct rcar_du_commit {
+	struct work_struct work;
+	struct drm_device *dev;
+	struct drm_atomic_state *state;
+	u32 crtcs;
+};
+
+static void rcar_du_atomic_complete(struct rcar_du_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	struct rcar_du_device *rcdu = dev->dev_private;
+	struct drm_atomic_state *old_state = commit->state;
+
+	/* Apply the atomic update. */
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+	drm_atomic_helper_commit_planes(dev, old_state);
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+
+	drm_atomic_state_free(old_state);
+
+	/* Complete the commit, wake up any waiter. */
+	spin_lock(&rcdu->commit.wait.lock);
+	rcdu->commit.pending &= ~commit->crtcs;
+	wake_up_all_locked(&rcdu->commit.wait);
+	spin_unlock(&rcdu->commit.wait.lock);
+
+	kfree(commit);
+}
+
+static void rcar_du_atomic_work(struct work_struct *work)
+{
+	struct rcar_du_commit *commit +		container_of(work, struct rcar_du_commit, work);
+
+	rcar_du_atomic_complete(commit);
+}
+
+static int rcar_du_atomic_commit(struct drm_device *dev,
+				 struct drm_atomic_state *state, bool async)
+{
+	struct rcar_du_device *rcdu = dev->dev_private;
+	struct rcar_du_commit *commit;
+	unsigned int i;
+	int ret;
+
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	/* Allocate the commit object. */
+	commit = kzalloc(sizeof(*commit), GFP_KERNEL);
+	if (commit = NULL)
+		return -ENOMEM;
+
+	INIT_WORK(&commit->work, rcar_du_atomic_work);
+	commit->dev = dev;
+	commit->state = state;
+
+	/* Wait until all affected CRTCs have completed previous commits and
+	 * mark them as pending.
+	 */
+	for (i = 0; i < dev->mode_config.num_crtc; ++i) {
+		if (state->crtcs[i])
+			commit->crtcs |= 1 << drm_crtc_index(state->crtcs[i]);
+	}
+
+	spin_lock(&rcdu->commit.wait.lock);
+	ret = wait_event_interruptible_locked(rcdu->commit.wait,
+			!(rcdu->commit.pending & commit->crtcs));
+	if (ret = 0)
+		rcdu->commit.pending |= commit->crtcs;
+	spin_unlock(&rcdu->commit.wait.lock);
+
+	if (ret) {
+		kfree(commit);
+		return ret;
+	}
+
+	/* Swap the state, this is the point of no return. */
+	drm_atomic_helper_swap_state(dev, state);
+
+	if (async)
+		schedule_work(&commit->work);
+	else
+		rcar_du_atomic_complete(commit);
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
 static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.fb_create = rcar_du_fb_create,
 	.output_poll_changed = rcar_du_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_commit = rcar_du_atomic_commit,
 };
 
 static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
-- 
2.0.5

