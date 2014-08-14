From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:25 +0000
Subject: [PATCH 4/7] ARM: shmobile: koelsch_defconfig: Enable missing hardware support
Message-Id: <1408035448-8811-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Based on the DTS

Notes:
  - MTD_SPI_NOR is a dependency for MTD_M25P80 since commit
    03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI
    nor framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4
    ("mtd: spi-nor: shorten Kconfig naming").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/koelsch_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 86faab565a96..b33d19b7f134 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,9 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_NR_CPUS=8
@@ -42,6 +45,8 @@ CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_EEPROM_AT24=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -66,9 +71,12 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH_MSIOF=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
@@ -76,7 +84,16 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_PLATFORM=y
+CONFIG_VIDEO_RCAR_VIN=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-- 
1.9.1

