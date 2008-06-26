From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 26 Jun 2008 05:44:22 +0000
Subject: [PATCH v2 3/4] video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver
Message-Id: <48632CB6.4060609@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

Makefile and Kconfig of driver for LCDC interface on SH7760 and SH7763 SoCs.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/video/Kconfig  |   13 +++++++++++++
 drivers/video/Makefile |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 002b61b..f79634d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1950,6 +1950,19 @@ config FB_AM200EPD
          This enables support for the Metronome display controller used on
          the E-Ink AM-200 EPD devkit.

+config FB_SH7760
+	bool "SH7760/SH7763 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Support for the SH7760/SH7763 integrated (D)STN/TFT LCD Controller.
+	  Supports display resolutions up to 1024x1024 pixel, grayscale and
+	  color operation, with depths ranging from 1 bpp to 8 bpp monochrome
+	  and 8, 15 or 16 bpp color; 90 degrees clockwise display rotation for
+	  panels <= 320 pixel horizontal resolution.
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 04bca35..0dcd740 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_FB_SM501)            += sm501fb.o
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
+obj-$(CONFIG_FB_SH7760)		  += sh7760fb.o

 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
-- 
1.5.5.1

