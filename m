From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:15 +0000
Subject: [PATCH v3 41/81] sh: sh7786: Register PFC platform device
Message-Id: <1355611915-25060-42-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1886843..6c97808 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -509,6 +509,7 @@ config CPU_SUBTYPE_SH7786
 	select USB_OHCI_SH if USB_OHCI_HCD
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_SH if USB_EHCI_HCD
+	select PINCTRL
 
 config CPU_SUBTYPE_SHX3
 	bool "Support SH-X3 processor"
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
index 60df99c..be876b0 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7786.h>
 
 enum {
@@ -837,7 +838,7 @@ static struct pinmux_info sh7786_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7786_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7786_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

