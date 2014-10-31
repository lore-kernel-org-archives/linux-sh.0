From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 31 Oct 2014 15:01:35 +0000
Subject: [PATCH 1/2] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1414767696-23211-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, mturquette@linaro.org, laurent.pinchart+renesas@ideasonboard.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, devicetree@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Support for setting the parent at initialization time based on the current
hardware configuration in DIV6 clocks with selectable parents as found in
the r8a73a4, r8a7740, sh73a0, and other SoCs.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/clk/shmobile/clk-div6.c | 117 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index f065f69..ea44988 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -32,6 +32,9 @@ struct div6_clock {
 	struct clk_hw hw;
 	void __iomem *reg;
 	unsigned int div;
+	int src_shift;
+	int src_width;
+	u8 *parents;
 };
 
 #define to_div6_clock(_hw) container_of(_hw, struct div6_clock, hw)
@@ -39,8 +42,11 @@ struct div6_clock {
 static int cpg_div6_clock_enable(struct clk_hw *hw)
 {
 	struct div6_clock *clock = to_div6_clock(hw);
+	u32 val;
 
-	clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
+	val = (clk_readl(clock->reg) & ~(CPG_DIV6_DIV_MASK | CPG_DIV6_CKSTP))
+	    | CPG_DIV6_DIV(clock->div - 1);
+	clk_writel(val, clock->reg);
 
 	return 0;
 }
@@ -52,7 +58,7 @@ static void cpg_div6_clock_disable(struct clk_hw *hw)
 	/* DIV6 clocks require the divisor field to be non-zero when stopping
 	 * the clock.
 	 */
-	clk_writel(CPG_DIV6_CKSTP | CPG_DIV6_DIV(CPG_DIV6_DIV_MASK),
+	clk_writel(clk_readl(clock->reg) | CPG_DIV6_CKSTP | CPG_DIV6_DIV_MASK,
 		   clock->reg);
 }
 
@@ -94,12 +100,53 @@ static int cpg_div6_clock_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct div6_clock *clock = to_div6_clock(hw);
 	unsigned int div = cpg_div6_clock_calc_div(rate, parent_rate);
+	u32 val;
 
 	clock->div = div;
 
+	val = clk_readl(clock->reg) & ~CPG_DIV6_DIV_MASK;
 	/* Only program the new divisor if the clock isn't stopped. */
-	if (!(clk_readl(clock->reg) & CPG_DIV6_CKSTP))
-		clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
+	if (!(val & CPG_DIV6_CKSTP))
+		clk_writel(val | CPG_DIV6_DIV(clock->div - 1), clock->reg);
+
+	return 0;
+}
+
+static unsigned char cpg_div6_clock_get_parent(struct clk_hw *hw)
+{
+	struct div6_clock *clock = to_div6_clock(hw);
+	u8 hw_index;
+	int i;
+
+	if (clock->src_width = 0)
+		return 0;
+
+	hw_index = (clk_readl(clock->reg) >> clock->src_shift) &
+		   (BIT(clock->src_width) - 1);
+	for (i = 0; i < hw->init->num_parents; i++) {
+		if (clock->parents[i] = hw_index)
+			return i;
+	}
+
+	pr_err("%s: %s DIV6 clock set to invalid parent %d\n",
+	       __func__, hw->init->name, hw_index);
+	return 0;
+}
+
+static int cpg_div6_clock_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct div6_clock *clock = to_div6_clock(hw);
+	u8 hw_index;
+	u32 mask;
+
+	if (index >= hw->init->num_parents)
+		return -EINVAL;
+
+	mask = ~((BIT(clock->src_width) - 1) << clock->src_shift);
+	hw_index = clock->parents[index];
+
+	clk_writel((clk_readl(clock->reg) & mask) |
+		(hw_index << clock->src_shift), clock->reg);
 
 	return 0;
 }
@@ -108,6 +155,8 @@ static const struct clk_ops cpg_div6_clock_ops = {
 	.enable = cpg_div6_clock_enable,
 	.disable = cpg_div6_clock_disable,
 	.is_enabled = cpg_div6_clock_is_enabled,
+	.get_parent = cpg_div6_clock_get_parent,
+	.set_parent = cpg_div6_clock_set_parent,
 	.recalc_rate = cpg_div6_clock_recalc_rate,
 	.round_rate = cpg_div6_clock_round_rate,
 	.set_rate = cpg_div6_clock_set_rate,
@@ -115,12 +164,17 @@ static const struct clk_ops cpg_div6_clock_ops = {
 
 static void __init cpg_div6_clock_init(struct device_node *np)
 {
+	const char **parent_names;
 	struct clk_init_data init;
 	struct div6_clock *clock;
-	const char *parent_name;
 	const char *name;
 	struct clk *clk;
+	int valid_parents;
+	int num_parents;
+	u32 src_shift;
+	u32 src_width;
 	int ret;
+	int i;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock) {
@@ -129,6 +183,24 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 		return;
 	}
 
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found for %s DIV6 clock\n",
+		       __func__, np->name);
+		return;
+	}
+
+	clock->parents = kmalloc_array(num_parents, sizeof(*clock->parents),
+		GFP_KERNEL);
+	parent_names = kmalloc_array(num_parents, sizeof(*parent_names),
+				GFP_KERNEL);
+
+	if (!parent_names) {
+		pr_err("%s: failed to allocate %s parent name list\n",
+		       __func__, np->name);
+		return;
+	}
+
 	/* Remap the clock register and read the divisor. Disabling the
 	 * clock overwrites the divisor, so we need to cache its value for the
 	 * enable operation.
@@ -150,19 +222,38 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 		goto error;
 	}
 
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (parent_name = NULL) {
-		pr_err("%s: failed to get %s DIV6 clock parent name\n",
-		       __func__, np->name);
-		goto error;
+
+	for (i = 0, valid_parents = 0; i < num_parents; i++) {
+		const char *name = of_clk_get_parent_name(np, i);
+
+		if (name) {
+			parent_names[valid_parents] = name;
+			clock->parents[valid_parents] = i;
+			valid_parents++;
+		}
+	}
+
+	if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
+		if (!of_property_read_u32(np, "renesas,src-width",
+					&src_width)) {
+			clock->src_shift = src_shift;
+			clock->src_width = src_width;
+		} else {
+			pr_err("%s: renesas,src-shift without renesas,src-width in %s\n",
+			       __func__, np->name);
+			goto error;
+		}
+	} else {
+		clock->src_shift = clock->src_width = 0;
 	}
 
+
 	/* Register the clock. */
 	init.name = name;
 	init.ops = &cpg_div6_clock_ops;
 	init.flags = CLK_IS_BASIC;
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	init.parent_names = parent_names;
+	init.num_parents = valid_parents;
 
 	clock->hw.init = &init;
 
@@ -175,11 +266,13 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 
+	kfree(parent_names);
 	return;
 
 error:
 	if (clock->reg)
 		iounmap(clock->reg);
+	kfree(parent_names);
 	kfree(clock);
 }
 CLK_OF_DECLARE(cpg_div6_clk, "renesas,cpg-div6-clock", cpg_div6_clock_init);
-- 
1.8.4.5

