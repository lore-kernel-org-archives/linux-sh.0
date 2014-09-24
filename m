From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 20:04:25 +0000
Subject: [PATCH 05/12] drm: rcar-du: Pass the encoder DT node to rcar_du_encoder_init()
Message-Id: <1411589072-28609-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The encoder DT node will be needed to register an external HDMI encoder.
Pass it to the rcar_du_encoder_init() function to prepare for HDMI
support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 5 +++--
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h | 3 ++-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 89ed4a9..c699100 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -142,7 +142,8 @@ static const struct drm_encoder_funcs encoder_funcs = {
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 struct device_node *np)
+			 struct device_node *enc_node,
+			 struct device_node *con_node)
 {
 	struct rcar_du_encoder *renc;
 	unsigned int encoder_type;
@@ -190,7 +191,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 
 	switch (encoder_type) {
 	case DRM_MODE_ENCODER_LVDS:
-		return rcar_du_lvds_connector_init(rcdu, renc, np);
+		return rcar_du_lvds_connector_init(rcdu, renc, con_node);
 
 	case DRM_MODE_ENCODER_DAC:
 		return rcar_du_vga_connector_init(rcdu, renc);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index c37ed94..4b906b9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -49,6 +49,7 @@ rcar_du_connector_best_encoder(struct drm_connector *connector);
 int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 			 enum rcar_du_encoder_type type,
 			 enum rcar_du_output output,
-			 struct device_node *np);
+			 struct device_node *enc_node,
+			 struct device_node *con_node);
 
 #endif /* __RCAR_DU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 6575681..a798294 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -289,7 +289,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 		connector = entity;
 	}
 
-	ret = rcar_du_encoder_init(rcdu, enc_type, output, connector);
+	ret = rcar_du_encoder_init(rcdu, enc_type, output, encoder, connector);
 	of_node_put(encoder);
 	of_node_put(connector);
 
-- 
1.8.5.5

