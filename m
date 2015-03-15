From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 15 Mar 2015 12:55:29 +0000
Subject: [PATCH 3/3] drm: rcar-du: Enable the atomic updates API
Message-Id: <1426424129-20746-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426424129-20746-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Set the DRIVER_ATOMIC flag to enable usage of the atomic updates API
with the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 1d9e4f8568ae..da1216a73969 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -252,7 +252,8 @@ static const struct file_operations rcar_du_fops = {
 };
 
 static struct drm_driver rcar_du_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME,
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME
+				| DRIVER_ATOMIC,
 	.load			= rcar_du_load,
 	.unload			= rcar_du_unload,
 	.preclose		= rcar_du_preclose,
-- 
2.0.5

