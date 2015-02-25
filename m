From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:54 +0000
Subject: [PATCH 34/38] drm: rcar-du: Remove unneeded rcar_du_crtc plane field
Message-Id: <1424901298-6829-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The rcar_du_crtc plane field is only used to check for an error that
can't occur. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 7 ++-----
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 3f64707412e6..c70f73036056 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -353,9 +353,6 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	if (rcrtc->started)
 		return;
 
-	if (WARN_ON(rcrtc->plane->format = NULL))
-		return;
-
 	/* Set display off and background to black */
 	rcar_du_crtc_write(rcrtc, DOOR, DOOR_RGB(0, 0, 0));
 	rcar_du_crtc_write(rcrtc, BPOR, BPOR_RGB(0, 0, 0));
@@ -606,9 +603,9 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 	rcrtc->mmio_offset = mmio_offsets[index];
 	rcrtc->index = index;
 	rcrtc->enabled = false;
-	rcrtc->plane = &rgrp->planes.planes[index % 2];
 
-	ret = drm_crtc_init_with_planes(rcdu->ddev, crtc, &rcrtc->plane->plane,
+	ret = drm_crtc_init_with_planes(rcdu->ddev, crtc,
+					&rgrp->planes.planes[index % 2].plane,
 					NULL, &crtc_funcs);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 0a3dcca58fd7..5d9aa9b33769 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -21,7 +21,6 @@
 #include <drm/drm_crtc.h>
 
 struct rcar_du_group;
-struct rcar_du_plane;
 
 struct rcar_du_crtc {
 	struct drm_crtc crtc;
@@ -39,7 +38,6 @@ struct rcar_du_crtc {
 	bool enabled;
 
 	struct rcar_du_group *group;
-	struct rcar_du_plane *plane;
 };
 
 #define to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, crtc)
-- 
2.0.5

