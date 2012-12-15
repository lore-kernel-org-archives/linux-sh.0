From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:05 +0000
Subject: [PATCH v3 31/81] sh: sh7203: Register PFC platform device
Message-Id: <1355611915-25060-32-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8451317..fe970c0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -278,6 +278,7 @@ config CPU_SUBTYPE_SH7203
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7206
 	bool "Support SH7206 processor"
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
index c465af7..814926e 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7203.h>
 
 enum {
@@ -1592,6 +1593,6 @@ static struct pinmux_info sh7203_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7203_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7203_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

