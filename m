From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:12 +0000
Subject: [PATCH v3 38/81] sh: sh7734: Register PFC platform device
Message-Id: <1355611915-25060-39-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add arch code to register the PFC platform device instead of calling the
driver directly. Platform device registration in the sh-pfc driver will
be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/Kconfig                         |    1 +
 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ef1fbf7..8b5b399 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -458,6 +458,7 @@ config CPU_SUBTYPE_SH7734
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select PINCTRL
 	help
 	  Select SH7734 if you have a SH4A SH7734 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
index eed3b9d..fa33583 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/ioport.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7734.h>
 
 #define CPU_32_PORT(fn, pfx, sfx)				\
@@ -2467,9 +2468,6 @@ static struct resource sh7734_pfc_resources[] = {
 static struct pinmux_info sh7734_pinmux_info = {
 	.name = "sh7734_pfc",
 
-	.resource = sh7734_pfc_resources,
-	.num_resources = ARRAY_SIZE(sh7734_pfc_resources),
-
 	.unlock_reg = 0xFFFC0000,
 
 	.reserved_id = PINMUX_RESERVED,
@@ -2492,6 +2490,8 @@ static struct pinmux_info sh7734_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7734_pinmux_info);
+	return sh_pfc_register_info(NULL, sh7734_pfc_resources,
+				    ARRAY_SIZE(sh7734_pfc_resources),
+				    &sh7734_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

