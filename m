From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:27 +0000
Subject: [PATCH 17/24] drm/rcar-du: Move output routing configuration to group
Message-Id: <1372326574-4315-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Output routing is configured in group registers, move the corresponding
code from rcar_du_crtc.c to rcar_du_group.c.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 21 +--------------------
 drivers/gpu/drm/rcar-du/rcar_du_group.c | 19 +++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 7784a3b..6a2b959 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -130,25 +130,6 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	rcar_du_crtc_write(rcrtc, DEWR,  mode->hdisplay);
 }
 
-static void rcar_du_crtc_set_routing(struct rcar_du_crtc *rcrtc)
-{
-	struct rcar_du_device *rcdu = rcrtc->group->dev;
-	u32 dorcr = rcar_du_read(rcdu, DORCR);
-
-	dorcr &= ~(DORCR_PG2T | DORCR_DK2S | DORCR_PG2D_MASK);
-
-	/* Set the DU1 pins sources. Select CRTC 0 if explicitly requested and
-	 * CRTC 1 in all other cases to avoid cloning CRTC 0 to DU0 and DU1 by
-	 * default.
-	 */
-	if (rcrtc->outputs & (1 << 1) && rcrtc->index = 0)
-		dorcr |= DORCR_PG2D_DS1;
-	else
-		dorcr |= DORCR_PG2T | DORCR_DK2S | DORCR_PG2D_DS2;
-
-	rcar_du_write(rcdu, DORCR, dorcr);
-}
-
 void rcar_du_crtc_route_output(struct drm_crtc *crtc, unsigned int output)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
@@ -245,7 +226,7 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 
 	/* Configure display timings and output routing */
 	rcar_du_crtc_set_display_timing(rcrtc);
-	rcar_du_crtc_set_routing(rcrtc);
+	rcar_du_group_set_routing(rcrtc->group);
 
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcrtc->plane->enabled = true;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 625b9f4..7e75451 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -125,3 +125,22 @@ void rcar_du_group_restart(struct rcar_du_group *rgrp)
 	__rcar_du_group_start_stop(rgrp, false);
 	__rcar_du_group_start_stop(rgrp, true);
 }
+
+void rcar_du_group_set_routing(struct rcar_du_group *rgrp)
+{
+	struct rcar_du_crtc *crtc0 = &rgrp->dev->crtcs[rgrp->index * 2];
+	u32 dorcr = rcar_du_group_read(rgrp, DORCR);
+
+	dorcr &= ~(DORCR_PG2T | DORCR_DK2S | DORCR_PG2D_MASK);
+
+	/* Set the DU1 pins sources. Select CRTC 0 if explicitly requested and
+	 * CRTC 1 in all other cases to avoid cloning CRTC 0 to DU0 and DU1 by
+	 * default.
+	 */
+	if (crtc0->outputs & (1 << 1))
+		dorcr |= DORCR_PG2D_DS1;
+	else
+		dorcr |= DORCR_PG2T | DORCR_DK2S | DORCR_PG2D_DS2;
+
+	rcar_du_group_write(rgrp, DORCR, dorcr);
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 748331b..180c739 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -42,6 +42,6 @@ int rcar_du_group_get(struct rcar_du_group *rgrp);
 void rcar_du_group_put(struct rcar_du_group *rgrp);
 void rcar_du_group_start_stop(struct rcar_du_group *rgrp, bool start);
 void rcar_du_group_restart(struct rcar_du_group *rgrp);
-
+void rcar_du_group_set_routing(struct rcar_du_group *rgrp);
 
 #endif /* __RCAR_DU_GROUP_H__ */
-- 
1.8.1.5

