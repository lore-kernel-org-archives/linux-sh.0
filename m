From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:43 +0000
Subject: [WIP 5/7] drm/rcar-du: Add HDMI encoder and connector support
Message-Id: <1396439205-26199-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/Kconfig           |  11 ++-
 drivers/gpu/drm/rcar-du/Makefile          |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  30 +++++-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 118 ++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h |  31 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 157 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h |  34 +++++++
 include/linux/platform_data/rcar-du.h     |   5 +
 9 files changed, 383 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index d8e835a..691efe3 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -9,9 +9,16 @@ config DRM_RCAR_DU
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
 
+config DRM_RCAR_HDMI
+	bool "R-Car DU HDMI Encoder Support"
+	depends on DRM_RCAR_DU
+	depends on OF
+	help
+	  Enable support for external HDMI encoders.
+
 config DRM_RCAR_LVDS
 	bool "R-Car DU LVDS Encoder Support"
 	depends on DRM_RCAR_DU
 	help
-	  Enable support the R-Car Display Unit embedded LVDS encoders
-	  (currently only on R8A7790).
+	  Enable support for the R-Car Display Unit embedded LVDS encoders
+	  (currently only on R8A7790 and R8A7791).
diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/rcar-du/Makefile
index 12b8d44..05de1c4 100644
--- a/drivers/gpu/drm/rcar-du/Makefile
+++ b/drivers/gpu/drm/rcar-du/Makefile
@@ -7,6 +7,8 @@ rcar-du-drm-y := rcar_du_crtc.o \
 		 rcar_du_plane.o \
 		 rcar_du_vgacon.o
 
+rcar-du-drm-$(CONFIG_DRM_RCAR_HDMI)	+= rcar_du_hdmicon.o \
+					   rcar_du_hdmienc.o
 rcar-du-drm-$(CONFIG_DRM_RCAR_LVDS)	+= rcar_du_lvdsenc.o
 
 obj-$(CONFIG_DRM_RCAR_DU)		+= rcar-du-drm.o
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 0de9967..7da4dec 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -19,6 +19,8 @@
 
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
+#include "rcar_du_hdmicon.h"
+#include "rcar_du_hdmienc.h"
 #include "rcar_du_kms.h"
 #include "rcar_du_lvdscon.h"
 #include "rcar_du_lvdsenc.h"
@@ -176,6 +178,9 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	case RCAR_DU_ENCODER_LVDS:
 		encoder_type = DRM_MODE_ENCODER_LVDS;
 		break;
+	case RCAR_DU_ENCODER_HDMI:
+		encoder_type = DRM_MODE_ENCODER_TMDS;
+		break;
 	case RCAR_DU_ENCODER_NONE:
 	default:
 		/* No external encoder, use the internal encoder type. */
@@ -183,12 +188,24 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		break;
 	}
 
