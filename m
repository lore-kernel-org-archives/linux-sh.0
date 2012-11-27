From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:02:24 +0000
Subject: [PATCH v2 25/77] sh: sh7723: Register PFC platform device
Message-Id: <1353974596-30033-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2f0d9bf..89fb594 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -433,6 +433,7 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
index 88bf5ec..ca08b5f 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7723.h>
 
 enum {
@@ -1903,7 +1904,7 @@ static struct pinmux_info sh7723_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7723_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7723_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.8.6

