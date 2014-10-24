From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 24 Oct 2014 12:58:10 +0000
Subject: [PATCH v2 4/9] drm: rcar-du: Replace drm_encoder with drm_slave_encoder
Message-Id: <1414155495-3979-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414155495-3979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414155495-3979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

DRM slave encoders require their associated struct drm_encoder instance
to be embedded in a struct drm_slave_encoder. This makes processing
encoders regardless of their types needlessly and painfully complex in
drivers that use a mix of slave encoders and custom encoders. Such a
driver will need to either create drm_slave_encoder instances that fake
their embedded encoder instance, or to turn all drm_encoder instances
into drm_slave_encoder instances.

Between the two evils, one must choose the lesser. Use drm_slave_encoder
everywhere.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
index c6334b4280d9..c4dccdbcff33 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -15,6 +15,7 @@
 #define __RCAR_DU_ENCODER_H__
 
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder_slave.h>
 
 struct rcar_du_device;
 struct rcar_du_lvdsenc;
@@ -27,15 +28,15 @@ enum rcar_du_encoder_type {
 };
 
 struct rcar_du_encoder {
-	struct drm_encoder encoder;
+	struct drm_encoder_slave slave;
 	enum rcar_du_output output;
 	struct rcar_du_lvdsenc *lvds;
 };
 
 #define to_rcar_encoder(e) \
-	container_of(e, struct rcar_du_encoder, encoder)
+	container_of(e, struct rcar_du_encoder, slave.base)
 
-#define rcar_encoder_to_drm_encoder(e)	(&(e)->encoder)
+#define rcar_encoder_to_drm_encoder(e)	(&(e)->slave.base)
 
 struct rcar_du_connector {
 	struct drm_connector connector;
-- 
2.0.4

