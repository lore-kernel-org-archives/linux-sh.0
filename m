From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:35:38 +0000
Subject: [RFC/PATCH 1/7 RESEND] drm/rcar-du: Add OF support
Message-Id: <1390318538-30157-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390318362-29954-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

Add DT bindings for the R-Car DU with support for core resources
(memory, IRQ and clocks). Output configuration must still be passed
through platform data using OF_DEV_AUXDATA.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/renesas,du.txt       |  49 +++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 161 ++++++++++++---------
 2 files changed, 138 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt

With the devicetree mailing list CC'ed this time.

diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt b/Documentation/devicetree/bindings/video/renesas,du.txt
new file mode 100644
index 0000000..6bd947c
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/renesas,du.txt
@@ -0,0 +1,49 @@
+* Renesas R-Car Display Unit (DU)
+
+Required Properties:
+
+  - compatible: must be one of the following.
+    - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
+    - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
+    - "renesas,du-r8a7790" for R8A7791 (R-Car M2) compatible DU
+
+  - reg: A list of base address and length of each memory resource, one for
+    each entry in the reg-names property.
+  - reg-names: Name of the memory resources. The DU requires one memory
+    resource for the DU core (named "du") and one memory resource for each
+    LVDS encoder (named "lvds.x" with "x" being the LVDS controller numerical
+    index).
+
+  - interrupt-parent: phandle of the parent interrupt controller.
+  - interrupts: Interrupt specifiers for the DU interrupts.
+
+  - clocks: A list of phandles + clock-specifier pairs, one for each entry in
+    the clock-names property.
+  - clock-names: Name of the clocks. This property is model-dependent.
+    - R8A7779 uses a single functional clock. The clock doesn't need to be
+      named.
+    - R8A7790 and R8A7790 use one functional clock per channel and one clock
+      per LVDS encoder. The functional clocks must be named "du.x" with "x"
+      being the channel numerical index. The LVDS clocks must be named
+      "lvds.x" with "x" being the LVDS encoder numerical index.
+
+
+Example: R8A7790 (R-Car H2) DU
+
+	du: du@feb00000 {
+		compatible = "renesas,du-r8a7790";
+		reg = <0 0xfeb00000 0 0x70000>,
+		      <0 0xfeb90000 0 0x1c>,
+		      <0 0xfeb94000 0 0x1c>;
+		reg-names = "du", "lvds.0", "lvds.1";
+		interrupt-parent = <&gic>;
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 269 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+		         <&mstp7_clks R8A7790_CLK_DU1>,
+		         <&mstp7_clks R8A7790_CLK_DU2>,
+		         <&mstp7_clks R8A7790_CLK_LVDS0>,
+		         <&mstp7_clks R8A7790_CLK_LVDS1>;
+		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
+	};
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5536811..86ba5c7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -30,6 +31,90 @@
 #include "rcar_du_regs.h"
 
 /* -----------------------------------------------------------------------------
+ * Device Information
+ */
+
+static const struct rcar_du_device_info rcar_du_r8a7779_info = {
+	.features = 0,
+	.num_crtcs = 2,
+	.routes = {
+		/* R8A7779 has two RGB outputs and one (currently unsupported)
+		 * TCON output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+		},
+		[RCAR_DU_OUTPUT_DPAD1] = {
+			.possible_crtcs = BIT(1) | BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+		},
+	},
+	.num_lvds = 0,
+};
+
+static const struct rcar_du_device_info rcar_du_r8a7790_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.quirks = RCAR_DU_QUIRK_ALIGN_128B | RCAR_DU_QUIRK_LVDS_LANES,
+	.num_crtcs = 3,
+	.routes = {
+		/* R8A7790 has one RGB output, two LVDS outputs and one
+		 * (currently unsupported) TCON output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(2) | BIT(1) | BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+		},
+		[RCAR_DU_OUTPUT_LVDS1] = {
+			.possible_crtcs = BIT(2) | BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+		},
+	},
+	.num_lvds = 2,
+};
+
+static const struct rcar_du_device_info rcar_du_r8a7791_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
+	.num_crtcs = 2,
+	.routes = {
+		/* R8A7791 has one RGB output, one LVDS output and one
+		 * (currently unsupported) TCON output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+		},
+	},
+	.num_lvds = 1,
+};
+
+static const struct platform_device_id rcar_du_id_table[] = {
+	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
+	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
+	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(platform, rcar_du_id_table);
+
+static const struct of_device_id rcar_du_of_table[] = {
+	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
+	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
+	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, rcar_du_of_table);
+
+/* -----------------------------------------------------------------------------
  * DRM operations
  */
 
@@ -53,6 +138,7 @@ static int rcar_du_unload(struct drm_device *dev)
 static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 {
 	struct platform_device *pdev = dev->platformdev;
+	struct device_node *np = pdev->dev.of_node;
 	struct rcar_du_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_du_device *rcdu;
 	struct resource *mem;
@@ -71,7 +157,8 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 
 	rcdu->dev = &pdev->dev;
 	rcdu->pdata = pdata;
-	rcdu->info = (struct rcar_du_device_info *)pdev->id_entry->driver_data;
+	rcdu->info = np ? of_match_device(rcar_du_of_table, rcdu->dev)->data
+		   : (void *)platform_get_device_id(pdev)->driver_data;
 	rcdu->ddev = dev;
 	dev->dev_private = rcdu;
 
@@ -229,77 +316,6 @@ static int rcar_du_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct rcar_du_device_info rcar_du_r8a7779_info = {
-	.features = 0,
-	.num_crtcs = 2,
-	.routes = {
-		/* R8A7779 has two RGB outputs and one (currently unsupported)
-		 * TCON output.
-		 */
-		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(0),
-			.encoder_type = DRM_MODE_ENCODER_NONE,
-		},
-		[RCAR_DU_OUTPUT_DPAD1] = {
-			.possible_crtcs = BIT(1) | BIT(0),
-			.encoder_type = DRM_MODE_ENCODER_NONE,
-		},
-	},
-	.num_lvds = 0,
-};
-
-static const struct rcar_du_device_info rcar_du_r8a7790_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
-	.quirks = RCAR_DU_QUIRK_ALIGN_128B | RCAR_DU_QUIRK_LVDS_LANES,
-	.num_crtcs = 3,
-	.routes = {
-		/* R8A7790 has one RGB output, two LVDS outputs and one
-		 * (currently unsupported) TCON output.
-		 */
-		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(2) | BIT(1) | BIT(0),
-			.encoder_type = DRM_MODE_ENCODER_NONE,
-		},
-		[RCAR_DU_OUTPUT_LVDS0] = {
-			.possible_crtcs = BIT(0),
-			.encoder_type = DRM_MODE_ENCODER_LVDS,
-		},
-		[RCAR_DU_OUTPUT_LVDS1] = {
-			.possible_crtcs = BIT(2) | BIT(1),
-			.encoder_type = DRM_MODE_ENCODER_LVDS,
-		},
-	},
-	.num_lvds = 2,
-};
-
-static const struct rcar_du_device_info rcar_du_r8a7791_info = {
-	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK | RCAR_DU_FEATURE_DEFR8,
-	.num_crtcs = 2,
-	.routes = {
-		/* R8A7791 has one RGB output, one LVDS output and one
-		 * (currently unsupported) TCON output.
-		 */
-		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(1),
-			.encoder_type = DRM_MODE_ENCODER_NONE,
-		},
-		[RCAR_DU_OUTPUT_LVDS0] = {
-			.possible_crtcs = BIT(0),
-			.encoder_type = DRM_MODE_ENCODER_LVDS,
-		},
-	},
-	.num_lvds = 1,
-};
-
-static const struct platform_device_id rcar_du_id_table[] = {
-	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
-	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
-	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(platform, rcar_du_id_table);
-
 static struct platform_driver rcar_du_platform_driver = {
 	.probe		= rcar_du_probe,
 	.remove		= rcar_du_remove,
@@ -307,6 +323,7 @@ static struct platform_driver rcar_du_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "rcar-du",
 		.pm	= &rcar_du_pm_ops,
+		.of_match_table = rcar_du_of_table,
 	},
 	.id_table	= rcar_du_id_table,
 };
-- 
1.8.3.2

