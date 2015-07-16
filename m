From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 16 Jul 2015 08:44:07 +0000
Subject: [PATCH] drm: rcar-du: Add dependency to OF
Message-Id: <1437036247-30168-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The driver requires OF support, add a dependency in Kconfig and remove
the platform_device_id table that isn't used anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/Kconfig       |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 11485a4a16ae..d4e0a39568f6 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -1,6 +1,6 @@
 config DRM_RCAR_DU
 	tristate "DRM Support for R-Car Display Unit"
-	depends on DRM && ARM && HAVE_DMA_ATTRS
+	depends on DRM && ARM && HAVE_DMA_ATTRS && OF
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index fb6709160a59..a9c445f1ebff 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -106,13 +106,6 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.num_lvds = 1,
 };
 
-static const struct platform_device_id rcar_du_id_table[] = {
-	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(platform, rcar_du_id_table);
-
 static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
 	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
@@ -165,8 +158,7 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 	init_waitqueue_head(&rcdu->commit.wait);
 
 	rcdu->dev = &pdev->dev;
-	rcdu->info = np ? of_match_device(rcar_du_of_table, rcdu->dev)->data
-		   : (void *)platform_get_device_id(pdev)->driver_data;
+	rcdu->info = of_match_device(rcar_du_of_table, rcdu->dev)->data;
 	rcdu->ddev = dev;
 	dev->dev_private = rcdu;
 
@@ -338,7 +330,6 @@ static struct platform_driver rcar_du_platform_driver = {
 		.pm	= &rcar_du_pm_ops,
 		.of_match_table = rcar_du_of_table,
 	},
-	.id_table	= rcar_du_id_table,
 };
 
 module_platform_driver(rcar_du_platform_driver);
-- 
Regards,

Laurent Pinchart

