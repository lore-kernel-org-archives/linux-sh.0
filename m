From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:04 +0000
Subject: [PATCH 07/16] drm/rcar-du: Use struct videomode in platform data
Message-Id: <1409157673-4154-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

In preparation for DT support where panel timings will be described by a
DRM-agnostic video mode, replace the struct drm_mode_modeinfo instance
in the panel platform data with a struct videomode.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 19 +++++++++----------
 arch/arm/mach-shmobile/board-koelsch.c           | 19 +++++++++----------
 arch/arm/mach-shmobile/board-lager-reference.c   | 19 +++++++++----------
 arch/arm/mach-shmobile/board-lager.c             | 19 +++++++++----------
 arch/arm/mach-shmobile/board-marzen.c            | 19 +++++++++----------
 drivers/gpu/drm/rcar-du/Kconfig                  |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c        | 15 +++------------
 include/linux/platform_data/rcar-du.h            |  4 ++--
 8 files changed, 51 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 9db5e67..46aa540 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -41,16 +41,15 @@ static struct rcar_du_encoder_data koelsch_du_encoders[] = {
 			.width_mm = 210,
 			.height_mm = 158,
 			.mode = {
-				.clock = 65000,
-				.hdisplay = 1024,
-				.hsync_start = 1048,
-				.hsync_end = 1184,
-				.htotal = 1344,
-				.vdisplay = 768,
-				.vsync_start = 771,
-				.vsync_end = 777,
-				.vtotal = 806,
-				.flags = 0,
+				.pixelclock = 65000000,
+				.hactive = 1024,
+				.hfront_porch = 20,
+				.hback_porch = 160,
+				.hsync_len = 136,
+				.vactive = 768,
+				.vfront_porch = 3,
+				.vback_porch = 29,
+				.vsync_len = 6,
 			},
 		},
 	},
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index b7d5bc7..ad10ddb 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -63,16 +63,15 @@ static struct rcar_du_encoder_data koelsch_du_encoders[] = {
 			.width_mm = 210,
 			.height_mm = 158,
 			.mode = {
-				.clock = 65000,
-				.hdisplay = 1024,
-				.hsync_start = 1048,
-				.hsync_end = 1184,
-				.htotal = 1344,
-				.vdisplay = 768,
-				.vsync_start = 771,
-				.vsync_end = 777,
-				.vtotal = 806,
-				.flags = 0,
+				.pixelclock = 65000000,
+				.hactive = 1024,
+				.hfront_porch = 20,
+				.hback_porch = 160,
+				.hsync_len = 136,
+				.vactive = 768,
+				.vfront_porch = 3,
+				.vback_porch = 29,
+				.vsync_len = 6,
 			},
 		},
 	},
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 2a05c02..bc4b483 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -43,16 +43,15 @@ static struct rcar_du_encoder_data lager_du_encoders[] = {
 			.width_mm = 210,
 			.height_mm = 158,
 			.mode = {
-				.clock = 65000,
-				.hdisplay = 1024,
-				.hsync_start = 1048,
-				.hsync_end = 1184,
-				.htotal = 1344,
-				.vdisplay = 768,
-				.vsync_start = 771,
-				.vsync_end = 777,
-				.vtotal = 806,
-				.flags = 0,
+				.pixelclock = 65000000,
+				.hactive = 1024,
+				.hfront_porch = 20,
+				.hback_porch = 160,
+				.hsync_len = 136,
+				.vactive = 768,
+				.vfront_porch = 3,
+				.vback_porch = 29,
+				.vsync_len = 6,
 			},
 		},
 	},
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index e1d8215..80576c2 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -99,16 +99,15 @@ static struct rcar_du_encoder_data lager_du_encoders[] = {
 			.width_mm = 210,
 			.height_mm = 158,
 			.mode = {
-				.clock = 65000,
-				.hdisplay = 1024,
-				.hsync_start = 1048,
-				.hsync_end = 1184,
-				.htotal = 1344,
-				.vdisplay = 768,
-				.vsync_start = 771,
-				.vsync_end = 777,
-				.vtotal = 806,
-				.flags = 0,
+				.pixelclock = 65000000,
+				.hactive = 1024,
+				.hfront_porch = 20,
+				.hback_porch = 160,
+				.hsync_len = 136,
+				.vactive = 768,
+				.vfront_porch = 3,
+				.vback_porch = 29,
+				.vsync_len = 6,
 			},
 		},
 	},
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index e5cf420..ce33d78 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -192,16 +192,15 @@ static struct rcar_du_encoder_data du_encoders[] = {
 			.width_mm = 210,
 			.height_mm = 158,
 			.mode = {
-				.clock = 65000,
-				.hdisplay = 1024,
-				.hsync_start = 1048,
-				.hsync_end = 1184,
-				.htotal = 1344,
-				.vdisplay = 768,
-				.vsync_start = 771,
-				.vsync_end = 777,
-				.vtotal = 806,
-				.flags = 0,
+				.pixelclock = 65000000,
+				.hactive = 1024,
+				.hfront_porch = 20,
+				.hback_porch = 160,
+				.hsync_len = 136,
+				.vactive = 768,
+				.vfront_porch = 3,
+				.vback_porch = 29,
+				.vsync_len = 6,
 			},
 		},
 	},
diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 2e3d7b5..c96f608 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -6,6 +6,7 @@ config DRM_RCAR_DU
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_FB_HELPER
+	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 21426bd..f2d92a0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -40,18 +40,9 @@ static int rcar_du_lvds_connector_get_modes(struct drm_connector *connector)
 		return 0;
 
 	mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
-	mode->clock = lvdscon->panel->mode.clock;
-	mode->hdisplay = lvdscon->panel->mode.hdisplay;
-	mode->hsync_start = lvdscon->panel->mode.hsync_start;
-	mode->hsync_end = lvdscon->panel->mode.hsync_end;
-	mode->htotal = lvdscon->panel->mode.htotal;
-	mode->vdisplay = lvdscon->panel->mode.vdisplay;
-	mode->vsync_start = lvdscon->panel->mode.vsync_start;
-	mode->vsync_end = lvdscon->panel->mode.vsync_end;
-	mode->vtotal = lvdscon->panel->mode.vtotal;
-	mode->flags = lvdscon->panel->mode.flags;
-
-	drm_mode_set_name(mode);
+
+	drm_display_mode_from_videomode(&lvdscon->panel->mode, mode);
+
 	drm_mode_probed_add(connector, mode);
 
 	return 1;
diff --git a/include/linux/platform_data/rcar-du.h b/include/linux/platform_data/rcar-du.h
index 1a2e990..a5f045e 100644
--- a/include/linux/platform_data/rcar-du.h
+++ b/include/linux/platform_data/rcar-du.h
@@ -14,7 +14,7 @@
 #ifndef __RCAR_DU_H__
 #define __RCAR_DU_H__
 
-#include <drm/drm_mode.h>
+#include <video/videomode.h>
 
 enum rcar_du_output {
 	RCAR_DU_OUTPUT_DPAD0,
@@ -35,7 +35,7 @@ enum rcar_du_encoder_type {
 struct rcar_du_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
-	struct drm_mode_modeinfo mode;
+	struct videomode mode;
 };
 
 struct rcar_du_connector_lvds_data {
-- 
1.8.5.5

