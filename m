From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 06 May 2014 14:23:52 +0000
Subject: [PATCH 5/6] ARM: shmobile: sh73a0: common clock framework board support
Message-Id: <1399386233-11928-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds support for the common clock framework to the KZM9G reference board
and SH73A0 SoC setup code.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 25 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c          |  5 ++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 598e324..2ca37b8 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -26,13 +26,38 @@
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <mach/sh73a0.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#ifdef CONFIG_COMMON_CLK
+static const struct clk_name clk_names[] __initconst = {
+	{ "cmt1", NULL, "sh_cmt.10" },
+	{ "scifa0", NULL, "sh-sci.0" },
+	{ "scifa1", NULL, "sh-sci.1" },
+	{ "scifa2", NULL, "sh-sci.2" },
+	{ "scifa3", NULL, "sh-sci.3" },
+	{ "scifa4", NULL, "sh-sci.4" },
+	{ "scifa5", NULL, "sh-sci.5" },
+	{ "scifa6", NULL, "sh-sci.6" },
+	{ "scifa7", NULL, "sh-sci.7" },
+	{ "scifb", NULL, "sh-sci.8" },
+	{ "sdhi0", NULL, "ee100000.sd" },
+	{ "sdhi1", NULL, "ee120000.sd" },
+	{ "sdhi2", NULL, "ee140000.sd" },
+	{ "mmcif0", NULL, "e6bd0000.mmc" },
+	{ "iic0", NULL, "e6820000.i2c" },
+	{ "iic3", NULL, "e6826000.i2c" },
+};
+#endif
+
 static void __init kzm_init(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+#endif
 	sh73a0_add_standard_devices_dt();
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index f74ab53..12a007a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -796,7 +796,9 @@ void __init __weak sh73a0_register_twd(void) { }
 void __init sh73a0_earlytimer_init(void)
 {
 	sh73a0_init_delay();
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
+#endif
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
 }
@@ -819,8 +821,9 @@ void __init sh73a0_add_standard_devices_dt(void)
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
 
 	/* clocks are setup late during boot in the case of DT */
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
-
+#endif
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.8.4.5

