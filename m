From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 15:24:22 +0000
Subject: [PATCH v3 3/9] drm: rcar-du: Replace direct DRM encoder access with cast macro
Message-Id: <1414337068-28664-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Add a new macro to downcast an rcar_du_encoder pointer to a drm_encoder
pointer and use it. This prepares for the replacement of the
rcar_drm_encoder encoder field with a drm_slave_encoder.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 8 +++++---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c | 5 +++--
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index c699100a1359..e88e63b06b09 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -33,7 +33,7 @@ rcar_du_connector_best_encoder(struct drm_connector *connector)
 {
 	struct rcar_du_connector *rcon = to_rcar_connector(connector);
 
-	return &rcon->encoder->encoder;
+	return rcar_encoder_to_drm_encoder(rcon->encoder);
 }
 
 /* -----------------------------------------------------------------------------
@@ -146,6 +146,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 struct device_node *con_node)
 {
 	struct rcar_du_encoder *renc;
+	struct drm_encoder *encoder;
 	unsigned int encoder_type;
 	int ret;
 
@@ -154,6 +155,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		return -ENOMEM;
 
 	renc->output = output;
+	encoder = rcar_encoder_to_drm_encoder(renc);
 
 	switch (output) {
 	case RCAR_DU_OUTPUT_LVDS0:
@@ -182,12 +184,12 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		break;
 	}
 
-	ret = drm_encoder_init(rcdu->ddev, &renc->encoder, &encoder_funcs,
+	ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
 			       encoder_type);
 	if (ret < 0)
 		return ret;
 
-	drm_encoder_helper_add(&renc->encoder, &encoder_helper_funcs);
+	drm_encoder_helper_add(encoder, &encoder_helper_funcs);
 
 	switch (encoder_type) {
 	case DRM_MODE_ENCODER_LVDS:
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index 4b906b90c204..c6334b4280d9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -35,6 +35,8 @@ struct rcar_du_encoder {
 #define to_rcar_encoder(e) \
 	container_of(e, struct rcar_du_encoder, encoder)
 
+#define rcar_encoder_to_drm_encoder(e)	(&(e)->encoder)
+
 struct rcar_du_connector {
 	struct drm_connector connector;
 	struct rcar_du_encoder *encoder;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 80dc02166c88..6d9811c052c4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -84,6 +84,7 @@ int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
 				/* TODO const */ struct device_node *np)
 {
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
 	struct rcar_du_lvds_connector *lvdscon;
 	struct drm_connector *connector;
 	struct display_timing timing;
@@ -120,11 +121,11 @@ int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 	drm_object_property_set_value(&connector->base,
 		rcdu->ddev->mode_config.dpms_property, DRM_MODE_DPMS_OFF);
 
-	ret = drm_mode_connector_attach_encoder(connector, &renc->encoder);
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
 	if (ret < 0)
 		return ret;
 
-	connector->encoder = &renc->encoder;
+	connector->encoder = encoder;
 	lvdscon->connector.encoder = renc;
 
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
index 564a723ede03..752747a5e920 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
@@ -52,6 +52,7 @@ static const struct drm_connector_funcs connector_funcs = {
 int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
 			       struct rcar_du_encoder *renc)
 {
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
 	struct rcar_du_connector *rcon;
 	struct drm_connector *connector;
 	int ret;
@@ -78,11 +79,11 @@ int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
 	drm_object_property_set_value(&connector->base,
 		rcdu->ddev->mode_config.dpms_property, DRM_MODE_DPMS_OFF);
 
-	ret = drm_mode_connector_attach_encoder(connector, &renc->encoder);
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
 	if (ret < 0)
 		return ret;
 
-	connector->encoder = &renc->encoder;
+	connector->encoder = encoder;
 	rcon->encoder = renc;
 
 	return 0;
-- 
2.0.4

