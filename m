From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:08:34 +0000
Subject: [PATCH 02/02] ARM: shmobile: Drop DU LVDS deps to allow 64-bit build
Message-Id: <20150219010834.1660.21912.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow building the LVDS components of the DU driver on any architecture.
Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/gpu/drm/rcar-du/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0002/drivers/gpu/drm/rcar-du/Kconfig
+++ work/drivers/gpu/drm/rcar-du/Kconfig	2015-02-19 06:02:32.285532677 +0900
@@ -20,7 +20,6 @@ config DRM_RCAR_HDMI
 config DRM_RCAR_LVDS
 	bool "R-Car DU LVDS Encoder Support"
 	depends on DRM_RCAR_DU
-	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
 	help
 	  Enable support for the R-Car Display Unit embedded LVDS encoders
 	  (currently only on R8A7790 and R8A7791).
