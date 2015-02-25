From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:48 +0000
Subject: [PATCH 28/38] drm: rcar-du: Replace encoder mode_fixup with atomic_check
Message-Id: <1424901298-6829-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The encoder .mode_fixup() operation is legacy, atomic updates uses the
new .atomic_check() operation. Convert the encoders drivers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 35 +++++++++++--------------------
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 14 +++++++------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index d4a70228ce50..d0ae1e8009c6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -58,35 +58,24 @@ static void rcar_du_encoder_enable(struct drm_encoder *encoder)
 		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, true);
 }
 
-static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
+static int rcar_du_encoder_atomic_check(struct drm_encoder *encoder,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	const struct drm_display_mode *mode = &crtc_state->mode;
 	const struct drm_display_mode *panel_mode;
+	struct drm_connector *connector = conn_state->connector;
 	struct drm_device *dev = encoder->dev;
-	struct drm_connector *connector;
-	bool found = false;
 
 	/* DAC encoders have currently no restriction on the mode. */
 	if (encoder->encoder_type = DRM_MODE_ENCODER_DAC)
-		return true;
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		if (connector->encoder = encoder) {
-			found = true;
-			break;
-		}
-	}
-
-	if (!found) {
-		dev_dbg(dev->dev, "mode_fixup: no connector found\n");
-		return false;
-	}
+		return 0;
 
 	if (list_empty(&connector->modes)) {
-		dev_dbg(dev->dev, "mode_fixup: empty modes list\n");
-		return false;
+		dev_dbg(dev->dev, "encoder: empty modes list\n");
+		return -EINVAL;
 	}
 
 	panel_mode = list_first_entry(&connector->modes,
@@ -95,7 +84,7 @@ static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 	/* We're not allowed to modify the resolution. */
 	if (mode->hdisplay != panel_mode->hdisplay ||
 	    mode->vdisplay != panel_mode->vdisplay)
-		return false;
+		return -EINVAL;
 
 	/* The flat panel mode is fixed, just copy it to the adjusted mode. */
 	drm_mode_copy(adjusted_mode, panel_mode);
@@ -107,7 +96,7 @@ static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 		adjusted_mode->clock = clamp(adjusted_mode->clock,
 					     30000, 150000);
 
-	return true;
+	return 0;
 }
 
 static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
@@ -120,10 +109,10 @@ static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
-	.mode_fixup = rcar_du_encoder_mode_fixup,
 	.mode_set = rcar_du_encoder_mode_set,
 	.disable = rcar_du_encoder_disable,
 	.enable = rcar_du_encoder_enable,
+	.atomic_check = rcar_du_encoder_atomic_check,
 };
 
 static const struct drm_encoder_funcs encoder_funcs = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 3c29250c8abd..81da8419282b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -62,12 +62,14 @@ static void rcar_du_hdmienc_enable(struct drm_encoder *encoder)
 	hdmienc->enabled = true;
 }
 
-static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
+static int rcar_du_hdmienc_atomic_check(struct drm_encoder *encoder,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
 {
 	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	const struct drm_display_mode *mode = &crtc_state->mode;
 
 	/* The internal LVDS encoder has a clock frequency operating range of
 	 * 30MHz to 150MHz. Clamp the clock accordingly.
@@ -77,9 +79,9 @@ static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
 					     30000, 150000);
 
 	if (sfuncs->mode_fixup = NULL)
-		return true;
+		return 0;
 
-	return sfuncs->mode_fixup(encoder, mode, adjusted_mode);
+	return sfuncs->mode_fixup(encoder, mode, adjusted_mode) ? 0 : -EINVAL;
 }
 
 static void rcar_du_hdmienc_mode_set(struct drm_encoder *encoder,
@@ -96,10 +98,10 @@ static void rcar_du_hdmienc_mode_set(struct drm_encoder *encoder,
 }
 
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
-	.mode_fixup = rcar_du_hdmienc_mode_fixup,
 	.mode_set = rcar_du_hdmienc_mode_set,
 	.disable = rcar_du_hdmienc_disable,
 	.enable = rcar_du_hdmienc_enable,
+	.atomic_check = rcar_du_hdmienc_atomic_check,
 };
 
 static void rcar_du_hdmienc_cleanup(struct drm_encoder *encoder)
-- 
2.0.5

