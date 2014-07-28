From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Jul 2014 18:18:36 +0000
Subject: [PATCH] drm/rcar-du: Fix maximum frame buffer pitch computation
Message-Id: <1406571516-5827-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

The maximum pitch constraint for the hardware is expressed in pixels.
Convert it to bytes to validate frame buffer creation, as frame buffer
pitches are expressed in bytes.

Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 3875854..7eabbd7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -135,7 +135,9 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 {
 	struct rcar_du_device *rcdu = dev->dev_private;
 	const struct rcar_du_format_info *format;
+	unsigned int max_pitch;
 	unsigned int align;
+	unsigned int bpp;
 
 	format = rcar_du_format_info(mode_cmd->pixel_format);
 	if (format = NULL) {
@@ -144,13 +146,20 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/*
+	 * The pitch and alignment constraints are expressed in pixels on the
+	 * hardware side and in bytes in the DRM API.
+	 */
+	bpp = format->planes = 2 ? 1 : format->bpp / 8;
+	max_pitch =  4096 * bpp;
+
 	if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
 		align = 128;
 	else
-		align = 16 * format->bpp / 8;
+		align = 16 * bpp;
 
 	if (mode_cmd->pitches[0] & (align - 1) ||
-	    mode_cmd->pitches[0] >= 8192) {
+	    mode_cmd->pitches[0] >= max_pitch) {
 		dev_dbg(dev->dev, "invalid pitch value %u\n",
 			mode_cmd->pitches[0]);
 		return ERR_PTR(-EINVAL);
-- 
Regards,

Laurent Pinchart

