From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:22 +0000
Subject: [PATCH v4 40/81] sh: sh7785: Register PFC platform device
Message-Id: <1356735303-29474-41-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add arch code to register the PFC platform device instead of calling the
driver directly. Platform device registration in the sh-pfc driver will
be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/Kconfig                         |    1 +
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index c99193f..7d5bc1d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -494,6 +494,7 @@ config CPU_SUBTYPE_SH7785
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7786
 	bool "Support SH7786 processor"
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
index 5ebc25f..da0bd79 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7785.h>
 
 enum {
@@ -1304,7 +1305,7 @@ static struct pinmux_info sh7785_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7785_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7785_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

