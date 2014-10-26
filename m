From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 15:24:20 +0000
Subject: [PATCH v3 1/9] drm: rcar-du: Remove platform data support
Message-Id: <1414337068-28664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

All platforms now instantiate the DU through DT, platform data support
isn't needed anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h    | 10 ++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |  4 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |  2 -
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  8 +---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h | 10 +++--
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 52 +++-------------------
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c | 26 +++++------
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h |  2 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h |  1 -
 include/linux/platform_data/rcar-du.h     | 74 -------------------------------
 10 files changed, 38 insertions(+), 151 deletions(-)
 delete mode 100644 include/linux/platform_data/rcar-du.h

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index e97ae502dec5..984e6083699f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -15,7 +15,6 @@
 #define __RCAR_DU_CRTC_H__
 
 #include <linux/mutex.h>
-#include <linux/platform_data/rcar-du.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
@@ -41,6 +40,15 @@ struct rcar_du_crtc {
 
 #define to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, crtc)
 
+enum rcar_du_output {
+	RCAR_DU_OUTPUT_DPAD0,
+	RCAR_DU_OUTPUT_DPAD1,
+	RCAR_DU_OUTPUT_LVDS0,
+	RCAR_DU_OUTPUT_LVDS1,
+	RCAR_DU_OUTPUT_TCON,
+	RCAR_DU_OUTPUT_MAX,
+};
+
 int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index);
 void rcar_du_crtc_enable_vblank(struct rcar_du_crtc *rcrtc, bool enable);
 void rcar_du_crtc_cancel_page_flip(struct rcar_du_crtc *rcrtc,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index d212efa6a495..967ae8f20233 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -146,12 +146,11 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 {
 	struct platform_device *pdev = dev->platformdev;
 	struct device_node *np = pdev->dev.of_node;
-	struct rcar_du_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_du_device *rcdu;
 	struct resource *mem;
 	int ret;
 
-	if (pdata = NULL && np = NULL) {
+	if (np = NULL) {
 		dev_err(dev->dev, "no platform data\n");
 		return -ENODEV;
 	}
@@ -163,7 +162,6 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 	}
 
 	rcdu->dev = &pdev->dev;
-	rcdu->pdata = pdata;
 	rcdu->info = np ? of_match_device(rcar_du_of_table, rcdu->dev)->data
 		   : (void *)platform_get_device_id(pdev)->driver_data;
 	rcdu->ddev = dev;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 8e494633c3b3..0a724669f02d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -15,7 +15,6 @@
 #define __RCAR_DU_DRV_H__
 
 #include <linux/kernel.h>
-#include <linux/platform_data/rcar-du.h>
 
 #include "rcar_du_crtc.h"
 #include "rcar_du_group.h"
@@ -67,7 +66,6 @@ struct rcar_du_device_info {
 
 struct rcar_du_device {
 	struct device *dev;
-	const struct rcar_du_platform_data *pdata;
 	const struct rcar_du_device_info *info;
 
 	void __iomem *mmio;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 7c0ec95915ef..89ed4a929f7b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -142,7 +142,6 @@ static const struct drm_encoder_funcs encoder_funcs = {
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 const struct rcar_du_encoder_data *data,
 			 struct device_node *np)
 {
 	struct rcar_du_encoder *renc;
@@ -190,11 +189,8 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	drm_encoder_helper_add(&renc->encoder, &encoder_helper_funcs);
 
 	switch (encoder_type) {
-	case DRM_MODE_ENCODER_LVDS: {
-		const struct rcar_du_panel_data *pdata -			data ? &data->connector.lvds.panel : NULL;
-		return rcar_du_lvds_connector_init(rcdu, renc, pdata, np);
-	}
+	case DRM_MODE_ENCODER_LVDS:
+		return rcar_du_lvds_connector_init(rcdu, renc, np);
 
 	case DRM_MODE_ENCODER_DAC:
 		return rcar_du_vga_connector_init(rcdu, renc);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index bd624135ef1f..c37ed9499542 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -14,13 +14,18 @@
 #ifndef __RCAR_DU_ENCODER_H__
 #define __RCAR_DU_ENCODER_H__
 
-#include <linux/platform_data/rcar-du.h>
-
 #include <drm/drm_crtc.h>
 
 struct rcar_du_device;
 struct rcar_du_lvdsenc;
 
+enum rcar_du_encoder_type {
+	RCAR_DU_ENCODER_UNUSED = 0,
+	RCAR_DU_ENCODER_NONE,
+	RCAR_DU_ENCODER_VGA,
+	RCAR_DU_ENCODER_LVDS,
+};
+
 struct rcar_du_encoder {
 	struct drm_encoder encoder;
 	enum rcar_du_output output;
@@ -44,7 +49,6 @@ rcar_du_connector_best_encoder(struct drm_connector *connector);
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 const struct rcar_du_encoder_data *data,
 			 struct device_node *np);
 
 #endif /* __RCAR_DU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 6c24ad7d03ef..c6a7fd604d46 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -190,43 +190,9 @@ static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.output_poll_changed = rcar_du_output_poll_changed,
 };
 
-static int rcar_du_encoders_init_pdata(struct rcar_du_device *rcdu)
-{
-	unsigned int num_encoders = 0;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < rcdu->pdata->num_encoders; ++i) {
-		const struct rcar_du_encoder_data *pdata -			&rcdu->pdata->encoders[i];
-		const struct rcar_du_output_routing *route -			&rcdu->info->routes[pdata->output];
-
-		if (pdata->type = RCAR_DU_ENCODER_UNUSED)
-			continue;
-
-		if (pdata->output >= RCAR_DU_OUTPUT_MAX ||
-		    route->possible_crtcs = 0) {
-			dev_warn(rcdu->dev,
-				 "encoder %u references unexisting output %u, skipping\n",
-				 i, pdata->output);
-			continue;
-		}
-
-		ret = rcar_du_encoder_init(rcdu, pdata->type, pdata->output,
-					   pdata, NULL);
-		if (ret < 0)
-			return ret;
-
-		num_encoders++;
-	}
-
-	return num_encoders;
-}
-
-static int rcar_du_encoders_init_dt_one(struct rcar_du_device *rcdu,
-					enum rcar_du_output output,
-					struct of_endpoint *ep)
+static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
+				     enum rcar_du_output output,
+				     struct of_endpoint *ep)
 {
 	static const struct {
 		const char *compatible;
@@ -323,14 +289,14 @@ static int rcar_du_encoders_init_dt_one(struct rcar_du_device *rcdu,
 		connector = entity;
 	}
 
-	ret = rcar_du_encoder_init(rcdu, enc_type, output, NULL, connector);
+	ret = rcar_du_encoder_init(rcdu, enc_type, output, connector);
 	of_node_put(encoder);
 	of_node_put(connector);
 
 	return ret < 0 ? ret : 1;
 }
 
-static int rcar_du_encoders_init_dt(struct rcar_du_device *rcdu)
+static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 {
 	struct device_node *np = rcdu->dev->of_node;
 	struct device_node *prev = NULL;
@@ -377,7 +343,7 @@ static int rcar_du_encoders_init_dt(struct rcar_du_device *rcdu)
 		}
 
 		/* Process the output pipeline. */
-		ret = rcar_du_encoders_init_dt_one(rcdu, output, &ep);
+		ret = rcar_du_encoders_init_one(rcdu, output, &ep);
 		if (ret < 0) {
 			of_node_put(ep_node);
 			return ret;
@@ -442,11 +408,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	if (ret < 0)
 		return ret;
 
-	if (rcdu->pdata)
-		ret = rcar_du_encoders_init_pdata(rcdu);
-	else
-		ret = rcar_du_encoders_init_dt(rcdu);
-
+	ret = rcar_du_encoders_init(rcdu);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 115eed20db12..80dc02166c88 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -27,7 +27,11 @@
 struct rcar_du_lvds_connector {
 	struct rcar_du_connector connector;
 
-	struct rcar_du_panel_data panel;
+	struct {
+		unsigned int width_mm;		/* Panel width in mm */
+		unsigned int height_mm;		/* Panel height in mm */
+		struct videomode mode;
+	} panel;
 };
 
 #define to_rcar_lvds_connector(c) \
@@ -78,31 +82,25 @@ static const struct drm_connector_funcs connector_funcs = {
 
 int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
-				const struct rcar_du_panel_data *panel,
 				/* TODO const */ struct device_node *np)
 {
 	struct rcar_du_lvds_connector *lvdscon;
 	struct drm_connector *connector;
+	struct display_timing timing;
 	int ret;
 
 	lvdscon = devm_kzalloc(rcdu->dev, sizeof(*lvdscon), GFP_KERNEL);
 	if (lvdscon = NULL)
 		return -ENOMEM;
 
-	if (panel) {
-		lvdscon->panel = *panel;
-	} else {
-		struct display_timing timing;
-
-		ret = of_get_display_timing(np, "panel-timing", &timing);
-		if (ret < 0)
-			return ret;
+	ret = of_get_display_timing(np, "panel-timing", &timing);
+	if (ret < 0)
+		return ret;
 
-		videomode_from_timing(&timing, &lvdscon->panel.mode);
+	videomode_from_timing(&timing, &lvdscon->panel.mode);
 
-		of_property_read_u32(np, "width-mm", &lvdscon->panel.width_mm);
-		of_property_read_u32(np, "height-mm", &lvdscon->panel.height_mm);
-	}
+	of_property_read_u32(np, "width-mm", &lvdscon->panel.width_mm);
+	of_property_read_u32(np, "height-mm", &lvdscon->panel.height_mm);
 
 	connector = &lvdscon->connector.connector;
 	connector->display_info.width_mm = lvdscon->panel.width_mm;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
index d11424d537f9..d4881ee0be7e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.h
@@ -16,11 +16,9 @@
 
 struct rcar_du_device;
 struct rcar_du_encoder;
-struct rcar_du_panel_data;
 
 int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
-				const struct rcar_du_panel_data *panel,
 				struct device_node *np);
 
 #endif /* __RCAR_DU_LVDSCON_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
index 3303a55cec79..f65aabda0796 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
@@ -16,7 +16,6 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/platform_data/rcar-du.h>
 
 struct rcar_drm_crtc;
 struct rcar_du_lvdsenc;
diff --git a/include/linux/platform_data/rcar-du.h b/include/linux/platform_data/rcar-du.h
deleted file mode 100644
index a5f045e1d8fe..000000000000
--- a/include/linux/platform_data/rcar-du.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * rcar_du.h  --  R-Car Display Unit DRM driver
- *
- * Copyright (C) 2013 Renesas Corporation
- *
- * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __RCAR_DU_H__
-#define __RCAR_DU_H__
-
-#include <video/videomode.h>
-
-enum rcar_du_output {
-	RCAR_DU_OUTPUT_DPAD0,
-	RCAR_DU_OUTPUT_DPAD1,
-	RCAR_DU_OUTPUT_LVDS0,
-	RCAR_DU_OUTPUT_LVDS1,
-	RCAR_DU_OUTPUT_TCON,
-	RCAR_DU_OUTPUT_MAX,
-};
-
-enum rcar_du_encoder_type {
-	RCAR_DU_ENCODER_UNUSED = 0,
-	RCAR_DU_ENCODER_NONE,
-	RCAR_DU_ENCODER_VGA,
-	RCAR_DU_ENCODER_LVDS,
-};
-
-struct rcar_du_panel_data {
-	unsigned int width_mm;		/* Panel width in mm */
-	unsigned int height_mm;		/* Panel height in mm */
-	struct videomode mode;
-};
-
-struct rcar_du_connector_lvds_data {
-	struct rcar_du_panel_data panel;
-};
-
-struct rcar_du_connector_vga_data {
-	/* TODO: Add DDC information for EDID retrieval */
-};
-
-/*
- * struct rcar_du_encoder_data - Encoder platform data
- * @type: the encoder type (RCAR_DU_ENCODER_*)
- * @output: the DU output the connector is connected to (RCAR_DU_OUTPUT_*)
- * @connector.lvds: platform data for LVDS connectors
- * @connector.vga: platform data for VGA connectors
- *
- * Encoder platform data describes an on-board encoder, its associated DU SoC
- * output, and the connector.
- */
-struct rcar_du_encoder_data {
-	enum rcar_du_encoder_type type;
-	enum rcar_du_output output;
-
-	union {
-		struct rcar_du_connector_lvds_data lvds;
-		struct rcar_du_connector_vga_data vga;
-	} connector;
-};
-
-struct rcar_du_platform_data {
-	struct rcar_du_encoder_data *encoders;
-	unsigned int num_encoders;
-};
-
-#endif /* __RCAR_DU_H__ */
-- 
2.0.4