-	ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
-			       encoder_type);
-	if (ret < 0)
-		return ret;
+	if (type = RCAR_DU_ENCODER_HDMI) {
+		if (renc->lvds) {
+			dev_err(rcdu->dev,
+				"Chaining LVDS and HDMI encoders not supported\n");
+			return -EINVAL;
+		}
 
-	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+		ret = rcar_du_hdmienc_init(rcdu, renc, data->of_path);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
+				       encoder_type);
+		if (ret < 0)
+			return ret;
+
+		drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+	}
 
 	switch (encoder_type) {
 	case DRM_MODE_ENCODER_LVDS:
@@ -198,6 +215,9 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	case DRM_MODE_ENCODER_DAC:
 		return rcar_du_vga_connector_init(rcdu, renc);
 
+	case DRM_MODE_ENCODER_TMDS:
+		return rcar_du_hdmi_connector_init(rcdu, renc);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index a008498..008b7a2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -20,11 +20,13 @@
 #include <drm/drm_encoder_slave.h>
 
 struct rcar_du_device;
+struct rcar_du_hdmienc;
 struct rcar_du_lvdsenc;
 
 struct rcar_du_encoder {
 	struct drm_encoder_slave slave;
 	enum rcar_du_output output;
+	struct rcar_du_hdmienc *hdmi;
 	struct rcar_du_lvdsenc *lvds;
 };
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
new file mode 100644
index 0000000..aa96cd0
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -0,0 +1,118 @@
+/*
+ * R-Car Display Unit HDMI Connector
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+
+#include "rcar_du_drv.h"
+#include "rcar_du_encoder.h"
+#include "rcar_du_hdmicon.h"
+#include "rcar_du_kms.h"
+
+#define to_slave_funcs(e)	(to_rcar_encoder(e)->slave.slave_funcs)
+
+static int rcar_du_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_encoder *encoder = connector->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (sfuncs->get_modes = NULL)
+		return 0;
+
+	return sfuncs->get_modes(encoder, connector);
+}
+
+static int rcar_du_hdmi_connector_mode_valid(struct drm_connector *connector,
+					     struct drm_display_mode *mode)
+{
+	struct drm_encoder *encoder = connector->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (sfuncs->mode_valid = NULL)
+		return MODE_OK;
+
+	return sfuncs->mode_valid(encoder, mode);
+}
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = rcar_du_hdmi_connector_get_modes,
+	.mode_valid = rcar_du_hdmi_connector_mode_valid,
+	.best_encoder = rcar_du_connector_best_encoder,
+};
+
+static void rcar_du_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_sysfs_connector_remove(connector);
+	drm_connector_cleanup(connector);
+}
+
+static enum drm_connector_status
+rcar_du_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct drm_encoder *encoder = connector->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (sfuncs->detect = NULL)
+		return connector_status_unknown;
+
+	return sfuncs->detect(encoder, connector);
+}
+
+static const struct drm_connector_funcs connector_funcs = {
+	.dpms = drm_helper_connector_dpms,
+	.detect = rcar_du_hdmi_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = rcar_du_hdmi_connector_destroy,
+};
+
+int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
+				struct rcar_du_encoder *renc)
+{
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
+	struct rcar_du_connector *rcon;
+	struct drm_connector *connector;
+	int ret;
+
+	rcon = devm_kzalloc(rcdu->dev, sizeof(*rcon), GFP_KERNEL);
+	if (rcon = NULL)
+		return -ENOMEM;
+
+	connector = &rcon->connector;
+	connector->display_info.width_mm = 0;
+	connector->display_info.height_mm = 0;
+
+	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
+				 DRM_MODE_CONNECTOR_HDMIA);
+	if (ret < 0)
+		return ret;
+
+	drm_connector_helper_add(connector, &connector_helper_funcs);
+	ret = drm_sysfs_connector_add(connector);
+	if (ret < 0)
+		return ret;
+
+	drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
+	drm_object_property_set_value(&connector->base,
+		rcdu->ddev->mode_config.dpms_property, DRM_MODE_DPMS_OFF);
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret < 0)
+		return ret;
+
+	connector->encoder = encoder;
+	rcon->encoder = renc;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
new file mode 100644
index 0000000..87daa94
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
@@ -0,0 +1,31 @@
+/*
+ * R-Car Display Unit HDMI Connector
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __RCAR_DU_HDMICON_H__
+#define __RCAR_DU_HDMICON_H__
+
+struct rcar_du_device;
+struct rcar_du_encoder;
+
+#if IS_ENABLED(CONFIG_DRM_RCAR_HDMI)
+int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
+				struct rcar_du_encoder *renc);
+#else
+static inline int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
+					      struct rcar_du_encoder *renc)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif /* __RCAR_DU_HDMICON_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
new file mode 100644
index 0000000..7050d74
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -0,0 +1,157 @@
+/*
+ * R-Car Display Unit HDMI Encoder
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
+
+#include "rcar_du_drv.h"
+#include "rcar_du_encoder.h"
+#include "rcar_du_hdmienc.h"
+
+struct rcar_du_hdmienc {
+	struct rcar_du_encoder *renc;
+	struct device *dev;
+	int dpms;
+};
+
+#define to_rcar_hdmienc(e)	(to_rcar_encoder(e)->hdmi)
+#define to_slave_funcs(e)	(to_rcar_encoder(e)->slave.slave_funcs)
+
+static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (hdmienc->dpms = mode)
+		return;
+
+	if (sfuncs->dpms)
+		sfuncs->dpms(encoder, mode);
+
+	hdmienc->dpms = mode;
+}
+
+static bool rcar_du_hdmienc_mode_fixup(struct drm_encoder *encoder,
+				       const struct drm_display_mode *mode,
+				       struct drm_display_mode *adjusted_mode)
+{
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (sfuncs->mode_fixup = NULL)
+		return true;
+
+	return sfuncs->mode_fixup(encoder, mode, adjusted_mode);
+}
+
+static void rcar_du_hdmienc_mode_prepare(struct drm_encoder *encoder)
+{
+	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_OFF);
+}
+
+static void rcar_du_hdmienc_mode_commit(struct drm_encoder *encoder)
+{
+	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_ON);
+}
+
+static void rcar_du_hdmienc_mode_set(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adjusted_mode)
+{
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
+	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
+
+	if (sfuncs->mode_set)
+		sfuncs->mode_set(encoder, mode, adjusted_mode);
+
+	rcar_du_crtc_route_output(encoder->crtc, hdmienc->renc->output);
+}
+
+static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
+	.dpms = rcar_du_hdmienc_dpms,
+	.mode_fixup = rcar_du_hdmienc_mode_fixup,
+	.prepare = rcar_du_hdmienc_mode_prepare,
+	.commit = rcar_du_hdmienc_mode_commit,
+	.mode_set = rcar_du_hdmienc_mode_set,
+};
+
+static void rcar_du_hdmienc_cleanup(struct drm_encoder *encoder)
+{
+	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
+
+	rcar_du_hdmienc_dpms(encoder, DRM_MODE_DPMS_OFF);
+
+	drm_encoder_cleanup(encoder);
+	put_device(hdmienc->dev);
+}
+
+static const struct drm_encoder_funcs encoder_funcs = {
+	.destroy = rcar_du_hdmienc_cleanup,
+};
+
+int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
+			 struct rcar_du_encoder *renc, const char *of_path)
+{
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
+	struct drm_i2c_encoder_driver *driver;
+	struct i2c_client *i2c_slave;
+	struct rcar_du_hdmienc *hdmienc;
+	struct device_node *node;
+	int ret;
+
+	hdmienc = devm_kzalloc(rcdu->dev, sizeof(*hdmienc), GFP_KERNEL);
+	if (hdmienc = NULL)
+		return -ENOMEM;
+
+	/* Locate the slave I2C device and driver. */
+	node = of_find_node_by_path(of_path);
+	if (node = NULL)
+		return -EINVAL;
+
+	i2c_slave = of_find_i2c_device_by_node(node);
+	of_node_put(node);
+	if (i2c_slave = NULL)
+		return -EPROBE_DEFER;
+
+	hdmienc->dev = &i2c_slave->dev;
+
+	if (hdmienc->dev->driver = NULL) {
+		ret = -EPROBE_DEFER;
+		goto error;
+	}
+
+	/* Initialize the slave encoder. */
+	driver = to_drm_i2c_encoder_driver(to_i2c_driver(hdmienc->dev->driver));
+	ret = driver->encoder_init(i2c_slave, rcdu->ddev, &renc->slave);
+	if (ret < 0)
+		goto error;
+
+	ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS);
+	if (ret < 0)
+		goto error;
+
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
+
+	renc->hdmi = hdmienc;
+	hdmienc->renc = renc;
+
+	return 0;
+
+error:
+	put_device(hdmienc->dev);
+	return ret;
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
new file mode 100644
index 0000000..bcd25cc
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
@@ -0,0 +1,34 @@
+/*
+ * R-Car Display Unit HDMI Encoder
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __RCAR_DU_HDMIENC_H__
+#define __RCAR_DU_HDMIENC_H__
+
+#include <linux/module.h>
+
+struct rcar_du_device;
+struct rcar_du_encoder;
+
+#if IS_ENABLED(CONFIG_DRM_RCAR_HDMI)
+int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
+			 struct rcar_du_encoder *renc, const char *of_path);
+#else
+static inline int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
+				       struct rcar_du_encoder *renc,
+				       const char *of_path)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif /* __RCAR_DU_HDMIENC_H__ */
diff --git a/include/linux/platform_data/rcar-du.h b/include/linux/platform_data/rcar-du.h
index 1a2e990..5cf3261 100644
--- a/include/linux/platform_data/rcar-du.h
+++ b/include/linux/platform_data/rcar-du.h
@@ -14,6 +14,8 @@
 #ifndef __RCAR_DU_H__
 #define __RCAR_DU_H__
 
+#include <linux/i2c.h>
+
 #include <drm/drm_mode.h>
 
 enum rcar_du_output {
@@ -30,6 +32,7 @@ enum rcar_du_encoder_type {
 	RCAR_DU_ENCODER_NONE,
 	RCAR_DU_ENCODER_VGA,
 	RCAR_DU_ENCODER_LVDS,
+	RCAR_DU_ENCODER_HDMI,
 };
 
 struct rcar_du_panel_data {
@@ -60,6 +63,8 @@ struct rcar_du_encoder_data {
 	enum rcar_du_encoder_type type;
 	enum rcar_du_output output;
 
+	const char *of_path;
+
 	union {
 		struct rcar_du_connector_lvds_data lvds;
 		struct rcar_du_connector_vga_data vga;
-- 
1.8.3.2

