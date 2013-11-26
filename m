From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Nov 2013 01:53:16 +0000
Subject: [PATCH] ARM: shmobile: lager: fixup I2C device on defconfig
Message-Id: <87iovgorng.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car H2 needs I2C_CAR, not I2C_SH_MOBILE

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/lager_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 35b7cb7..883443f 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -80,7 +80,7 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_GPIO=y
-CONFIG_I2C_SH_MOBILE=y
+CONFIG_I2C_RCAR=y
 CONFIG_GPIO_SH_PFC=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
-- 
1.7.9.5

