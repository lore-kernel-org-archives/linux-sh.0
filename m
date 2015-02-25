From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:28 +0000
Subject: [PATCH 08/38] drm: rcar-du: Remove drm_fbdev_cma_restore_mode() call at init time
Message-Id: <1424901298-6829-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The function is meant to restore the fbdev mode in the lastclose
handler, not to be called at init time. Remove the call.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 1ea2c1e9cb79..aebbcde82ddf 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -453,10 +453,6 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	if (IS_ERR(fbdev))
 		return PTR_ERR(fbdev);
 
-#ifndef CONFIG_FRAMEBUFFER_CONSOLE
-	drm_fbdev_cma_restore_mode(fbdev);
-#endif
-
 	rcdu->fbdev = fbdev;
 
 	return 0;
-- 
2.0.5

