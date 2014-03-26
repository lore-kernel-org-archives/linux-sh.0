From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Mar 2014 05:16:19 +0000
Subject: [PATCH] ARM: shmobile: Include i2c-shmobile.c in shmobile_defconfig
Message-Id: <20140326051619.2454.811.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Many SoCs include I2C controller instances compatible with
the i2c-shmobile.c driver. To increase hardware support enable
the driver in the shmobile_defconfig multiplatform configuration.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-devel-v3.14-rc8-20140325v2

 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2014-03-26 13:42:06.000000000 +0900
@@ -75,6 +75,7 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
