From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:43 +0000
Subject: [RFC 09/10] drm: rcar-du: support for i2c HDMI encoders
Message-Id: <1377866264-21110-10-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enables use of i2c HDMI encoders with the rcar-du driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 drivers/gpu/drm/rcar-du/Makefile          |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c     |   7 ++
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  56 +++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h |   6 +-
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 165 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h |  28 +++++
 include/linux/platform_data/rcar-du.h     |   4 +
 8 files changed, 266 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h

diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/rcar-du/Makefile
index 12b8d44..1d7d4c5a 100644
--- a/drivers/gpu/drm/rcar-du/Makefile
+++ b/drivers/gpu/drm/rcar-du/Makefile
@@ -1,6 +1,7 @@
 rcar-du-drm-y := rcar_du_crtc.o \
 		 rcar_du_drv.o \
 		 rcar_du_encoder.o \
+		 rcar_du_hdmicon.o \
 		 rcar_du_group.o \
 		 rcar_du_kms.o \
 		 rcar_du_lvdscon.o \
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index e113352..81c7676 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -220,6 +220,13 @@ static const struct dev_pm_ops rcar_du_pm_ops = {
 
 static int rcar_du_probe(struct platform_device *pdev)
 {
+	struct rcar_du_platform_data *pdata = pdev->dev.platform_data;
+	int i;
+	for (i = 0; i < pdata->num_encoders; i++) {
+		if (pdata->encoders[i].slave && !*pdata->encoders[i].slave) {
+			return -EPROBE_DEFER;
+		}
+	}
 	return drm_platform_init(&rcar_du_driver, pdev);
 }
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 65d2d63..72d44de 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -76,6 +76,8 @@ struct rcar_du_device {
 
 	unsigned int dpad0_source;
 	struct rcar_du_lvdsenc *lvds[2];
+
+	struct i2c_client *encoder_slave;
 };
 
 static inline bool rcar_du_has(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 3daa7a1..16e0f87 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -16,9 +16,11 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder_slave.h>
 
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
+#include "rcar_du_hdmicon.h"
 #include "rcar_du_kms.h"
 #include "rcar_du_lvdscon.h"
 #include "rcar_du_lvdsenc.h"
@@ -44,10 +46,22 @@ static void rcar_du_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
-	if (renc->lvds)
+	if (encoder->encoder_type = DRM_MODE_ENCODER_TMDS)
+		rcar_du_hdmi_encoder_dpms(encoder, mode);
+	else if (renc->lvds)
 		rcar_du_lvdsenc_dpms(renc->lvds, encoder->crtc, mode);
 }
 
+static inline struct drm_encoder_slave_funcs *
+get_slave_funcs(struct drm_encoder *enc)
+{
+	if (!to_encoder_slave(enc))
+		return NULL;
+
+	return to_encoder_slave(enc)->slave_funcs;
+}
+                                
+
 static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 				       const struct drm_display_mode *mode,
 				       struct drm_display_mode *adjusted_mode)
@@ -62,6 +76,14 @@ static bool rcar_du_encoder_mode_fixup(struct drm_encoder *encoder,
 	if (encoder->encoder_type = DRM_MODE_ENCODER_DAC)
 		return true;
 
+	if (encoder->encoder_type = DRM_MODE_ENCODER_TMDS) {
+		struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+		if (sfuncs && sfuncs->mode_fixup)
+			return sfuncs->mode_fixup(encoder, mode, adjusted_mode);
+
+		return true;
+	}
+
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		if (connector->encoder = encoder) {
 			found = true;
@@ -124,6 +146,12 @@ static void rcar_du_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
+	if (encoder->encoder_type = DRM_MODE_ENCODER_TMDS) {
+		struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+		if (sfuncs && sfuncs->mode_set)
+			sfuncs->mode_set(encoder, mode, adjusted_mode);
+	}
+
 	rcar_du_crtc_route_output(encoder->crtc, renc->output);
 }
 
@@ -135,8 +163,20 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.mode_set = rcar_du_encoder_mode_set,
 };
 
+static void rcar_du_encoder_destroy(struct drm_encoder *encoder)
+{
+	if (encoder->encoder_type = DRM_MODE_ENCODER_TMDS) {
+		struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+		if (sfuncs && sfuncs->destroy)
+			sfuncs->destroy(encoder);
+	}
+
+	drm_encoder_cleanup(encoder);
+}
+
 static const struct drm_encoder_funcs encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
+	.destroy = rcar_du_encoder_destroy,
 };
 
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
@@ -147,6 +187,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	struct rcar_du_encoder *renc;
 	unsigned int encoder_type;
 	int ret;
+	struct drm_i2c_encoder_driver *encoder_drv;
 
 	renc = devm_kzalloc(rcdu->dev, sizeof(*renc), GFP_KERNEL);
 	if (renc = NULL)
@@ -174,6 +215,9 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	case RCAR_DU_ENCODER_LVDS:
 		encoder_type = DRM_MODE_ENCODER_LVDS;
 		break;
+	case RCAR_DU_ENCODER_HDMI:
+		encoder_type = DRM_MODE_ENCODER_TMDS;
+		break;
 	case RCAR_DU_ENCODER_NONE:
 	default:
 		/* No external encoder, use the internal encoder type. */
@@ -196,6 +240,14 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	case DRM_MODE_ENCODER_DAC:
 		return rcar_du_vga_connector_init(rcdu, renc);
 
