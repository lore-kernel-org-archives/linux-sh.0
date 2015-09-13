From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:01 +0000
Subject: [PATCH 14/22] drm: rcar-du: Drop LVDS double dependency on OF
Message-Id: <1442184669-30990-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

LVDS support depends on DRM_RCAR_DU which already depends on OF. Drop
the explicit dependency.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 7c465ee7aec3..6c3e49e9e290 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -15,7 +15,6 @@ config DRM_RCAR_DU
 config DRM_RCAR_HDMI
 	bool "R-Car DU HDMI Encoder Support"
 	depends on DRM_RCAR_DU
-	depends on OF
 	help
 	  Enable support for external HDMI encoders.
 
-- 
2.4.6

