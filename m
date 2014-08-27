From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:05 +0000
Subject: [PATCH 08/16] drm/rcar-du: Add OF support
Message-Id: <1409157673-4154-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Implement support for the R-Car DU DT bindings in the rcar-du DRM
driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 170 ++++++++++++----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  11 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |   3 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 231 +++++++++++++++++++++++++++---
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c |  30 +++-
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h |   3 +-
 7 files changed, 344 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index fda64b7..4ee8cb2 100644
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
@@ -30,6 +31,97 @@
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
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_DPAD1] = {
+			.possible_crtcs = BIT(1) | BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 1,
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
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 1,
+		},
+		[RCAR_DU_OUTPUT_LVDS1] = {
+			.possible_crtcs = BIT(2) | BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 2,
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
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 1,
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
 
@@ -53,12 +145,13 @@ static int rcar_du_unload(struct drm_device *dev)
 static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 {
 	struct platform_device *pdev = dev->platformdev;
+	struct device_node *np = pdev->dev.of_node;
 	struct rcar_du_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_du_device *rcdu;
 	struct resource *mem;
 	int ret;
 
-	if (pdata = NULL) {
+	if (pdata = NULL && np = NULL) {
 		dev_err(dev->dev, "no platform data\n");
 		return -ENODEV;
 	}
@@ -71,7 +164,8 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 
 	rcdu->dev = &pdev->dev;
 	rcdu->pdata = pdata;
-	rcdu->info = (struct rcar_du_device_info *)pdev->id_entry->driver_data;
+	rcdu->info = np ? of_match_device(rcar_du_of_table, rcdu->dev)->data
+		   : (void *)platform_get_device_id(pdev)->driver_data;
 	rcdu->ddev = dev;
 	dev->dev_private = rcdu;
 
@@ -231,77 +325,6 @@ static int rcar_du_remove(struct platform_device *pdev)
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
@@ -309,6 +332,7 @@ static struct platform_driver rcar_du_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "rcar-du",
 		.pm	= &rcar_du_pm_ops,
+		.of_match_table = rcar_du_of_table,
 	},
 	.id_table	= rcar_du_id_table,
 };
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index e31b735..c6e944b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -37,6 +37,7 @@ struct rcar_du_lvdsenc;
  * struct rcar_du_output_routing - Output routing specification
  * @possible_crtcs: bitmask of possible CRTCs for the output
  * @encoder_type: DRM type of the internal encoder associated with the output
+ * @port: device tree port number corresponding to this output route
  *
  * The DU has 5 possible outputs (DPAD0/1, LVDS0/1, TCON). Output routing data
  * specify the valid SoC outputs, which CRTCs can drive the output, and the type
@@ -45,6 +46,7 @@ struct rcar_du_lvdsenc;
 struct rcar_du_output_routing {
 	unsigned int possible_crtcs;
 	unsigned int encoder_type;
+	unsigned int port;
 };
 
 /*
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 3daa7a1..1adfd29 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -142,7 +142,8 @@ static const struct drm_encoder_funcs encoder_funcs = {
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 const struct rcar_du_encoder_data *data)
+			 const struct rcar_du_encoder_data *data,
+			 struct device_node *np)
 {
 	struct rcar_du_encoder *renc;
 	unsigned int encoder_type;
@@ -189,9 +190,11 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	drm_encoder_helper_add(&renc->encoder, &encoder_helper_funcs);
 
 	switch (encoder_type) {
-	case DRM_MODE_ENCODER_LVDS:
-		return rcar_du_lvds_connector_init(rcdu, renc,
-						   &data->connector.lvds.panel);
+	case DRM_MODE_ENCODER_LVDS: {
+		const struct rcar_du_panel_data *pdata +			data ? &data->connector.lvds.panel : NULL;
+		return rcar_du_lvds_connector_init(rcdu, renc, pdata, np);
+	}
 
 	case DRM_MODE_ENCODER_DAC:
 		return rcar_du_vga_connector_init(rcdu, renc);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index 0e5a65e..0524baa 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -44,6 +44,7 @@ rcar_du_connector_best_encoder(struct drm_connector *connector);
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 const struct rcar_du_encoder_data *data);
+			 const struct rcar_du_encoder_data *data,
+			 struct device_node *np);
 
 #endif /* __RCAR_DU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 7602610..7558570 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -17,6 +17,8 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
+#include <linux/of_graph.h>
+
 #include "rcar_du_crtc.h"
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
@@ -188,6 +190,205 @@ static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.output_poll_changed = rcar_du_output_poll_changed,
 };
 
+static int rcar_du_encoders_init_pdata(struct rcar_du_device *rcdu)
+{
+	unsigned int num_encoders = 0;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < rcdu->pdata->num_encoders; ++i) {
+		const struct rcar_du_encoder_data *pdata +			&rcdu->pdata->encoders[i];
+		const struct rcar_du_output_routing *route +			&rcdu->info->routes[pdata->output];
+
+		if (pdata->type = RCAR_DU_ENCODER_UNUSED)
+			continue;
+
+		if (pdata->output >= RCAR_DU_OUTPUT_MAX ||
+		    route->possible_crtcs = 0) {
+			dev_warn(rcdu->dev,
+				 "encoder %u references unexisting output %u, skipping\n",
+				 i, pdata->output);
+			continue;
+		}
+
+		ret = rcar_du_encoder_init(rcdu, pdata->type, pdata->output,
+					   pdata, NULL);
+		if (ret < 0)
+			return ret;
+
+		num_encoders++;
+	}
+
+	return num_encoders;
+}
+
+static int rcar_du_encoders_init_dt_one(struct rcar_du_device *rcdu,
+					enum rcar_du_output output,
+					struct of_endpoint *ep)
+{
+	static const struct {
+		const char *compatible;
+		enum rcar_du_encoder_type type;
+	} encoders[] = {
+		{ "adi,adv7123", RCAR_DU_ENCODER_VGA },
+		{ "thine,thc63lvdm83d", RCAR_DU_ENCODER_LVDS },
+	};
+
+	enum rcar_du_encoder_type enc_type = RCAR_DU_ENCODER_NONE;
+	struct device_node *connector = NULL;
+	struct device_node *encoder = NULL;
+	struct device_node *prev = NULL;
+	struct device_node *entity_ep_node;
+	struct device_node *entity;
+	int ret;
+
+	/*
+	 * Locate the connected entity and infer its type from the number of
+	 * endpoints.
+	 */
+	entity = of_graph_get_remote_port_parent(ep->local_node);
+	if (!entity) {
+		dev_dbg(rcdu->dev, "unconnected endpoint %s, skipping\n",
+			ep->local_node->full_name);
+		return 0;
+	}
+
+	entity_ep_node = of_parse_phandle(ep->local_node, "remote-endpoint", 0);
+
+	while (1) {
+		struct device_node *ep_node;
+
+		ep_node = of_graph_get_next_endpoint(entity, prev);
+		of_node_put(prev);
+		prev = ep_node;
+
+		if (!ep_node)
+			break;
+
+		if (ep_node = entity_ep_node)
+			continue;
+
+		/*
+		 * We've found one endpoint other than the input, this must
+		 * be an encoder. Locate the connector.
+		 */
+		encoder = entity;
+		connector = of_graph_get_remote_port_parent(ep_node);
+		of_node_put(ep_node);
+
+		if (!connector) {
+			dev_warn(rcdu->dev,
+				 "no connector for encoder %s, skipping\n",
+				 encoder->full_name);
+			of_node_put(entity_ep_node);
+			of_node_put(encoder);
+			return 0;
+		}
+
+		break;
+	}
+
+	of_node_put(entity_ep_node);
+
+	if (encoder) {
+		/*
+		 * If an encoder has been found, get its type based on its
+		 * compatible string.
+		 */
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(encoders); ++i) {
+			if (of_device_is_compatible(encoder,
+						    encoders[i].compatible)) {
+				enc_type = encoders[i].type;
+				break;
+			}
+		}
+
+		if (i = ARRAY_SIZE(encoders)) {
+			dev_warn(rcdu->dev,
+				 "unknown encoder type for %s, skipping\n",
+				 encoder->full_name);
+			of_node_put(encoder);
+			of_node_put(connector);
+			return 0;
+		}
+	} else {
+		/*
+		 * If no encoder has been found the entity must be the
+		 * connector.
+		 */
+		connector = entity;
+	}
+
+	ret = rcar_du_encoder_init(rcdu, enc_type, output, NULL, connector);
+	of_node_put(encoder);
+	of_node_put(connector);
+
+	return ret < 0 ? ret : 1;
+}
+
+static int rcar_du_encoders_init_dt(struct rcar_du_device *rcdu)
+{
+	struct device_node *np = rcdu->dev->of_node;
+	struct device_node *prev = NULL;
+	unsigned int num_encoders = 0;
+
+	/*
+	 * Iterate over the endpoints and create one encoder for each output
+	 * pipeline.
+	 */
+	while (1) {
+		struct device_node *ep_node;
+		enum rcar_du_output output;
+		struct of_endpoint ep;
+		unsigned int i;
+		int ret;
+
+		ep_node = of_graph_get_next_endpoint(np, prev);
+		of_node_put(prev);
+		prev = ep_node;
+
+		if (ep_node = NULL)
+			break;
+
+		ret = of_graph_parse_endpoint(ep_node, &ep);
+		if (ret < 0) {
+			of_node_put(ep_node);
+			return ret;
+		}
+
+		/* Find the output route corresponding to the port number. */
+		for (i = 0; i < RCAR_DU_OUTPUT_MAX; ++i) {
+			if (rcdu->info->routes[i].possible_crtcs &&
+			    rcdu->info->routes[i].port = ep.port) {
+				output = i;
+				break;
+			}
+		}
+
+		if (i = RCAR_DU_OUTPUT_MAX) {
+			dev_warn(rcdu->dev,
+				 "port %u references unexisting output, skipping\n",
+				 ep.port);
+			continue;
+		}
+
+		/* Process the output pipeline. */
+		ret = rcar_du_encoders_init_dt_one(rcdu, output, &ep);
+		if (ret < 0) {
+			of_node_put(ep_node);
+			return ret;
+		}
+
+		num_encoders += ret;
+	}
+
+	return num_encoders;
+}
+
 int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 {
 	static const unsigned int mmio_offsets[] = {
@@ -197,6 +398,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
 	struct drm_fbdev_cma *fbdev;
+	unsigned int num_encoders;
 	unsigned int num_groups;
 	unsigned int i;
 	int ret;
@@ -240,28 +442,15 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < rcdu->pdata->num_encoders; ++i) {
-		const struct rcar_du_encoder_data *pdata -			&rcdu->pdata->encoders[i];
-		const struct rcar_du_output_routing *route -			&rcdu->info->routes[pdata->output];
-
-		if (pdata->type = RCAR_DU_ENCODER_UNUSED)
-			continue;
+	if (rcdu->pdata)
+		ret = rcar_du_encoders_init_pdata(rcdu);
+	else
+		ret = rcar_du_encoders_init_dt(rcdu);
 
-		if (pdata->output >= RCAR_DU_OUTPUT_MAX ||
-		    route->possible_crtcs = 0) {
-			dev_warn(rcdu->dev,
-				 "encoder %u references unexisting output %u, skipping\n",
-				 i, pdata->output);
-			continue;
-		}
+	if (ret < 0)
+		return ret;
 
-		ret = rcar_du_encoder_init(rcdu, pdata->type, pdata->output,
-					   pdata);
-		if (ret < 0)
-			return ret;
-	}
+	num_encoders = ret;
 
 	/* Set the possible CRTCs and possible clones. There's always at least
 	 * one way for all encoders to clone each other, set all bits in the
@@ -273,7 +462,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 			&rcdu->info->routes[renc->output];
 
 		encoder->possible_crtcs = route->possible_crtcs;
-		encoder->possible_clones = (1 << rcdu->pdata->num_encoders) - 1;
+		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
 	/* Now that the CRTCs have been initialized register the planes. */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index f2d92a0..dae5052 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -15,6 +15,10 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
+#include <video/display_timing.h>
+#include <video/of_display_timing.h>
+#include <video/videomode.h>
+
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
 #include "rcar_du_kms.h"
@@ -23,7 +27,7 @@
 struct rcar_du_lvds_connector {
 	struct rcar_du_connector connector;
 
-	const struct rcar_du_panel_data *panel;
+	struct rcar_du_panel_data panel;
 };
 
 #define to_rcar_lvds_connector(c) \
@@ -41,7 +45,7 @@ static int rcar_du_lvds_connector_get_modes(struct drm_connector *connector)
 
 	mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 
-	drm_display_mode_from_videomode(&lvdscon->panel->mode, mode);
+	drm_display_mode_from_videomode(&lvdscon->panel.mode, mode);
 
 	drm_mode_probed_add(connector, mode);
 
@@ -74,7 +78,8 @@ static const struct drm_connector_funcs connector_funcs = {
 
 int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
-				const struct rcar_du_panel_data *panel)
+				const struct rcar_du_panel_data *panel,
+				/* TODO const */ struct device_node *np)
 {
 	struct rcar_du_lvds_connector *lvdscon;
 	struct drm_connector *connector;
@@ -84,11 +89,24 @@ int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 	if (lvdscon = NULL)
 		return -ENOMEM;
 
-	lvdscon->panel = panel;
+	if (panel) {
+		lvdscon->panel = *panel;
+	} else {
+		struct display_timing timing;
+
+		ret = of_get_display_timing(np, "panel-timing", &timing);
+		if (ret < 0)
+			return ret;
+
+		videomode_from_timing(&timing, &lvdscon->panel.mode);
+
+		of_property_read_u32(np, "width-mm", &lvdscon->panel.width_mm);
+		of_property_read_u32(np, "height-mm", &lvdscon->panel.height_mm);
+	}
 
 	connector = &lvdscon->connector.connector;
-	connector->display_info.width_mm = panel->width_mm;
-	connector->display_info.height_mm = panel->height_mm;
+	connector->display_info.width_mm = lvdscon->panel.width_mm;
+	connector->display_info.height_mm = lvdscon->panel.height_mm;
 
 	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
 				 DRM_MODE_CONNECTOR_LVDS);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
index bff8683..c2fffd3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
@@ -20,6 +20,7 @@ struct rcar_du_panel_data;
 
 int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
-				const struct rcar_du_panel_data *panel);
+				const struct rcar_du_panel_data *panel,
+				struct device_node *np);
 
 #endif /* __RCAR_DU_LVDSCON_H__ */
-- 
1.8.5.5

