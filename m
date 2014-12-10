From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:04 +0000
Subject: [PATCH 04/15] drm: rcar-du: Remove LVDS and HDMI encoders chaining restriction
Message-Id: <1418254935-13536-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The rcar-du driver refuses connecting an LVDS output to an HDMI encoder.
There is not technical reason for that restriction, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  7 -------
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 7c74ecf2ca67..243aba8d4dd2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -190,13 +190,6 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	}
 
 	if (type = RCAR_DU_ENCODER_HDMI) {
-		if (renc->lvds) {
-			dev_err(rcdu->dev,
-				"Chaining LVDS and HDMI encoders not supported\n");
-			ret = -EINVAL;
-			goto done;
-		}
-
 		ret = rcar_du_hdmienc_init(rcdu, renc, enc_node);
 		if (ret < 0)
 			goto done;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 359bc999a9c8..0d774a937e79 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -21,6 +21,7 @@
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
 #include "rcar_du_hdmienc.h"
+#include "rcar_du_lvdsenc.h"
 
 struct rcar_du_hdmienc {
 	struct rcar_du_encoder *renc;
@@ -39,9 +40,15 @@ static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
 	if (hdmienc->dpms = mode)
 		return;
 
+	if (mode = DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
+		rcar_du_lvdsenc_dpms(hdmienc->renc->lvds, encoder->crtc, mode);
+
 	if (sfuncs->dpms)
 		sfuncs->dpms(encoder, mode);
 
+	if (mode != DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
+		rcar_du_lvdsenc_dpms(hdmienc->renc->lvds, encoder->crtc, mode);
+
 	hdmienc->dpms = mode;
 }
 
@@ -49,8 +56,16 @@ static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
 				       const struct drm_display_mode *mode,
 				       struct drm_display_mode *adjusted_mode)
 {
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
+	/* The internal LVDS encoder has a clock frequency operating range of
+	 * 30MHz to 150MHz. Clamp the clock accordingly.
+	 */
+	if (hdmienc->renc->lvds)
+		adjusted_mode->clock = clamp(adjusted_mode->clock,
+					     30000, 150000);
+
 	if (sfuncs->mode_fixup = NULL)
 		return true;
 
-- 
2.0.4

