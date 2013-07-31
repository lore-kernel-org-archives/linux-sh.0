From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 31 Jul 2013 13:21:49 +0000
Subject: [PATCH v2 05/23] drm/rcar-du: Clarify comment regarding plane Y source coordinate
Message-Id: <1375276927-20181-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The R8A7790 DU documentation contains further information regarding the
plane Y source coordinate. Update the comment accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index a65f81d..38ebd20 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -103,9 +103,12 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	struct rcar_du_device *rcdu = plane->dev;
 	unsigned int index = plane->hwindex;
 
-	/* According to the datasheet the Y position is expressed in raster line
-	 * units. However, 32bpp formats seem to require a doubled Y position
-	 * value. Similarly, for the second plane, NV12 and NV21 formats seem to
+	/* The Y position is expressed in raster line units and must be doubled
+	 * for 32bpp formats, according to the R8A7790 datasheet. No mention of
+	 * doubling the Y position is found in the R8A7779 datasheet, but the
+	 * rule seems to apply there as well.
+	 *
+	 * Similarly, for the second plane, NV12 and NV21 formats seem to
 	 * require a halved Y position value.
 	 */
 	rcar_du_plane_write(rcdu, index, PnSPXR, plane->src_x);
-- 
1.8.1.5

