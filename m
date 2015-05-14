From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 14 May 2015 12:34:01 +0000
Subject: [PATCH 1/2] drm: rcar-du: Print the error value when DRM/KMS init fails
Message-Id: <1431606842-15522-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

This helps debugging probe failures.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index da1216a73969..780ca11512ba 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -190,7 +190,7 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 	/* DRM/KMS objects */
 	ret = rcar_du_modeset_init(rcdu);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to initialize DRM/KMS\n");
+		dev_err(&pdev->dev, "failed to initialize DRM/KMS (%d)\n", ret);
 		goto done;
 	}
 
-- 
Regards,

Laurent Pinchart

