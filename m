From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 15 Mar 2015 12:55:28 +0000
Subject: [PATCH 2/3] drm: rcar-du: Don't initialize event->pipe field
Message-Id: <1426424129-20746-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The field is set by drm_send_vblank_event(), there's no need to
preinitialize it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 9e72133bb64b..7d0b8ef9bea2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -486,8 +486,6 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc)
 	unsigned long flags;
 
 	if (event) {
-		event->pipe = rcrtc->index;
-
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
 		spin_lock_irqsave(&dev->event_lock, flags);
-- 
2.0.5

