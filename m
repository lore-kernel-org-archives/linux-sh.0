From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:06 +0000
Subject: [PATCH v2 10/17] ARM: shmobile: koelsch-reference: Remove workarounds for core clock issues
Message-Id: <1397565253-22741-11-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now the core clock issues have been fixed by "ARM: shmobile: Call
sh_pm_runtime_init() from platform code on all SoCs", revert the following
3 commits:
  - 4dcb4c80380dfa482874b931e308fd382597feab ("ARM: shmobile: Add Koelsch
    clock workarounds for SDHI"),
  - 8e4f394b20a0fe474dd88204d76978191566decf ("ARM: shmobile:
    koelsch-reference: Annotate clk_enables as __initconst"),
  - 3d75d9ea74fee6f5a4bdcbbdf2d577661d047eef ("ARM: shmobile:
    koelsch-reference: Work around core clock issues").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/board-koelsch-reference.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 12e2c4c1b2ef..da0eb670d531 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -107,25 +107,10 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
 };
 
-/*
- * This is a really crude hack to work around core platform clock issues
- */
-static const struct clk_name clk_enables[] __initconst = {
-	{ "ether", NULL, "ee700000.ethernet" },
-	{ "i2c2", NULL, "e6530000.i2c" },
-	{ "msiof0", NULL, "e6e20000.spi" },
-	{ "qspi_mod", NULL, "e6b10000.spi" },
-	{ "sdhi0", NULL, "ee100000.sd" },
-	{ "sdhi1", NULL, "ee140000.sd" },
-	{ "sdhi2", NULL, "ee160000.sd" },
-	{ "thermal", NULL, "e61f0000.thermal" },
-};
-
 static void __init koelsch_add_standard_devices(void)
 {
 	sh_pm_runtime_init();
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.9.5

