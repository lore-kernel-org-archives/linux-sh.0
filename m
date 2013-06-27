From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:16 +0000
Subject: [PATCH 06/24] drm/rcar-du: Fix buffer pitch alignment
Message-Id: <1372326574-4315-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DU requires a 16 pixels pitch alignement. Make sure dumb buffers are
allocated with the correct pitch, and validate the pitch when creating
frame buffers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/rcar-du/rcar_du_kms.h |  3 +++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 2a85056..bcda2e0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -200,7 +200,7 @@ static struct drm_driver rcar_du_driver = {
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_import	= drm_gem_cma_dmabuf_import,
 	.gem_prime_export	= drm_gem_cma_dmabuf_export,
-	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_create		= rcar_du_dumb_create,
 	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
 	.dumb_destroy		= drm_gem_cma_dumb_destroy,
 	.fops			= &rcar_du_fops,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 06cacf6..d30c2e2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -138,11 +138,25 @@ void rcar_du_encoder_mode_commit(struct drm_encoder *encoder)
  * Frame buffer
  */
 
+int rcar_du_dumb_create(struct drm_file *file, struct drm_device *dev,
+			struct drm_mode_create_dumb *args)
+{
+	unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	unsigned int align;
+
+	/* The pitch must be aligned to a 16 pixels boundary. */
+	align = 16 * args->bpp / 8;
+	args->pitch = roundup(max(args->pitch, min_pitch), align);
+
+	return drm_gem_cma_dumb_create(file, dev, args);
+}
+
 static struct drm_framebuffer *
 rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		  struct drm_mode_fb_cmd2 *mode_cmd)
 {
 	const struct rcar_du_format_info *format;
+	unsigned int align;
 
 	format = rcar_du_format_info(mode_cmd->pixel_format);
 	if (format = NULL) {
@@ -151,7 +165,10 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (mode_cmd->pitches[0] & 15 || mode_cmd->pitches[0] >= 8192) {
+	align = 16 * format->bpp / 8;
+
+	if (mode_cmd->pitches[0] & (align - 1) ||
+	    mode_cmd->pitches[0] >= 8192) {
 		dev_dbg(dev->dev, "invalid pitch value %u\n",
 			mode_cmd->pitches[0]);
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.h b/drivers/gpu/drm/rcar-du/rcar_du_kms.h
index e4d8db0..dba4722 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.h
@@ -56,4 +56,7 @@ void rcar_du_encoder_mode_commit(struct drm_encoder *encoder);
 
 int rcar_du_modeset_init(struct rcar_du_device *rcdu);
 
+int rcar_du_dumb_create(struct drm_file *file, struct drm_device *dev,
+			struct drm_mode_create_dumb *args);
+
 #endif /* __RCAR_DU_KMS_H__ */
-- 
1.8.1.5

