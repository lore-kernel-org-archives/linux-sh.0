From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 22 Apr 2014 13:19:11 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7740: common clock framework board support
Message-Id: <1398172752-30567-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Adds support for the common clock framework to the Armadillo800
reference board and R8A7740 SoC setup code.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../board-armadillo800eva-reference.c              | 25 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c             |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78..fa05621 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <asm/mach/arch.h>
@@ -118,6 +119,7 @@
  *	usbhsf_power_ctrl()
  */
 
+#ifndef CONFIG_COMMON_CLK
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -152,14 +154,34 @@ clock_error:
 	if (!IS_ERR(fsibck))
 		clk_put(fsibck);
 }
+#else
+static const struct clk_name clk_names[] __initconst = {
+	{ "cmt1", NULL, "sh_cmt.10" },
+	{ "iic0", NULL, "fff20000.i2c" },
+	{ "mmc", NULL, "e6bd0000.mmc" },
+	{ "scifa0", NULL, "sh-sci.0" },
+	{ "scifa1", NULL, "sh-sci.1" },
+	{ "scifa2", NULL, "sh-sci.2" },
+	{ "scifa3", NULL, "sh-sci.3" },
+	{ "scifa4", NULL, "sh-sci.4" },
+	{ "scifa5", NULL, "sh-sci.5" },
+	{ "scifa6", NULL, "sh-sci.6" },
+	{ "scifa7", NULL, "sh-sci.7" },
+	{ "scifb", NULL, "sh-sci.8" },
+	{ "sdhi0", NULL, "e6850000.sd" },
+	{ "tpu0", NULL, "e6600000.pwm" },
+};
+#endif
 
 /*
  * board init
  */
 static void __init eva_init(void)
 {
+#ifndef CONFIG_COMMON_CLK
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
+#endif
 
 	r8a7740_meram_workaround();
 
@@ -167,6 +189,9 @@ static void __init eva_init(void)
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
+#ifdef CONFIG_COMMON_CLK
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+#endif
 
 	r8a7740_add_standard_devices_dt();
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index a177a7b..8e81c61 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -913,7 +913,9 @@ void __init r8a7740_init_irq_of(void)
 
 static void __init r8a7740_generic_init(void)
 {
+#ifndef CONFIG_COMMON_CLK
 	r8a7740_clock_init(0);
+#endif
 	r8a7740_add_standard_devices_dt();
 }
 
-- 
1.8.4.5

