From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 14 Aug 2014 16:57:22 +0000
Subject: [PATCH 1/7] ARM: shmobile: shmobile_defconfig: Enable missing hardware support
Message-Id: <1408035448-8811-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Based on the DTSes

Notes:
  - MTD_SPI_NOR is a dependency for MTD_M25P80 since commit
    03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI
    nor framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4
    ("mtd: spi-nor: shorten Kconfig naming"),
  - I2C_RIIC was enabled in the old genmai_defconfig.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d655f088ac58..f847a9f8612a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -51,6 +51,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
@@ -84,6 +85,7 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_RIIC=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
-- 
1.9.1

