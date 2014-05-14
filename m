From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 May 2014 14:47:46 +0000
Subject: [PATCH v3 2/2] ARM: shmobile: lager-reference: Remove workarounds for core clock issues
Message-Id: <1400078866-5694-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now the core clock issues have been fixed by commit
3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh: compile
drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI"), revert the following
2 commits:
  - f98b55d730492e664fb2649bd7054fec0fe81acd ("ARM: shmobile: Add Lager
    clock workarounds for SDHI and MMCIF"),
  - aa5de826afe747c353162bbc116c63ab5335f91c ("ARM: shmobile:
    lager-reference: Work around core clock issues").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
This depends on 3c90c55dcde745bed81f6447f24ba96bda43d984 having landed
in Linus' tree

v3:
  - Add Reviewed-by
v2:
  - New
---
 arch/arm/mach-shmobile/board-lager-reference.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 749832e3f33c..e55d817377ab 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -98,23 +98,9 @@ static const struct clk_name clk_names[] __initconst = {
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
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.9.5

