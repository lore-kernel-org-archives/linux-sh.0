From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:09 +0000
Subject: [PATCH v3 35/81] sh: sh7722: Register PFC platform device
Message-Id: <1355611915-25060-36-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 3e60a5c..8547356 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -529,6 +529,7 @@ config CPU_SUBTYPE_SH7722
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
index 0688a75..11dbce3 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
@@ -1,6 +1,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7722.h>
 
 enum {
@@ -1778,7 +1779,7 @@ static struct pinmux_info sh7722_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7722_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7722_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

