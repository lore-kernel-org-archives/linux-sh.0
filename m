From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:52:14 +0000
Subject: [PATCH 4/5] drm/rcar-du: Add LVDS_LANES quirk
Message-Id: <1384350735-4419-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

LVDS lanes 1 and 3 are switched in ES1 hardware (R8A7790). The problem
has been fixed in newer revisions, add a quirk to make the workaround
selectable.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c | 15 ++++++++++-----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index a0ffacb..4eee02f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -250,7 +250,7 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
-	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
+	.quirks = RCAR_DU_QUIRK_ALIGN_128B | RCAR_DU_QUIRK_LVDS_LANES,
 	.num_crtcs = 3,
 	.routes = {
 		/* R8A7790 has one RGB output, two LVDS outputs and one
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 7ca98f3..e31b735 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -31,6 +31,7 @@ struct rcar_du_lvdsenc;
 #define RCAR_DU_FEATURE_DEFR8		(1 << 1)	/* Has DEFR8 register */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes */
+#define RCAR_DU_QUIRK_LVDS_LANES	(1 << 1)	/* LVDS lanes 1 and 3 inverted */
 
 /*
  * struct rcar_du_output_routing - Output routing specification
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
index a0f6a17..3dc1331 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -44,6 +44,7 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 	const struct drm_display_mode *mode = &rcrtc->crtc.mode;
 	unsigned int freq = mode->clock;
 	u32 lvdcr0;
+	u32 lvdhcr;
 	u32 pllcr;
 	int ret;
 
@@ -72,15 +73,19 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc *lvds,
 	 * VSYNC -> CTRL1
 	 * DISP  -> CTRL2
 	 * 0     -> CTRL3
-	 *
-	 * Channels 1 and 3 are switched on ES1.
 	 */
 	rcar_lvds_write(lvds, LVDCTRCR, LVDCTRCR_CTR3SEL_ZERO |
 			LVDCTRCR_CTR2SEL_DISP | LVDCTRCR_CTR1SEL_VSYNC |
 			LVDCTRCR_CTR0SEL_HSYNC);
-	rcar_lvds_write(lvds, LVDCHCR,
-			LVDCHCR_CHSEL_CH(0, 0) | LVDCHCR_CHSEL_CH(1, 3) |
-			LVDCHCR_CHSEL_CH(2, 2) | LVDCHCR_CHSEL_CH(3, 1));
+
+	if (rcar_du_needs(lvds->dev, RCAR_DU_QUIRK_LVDS_LANES))
+		lvdhcr = LVDCHCR_CHSEL_CH(0, 0) | LVDCHCR_CHSEL_CH(1, 3)
+		       | LVDCHCR_CHSEL_CH(2, 2) | LVDCHCR_CHSEL_CH(3, 1);
+	else
+		lvdhcr = LVDCHCR_CHSEL_CH(0, 0) | LVDCHCR_CHSEL_CH(1, 1)
+		       | LVDCHCR_CHSEL_CH(2, 2) | LVDCHCR_CHSEL_CH(3, 3);
+
+	rcar_lvds_write(lvds, LVDCHCR, lvdhcr);
 
 	/* Select the input, hardcode mode 0, enable LVDS operation and turn
 	 * bias circuitry on.
-- 
1.8.3.2

