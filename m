From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:22 +0000
Subject: [PATCH 12/24] drm/rcar-du: Create rcar_du_planes structure
Message-Id: <1372326574-4315-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Move the plane-related fields of struct rcar_du_device to their own
structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   | 11 +----------
 drivers/gpu/drm/rcar-du/rcar_du_plane.h | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 7d2320f..0305c21 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -15,7 +15,6 @@
 #define __RCAR_DU_DRV_H__
 
 #include <linux/kernel.h>
-#include <linux/mutex.h>
 #include <linux/platform_data/rcar-du.h>
 
 #include "rcar_du_crtc.h"
@@ -49,15 +48,7 @@ struct rcar_du_device {
 	unsigned int used_crtcs;
 	unsigned int num_crtcs;
 
-	struct {
-		struct rcar_du_plane planes[RCAR_DU_NUM_SW_PLANES];
-		unsigned int free;
-		struct mutex lock;
-
-		struct drm_property *alpha;
-		struct drm_property *colorkey;
-		struct drm_property *zpos;
-	} planes;
+	struct rcar_du_planes planes;
 };
 
 static inline bool rcar_du_has(struct rcar_du_device *rcdu,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 5397dba..5c8488c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -14,8 +14,11 @@
 #ifndef __RCAR_DU_PLANE_H__
 #define __RCAR_DU_PLANE_H__
 
-struct drm_crtc;
-struct drm_framebuffer;
+#include <linux/mutex.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+
 struct rcar_du_device;
 struct rcar_du_format_info;
 
@@ -54,6 +57,16 @@ struct rcar_du_plane {
 	unsigned int dst_y;
 };
 
+struct rcar_du_planes {
+	struct rcar_du_plane planes[RCAR_DU_NUM_SW_PLANES];
+	unsigned int free;
+	struct mutex lock;
+
+	struct drm_property *alpha;
+	struct drm_property *colorkey;
+	struct drm_property *zpos;
+};
+
 int rcar_du_plane_init(struct rcar_du_device *rcdu);
 int rcar_du_plane_register(struct rcar_du_device *rcdu);
 void rcar_du_plane_setup(struct rcar_du_plane *plane);
-- 
1.8.1.5

