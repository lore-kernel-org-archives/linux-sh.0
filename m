From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Jan 2010 07:49:55 +0000
Subject: [PATCH] sh: support SIU sourcing from external clock on sh7722
Message-Id: <Pine.LNX.4.64.1001150843570.4375@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a preparation patch for upcoming SIU audio interface support 
patches. It implements switching between the PLL and the master clock, 
supplied from a codec over SIUMCK[AB] pins, as a clock source for SIU[AB] 
and setting of the divisor.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

In fact, the .set_rate() method can be easily extended to become suitable 
for all "div4" clocks, would this be preferred?

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index ea38b55..a6cc9eb 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -172,6 +172,63 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("lcdc0", -1, P_CLK, HWBLK_LCDC, 0),
 };
 
+static int siu_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_div_mult_table *table = clk->priv;
+	u32 value;
+	int ret;
+
+	if (!strcmp("pll_clk", parent->name))
+		value = __raw_readl(clk->enable_reg) & ~(1 << 7);
+	else if ((!strcmp("siumcka_clk", parent->name) &&
+		  !strcmp("siua_clk", clk->name)) ||
+		 (!strcmp("siumckb_clk", parent->name) &&
+		  !strcmp("siub_clk", clk->name)))
+		value = __raw_readl(clk->enable_reg) | (1 << 7);
+	else
+		return -EINVAL;
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
+static int siu_clk_set_rate(struct clk *clk, unsigned long rate, int algo_id)
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
+static int siu_clk_enable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << 8), clk->enable_reg);
+	return 0;
+}
+
+static void siu_clk_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) | (1 << 8), clk->enable_reg);
+}
+
+static struct clk_ops siu_ops;
+
 int __init arch_clk_init(void)
 {
 	int k, ret = 0;
@@ -187,6 +244,15 @@ int __init arch_clk_init(void)
 
 	if (!ret)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+	if (!ret) {
+		siu_ops = *div4_clks[DIV4_SIUA].ops;
+		siu_ops.enable = siu_clk_enable;
+		siu_ops.disable = siu_clk_disable;
+		siu_ops.set_rate = siu_clk_set_rate;
+		siu_ops.set_parent = siu_clk_set_parent;
+		div4_clks[DIV4_SIUA].ops = &siu_ops;
+		div4_clks[DIV4_SIUB].ops = &siu_ops;
+	}
 
 	if (!ret)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
