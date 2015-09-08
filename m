From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 08 Sep 2015 15:42:25 +0000
Subject: [PATCH v3 4/5] ARM: shmobile_defconfig: enable PINCTRL_SINGLE
Message-Id: <1441726946-30131-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Required to enable SMSC interrupt on shmobile r8a7778 SoC.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0bdeb49..65e4ff5 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -107,6 +107,7 @@ CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_SH_MSIOF=y
 CONFIG_SPI_SH_HSPI=y
+CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_PCF857X=y
-- 
2.4.6

