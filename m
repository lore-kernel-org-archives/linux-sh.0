From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:06 +0000
Subject: [PATCH 19/22] drm: rcar-du: lvds: Avoid duplication of clock clamp code
Message-Id: <1442184669-30990-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Replace the duplicate code by a single central function.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 6 +-----
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 7 ++-----
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 9 +++++++++
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h | 6 ++++++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index d0ae1e8009c6..b7d64336fb3b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -89,12 +89,8 @@ static int rcar_du_encoder_atomic_check(struct drm_encoder *encoder,
 	/* The flat panel mode is fixed, just copy it to the adjusted mode. */
 	drm_mode_copy(adjusted_mode, panel_mode);
 
-	/* The internal LVDS encoder has a clock frequency operating range of
-	 * 30MHz to 150MHz. Clamp the clock accordingly.
-	 */
 	if (renc->lvds)
-		adjusted_mode->clock = clamp(adjusted_mode->clock,
-					     30000, 150000);
+		rcar_du_lvdsenc_atomic_check(renc->lvds, adjusted_mode);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 81da8419282b..c45b626c7d66 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -71,12 +71,9 @@ static int rcar_du_hdmienc_atomic_check(struct drm_encoder *encoder,
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
 	const struct drm_display_mode *mode = &crtc_state->mode;
 
-	/* The internal LVDS encoder has a clock frequency operating range of
-	 * 30MHz to 150MHz. Clamp the clock accordingly.
-	 */
 	if (hdmienc->renc->lvds)
-		adjusted_mode->clock = clamp(adjusted_mode->clock,
-					     30000, 150000);
+		rcar_du_lvdsenc_atomic_check(hdmienc->renc->lvds,
+					     adjusted_mode);
 
 	if (sfuncs->mode_fixup = NULL)
 		return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
index 85043c5bad03..937b2da98814 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -140,6 +140,15 @@ int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds, struct drm_crtc *crtc,
 		return -EINVAL;
 }
 
+void rcar_du_lvdsenc_atomic_check(struct rcar_du_lvdsenc *lvds,
+				  struct drm_display_mode *mode)
+{
+	/* The internal LVDS encoder has a clock frequency operating range of
+	 * 30MHz to 150MHz. Clamp the clock accordingly.
+	 */
+	mode->clock = clamp(mode->clock, 30000, 150000);
+}
+
 static int rcar_du_lvdsenc_get_resources(struct rcar_du_lvdsenc *lvds,
 					 struct platform_device *pdev)
 {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
index 9a6001c07303..dfdba746edf4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
@@ -30,6 +30,8 @@ enum rcar_lvds_input {
 int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu);
 int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
 			   struct drm_crtc *crtc, bool enable);
+void rcar_du_lvdsenc_atomic_check(struct rcar_du_lvdsenc *lvds,
+				  struct drm_display_mode *mode);
 #else
 static inline int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu)
 {
@@ -40,6 +42,10 @@ static inline int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
 {
 	return 0;
 }
+static inline void rcar_du_lvdsenc_atomic_check(struct rcar_du_lvdsenc *lvds,
+						struct drm_display_mode *mode)
+{
+}
 #endif
 
 #endif /* __RCAR_DU_LVDSENC_H__ */
-- 
2.4.6

