From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Mar 2014 05:19:11 +0000
Subject: [PATCH] ARM: shmobile: Include at24.c in shmobile_defconfig
Message-Id: <20140326051911.2461.88848.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The Koelsch board includes an at24-compatible EEPROM hooked up via I2C.
To increase hardware support enable the driver in the shmobile_defconfig
multiplatform configuration.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-devel-v3.14-rc8-20140325v2
 and
 [PATCH] ARM: shmobile: Include i2c-shmobile.c in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0002/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2014-03-26 13:44:02.000000000 +0900
@@ -43,6 +43,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
+CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
