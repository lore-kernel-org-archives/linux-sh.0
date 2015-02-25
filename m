From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:34 +0000
Subject: [PATCH 14/38] drm: rcar-du: Define macros for the max number of groups, CRTCs and LVDS
Message-Id: <1424901298-6829-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Let's avoid magic constants. Beside increasing code readability, it will
also ensure that no location will be forgotten when raising the maximum
number of groups, CRTCs or LVDS encoders

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index c5b9ea6a7eaa..d1ede13cb1d5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -64,6 +64,10 @@ struct rcar_du_device_info {
 	unsigned int num_lvds;
 };
 
+#define RCAR_DU_MAX_CRTCS		3
+#define RCAR_DU_MAX_GROUPS		DIV_ROUND_UP(RCAR_DU_MAX_CRTCS, 2)
+#define RCAR_DU_MAX_LVDS		2
+
 struct rcar_du_device {
 	struct device *dev;
 	const struct rcar_du_device_info *info;
@@ -73,13 +77,13 @@ struct rcar_du_device {
 	struct drm_device *ddev;
 	struct drm_fbdev_cma *fbdev;
 
-	struct rcar_du_crtc crtcs[3];
+	struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
 
-	struct rcar_du_group groups[2];
+	struct rcar_du_group groups[RCAR_DU_MAX_GROUPS];
 
 	unsigned int dpad0_source;
-	struct rcar_du_lvdsenc *lvds[2];
+	struct rcar_du_lvdsenc *lvds[RCAR_DU_MAX_LVDS];
 };
 
 static inline bool rcar_du_has(struct rcar_du_device *rcdu,
-- 
2.0.5

