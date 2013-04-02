From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Apr 2013 05:07:05 +0000
Subject: [PATCH 09/30] ARM: shmobile: Disallow PINCTRL without GPIOLIB
Message-Id: <1364879246-9470-10-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Modify mach-shmobile to only select PINCTRL in case of
ARCH_WANT_OPTIONAL_GPIOLIB is set.

This fixes a build error triggered when adding a new SoC
lacking GPIO software support (ARCH_WANT_OPTIONAL_GPIOLIB=n):

 CC      drivers/tty/vt/keyboard.o
In file included from drivers/pinctrl/core.c:30:0:
include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
include/asm-generic/gpio.h:270:2: error: implicit declaration of function '__gpio_get_value'
include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
include/asm-generic/gpio.h:276:2: error: implicit declaration of function '__gpio_set_value'
drivers/pinctrl/core.c: In function 'pinctrl_ready_for_gpio_range':
drivers/pinctrl/core.c:297:9: error: implicit declaration of function 'gpio_to_chip'
drivers/pinctrl/core.c:297:27: warning: initialization makes pointer from integer without a cast
drivers/pinctrl/core.c:304:45: error: dereferencing pointer to incomplete type
drivers/pinctrl/core.c:305:26: error: dereferencing pointer to incomplete type
drivers/pinctrl/core.c:305:39: error: dereferencing pointer to incomplete type
make[2]: *** [drivers/pinctrl/core.o] Error 1
make[1]: *** [drivers/pinctrl] Error 2
make[1]: *** Waiting for unfinished jobs....
  LD      drivers/sh/built-in.o

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..b63902e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -725,7 +725,7 @@ config ARCH_SHMOBILE
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
-	select PINCTRL
+	select PINCTRL if ARCH_WANT_OPTIONAL_GPIOLIB
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-- 
1.7.10.4

