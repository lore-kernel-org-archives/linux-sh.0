From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:25 +0000
Subject: [PATCH 15/24] drm/rcar-du: Use dynamic number of CRTCs instead of CRTCs array size
Message-Id: <1372326574-4315-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The rcar_du_device structure contains a field that stores the number of
CRTCs, use it instead of the CRTCs array size. This prepares the driver
to support a variable number of CRTCs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5e4168d..fe61962 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -105,7 +105,7 @@ static void rcar_du_preclose(struct drm_device *dev, struct drm_file *file)
 	struct rcar_du_device *rcdu = dev->dev_private;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(rcdu->crtcs); ++i)
+	for (i = 0; i < rcdu->num_crtcs; ++i)
 		rcar_du_crtc_cancel_page_flip(&rcdu->crtcs[i], file);
 }
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index c32e0f9..845bcb3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -197,7 +197,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		if (pdata->type = RCAR_DU_ENCODER_UNUSED)
 			continue;
 
-		if (pdata->output >= ARRAY_SIZE(rcdu->crtcs)) {
+		if (pdata->output >= rcdu->num_crtcs) {
 			dev_warn(rcdu->dev,
 				 "encoder %u references unexisting output %u, skipping\n",
 				 i, pdata->output);
-- 
1.8.1.5

