From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 22:51:00 +0000
Subject: [PATCH 13/22] drm: rcar-du: Enable compilation on ARM64
Message-Id: <1442184669-30990-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The R8A7795 SoC is ARM64-based and include a DU. Enable driver
compilation on ARM64.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 62650abc3120..7c465ee7aec3 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -1,6 +1,7 @@
 config DRM_RCAR_DU
 	tristate "DRM Support for R-Car Display Unit"
-	depends on DRM && ARM && HAVE_DMA_ATTRS && OF
+	depends on DRM && HAVE_DMA_ATTRS && OF
+	depends on ARM || ARM64
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-- 
2.4.6

