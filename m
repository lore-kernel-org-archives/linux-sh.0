From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:52:13 +0000
Subject: [PATCH 3/5] drm/rcar-du: Split features and quirks
Message-Id: <1384350735-4419-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

128-byte pitch alignement is not a hardware feature, it's a hardware
bug. Split it from the features field into a new quirks field. New
quirks will be added to support the R8A7791 SoC.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c |  4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.h | 13 +++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.c |  4 ++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 0023f97..a0ffacb 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -249,8 +249,8 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_ALIGN_128B
-		  | RCAR_DU_FEATURE_DEFR8,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
 	.num_crtcs = 3,
 	.routes = {
 		/* R8A7790 has one RGB output, two LVDS outputs and one
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 65d2d63..7ca98f3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -28,8 +28,9 @@ struct rcar_du_device;
 struct rcar_du_lvdsenc;
 
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock */
-#define RCAR_DU_FEATURE_ALIGN_128B	(1 << 1)	/* Align pitches to 128 bytes */
-#define RCAR_DU_FEATURE_DEFR8		(1 << 2)	/* Has DEFR8 register */
+#define RCAR_DU_FEATURE_DEFR8		(1 << 1)	/* Has DEFR8 register */
+
+#define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes */
 
 /*
  * struct rcar_du_output_routing - Output routing specification
@@ -48,12 +49,14 @@ struct rcar_du_output_routing {
 /*
  * struct rcar_du_device_info - DU model-specific information
  * @features: device features (RCAR_DU_FEATURE_*)
+ * @quirks: device quirks (RCAR_DU_QUIRK_*)
  * @num_crtcs: total number of CRTCs
  * @routes: array of CRTC to output routes, indexed by output (RCAR_DU_OUTPUT_*)
  * @num_lvds: number of internal LVDS encoders
  */
 struct rcar_du_device_info {
 	unsigned int features;
+	unsigned int quirks;
 	unsigned int num_crtcs;
 	struct rcar_du_output_routing routes[RCAR_DU_OUTPUT_MAX];
 	unsigned int num_lvds;
@@ -84,6 +87,12 @@ static inline bool rcar_du_has(struct rcar_du_device *rcdu,
 	return rcdu->info->features & feature;
 }
 
+static inline bool rcar_du_needs(struct rcar_du_device *rcdu,
+				 unsigned int quirk)
+{
+	return rcdu->info->quirks & quirk;
+}
+
 static inline u32 rcar_du_read(struct rcar_du_device *rcdu, u32 reg)
 {
 	return ioread32(rcdu->mmio + reg);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index b31ac08..fbeabd9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -119,7 +119,7 @@ int rcar_du_dumb_create(struct drm_file *file, struct drm_device *dev,
 	/* The R8A7779 DU requires a 16 pixels pitch alignment as documented,
 	 * but the R8A7790 DU seems to require a 128 bytes pitch alignment.
 	 */
-	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_ALIGN_128B))
+	if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
 		align = 128;
 	else
 		align = 16 * args->bpp / 8;
@@ -144,7 +144,7 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_ALIGN_128B))
+	if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
 		align = 128;
 	else
 		align = 16 * format->bpp / 8;
-- 
1.8.3.2

