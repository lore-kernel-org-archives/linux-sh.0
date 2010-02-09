From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 09:56:21 +0000
Subject: [PATCH] ARM: mach-shmobile: driver kconfig update
Message-Id: <20100209095621.1458.15191.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the Kconfig entries for various
SuperH drivers to enable use on SH-Mobile G-series.

While at it, add a HAVE_CLK dependency for drivers
that use the clock framework.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to linux-next, depends on a flctl patch.

 drivers/i2c/busses/Kconfig     |    2 +-
 drivers/input/keyboard/Kconfig |    2 +-
 drivers/mfd/Kconfig            |    2 +-
 drivers/mmc/host/Kconfig       |    2 +-
 drivers/mtd/nand/Kconfig       |    2 +-
 drivers/spi/Kconfig            |    2 +-
 drivers/video/Kconfig          |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

--- 0001/drivers/i2c/busses/Kconfig
+++ work/drivers/i2c/busses/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -520,7 +520,7 @@ config I2C_SH7760
 
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
-	depends on SUPERH
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
--- 0001/drivers/input/keyboard/Kconfig
+++ work/drivers/input/keyboard/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -363,7 +363,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH
+	depends on SUPERH || ARCH_SHMOBILE
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
--- 0001/drivers/mfd/Kconfig
+++ work/drivers/mfd/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -47,7 +47,7 @@ config MFD_ASIC3
 
 config MFD_SH_MOBILE_SDHI
 	bool "Support for SuperH Mobile SDHI"
-	depends on SUPERH
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select MFD_CORE
 	 ---help---
 	  This driver supports the SDHI hardware block found in many
--- 0001/drivers/mmc/host/Kconfig
+++ work/drivers/mmc/host/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -368,7 +368,7 @@ config MMC_SDRICOH_CS
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3 || SUPERH
+	depends on MFD_TMIO || MFD_ASIC3 || SUPERH || ARCH_SHMOBILE
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
--- 0015/drivers/mtd/nand/Kconfig
+++ work/drivers/mtd/nand/Kconfig	2010-01-26 22:13:47.000000000 +0900
@@ -451,7 +451,7 @@ config MTD_NAND_NOMADIK
 
 config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
-	depends on MTD_NAND && SUPERH
+	depends on MTD_NAND && (SUPERH || ARCH_SHMOBILE)
 	help
 	  Several Renesas SuperH CPU has FLCTL. This option enables support
 	  for NAND Flash using FLCTL.
--- 0001/drivers/spi/Kconfig
+++ work/drivers/spi/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -246,7 +246,7 @@ config SPI_S3C64XX
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on SUPERH && HAVE_CLK
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH MSIOF blocks.
--- 0001/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2010-01-26 22:13:31.000000000 +0900
@@ -1867,7 +1867,7 @@ config FB_W100
 
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
-	depends on FB && SUPERH && HAVE_CLK
+	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
