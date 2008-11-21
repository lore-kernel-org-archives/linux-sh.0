From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 21 Nov 2008 05:35:29 +0000
Subject: [PATCH] sh: sh7760fb: Add support SH7720/SH7721 of Renesas
Message-Id: <492648A1.2090000@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux-sh <linux-sh@vger.kernel.org>

SH7720 and 7721 has IP of Frame Buffer same as SH7760.
This driver can support these.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/video/Kconfig |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3f3ce13..f416d3d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2021,17 +2021,19 @@ config FB_COBALT
 	depends on FB && MIPS_COBALT

 config FB_SH7760
-       bool "SH7760/SH7763 LCDC support"
-       depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763)
-       select FB_CFB_FILLRECT
-       select FB_CFB_COPYAREA
-       select FB_CFB_IMAGEBLIT
-       help
-         Support for the SH7760/SH7763 integrated (D)STN/TFT LCD Controller.
-         Supports display resolutions up to 1024x1024 pixel, grayscale and
-         color operation, with depths ranging from 1 bpp to 8 bpp monochrome
-         and 8, 15 or 16 bpp color; 90 degrees clockwise display rotation for
-         panels <= 320 pixel horizontal resolution.
+	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Support for the SH7760/SH7763/SH7720/SH7721 integrated
+	  (D)STN/TFT LCD Controller.
+	  Supports display resolutions up to 1024x1024 pixel, grayscale and
+	  color operation, with depths ranging from 1 bpp to 8 bpp monochrome
+	  and 8, 15 or 16 bpp color; 90 degrees clockwise display rotation for
+	  panels <= 320 pixel horizontal resolution.

 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
-- 
1.5.6.5

