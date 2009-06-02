From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 08:53:54 +0000
Subject: [PATCH] sh: clock div6 helper code
Message-Id: <20090602085354.26895.36340.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds div6 clock helper code. The div6 clocks
are simply 6-bit divide-by-n modules where n is 1 to 64.

Needed for vclk on sh7722, sh7723, sh7343 and sh7366.
sh7724 needs this even more for vclk, fclka, fclkb,
irdaclk and spuclk.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h    |   10 +++++
 arch/sh/kernel/cpu/clock-cpg.c |   71 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 6 deletions(-)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-06-02 16:44:33.000000000 +0900
@@ -145,4 +145,14 @@ int sh_clk_mstp32_register(struct clk *c
 int sh_clk_div4_register(struct clk *clks, int nr,
 			 struct clk_div_mult_table *table);
 
+#define SH_CLK_DIV6(_name, _parent, _reg, _flags)	\
+{							\
+	.name = _name,					\
+	.parent = _parent,				\
+	.enable_reg = (void __iomem *)_reg,		\
+	.flags = _flags,				\
+}
+
+int sh_clk_div6_register(struct clk *clks, int nr);
+
 #endif /* __ASM_SH_CLOCK_H */
--- 0004/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-06-02 16:44:53.000000000 +0900
@@ -38,6 +38,70 @@ int __init sh_clk_mstp32_register(struct
 	return ret;
 }
 
+static long sh_clk_div_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_rate_table_round(clk, clk->freq_table, rate);
+}
+
+static int sh_clk_div6_divisors[64] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
+	17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
+	33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
+	49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
+};
+
+static struct clk_div_mult_table sh_clk_div6_table = {
+	.divisors = sh_clk_div6_divisors,
+	.nr_divisors = ARRAY_SIZE(sh_clk_div6_divisors),
+};
+
+static unsigned long sh_clk_div6_recalc(struct clk *clk)
+{
+	struct clk_div_mult_table *table = &sh_clk_div6_table;
+	unsigned int idx;
+
+	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
+			     table, NULL);
+
+	idx = __raw_readl(clk->enable_reg) & 0x003f;
+
+	return clk->freq_table[idx].frequency;
+}
+
+static struct clk_ops sh_clk_div6_clk_ops = {
+	.recalc		= sh_clk_div6_recalc,
+	.round_rate	= sh_clk_div_round_rate,
+};
+
+int __init sh_clk_div6_register(struct clk *clks, int nr)
+{
+	struct clk *clkp;
+	void *freq_table;
+	int nr_divs = sh_clk_div6_table.nr_divisors;
+	int freq_table_size = sizeof(struct cpufreq_frequency_table);
+	int ret = 0;
+	int k;
+
+	freq_table_size *= (nr_divs + 1);
+
+	freq_table = alloc_bootmem(freq_table_size * nr);
+	if (!freq_table)
+		return -ENOMEM;
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+
+		clkp->ops = &sh_clk_div6_clk_ops;
+		clkp->id = -1;
+		clkp->freq_table = freq_table + (k * freq_table_size);
+		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
+
+		ret = clk_register(clkp);
+	}
+
+	return ret;
+}
+
 static unsigned long sh_clk_div4_recalc(struct clk *clk)
 {
 	struct clk_div_mult_table *table = clk->priv;
@@ -51,14 +115,9 @@ static unsigned long sh_clk_div4_recalc(
 	return clk->freq_table[idx].frequency;
 }
 
-static long sh_clk_div4_round_rate(struct clk *clk, unsigned long rate)
-{
-	return clk_rate_table_round(clk, clk->freq_table, rate);
-}
-
 static struct clk_ops sh_clk_div4_clk_ops = {
 	.recalc		= sh_clk_div4_recalc,
-	.round_rate	= sh_clk_div4_round_rate,
+	.round_rate	= sh_clk_div_round_rate,
 };
 
 int __init sh_clk_div4_register(struct clk *clks, int nr,
