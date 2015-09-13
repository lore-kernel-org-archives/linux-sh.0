From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:50:51 +0000
Subject: [PATCH 04/22] drm: rcar-du: Compute plane DDCR4 register value directly
Message-Id: <1442184669-30990-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

There's no need for a read-modify-write pattern, all register bits can
be set explicitly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index ffa583712cd9..b20f3ceb55e6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -28,13 +28,6 @@
 #define RCAR_DU_COLORKEY_SOURCE		(1 << 24)
 #define RCAR_DU_COLORKEY_MASK		(1 << 24)
 
-static u32 rcar_du_plane_read(struct rcar_du_group *rgrp,
-			      unsigned int index, u32 reg)
-{
-	return rcar_du_read(rgrp->dev,
-			    rgrp->mmio_offset + index * PLANE_OFF + reg);
-}
-
 static void rcar_du_plane_write(struct rcar_du_group *rgrp,
 				unsigned int index, u32 reg, u32 data)
 {
@@ -182,9 +175,6 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	 * The data format is selected by the DDDF field in PnMR and the EDF
 	 * field in DDCR4.
 	 */
-	ddcr4 = rcar_du_plane_read(rgrp, index, PnDDCR4);
-	ddcr4 &= ~PnDDCR4_EDF_MASK;
-	ddcr4 |= state->format->edf | PnDDCR4_CODE;
 
 	rcar_du_plane_setup_mode(plane, index);
 
@@ -204,6 +194,9 @@ static void __rcar_du_plane_setup(struct rcar_du_plane *plane,
 	}
 
 	rcar_du_plane_write(rgrp, index, PnDDCR2, ddcr2);
+
+	ddcr4 = state->format->edf | PnDDCR4_CODE;
+
 	rcar_du_plane_write(rgrp, index, PnDDCR4, ddcr4);
 
 	/* Destination position and size */
-- 
2.4.6

