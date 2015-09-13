From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:50:48 +0000
Subject: [PATCH 01/22] drm: rcar-du: Don't update planes on disabled CRTCs
Message-Id: <1442184669-30990-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

A disabled CRTC can't display planes, the driver shouldn't try to
configure it when updating planes. The DRM core will store the plane
state for us, and the plane will be configured appropriately the next
time the CRTC is enabled.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index ca12e8ca5552..20813582fbf1 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -456,7 +456,7 @@ static void rcar_du_atomic_complete(struct rcar_du_commit *commit)
 	/* Apply the atomic update. */
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
-	drm_atomic_helper_commit_planes(dev, old_state, false);
+	drm_atomic_helper_commit_planes(dev, old_state, true);
 
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
-- 
2.4.6

