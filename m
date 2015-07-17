From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:04 +0000
Subject: [PATCH 2/5] drm: rcar-du: Add support for the R8A7794 DU
Message-Id: <1437121567-18467-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

The R8A7794 DU has a fixed output routing configuration with one RGB
output per CRTC and thus lacks the RGB output routing register field.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/renesas,du.txt       |  4 +++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 23 ++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |  5 +++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt b/Documentation/devicetree/bindings/video/renesas,du.txt
index d05be121486f..eccd4f4867b2 100644
--- a/Documentation/devicetree/bindings/video/renesas,du.txt
+++ b/Documentation/devicetree/bindings/video/renesas,du.txt
@@ -7,6 +7,7 @@ Required Properties:
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
     - "renesas,du-r8a7793" for R8A7793 (R-Car M2-N) compatible DU
+    - "renesas,du-r8a7794" for R8A7794 (R-Car E2) compatible DU
 
   - reg: A list of base address and length of each memory resource, one for
     each entry in the reg-names property.
@@ -23,7 +24,7 @@ Required Properties:
   - clock-names: Name of the clocks. This property is model-dependent.
     - R8A7779 uses a single functional clock. The clock doesn't need to be
       named.
-    - R8A779[013] use one functional clock per channel and one clock per LVDS
+    - R8A779[0134] use one functional clock per channel and one clock per LVDS
       encoder (if available). The functional clocks must be named "du.x" with
       "x" being the channel numerical index. The LVDS clocks must be named
       "lvds.x" with "x" being the LVDS encoder numerical index.
@@ -46,6 +47,7 @@ corresponding to each DU output.
  R8A7790 (H2)	DPAD		LVDS 0		LVDS 1
  R8A7791 (M2-W)	DPAD		LVDS 0		-
  R8A7793 (M2-N)	DPAD		LVDS 0		-
+ R8A7794 (E2)	DPAD 0		DPAD 1		-
 
 
 Example: R8A7790 (R-Car H2) DU
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5a7e6dfa5df2..2b9a7c87467c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -107,11 +107,34 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.num_lvds = 1,
 };
 
+static const struct rcar_du_device_info rcar_du_r8a7794_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+	.num_crtcs = 2,
+	.routes = {
+		/* R8A7794 has two RGB outputs and one (currently unsupported)
+		 * TCON output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_DPAD1] = {
+			.possible_crtcs = BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 1,
+		},
+	},
+	.num_lvds = 1,
+};
+
 static const struct platform_device_id rcar_du_id_table[] = {
 	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
 	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
 	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
 	{ "rcar-du-r8a7793", (kernel_ulong_t)&rcar_du_r8a7791_info },
+	{ "rcar-du-r8a7794", (kernel_ulong_t)&rcar_du_r8a7794_info },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 7fd39a7d91c8..8e2ffe025153 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -49,9 +49,10 @@ static void rcar_du_group_setup_defr8(struct rcar_du_group *rgrp)
 	u32 defr8 = DEFR8_CODE | DEFR8_DEFE8;
 
 	/* The DEFR8 register for the first group also controls RGB output
-	 * routing to DPAD0
+	 * routing to DPAD0 for DU instances that support it.
 	 */
-	if (rgrp->index = 0)
+	if (rgrp->dev->info->routes[RCAR_DU_OUTPUT_DPAD0].possible_crtcs > 1 &&
+	    rgrp->index = 0)
 		defr8 |= DEFR8_DRGBS_DU(rgrp->dev->dpad0_source);
 
 	rcar_du_group_write(rgrp, DEFR8, defr8);
-- 
2.3.6

