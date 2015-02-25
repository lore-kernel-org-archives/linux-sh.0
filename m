From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:42 +0000
Subject: [PATCH 22/38] drm: rcar-du: Rework encoder enable/disable for atomic updates
Message-Id: <1424901298-6829-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 33 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 6243af310368..74a744f5dfdb 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -42,13 +42,28 @@ rcar_du_connector_best_encoder(struct drm_connector *connector)
  * Encoder
  */
 
-static void rcar_du_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void rcar_du_encoder_disable(struct drm_encoder *encoder)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
 	if (renc->lvds)
-		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc,
-				       mode = DRM_MODE_DPMS_ON);
+		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, false);
+}
+
+static void rcar_du_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
+
+	if (renc->lvds)
+		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, true);
+}
+
+static void rcar_du_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	if (mode = DRM_MODE_DPMS_ON)
+		rcar_du_encoder_enable(encoder);
+	else
+		rcar_du_encoder_disable(encoder);
 }
 
 static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
@@ -105,18 +120,12 @@ static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 
 static void rcar_du_encoder_mode_prepare(struct drm_encoder *encoder)
 {
-	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
-
-	if (renc->lvds)
-		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, false);
+	rcar_du_encoder_disable(encoder);
 }
 
 static void rcar_du_encoder_mode_commit(struct drm_encoder *encoder)
 {
-	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
-
-	if (renc->lvds)
-		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, true);
+	rcar_du_encoder_enable(encoder);
 }
 
 static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
@@ -134,6 +143,8 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.prepare = rcar_du_encoder_mode_prepare,
 	.commit = rcar_du_encoder_mode_commit,
 	.mode_set = rcar_du_encoder_mode_set,
+	.disable = rcar_du_encoder_disable,
+	.enable = rcar_du_encoder_enable,
 };
 
 static const struct drm_encoder_funcs encoder_funcs = {
-- 
2.0.5

