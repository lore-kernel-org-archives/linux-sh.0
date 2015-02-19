From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:08:25 +0000
Subject: [PATCH 01/02] ARM: shmobile: Drop DU deps to allow 64-bit build
Message-Id: <20150219010825.1660.31402.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow building the DU driver on any architecture. Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/gpu/drm/rcar-du/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0001/drivers/gpu/drm/rcar-du/Kconfig
+++ work/drivers/gpu/drm/rcar-du/Kconfig	2015-02-19 05:59:44.585533280 +0900
@@ -1,7 +1,6 @@
 config DRM_RCAR_DU
 	tristate "DRM Support for R-Car Display Unit"
-	depends on DRM && ARM
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on DRM
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
