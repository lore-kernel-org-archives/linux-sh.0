From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 Jul 2014 20:23:43 +0000
Subject: [PATCH] clk-rcar-gen2: RCAN clock support
Message-Id: <201407310023.43605.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette@linaro.org, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, vksavl@gmail.com

Add RCAN clock support to the R-Car generation 2 CPG driver. This clock gets
derived from the USB_EXTAL clock by dividing it by 6. The layout of RCANCKCR
register is close to those of the clocks supported by the 'clk-div6'  driver
but has no divider field, and so can't be supported by that driver...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git' repo.

 drivers/clk/shmobile/clk-rcar-gen2.c |   99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

Index: linux/drivers/clk/shmobile/clk-rcar-gen2.c
=================================--- linux.orig/drivers/clk/shmobile/clk-rcar-gen2.c
+++ linux/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -33,6 +33,8 @@ struct rcar_gen2_cpg {
 #define CPG_FRQCRC			0x000000e0
 #define CPG_FRQCRC_ZFC_MASK		(0x1f << 8)
 #define CPG_FRQCRC_ZFC_SHIFT		8
+#define CPG_RCANCKCR			0x00000270
+#define CPG_RCANCKCR_CKSTP		BIT(8)
 
 /* -----------------------------------------------------------------------------
  * Z Clock
@@ -162,6 +164,101 @@ static struct clk * __init cpg_z_clk_reg
 }
 
 /* -----------------------------------------------------------------------------
+ * RCAN Clock
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable clears RCANCKCR.CKSTP bit
+ * rate - rate is adjustable.  clk->rate = parent->rate / 6
+ * parent - fixed parent.  No clk_set_parent support
+ */
+struct cpg_rcan_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+
+#define to_rcan_clk(_hw)	container_of(_hw, struct cpg_rcan_clk, hw)
+
+static unsigned long cpg_rcan_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	return parent_rate / 6;
+}
+
+static long cpg_rcan_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *parent_rate)
+{
+	return *parent_rate / 6;
+}
+
+static int cpg_rcan_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	return 0;
+}
+
+static int cpg_rcan_clk_enable(struct clk_hw *hw)
+{
+	struct cpg_rcan_clk *clock = to_rcan_clk(hw);
+
+	clk_writel(clk_readl(clock->reg) & ~CPG_RCANCKCR_CKSTP, clock->reg);
+
+	return 0;
+}
+
+static void cpg_rcan_clk_disable(struct clk_hw *hw)
+{
+	struct cpg_rcan_clk *clock = to_rcan_clk(hw);
+
+	clk_writel(clk_readl(clock->reg) | CPG_RCANCKCR_CKSTP, clock->reg);
+}
+
+static int cpg_rcan_clk_is_enabled(struct clk_hw *hw)
+{
+	struct cpg_rcan_clk *clock = to_rcan_clk(hw);
+
+	return !(clk_readl(clock->reg) & CPG_RCANCKCR_CKSTP);
+}
+
+static const struct clk_ops cpg_rcan_clk_ops = {
+	.enable = cpg_rcan_clk_enable,
+	.disable = cpg_rcan_clk_disable,
+	.is_enabled = cpg_rcan_clk_is_enabled,
+	.recalc_rate = cpg_rcan_clk_recalc_rate,
+	.round_rate = cpg_rcan_clk_round_rate,
+	.set_rate = cpg_rcan_clk_set_rate,
+};
+
+static struct clk * __init cpg_rcan_clk_register(struct rcar_gen2_cpg *cpg,
+						 struct device_node *np)
+{
+	static const char *parent_name;
+	struct clk_init_data init;
+	struct cpg_rcan_clk *rcanclk;
+	struct clk *clk;
+
+	rcanclk = kzalloc(sizeof(*rcanclk), GFP_KERNEL);
+	if (!rcanclk)
+		return ERR_PTR(-ENOMEM);
+
+	parent_name = of_clk_get_parent_name(np, 1);
+
+	init.name = "rcan";
+	init.ops = &cpg_rcan_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	rcanclk->reg = cpg->reg + CPG_RCANCKCR;
+	rcanclk->hw.init = &init;
+
+	clk = clk_register(NULL, &rcanclk->hw);
+	if (IS_ERR(clk))
+		kfree(rcanclk);
+
+	return clk;
+}
+
+/* -----------------------------------------------------------------------------
  * CPG Clock Data
  */
 
@@ -262,6 +359,8 @@ rcar_gen2_cpg_register_clock(struct devi
 		shift = 0;
 	} else if (!strcmp(name, "z")) {
 		return cpg_z_clk_register(cpg);
+	} else if (!strcmp(name, "rcan")) {
+		return cpg_rcan_clk_register(cpg, np);
 	} else {
 		return ERR_PTR(-EINVAL);
 	}
