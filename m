From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Nov 2014 12:49:07 +0000
Subject: [PATCH] drm: rcar-du: Fix NULL encoder pointer dereference
Message-Id: <1417092547-28224-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

The DRM connector's encoder pointer is managed internally by the DRM
core and set to NULL when the DRM connector is disconnected from the
CRTC it was attached to. This results in a NULL pointer dereference in
the HDMI connector functions when trying to call the associated slave
encoder's operations.

Fix this by retrieving the slave encoder pointer from the R-Car
connector structure instead of the DRM connector structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
index 8abaaf258f45..4d7d4dd46d26 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -25,7 +25,8 @@
 
 static int rcar_du_hdmi_connector_get_modes(struct drm_connector *connector)
 {
-	struct drm_encoder *encoder = connector->encoder;
+	struct rcar_du_connector *con = to_rcar_connector(connector);
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(con->encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
 	if (sfuncs->get_modes = NULL)
@@ -37,7 +38,8 @@ static int rcar_du_hdmi_connector_get_modes(struct drm_connector *connector)
 static int rcar_du_hdmi_connector_mode_valid(struct drm_connector *connector,
 					     struct drm_display_mode *mode)
 {
-	struct drm_encoder *encoder = connector->encoder;
+	struct rcar_du_connector *con = to_rcar_connector(connector);
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(con->encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
 	if (sfuncs->mode_valid = NULL)
@@ -61,7 +63,8 @@ static void rcar_du_hdmi_connector_destroy(struct drm_connector *connector)
 static enum drm_connector_status
 rcar_du_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
-	struct drm_encoder *encoder = connector->encoder;
+	struct rcar_du_connector *con = to_rcar_connector(connector);
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(con->encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
 	if (sfuncs->detect = NULL)
-- 
Regards,

Laurent Pinchart

