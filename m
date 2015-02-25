From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:36 +0000
Subject: [PATCH 16/38] drm: rcar-du: Fix hardware plane allocation
Message-Id: <1424901298-6829-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The hardware plane allocator loops over all planes to find free
candidates. However, instead of looping over the number of hardware
planes, it loops over the number of software planes, which happens to be
larger by one unit. This has no effect in practise as the extra plane is
always cleared in the mask of free planes, but it should still be fixed
for correctness.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 242db1e1a1e4..4a0669fd8176 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -54,7 +54,7 @@ int rcar_du_plane_reserve(struct rcar_du_plane *plane,
 
 	mutex_lock(&rgrp->planes.lock);
 
-	for (i = 0; i < ARRAY_SIZE(rgrp->planes.planes); ++i) {
+	for (i = 0; i < RCAR_DU_NUM_HW_PLANES; ++i) {
 		if (!(rgrp->planes.free & (1 << i)))
 			continue;
 
@@ -63,7 +63,7 @@ int rcar_du_plane_reserve(struct rcar_du_plane *plane,
 			break;
 	}
 
-	if (i = ARRAY_SIZE(rgrp->planes.planes))
+	if (i = RCAR_DU_NUM_HW_PLANES)
 		goto done;
 
 	rgrp->planes.free &= ~(1 << i);
-- 
2.0.5

