From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 25 Aug 2015 08:56:45 +0000
Subject: [PATCH] gpio: rcar: Enable support for ARM64
Message-Id: <1440493005-6598-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Enables the R-Car GPIO driver on ARM64.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8f1fe73..2256b2f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -356,7 +356,7 @@ config GPIO_PXA
 
 config GPIO_RCAR
 	tristate "Renesas R-Car GPIO"
-	depends on ARM && (ARCH_SHMOBILE || COMPILE_TEST)
+	depends on (ARM || ARM64) && (ARCH_SHMOBILE || COMPILE_TEST)
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
-- 
2.4.6

