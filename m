From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:38 +0000
Subject: [PATCH 3/6] clk: shmobile: rcar-gen3: Obtain MD pin values using syscon/regmap
Message-Id: <1441120361-1232-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Obtain the values of the mode pins by reading the Mode Monitoring
Register (MODEMR) using syscon and regmap. The syscon device and
register offset to use are obtained from the "renesas,modemr" property
in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/clk-rcar-gen3.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen3.c b/drivers/clk/shmobile/clk-rcar-gen3.c
index 4bf56dcf84a70ca5..43966656a30d0a4e 100644
--- a/drivers/clk/shmobile/clk-rcar-gen3.c
+++ b/drivers/clk/shmobile/clk-rcar-gen3.c
@@ -14,8 +14,10 @@
 #include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -51,28 +53,6 @@ struct rcar_gen3_cpg {
  */
 #define rcar_clk_readl(cpg, _reg) readl(cpg->reg + _reg)
 
-/*
- * Reset register definitions.
- */
-#define MODEMR 0xe6160060
-
-static u32 rcar_gen3_read_mode_pins(void)
-{
-	static u32 mode;
-	static bool mode_valid;
-
-	if (!mode_valid) {
-		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
-
-		BUG_ON(!modemr);
-		mode = ioread32(modemr);
-		iounmap(modemr);
-		mode_valid = true;
-	}
-
-	return mode;
-}
-
 /* -----------------------------------------------------------------------------
  * CPG Clock Data
  */
@@ -190,11 +170,18 @@ static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
 {
 	const struct cpg_pll_config *config;
 	struct rcar_gen3_cpg *cpg;
-	u32 cpg_mode;
+	struct regmap *regmap;
+	u32 reg, cpg_mode;
 	unsigned int i;
 	int num_clks;
 
-	cpg_mode = rcar_gen3_read_mode_pins();
+	regmap = syscon_regmap_lookup_by_phandle(np, "renesas,modemr");
+	if (IS_ERR(regmap) ||
+	    of_property_read_u32_index(np, "renesas,modemr", 1, &reg) ||
+	    regmap_read(regmap, reg, &cpg_mode)) {
+		pr_err("%s: failed to parse renesas,modemr\n", np->full_name);
+		return;
+	}
 
 	num_clks = of_property_count_u32_elems(np, "clock-indices");
 	if (num_clks < 0) {
-- 
1.9.1

