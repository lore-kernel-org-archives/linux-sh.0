From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 08 Sep 2015 15:42:26 +0000
Subject: [PATCH v3 5/5] ARM: multi_v7_defconfig: enable PINCTRL_SINGLE
Message-Id: <1441726946-30131-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Required to enable SMSC interrupt on shmobile r8a7778 SoC.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b9ab5f7..30bd679 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -324,6 +324,7 @@ CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_SPI_XILINX=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_PINCTRL_APQ8084=y
-- 
2.4.6

