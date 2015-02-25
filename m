From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:45 +0000
Subject: [PATCH 25/38] drm: rcar-du: Switch plane update to atomic helpers
Message-Id: <1424901298-6829-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

This removes the legacy plane update code. Wire up the default atomic
check and atomic commit mode config helpers as needed by the plane
update atomic helpers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 3 +++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 94ff8fcc7268..2b36f4f2980f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
@@ -188,6 +189,8 @@ static void rcar_du_output_poll_changed(struct drm_device *dev)
 static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.fb_create = rcar_du_fb_create,
 	.output_poll_changed = rcar_du_output_poll_changed,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index f247b1fcf791..ff087f7de88e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -480,8 +480,8 @@ static int rcar_du_plane_set_property(struct drm_plane *plane,
 }
 
 static const struct drm_plane_funcs rcar_du_plane_funcs = {
-	.update_plane = drm_plane_helper_update,
-	.disable_plane = drm_plane_helper_disable,
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
 	.reset = drm_atomic_helper_plane_reset,
 	.set_property = rcar_du_plane_set_property,
 	.destroy = drm_plane_cleanup,
-- 
2.0.5

