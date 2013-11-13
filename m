From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:52:11 +0000
Subject: [PATCH 1/5] drm/rcar-du: Don't cast crtc to rcrtc twice in the same function
Message-Id: <1384350735-4419-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384350735-4419-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Reuse the previously cast variable instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index a9d24e4..d2af2bc 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -413,7 +413,7 @@ static int rcar_du_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 	rcrtc->plane->src_x = x;
 	rcrtc->plane->src_y = y;
 
-	rcar_du_crtc_update_base(to_rcar_crtc(crtc));
+	rcar_du_crtc_update_base(rcrtc);
 
 	return 0;
 }
-- 
1.8.3.2