+	case DRM_MODE_ENCODER_TMDS:
+		rcdu->encoder_slave = *data->slave;
+		if (rcdu->encoder_slave) {
+			encoder_drv = to_drm_i2c_encoder_driver(rcdu->encoder_slave->driver);
+			encoder_drv->encoder_init(rcdu->encoder_slave, rcdu->ddev, &renc->encoder_slave);
+		}
+		return rcar_du_hdmi_connector_init(rcdu, renc);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index 0e5a65e..066c45c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -17,12 +17,16 @@
 #include <linux/platform_data/rcar-du.h>
 
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder_slave.h>
 
 struct rcar_du_device;
 struct rcar_du_lvdsenc;
 
 struct rcar_du_encoder {
-	struct drm_encoder encoder;
+	union {
+		struct drm_encoder encoder;
+		struct drm_encoder_slave encoder_slave;
+	};
 	enum rcar_du_output output;
 	struct rcar_du_lvdsenc *lvds;
 };
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
new file mode 100644
index 0000000..ffe8098
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -0,0 +1,165 @@
+/*
+ * rcar_du_hdmicon.c  --  R-Car Display Unit HDMI DAC and Connector
+ *
+ * Copyright (C) 2013 Renesas Corporation
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
+#include "rcar_du_kms.h"
+#include "rcar_du_hdmicon.h"
+
+#include "../i2c/adv7511.h"
+
+/* -----------------------------------------------------------------------------
+ * Connector
+ */
+
+static inline struct drm_encoder_slave_funcs *
+get_slave_funcs(struct drm_encoder *enc)
+{
+	if (!to_encoder_slave(enc))
+		return NULL;
+
+	return to_encoder_slave(enc)->slave_funcs;
+}
+                                
+static int rcar_du_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	int count = 0;
+	struct drm_encoder *encoder = &to_rcar_connector(connector)->encoder->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+	
+	if (sfuncs && sfuncs->get_modes)
+		count += sfuncs->get_modes(encoder, connector);
+
+	return count;
+}
+
+static int rcar_du_hdmi_connector_mode_valid(struct drm_connector *connector,
+					    struct drm_display_mode *mode)
+{
+	/* XXX: applicable here? */
+	if (mode->clock > 165000)
+		return MODE_CLOCK_HIGH;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		return MODE_NO_INTERLACE;
+
+	return MODE_OK;
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
+	enum drm_connector_status status = connector_status_unknown;
+	struct drm_encoder *encoder = &to_rcar_connector(connector)->encoder->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+	if (sfuncs && sfuncs->detect)
+		status = sfuncs->detect(encoder, connector);
+
+	return status;
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
+	ret = drm_mode_connector_attach_encoder(connector, &renc->encoder);
+	if (ret < 0)
+		return ret;
+
+	connector->encoder = &renc->encoder;
+	rcon->encoder = renc;
+
+	return 0;
+}
+
+void rcar_du_hdmi_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+	struct adv7511_video_config config;
+	struct edid *edid;
+	
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		edid = adv7511_get_edid(encoder);
+		if (edid) {
+			config.hdmi_mode = drm_detect_hdmi_monitor(edid);
+			kfree(edid);
+		} else {
+			config.hdmi_mode = false;
+		}
+		
+		hdmi_avi_infoframe_init(&config.avi_infoframe);
+
+		config.avi_infoframe.scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
+
+		/* XXX: does the DU do anything else? */
+		config.csc_enable = false;
+		config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+		
+		sfuncs->set_config(encoder, &config);
+		break;
+	default:
+		break;
+	}
+	if (sfuncs && sfuncs->dpms)
+		sfuncs->dpms(encoder, mode);
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
new file mode 100644
index 0000000..4fee757
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
@@ -0,0 +1,28 @@
+/*
+ * rcar_du_hdmicon.h  --  R-Car Display Unit HDMI DAC and Connector
+ *
+ * Copyright (C) 2013 Renesas Corporation
+ *
+ * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __RCAR_DU_HDMI_H__
+#define __RCAR_DU_HDMI_H__
+
+struct rcar_du_device;
+struct rcar_du_encoder_hdmi_data;
+struct rcar_du_encoder;
+
+int rcar_du_hdmi_init(struct rcar_du_device *rcdu,
+		     const struct rcar_du_encoder_hdmi_data *data,
+		     unsigned int output);
+void rcar_du_hdmi_encoder_dpms(struct drm_encoder *encoder, int mode);
+int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
+				struct rcar_du_encoder *renc);
+
+#endif /* __RCAR_DU_HDMI_H__ */
diff --git a/include/linux/platform_data/rcar-du.h b/include/linux/platform_data/rcar-du.h
index 1a2e990..fc4a87c 100644
--- a/include/linux/platform_data/rcar-du.h
+++ b/include/linux/platform_data/rcar-du.h
@@ -30,6 +30,7 @@ enum rcar_du_encoder_type {
 	RCAR_DU_ENCODER_NONE,
 	RCAR_DU_ENCODER_VGA,
 	RCAR_DU_ENCODER_LVDS,
+	RCAR_DU_ENCODER_HDMI,
 };
 
 struct rcar_du_panel_data {
@@ -46,6 +47,8 @@ struct rcar_du_connector_vga_data {
 	/* TODO: Add DDC information for EDID retrieval */
 };
 
+struct i2c_client;
+
 /*
  * struct rcar_du_encoder_data - Encoder platform data
  * @type: the encoder type (RCAR_DU_ENCODER_*)
@@ -59,6 +62,7 @@ struct rcar_du_connector_vga_data {
 struct rcar_du_encoder_data {
 	enum rcar_du_encoder_type type;
 	enum rcar_du_output output;
+	struct i2c_client **slave;
 
 	union {
 		struct rcar_du_connector_lvds_data lvds;
-- 
1.8.1.4

