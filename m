From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:27 +0000
Subject: [PATCH 07/38] drm: rcar-du: Don't disable unused functions at init time
Message-Id: <1424901298-6829-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

All encoders and CRTCs start disabled, re-disabling them is a no-op.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index cc9136e8ee9c..1ea2c1e9cb79 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -448,8 +448,6 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	drm_kms_helper_poll_init(dev);
 
-	drm_helper_disable_unused_functions(dev);
-
 	fbdev = drm_fbdev_cma_init(dev, 32, dev->mode_config.num_crtc,
 				   dev->mode_config.num_connector);
 	if (IS_ERR(fbdev))
-- 
2.0.5

