From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 09:12:43 +0000
Subject: [PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM
Message-Id: <871ter7n17.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

8cd1470("gpio: rcar: Add r8a7795 (R-Car H3) support") added
GPIO support for r8a7795. r8a7795 based on CONFIG_ARM64.
OTOH, GPIO_RCAR driver can be compiled fine on non-ARM.
This patch removed ARM dependency for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This was "gpio: rcar: Enable r8a7795 for ARM64"

 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b4fc9e4..8949b3f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -356,7 +356,7 @@ config GPIO_PXA
 
 config GPIO_RCAR
 	tristate "Renesas R-Car GPIO"
-	depends on ARM && (ARCH_SHMOBILE || COMPILE_TEST)
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support GPIO on Renesas R-Car SoCs.
-- 
1.9.1

