From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 11:14:31 +0000
Subject: [PATCH v2] sh: support SIU sourcing from external clock on sh7722
Message-Id: <Pine.LNX.4.64.1001191205221.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Implement .set_rate() for all SH "div4 clocks," .enable(), .disable(), and 
.set_parent() for those, that support them. This allows, among other uses, 
reparenting of SIU clocks to the external source, and enabling and 
disabling of the IrDA clock on sh7722.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
On Tue, 19 Jan 2010, Magnus Damm wrote:

> On Fri, Jan 15, 2010 at 4:49 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This is a preparation patch for upcoming SIU audio interface support
> > patches. It implements switching between the PLL and the master clock,
> > supplied from a codec over SIUMCK[AB] pins, as a clock source for SIU[AB]
> > and setting of the divisor.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> 
> Thanks for the patch!
> 
> > In fact, the .set_rate() method can be easily extended to become suitable
> > for all "div4" clocks, would this be preferred?
> 
> I think both .set_rate() and .set_parent() can be reused for all
> "div4" clocks. Check if parent name is "pll_clk", if so clear bit 7
> otherwise set bit 7. This way the external pin code will work for SIU
> on both sh7722 and sh7723.

v1 -> v2: after a private discussion (thanks for tips, Magnus) all methods 
from v1 of this patch have been made globally available for all 
sh_clk_div4 users.

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index 9fe7d7f..501d0b0 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -148,6 +148,10 @@ int sh_clk_mstp32_register(struct clk *clks, int nr);
 
 int sh_clk_div4_register(struct clk *clks, int nr,
 			 struct clk_div_mult_table *table);
+int sh_clk_div4_enable_register(struct clk *clks, int nr,
+			 struct clk_div_mult_table *table);
+int sh_clk_div4_reparent_register(struct clk *clks, int nr,
+			 struct clk_div_mult_table *table);
 
 #define SH_CLK_DIV6(_name, _parent, _reg, _flags)	\
 {							\
diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index 6dfe2cc..2827abb 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -160,13 +160,81 @@ static unsigned long sh_clk_div4_recalc(struct clk *clk)
 	return clk->freq_table[idx].frequency;
 }
 
+static int sh_clk_div4_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_div_mult_table *table = clk->priv;
+	u32 value;
+	int ret;
+
+	if (!strcmp("pll_clk", parent->name))
+		value = __raw_readl(clk->enable_reg) & ~(1 << 7);
+	else
+		value = __raw_readl(clk->enable_reg) | (1 << 7);
+
+	ret = clk_reparent(clk, parent);
+	if (ret < 0)
+		return ret;
+
+	__raw_writel(value, clk->enable_reg);
+
+	/* Rebiuld the frequency table */
+	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
+			     table, &clk->arch_flags);
+
+	return 0;
+}
+
+static int sh_clk_div4_set_rate(struct clk *clk, unsigned long rate, int algo_id)
+{
+	unsigned long value;
+	int idx = clk_rate_table_find(clk, clk->freq_table, rate);
+	if (idx < 0)
+		return idx;
+
+	value = __raw_readl(clk->enable_reg);
+	value &= ~0xf;
+	value |= idx;
+	__raw_writel(value, clk->enable_reg);
+
+	return 0;
+}
+
+static int sh_clk_div4_enable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << 8), clk->enable_reg);
+	return 0;
+}
+
+static void sh_clk_div4_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) | (1 << 8), clk->enable_reg);
+}
+
 static struct clk_ops sh_clk_div4_clk_ops = {
 	.recalc		= sh_clk_div4_recalc,
+	.set_rate	= sh_clk_div4_set_rate,
 	.round_rate	= sh_clk_div_round_rate,
 };
 
-int __init sh_clk_div4_register(struct clk *clks, int nr,
-				struct clk_div_mult_table *table)
+static struct clk_ops sh_clk_div4_enable_clk_ops = {
+	.recalc		= sh_clk_div4_recalc,
+	.set_rate	= sh_clk_div4_set_rate,
+	.round_rate	= sh_clk_div_round_rate,
+	.enable		= sh_clk_div4_enable,
+	.disable	= sh_clk_div4_disable,
+};
+
+static struct clk_ops sh_clk_div4_reparent_clk_ops = {
+	.recalc		= sh_clk_div4_recalc,
+	.set_rate	= sh_clk_div4_set_rate,
+	.round_rate	= sh_clk_div_round_rate,
+	.enable		= sh_clk_div4_enable,
+	.disable	= sh_clk_div4_disable,
+	.set_parent	= sh_clk_div4_set_parent,
+};
+
+static int __init sh_clk_div4_register_ops(struct clk *clks, int nr,
+			struct clk_div_mult_table *table, struct clk_ops *ops)
 {
 	struct clk *clkp;
 	void *freq_table;
@@ -185,7 +253,7 @@ int __init sh_clk_div4_register(struct clk *clks, int nr,
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
 
-		clkp->ops = &sh_clk_div4_clk_ops;
+		clkp->ops = ops;
 		clkp->id = -1;
 		clkp->priv = table;
 
@@ -198,6 +266,26 @@ int __init sh_clk_div4_register(struct clk *clks, int nr,
 	return ret;
 }
 
+int __init sh_clk_div4_register(struct clk *clks, int nr,
+				struct clk_div_mult_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table, &sh_clk_div4_clk_ops);
+}
+
+int __init sh_clk_div4_enable_register(struct clk *clks, int nr,
+				struct clk_div_mult_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table,
+					&sh_clk_div4_enable_clk_ops);
+}
+
+int __init sh_clk_div4_reparent_register(struct clk *clks, int nr,
+				struct clk_div_mult_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table,
+					&sh_clk_div4_reparent_clk_ops);
+}
+
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 static struct clk master_clk = {
 	.name		= "master_clk",
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index ea38b55..860ee2b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -117,12 +117,11 @@ static struct clk_div_mult_table div4_table = {
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
-enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
-       DIV4_SIUA, DIV4_SIUB, DIV4_IRDA, DIV4_NR };
-
 #define DIV4(_str, _reg, _bit, _mask, _flags) \
   SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
 
+enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P, DIV4_NR };
+
 struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
 	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
@@ -130,9 +129,19 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
 	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
 	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
+};
+
+enum { DIV4_IRDA, DIV4_ENABLE_NR };
+
+struct clk div4_enable_clks[DIV4_ENABLE_NR] = {
+	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x1fff, 0),
+};
+
+enum { DIV4_SIUA, DIV4_SIUB, DIV4_REPARENT_NR };
+
+struct clk div4_reparent_clks[DIV4_REPARENT_NR] = {
 	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
 	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
-	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x1fff, 0),
 };
 
 struct clk div6_clks[] = {
@@ -189,6 +198,14 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
+		ret = sh_clk_div4_enable_register(div4_enable_clks,
+					DIV4_ENABLE_NR, &div4_table);
+
+	if (!ret)
+		ret = sh_clk_div4_reparent_register(div4_reparent_clks,
+					DIV4_REPARENT_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
