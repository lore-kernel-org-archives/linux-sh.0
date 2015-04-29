From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:38:04 +0000
Subject: [PATCH 10/10] drm: rcar-du: Split planes pre-association 4/4 between CRTCs
Message-Id: <1430267884-20560-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

If we have more than one CRTCs in a group pre-associate planes 0-3 with
CRTC 0 and planes 4-7 with CRTC 1 to minimize flicker occurring when the
association is changed. The pre-association could be controlled by a
module parameter if needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 3 ---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c  | 7 ++++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 620a2c51185c..e6a32c4e4040 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -257,9 +257,6 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
 	 * resulting in visible flicker. To mitigate the issue only update the
 	 * association if needed by enabled planes. Planes being disabled will
 	 * keep their current association.
-	 *
-	 * To mitigate the issue further we could pre-associate planes with
-	 * CRTCs, either with a fixed 4/4 split, or through a module parameter.
 	 */
 	mutex_lock(&rcrtc->group->lock);
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index fec5f4d794da..20859aae882e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -765,10 +765,11 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		rgrp->index = i;
 		rgrp->num_crtcs = min(rcdu->num_crtcs - 2 * i, 2U);
 
-		/* Pre-associate all hardware planes with the first CRTC in the
-		 * group.
+		/* If we have more than one CRTCs in this group pre-associate
+		 * planes 0-3 with CRTC 0 and planes 4-7 with CRTC 1 to minimize
+		 * flicker occurring when the association is changed.
 		 */
-		rgrp->dptsr_planes = 0;
+		rgrp->dptsr_planes = rgrp->num_crtcs > 1 ? 0xf0 : 0;
 
 		ret = rcar_du_planes_init(rgrp);
 		if (ret < 0)
-- 
2.0.5

