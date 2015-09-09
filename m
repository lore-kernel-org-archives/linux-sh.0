From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Sep 2015 05:05:54 +0000
Subject: [PATCH][RFC] clk: Use node name and index for clock name
Message-Id: <20150909050554.27129.68718.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

This patch hacks the CCF core to take clock-indices into
consideration when making a default clock name in case
clock-output-names is not provided.

Without this patch of_clk_get_parent_name() does not work
for clocks with multiple indices associated with one node.

Proof of concept only. Leaks memory. Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of "renesas-drivers-2015-09-08-v4.2"
 Needed to propagate clock frequencies from CPG to MSTP.

 drivers/clk/clk.c                    |   46 ++++++++++++++++++++++------------
 drivers/clk/shmobile/clk-mstp.c      |    3 --
 drivers/clk/shmobile/clk-rcar-gen3.c |   13 +--------
 include/linux/clk-provider.h         |    1 
 4 files changed, 35 insertions(+), 28 deletions(-)

--- 0001/drivers/clk/clk.c
+++ work/drivers/clk/clk.c	2015-09-09 13:48:21.992366518 +0900
@@ -3045,31 +3045,25 @@ int of_clk_get_parent_count(struct devic
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
 
-const char *of_clk_get_parent_name(struct device_node *np, int index)
+const char *of_clk_get_name(struct device_node *np, int index)
 {
-	struct of_phandle_args clkspec;
 	struct property *prop;
 	const char *clk_name;
 	const __be32 *vp;
 	u32 pv;
-	int rc;
 	int count;
+	bool has_indices = false;
 
 	if (index < 0)
 		return NULL;
 
-	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
-					&clkspec);
-	if (rc)
-		return NULL;
-
-	index = clkspec.args_count ? clkspec.args[0] : 0;
 	count = 0;
 
 	/* if there is an indices property, use it to transfer the index
 	 * specified into an array offset for the clock-output-names property.
 	 */
-	of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
+	of_property_for_each_u32(np, "clock-indices", prop, vp, pv) {
+		has_indices = true;
 		if (index = pv) {
 			index = count;
 			break;
@@ -3077,12 +3071,34 @@ const char *of_clk_get_parent_name(struc
 		count++;
 	}
 
-	if (of_property_read_string_index(clkspec.np, "clock-output-names",
-					  index,
-					  &clk_name) < 0)
-		clk_name = clkspec.np->name;
+	if (of_property_read_string_index(np, "clock-output-names", index,
+					  &clk_name) < 0) {
+		if (has_indices)
+			return kasprintf(GFP_KERNEL, "%s.%u", np->name, index);
+		else
+			return kstrdup_const(np->name, GFP_KERNEL);
+	}
 
-	of_node_put(clkspec.np);
+	return kstrdup_const(clk_name, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(of_clk_get_name);
+
+const char *of_clk_get_parent_name(struct device_node *np, int index)
+{
+	struct of_phandle_args clkspec;
+	const char *clk_name = NULL;
+	int rc;
+
+	if (index < 0)
+		return NULL;
+
+	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
+					&clkspec);
+	if (!rc) {
+		clk_name = of_clk_get_name(clkspec.np, clkspec.args_count ?
+					   clkspec.args[0] : 0);
+		of_node_put(clkspec.np);
+	}
 	return clk_name;
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
--- 0001/drivers/clk/shmobile/clk-mstp.c
+++ work/drivers/clk/shmobile/clk-mstp.c	2015-09-09 13:45:51.652366518 +0900
@@ -216,8 +216,7 @@ static void __init cpg_mstp_clocks_init(
 
 		if (of_property_read_string_index(np, "clock-output-names",
 						  i, &name) < 0)
-			allocated_name = name = kasprintf(GFP_KERNEL, "%s.%u",
-							   np->name, clkidx);
+			allocated_name = name = of_clk_get_name(np, clkidx);
 
 		clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
 						       clkidx, group);
--- 0001/drivers/clk/shmobile/clk-rcar-gen3.c
+++ work/drivers/clk/shmobile/clk-rcar-gen3.c	2015-09-09 13:45:51.652366518 +0900
@@ -28,15 +28,6 @@
 #define RCAR_GEN3_CLK_PLL4	5
 #define RCAR_GEN3_CLK_NR	6
 
-static const char * const rcar_gen3_clk_names[RCAR_GEN3_CLK_NR] = {
-	[RCAR_GEN3_CLK_MAIN] = "main",
-	[RCAR_GEN3_CLK_PLL0] = "pll0",
-	[RCAR_GEN3_CLK_PLL1] = "pll1",
-	[RCAR_GEN3_CLK_PLL2] = "pll2",
-	[RCAR_GEN3_CLK_PLL3] = "pll3",
-	[RCAR_GEN3_CLK_PLL4] = "pll4",
-};
-
 struct rcar_gen3_cpg {
 	struct clk_onecell_data data;
 	void __iomem *reg;
@@ -116,7 +107,7 @@ rcar_gen3_cpg_register_clk(struct device
 			   const struct cpg_pll_config *config,
 			   unsigned int gen3_clk)
 {
-	const char *parent_name = rcar_gen3_clk_names[RCAR_GEN3_CLK_MAIN];
+	const char *parent_name = of_clk_get_name(np, RCAR_GEN3_CLK_MAIN);
 	unsigned int mult = 1;
 	unsigned int div = 1;
 	u32 value;
@@ -157,7 +148,7 @@ rcar_gen3_cpg_register_clk(struct device
 		return ERR_PTR(-EINVAL);
 	}
 
-	return clk_register_fixed_factor(NULL, rcar_gen3_clk_names[gen3_clk],
+	return clk_register_fixed_factor(NULL, of_clk_get_name(np, gen3_clk),
 					 parent_name, 0, mult, div);
 }
 
--- 0001/include/linux/clk-provider.h
+++ work/include/linux/clk-provider.h	2015-09-09 13:46:21.052366518 +0900
@@ -665,6 +665,7 @@ struct clk *of_clk_src_onecell_get(struc
 int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
+const char *of_clk_get_name(struct device_node *np, int index);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
 
 void of_clk_init(const struct of_device_id *matches);
