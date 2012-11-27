From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:02:27 +0000
Subject: [PATCH v2 28/77] sh: sh7757: Register PFC platform device
Message-Id: <1353974596-30033-29-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7a7d2ec..c99193f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -467,6 +467,7 @@ config CPU_SUBTYPE_SH7757
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select PINCTRL
 	help
 	  Select SH7757 if you have a SH4A SH7757 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
index 4c74bd0..368b82e 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7757.h>
 
 enum {
@@ -2282,6 +2283,6 @@ static struct pinmux_info sh7757_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7757_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7757_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

