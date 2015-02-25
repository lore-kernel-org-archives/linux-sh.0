From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:33 +0000
Subject: [PATCH 13/38] drm: rcar-du: Disable fbdev emulation when no connector is present
Message-Id: <1424901298-6829-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

fbdev emulation requires at least one connector, and will fail to
initialize if no connector has been successfully instantiated. Disable
it in that case and print an informational message instead of failing
probe with a confusing fbdev emulation error message.

It could be argued that probe should fail when no connector is present,
but the DU could still be useful in that case with the to-be-implemented
memory write-back support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index aebbcde82ddf..888df404932e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -448,12 +448,17 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	drm_kms_helper_poll_init(dev);
 
-	fbdev = drm_fbdev_cma_init(dev, 32, dev->mode_config.num_crtc,
-				   dev->mode_config.num_connector);
-	if (IS_ERR(fbdev))
-		return PTR_ERR(fbdev);
+	if (dev->mode_config.num_connector) {
+		fbdev = drm_fbdev_cma_init(dev, 32, dev->mode_config.num_crtc,
+					   dev->mode_config.num_connector);
+		if (IS_ERR(fbdev))
+			return PTR_ERR(fbdev);
 
-	rcdu->fbdev = fbdev;
+		rcdu->fbdev = fbdev;
+	} else {
+		dev_info(rcdu->dev,
+			 "no connector found, disabling fbdev emulation\n");
+	}
 
 	return 0;
 }
-- 
2.0.5

