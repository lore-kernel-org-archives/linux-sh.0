From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:41 +0000
Subject: [PATCH 21/38] drm: rcar-du: Replace LVDS encoder DPMS by enable/disable
Message-Id: <1424901298-6829-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The LVDS encoder doesn't support DPMS states, replace the DPMS operation
by enable/disable to avoid propagating DPMS states down to the encoder
code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 12 ++++--------
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c |  6 ++++--
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 18 +++++++++---------
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h |  8 ++++----
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 279167f783f6..6243af310368 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -46,11 +46,9 @@ static void rcar_du_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
-	if (mode != DRM_MODE_DPMS_ON)
-		mode = DRM_MODE_DPMS_OFF;
-
 	if (renc->lvds)
-		rcar_du_lvdsenc_dpms(renc->lvds, encoder->crtc, mode);
+		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc,
+				       mode = DRM_MODE_DPMS_ON);
 }
 
 static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
@@ -110,8 +108,7 @@ static void rcar_du_encoder_mode_prepare(struct drm_encoder *encoder)
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
 	if (renc->lvds)
-		rcar_du_lvdsenc_dpms(renc->lvds, encoder->crtc,
-				     DRM_MODE_DPMS_OFF);
+		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, false);
 }
 
 static void rcar_du_encoder_mode_commit(struct drm_encoder *encoder)
@@ -119,8 +116,7 @@ static void rcar_du_encoder_mode_commit(struct drm_encoder *encoder)
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
 	if (renc->lvds)
-		rcar_du_lvdsenc_dpms(renc->lvds, encoder->crtc,
-				     DRM_MODE_DPMS_ON);
+		rcar_du_lvdsenc_enable(renc->lvds, encoder->crtc, true);
 }
 
 static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 221f0a17fd6a..89a7c0ecc935 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -44,13 +44,15 @@ static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
 		return;
 
 	if (mode = DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
-		rcar_du_lvdsenc_dpms(hdmienc->renc->lvds, encoder->crtc, mode);
+		rcar_du_lvdsenc_enable(hdmienc->renc->lvds, encoder->crtc,
+				       true);
 
 	if (sfuncs->dpms)
 		sfuncs->dpms(encoder, mode);
 
 	if (mode != DRM_MODE_DPMS_ON && hdmienc->renc->lvds)
-		rcar_du_lvdsenc_dpms(hdmienc->renc->lvds, encoder->crtc, mode);
+		rcar_du_lvdsenc_enable(hdmienc->renc->lvds, encoder->crtc,
+				       false);
 
 	hdmienc->dpms = mode;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
index 7cfb48ce1791..85043c5bad03 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -28,7 +28,7 @@ struct rcar_du_lvdsenc {
 	unsigned int index;
 	void __iomem *mmio;
 	struct clk *clock;
-	int dpms;
+	bool enabled;
 
 	enum rcar_lvds_input input;
 };
@@ -48,7 +48,7 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 	u32 pllcr;
 	int ret;
 
-	if (lvds->dpms = DRM_MODE_DPMS_ON)
+	if (lvds->enabled)
 		return 0;
 
 	ret = clk_prepare_enable(lvds->clock);
@@ -110,13 +110,13 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 	lvdcr0 |= LVDCR0_LVRES;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
 
-	lvds->dpms = DRM_MODE_DPMS_ON;
+	lvds->enabled = true;
 	return 0;
 }
 
 static void rcar_du_lvdsenc_stop(struct rcar_du_lvdsenc *lvds)
 {
-	if (lvds->dpms = DRM_MODE_DPMS_OFF)
+	if (!lvds->enabled)
 		return;
 
 	rcar_lvds_write(lvds, LVDCR0, 0);
@@ -124,13 +124,13 @@ static void rcar_du_lvdsenc_stop(struct rcar_du_lvdsenc *lvds)
 
 	clk_disable_unprepare(lvds->clock);
 
-	lvds->dpms = DRM_MODE_DPMS_OFF;
+	lvds->enabled = false;
 }
 
-int rcar_du_lvdsenc_dpms(struct rcar_du_lvdsenc *lvds,
-			 struct drm_crtc *crtc, int mode)
+int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds, struct drm_crtc *crtc,
+			   bool enable)
 {
-	if (mode = DRM_MODE_DPMS_OFF) {
+	if (!enable) {
 		rcar_du_lvdsenc_stop(lvds);
 		return 0;
 	} else if (crtc) {
@@ -179,7 +179,7 @@ int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu)
 		lvds->dev = rcdu;
 		lvds->index = i;
 		lvds->input = i ? RCAR_LVDS_INPUT_DU1 : RCAR_LVDS_INPUT_DU0;
-		lvds->dpms = DRM_MODE_DPMS_OFF;
+		lvds->enabled = false;
 
 		ret = rcar_du_lvdsenc_get_resources(lvds, pdev);
 		if (ret < 0)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
index f65aabda0796..9a6001c07303 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
@@ -28,15 +28,15 @@ enum rcar_lvds_input {
 
 #if IS_ENABLED(CONFIG_DRM_RCAR_LVDS)
 int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu);
-int rcar_du_lvdsenc_dpms(struct rcar_du_lvdsenc *lvds,
-			 struct drm_crtc *crtc, int mode);
+int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
+			   struct drm_crtc *crtc, bool enable);
 #else
 static inline int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu)
 {
 	return 0;
 }
-static inline int rcar_du_lvdsenc_dpms(struct rcar_du_lvdsenc *lvds,
-				       struct drm_crtc *crtc, int mode)
+static inline int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
+					 struct drm_crtc *crtc, bool enable)
 {
 	return 0;
 }
-- 
2.0.5

