From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:42 +0000
Subject: [WIP 4/7] drm/rcar-du: Replace drm_encoder with drm_slave_encoder
Message-Id: <1396439205-26199-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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
index 4165a25..a008498 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.h
@@ -17,20 +17,21 @@
 #include <linux/platform_data/rcar-du.h>
 
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder_slave.h>
 
 struct rcar_du_device;
 struct rcar_du_lvdsenc;
 
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
1.8.3.2

