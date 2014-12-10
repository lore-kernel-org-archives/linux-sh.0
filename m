From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:05 +0000
Subject: [PATCH 05/15] drm: rcar-du: Refactor DEFR8 feature
Message-Id: <1418254935-13536-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Rename the feature from RCAR_DU_FEATURE_DEFR8 to
RCAR_DU_FEATURE_EXT_CTRL_REGS to cover all extended control registers in
addition to the DEFR8 register.

Usage of the feature is refactored to optimize runtime operation and
prepare for external clock support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 7 ++++---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 6 ++++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c | 9 +++++----
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 23cc910951f4..cf0dca13264f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -139,9 +139,10 @@ void rcar_du_crtc_route_output(struct drm_crtc *crtc,
 	 */
 	rcrtc->outputs |= BIT(output);
 
-	/* Store RGB routing to DPAD0 for R8A7790. */
-	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_DEFR8) &&
-	    output = RCAR_DU_OUTPUT_DPAD0)
+	/* Store RGB routing to DPAD0, the hardware will be configured when
+	 * starting the CRTC.
+	 */
+	if (output = RCAR_DU_OUTPUT_DPAD0)
 		rcdu->dpad0_source = rcrtc->index;
 }
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 967ae8f20233..4fb29b473560 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -56,7 +56,8 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B | RCAR_DU_QUIRK_LVDS_LANES,
 	.num_crtcs = 3,
 	.routes = {
@@ -83,7 +84,8 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
 	.num_crtcs = 2,
 	.routes = {
 		/* R8A7791 has one RGB output, one LVDS output and one
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 0a724669f02d..c5b9ea6a7eaa 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -27,7 +27,7 @@ struct rcar_du_device;
 struct rcar_du_lvdsenc;
 
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock */
-#define RCAR_DU_FEATURE_DEFR8		(1 << 1)	/* Has DEFR8 register */
+#define RCAR_DU_FEATURE_EXT_CTRL_REGS	(1 << 1)	/* Has extended control registers */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes */
 #define RCAR_DU_QUIRK_LVDS_LANES	(1 << 1)	/* LVDS lanes 1 and 3 inverted */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 4e7614b145db..7b6428234252 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -48,9 +48,6 @@ static void rcar_du_group_setup_defr8(struct rcar_du_group *rgrp)
 {
 	u32 defr8 = DEFR8_CODE | DEFR8_DEFE8;
 
-	if (!rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_DEFR8))
-		return;
-
 	/* The DEFR8 register for the first group also controls RGB output
 	 * routing to DPAD0
 	 */
@@ -69,7 +66,8 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 	rcar_du_group_write(rgrp, DEFR4, DEFR4_CODE);
 	rcar_du_group_write(rgrp, DEFR5, DEFR5_CODE | DEFR5_DEFE5);
 
-	rcar_du_group_setup_defr8(rgrp);
+	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS))
+		rcar_du_group_setup_defr8(rgrp);
 
 	/* Use DS1PR and DS2PR to configure planes priorities and connects the
 	 * superposition 0 to DU0 pins. DU1 pins will be configured dynamically.
@@ -149,6 +147,9 @@ static int rcar_du_set_dpad0_routing(struct rcar_du_device *rcdu)
 {
 	int ret;
 
+	if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_EXT_CTRL_REGS))
+		return 0;
+
 	/* RGB output routing to DPAD0 is configured in the DEFR8 register of
 	 * the first group. As this function can be called with the DU0 and DU1
 	 * CRTCs disabled, we need to enable the first group clock before
-- 
2.0.4

