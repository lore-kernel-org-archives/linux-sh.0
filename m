From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:03 +0000
Subject: [PATCH 16/22] drm: rcar-du: Output the DISP signal on the DISP pin
Message-Id: <1442184669-30990-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DE signal is currently configured to be identical to the DISP
signal and is used for the same purpose. To make it clearer that the
DISP pin outputs the DISP signal, select it explicitly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 9f0d94b3ec10..15bf57de106b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -151,7 +151,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	/* Signal polarities */
 	value = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : DSMR_VSL)
 	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : DSMR_HSL)
-	      | DSMR_DIPM_DE | DSMR_CSPM;
+	      | DSMR_DIPM_DISP | DSMR_CSPM;
 	rcar_du_crtc_write(rcrtc, DSMR, value);
 
 	/* Display timings */
-- 
2.4.6

