From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:39 +0000
Subject: [PATCH 19/38] drm: rcar-du: Wire up atomic state object scaffolding
Message-Id: <1424901298-6829-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hook up the default .reset(), .atomic_duplicate_state() and
.atomic_free_state() helpers to ensure that state objects are properly
created and destroyed, and call drm_mode_config_reset() at init time to
create the initial state objects.

Framebuffer reference count also gets maintained automatically by the
transitional helpers except for the legacy page flip operation. Maintain
it explicitly there.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 7 +++++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 4 ++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c | 4 ++++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c   | 4 ++++
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  | 4 ++++
 6 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 169558a3ab40..6e7266c1a47b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -15,6 +15,8 @@
 #include <linux/mutex.h>
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
@@ -572,6 +574,8 @@ static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
+	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
+
 	crtc->primary->fb = fb;
 	rcar_du_crtc_update_base(rcrtc);
 
@@ -587,9 +591,12 @@ static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_funcs crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_crtc_helper_set_config,
 	.page_flip = rcar_du_crtc_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
index 3896cb20ad51..9378c283cb58 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder_slave.h>
@@ -75,9 +76,12 @@ rcar_du_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
 	.detect = rcar_du_hdmi_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = rcar_du_hdmi_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 413145de3db3..94ff8fcc7268 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -439,6 +439,8 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
+	drm_mode_config_reset(dev);
+
 	drm_kms_helper_poll_init(dev);
 
 	if (dev->mode_config.num_connector) {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 7c0b08fe0774..4bfa3ce34ab3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
@@ -75,9 +76,12 @@ rcar_du_lvds_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
 	.detect = rcar_du_lvds_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = rcar_du_lvds_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index d4682ac7db03..c4e4fd293eee 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
@@ -486,8 +487,11 @@ static int rcar_du_plane_set_property(struct drm_plane *plane,
 static const struct drm_plane_funcs rcar_du_plane_funcs = {
 	.update_plane = drm_plane_helper_update,
 	.disable_plane = drm_plane_helper_disable,
+	.reset = drm_atomic_helper_plane_reset,
 	.set_property = rcar_du_plane_set_property,
 	.destroy = drm_plane_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
 static const uint32_t formats[] = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
index ae8b304e6fea..a110cf22f3b0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
@@ -12,6 +12,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
@@ -44,9 +45,12 @@ rcar_du_vga_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
 	.detect = rcar_du_vga_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = rcar_du_vga_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
-- 
2.0.5

