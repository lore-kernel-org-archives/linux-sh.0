From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:08 +0000
Subject: [PATCH v3 34/81] sh: sh7720: Register PFC platform device
Message-Id: <1355611915-25060-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/Kconfig                        |    1 +
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d29368c..3e60a5c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -369,6 +369,7 @@ config CPU_SUBTYPE_SH7720
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_SH if USB_OHCI_HCD
+	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
index 9ca1546..df0648f 100644
--- a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7720.h>
 
 enum {
@@ -1236,7 +1237,7 @@ static struct pinmux_info sh7720_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7720_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7720_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

