From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2014 14:29:30 +0000
Subject: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Due to issues with runtime PM clock management, clocks not explicitly
managed by their drivers may not be enabled at all, or be inadvertently
disabled by the clk_disable_unused() late initcall.

Until this is fixed, add a temporary workaround, calling
shmobile_clk_workaround() with enable = true.

For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
thermal. More clocks can be added if needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
Tested with and without CONFIG_PM_RUNTIME

 arch/arm/mach-shmobile/board-koelsch-reference.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a760f7f19bc9..040c6b99cde2 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -107,9 +107,21 @@ static const struct clk_name clk_names[] = {
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
 };
 
+/*
+ * This is a really crude hack to work around core platform clock issues
+ */
+static const struct clk_name clk_enables[] = {
+	{ "ether", NULL, "ee700000.ethernet" },
+	{ "i2c2", NULL, "e6530000.i2c" },
+	{ "msiof0", NULL, "e6e20000.spi" },
+	{ "qspi_mod", NULL, "e6b10000.spi" },
+	{ "thermal", NULL, "e61f0000.thermal" },
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.7.9.5

