From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:51:16 +0000
Subject: [PATCH v3 42/81] sh: shx3: Register PFC platform device
Message-Id: <1355611915-25060-43-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/sh/Kconfig                       |    1 +
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6c97808..e06f9ac 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -517,6 +517,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select PINCTRL
 
 # SH4AL-DSP Processor Support
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index 2ebb983..eef1b8f 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/shx3.h>
 
 enum {
@@ -582,6 +583,6 @@ static struct pinmux_info shx3_pinmux_info = {
 
 static int __init shx3_pinmux_setup(void)
 {
-	return register_pinmux(&shx3_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &shx3_pinmux_info);
 }
 arch_initcall(shx3_pinmux_setup);
-- 
1.7.8.6

