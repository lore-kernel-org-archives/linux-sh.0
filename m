From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 21:19:19 +0000
Subject: [PATCH 3/3] ARM: shmobile: r7s72100: update defconfig for I2C usage
Message-Id: <1392671959-22834-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Select the correct I2C driver and activate EEPROM support to have a
slave device for testing. Also activate i2c-dev, so i2c-tools will work.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/configs/genmai_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 5ee6ac0..d238faf 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -52,6 +52,7 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EEPROM_AT24=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
@@ -80,7 +81,8 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C_SH_MOBILE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_RIIC=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
-- 
1.8.5.1

