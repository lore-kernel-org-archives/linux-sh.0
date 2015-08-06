From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 06 Aug 2015 00:10:32 +0000
Subject: [PATCH] drm: rcar-du: Enable DU0 to DPAD connection on R8A7791
Message-Id: <1438819832-6110-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DPAD RGB output can be driven by both DU0 and DU1 on R8A7791. Mark
the DU0 connection as possible.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index a9c445f1ebff..44879136e933 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -93,7 +93,7 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 		 * (currently unsupported) TCON output.
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(1),
+			.possible_crtcs = BIT(1) | BIT(0),
 			.encoder_type = DRM_MODE_ENCODER_NONE,
 			.port = 0,
 		},
-- 
Regards,

Laurent Pinchart

