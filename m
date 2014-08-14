From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:27 +0000
Subject: [PATCH 6/7] ARM: shmobile: lager_defconfig: Enable missing hardware support
Message-Id: <1408035448-8811-7-git-send-email-geert+renesas@glider.be>
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
 arch/arm/configs/lager_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 58702440472a..929c571ea29b 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -22,6 +22,9 @@ CONFIG_ARM_ERRATA_458693=y
 CONFIG_ARM_ERRATA_460075=y
 CONFIG_ARM_ERRATA_743622=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
@@ -53,6 +56,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
@@ -85,11 +89,12 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH_MSIOF=y
 CONFIG_GPIO_SH_PFC=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
@@ -98,6 +103,7 @@ CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
-- 
1.9.1

