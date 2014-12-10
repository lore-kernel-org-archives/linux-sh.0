From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:02 +0000
Subject: [PATCH 02/15] drm: rcar-du: Don't fail probe in case of partial encoder init error
Message-Id: <1418254935-13536-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

If an encoder fails to initialize the device can still be used without
the failed encoder. Don't propagate the error out of the probe function
but just skip the failed encoder.

As a special case a deferred probe request from the encoder is still
propagated out of the probe function in order not to break the deferred
probing mechanism.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 28 +++++++++++++++++++++-------
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     | 15 +++++++++++++--
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 34a122a39664..7c74ecf2ca67 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -193,32 +193,46 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		if (renc->lvds) {
 			dev_err(rcdu->dev,
 				"Chaining LVDS and HDMI encoders not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto done;
 		}
 
 		ret = rcar_du_hdmienc_init(rcdu, renc, enc_node);
 		if (ret < 0)
-			return ret;
+			goto done;
 	} else {
 		ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
 				       encoder_type);
 		if (ret < 0)
-			return ret;
+			goto done;
 
 		drm_encoder_helper_add(encoder, &encoder_helper_funcs);
 	}
 
 	switch (encoder_type) {
 	case DRM_MODE_ENCODER_LVDS:
-		return rcar_du_lvds_connector_init(rcdu, renc, con_node);
+		ret = rcar_du_lvds_connector_init(rcdu, renc, con_node);
+		break;
 
 	case DRM_MODE_ENCODER_DAC:
-		return rcar_du_vga_connector_init(rcdu, renc);
+		ret = rcar_du_vga_connector_init(rcdu, renc);
+		break;
 
 	case DRM_MODE_ENCODER_TMDS:
-		return rcar_du_hdmi_connector_init(rcdu, renc);
+		ret = rcar_du_hdmi_connector_init(rcdu, renc);
+		break;
 
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
+
+done:
+	if (ret < 0) {
+		if (encoder->name)
+			encoder->funcs->destroy(encoder);
+		devm_kfree(rcdu->dev, renc);
+	}
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 0c5ee616b5a3..cc9136e8ee9c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -346,8 +346,14 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 		/* Process the output pipeline. */
 		ret = rcar_du_encoders_init_one(rcdu, output, &ep);
 		if (ret < 0) {
-			of_node_put(ep_node);
-			return ret;
+			if (ret = -EPROBE_DEFER) {
+				of_node_put(ep_node);
+				return ret;
+			}
+
+			dev_info(rcdu->dev,
+				 "encoder initialization failed, skipping\n");
+			continue;
 		}
 
 		num_encoders += ret;
@@ -413,6 +419,11 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	if (ret < 0)
 		return ret;
 
+	if (ret = 0) {
+		dev_err(rcdu->dev, "error: no encoder could be initialized\n");
+		return -EINVAL;
+	}
+
 	num_encoders = ret;
 
 	/* Set the possible CRTCs and possible clones. There's always at least
-- 
2.0.4

