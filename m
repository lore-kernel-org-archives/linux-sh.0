From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:41 +0000
Subject: [WIP 3/7] drm/rcar-du: Replace direct DRM encoder access with cast macro
Message-Id: <1396439205-26199-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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
index 3daa7a1..0de9967 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -33,7 +33,7 @@ rcar_du_connector_best_encoder(struct drm_connector *connector)
 {
 	struct rcar_du_connector *rcon = to_rcar_connector(connector);
 
-	return &rcon->encoder->encoder;
+	return rcar_encoder_to_drm_encoder(rcon->encoder);
 }
 
 /* -----------------------------------------------------------------------------
@@ -145,6 +145,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 const struct rcar_du_encoder_data *data)
 {
 	struct rcar_du_encoder *renc;
+	struct drm_encoder *encoder;
 	unsigned int encoder_type;
 	int ret;
 
@@ -153,6 +154,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		return -ENOMEM;
 
 	renc->output = output;
+	encoder = rcar_encoder_to_drm_encoder(renc);
 
 	switch (output) {
 	case RCAR_DU_OUTPUT_LVDS0:
@@ -181,12 +183,12 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
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
index 0e5a65e..4165a25 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -30,6 +30,8 @@ struct rcar_du_encoder {
 #define to_rcar_encoder(e) \
 	container_of(e, struct rcar_du_encoder, encoder)
 
+#define rcar_encoder_to_drm_encoder(e)	(&(e)->encoder)
+
 struct rcar_du_connector {
 	struct drm_connector connector;
 	struct rcar_du_encoder *encoder;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 4f3ba93..017f97f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -92,6 +92,7 @@ int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 				struct rcar_du_encoder *renc,
 				const struct rcar_du_panel_data *panel)
 {
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
 	struct rcar_du_lvds_connector *lvdscon;
 	struct drm_connector *connector;
 	int ret;
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
index 72312f7..8ca44f2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
@@ -59,6 +59,7 @@ static const struct drm_connector_funcs connector_funcs = {
 int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
 			       struct rcar_du_encoder *renc)
 {
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
 	struct rcar_du_connector *rcon;
 	struct drm_connector *connector;
 	int ret;
@@ -85,11 +86,11 @@ int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
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
1.8.3.2

