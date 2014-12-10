From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:03 +0000
Subject: [PATCH 03/15] drm: rcar-du: Configure pitch for chroma plane of multiplanar formats
Message-Id: <1418254935-13536-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The PnMWR register containing the plane stride must be programmed with
correct stride values for both the luma and chroma planes when using a
multiplanar format. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 72a7cb47bd9f..fb3ea4f95d4a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -130,6 +130,8 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	if (plane->format->planes = 2) {
 		index = (index + 1) % 8;
 
+		rcar_du_plane_write(rgrp, index, PnMWR, plane->pitch);
+
 		rcar_du_plane_write(rgrp, index, PnSPXR, plane->src_x);
 		rcar_du_plane_write(rgrp, index, PnSPYR, plane->src_y *
 				    (plane->format->bpp = 16 ? 2 : 1) / 2);
-- 
2.0.4

