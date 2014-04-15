From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:07 +0000
Subject: [PATCH v2 11/17] ARM: shmobile: lager-reference: Remove workarounds for core clock issues
Message-Id: <1397565253-22741-12-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now the core clock issues have been fixed by "ARM: shmobile: Call
sh_pm_runtime_init() from platform code on all SoCs", revert the following
2 commits:
  - f98b55d730492e664fb2649bd7054fec0fe81acd ("ARM: shmobile: Add Lager
    clock workarounds for SDHI and MMCIF"),
  - aa5de826afe747c353162bbc116c63ab5335f91c ("ARM: shmobile:
    lager-reference: Work around core clock issues").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/board-lager-reference.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 0af38a9c390e..ddf62cc86866 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -108,24 +108,10 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 };
 
-/*
- * This is a really crude hack to work around core platform clock issues
- */
-static const struct clk_name clk_enables[] __initconst = {
-	{ "ether", NULL, "ee700000.ethernet" },
-	{ "msiof1", NULL, "e6e10000.spi" },
-	{ "mmcif1", NULL, "ee220000.mmc" },
-	{ "qspi_mod", NULL, "e6b10000.spi" },
-	{ "sdhi0", NULL, "ee100000.sd" },
-	{ "sdhi2", NULL, "ee140000.sd" },
-	{ "thermal", NULL, "e61f0000.thermal" },
-};
-
 static void __init lager_add_standard_devices(void)
 {
 	sh_pm_runtime_init();
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.9.5

