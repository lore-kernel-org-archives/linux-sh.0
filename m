From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:43 +0000
Subject: [PATCH 23/38] drm: rcar-du: Rework HDMI encoder enable/disable for atomic updates
Message-Id: <1424901298-6829-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

When using atomic updates the encoder .enable() and .disable() helper
operations are preferred over the (then legacy) .prepare() and .commit()
operations. Implement .enable() and .disable() and rework .prepare(),
.commit() and .dpms() as wrappers around .enable() and .disable(),
easing their future removal.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 48 ++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 89a7c0ecc935..04e21b5f96d4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -26,35 +26,54 @@
 struct rcar_du_hdmienc {
 	struct rcar_du_encoder *renc;
 	struct device *dev;
-	int dpms;
+	bool enabled;
 };
 
 #define to_rcar_hdmienc(e)	(to_rcar_encoder(e)->hdmi)
 #define to_slave_funcs(e)	(to_rcar_encoder(e)->slave.slave_funcs)
 
-static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
+static void rcar_du_hdmienc_disable(struct drm_encoder *encoder)
 {
 	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
-	if (mode != DRM_MODE_DPMS_ON)
-		mode = DRM_MODE_DPMS_OFF;
+	if (sfuncs->dpms)
+		sfuncs->dpms(encoder, DRM_MODE_DPMS_OFF);
 
-	if (hdmienc->dpms = mode)
-		return;
+	if (hdmienc->renc->lvds)
+		rcar_du_lvdsenc_enable(hdmienc->renc->lvds, encoder->crtc,
+				       false);
+
+	hdmienc->enabled = false;
+}
+
+static void rcar_du_hdmienc_enable(struct drm_encoder *encoder)
+{
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
-	if (mode = DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
+	if (hdmienc->renc->lvds)
 		rcar_du_lvdsenc_enable(hdmienc->renc->lvds, encoder->crtc,
 				       true);
 
 	if (sfuncs->dpms)
-		sfuncs->dpms(encoder, mode);
+		sfuncs->dpms(encoder, DRM_MODE_DPMS_ON);
 
-	if (mode != DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
-		rcar_du_lvdsenc_enable(hdmienc->renc->lvds, encoder->crtc,
-				       false);
+	hdmienc->enabled = true;
+}
 
-	hdmienc->dpms = mode;
+static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
+	bool enable = mode = DRM_MODE_DPMS_ON;
+
+	if (hdmienc->enabled = enable)
+		return;
+
+	if (enable)
+		rcar_du_hdmienc_enable(encoder);
+	else
+		rcar_du_hdmienc_disable(encoder);
 }
 
 static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
@@ -106,13 +125,16 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.prepare = rcar_du_hdmienc_mode_prepare,
 	.commit = rcar_du_hdmienc_mode_commit,
 	.mode_set = rcar_du_hdmienc_mode_set,
+	.disable = rcar_du_hdmienc_disable,
+	.enable = rcar_du_hdmienc_enable,
 };
 
 static void rcar_du_hdmienc_cleanup(struct drm_encoder *encoder)
 {
 	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
 
-	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_OFF);
+	if (hdmienc->enabled)
+		rcar_du_hdmienc_disable(encoder);
 
 	drm_encoder_cleanup(encoder);
 	put_device(hdmienc->dev);
-- 
2.0.5

