From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:19 +0000
Subject: [PATCH v4 37/81] sh: sh7724: Register PFC platform device
Message-Id: <1356735303-29474-38-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 89fb594..1885213 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -445,6 +445,7 @@ config CPU_SUBTYPE_SH7724
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	help
 	  Select SH7724 if you have an SH-MobileR2R CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
index 1af0f95..51000f9 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7724.h>
 
 enum {
@@ -2225,6 +2226,6 @@ static struct pinmux_info sh7724_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7724_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7724_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

