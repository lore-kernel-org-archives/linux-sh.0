From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 05:31:41 +0000
Subject: [PATCH] sh: add enable()/disable()/set_rate() to div6 code
Message-Id: <20090604053141.31218.83540.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the div6 clock helper code to add support
for enable(), disable() and set_rate() callbacks.

Needed by the camera clock enabling board code on Migo-R.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on Migo-R with rewritten sh7722 clock framework.

 arch/sh/include/asm/clock.h    |    4 +++
 arch/sh/kernel/cpu/clock-cpg.c |   44 ++++++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/clock.c     |   19 +++++++++++++++++
 3 files changed, 67 insertions(+)

--- 0005/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-06-04 13:49:27.000000000 +0900
@@ -119,6 +119,10 @@ long clk_rate_table_round(struct clk *cl
 			  struct cpufreq_frequency_table *freq_table,
 			  unsigned long rate);
 
+int clk_rate_table_find(struct clk *clk,
+			struct cpufreq_frequency_table *freq_table,
+			unsigned long rate);
+
 #define SH_CLK_MSTP32(_name, _id, _parent, _enable_reg,	\
 	    _enable_bit, _flags)			\
 {							\
--- 0005/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-06-04 13:56:11.000000000 +0900
@@ -68,9 +68,53 @@ static unsigned long sh_clk_div6_recalc(
 	return clk->freq_table[idx].frequency;
 }
 
+static int sh_clk_div6_set_rate(struct clk *clk,
+				unsigned long rate, int algo_id)
+{
+	unsigned long value;
+	int idx;
+
+	idx = clk_rate_table_find(clk, clk->freq_table, rate);
+	if (idx < 0)
+		return idx;
+
+	value = __raw_readl(clk->enable_reg);
+	value &= ~0x3f;
+	value |= idx;
+	__raw_writel(value, clk->enable_reg);
+	return 0;
+}
+
+static int sh_clk_div6_enable(struct clk *clk)
+{
+	unsigned long value;
+	int ret;
+
+	ret = sh_clk_div6_set_rate(clk, clk->rate, 0);
+	if (ret = 0) {
+		value = __raw_readl(clk->enable_reg);
+		value &= ~0x100; /* clear stop bit to enable clock */
+		__raw_writel(value, clk->enable_reg);
+	}
+	return ret;
+}
+
+static void sh_clk_div6_disable(struct clk *clk)
+{
+	unsigned long value;
+
+	value = __raw_readl(clk->enable_reg);
+	value |= 0x100; /* stop clock */
+	value |= 0x3f; /* VDIV bits must be non-zero, overwrite divider */
+	__raw_writel(value, clk->enable_reg);
+}
+
 static struct clk_ops sh_clk_div6_clk_ops = {
 	.recalc		= sh_clk_div6_recalc,
 	.round_rate	= sh_clk_div_round_rate,
+	.set_rate	= sh_clk_div6_set_rate,
+	.enable		= sh_clk_div6_enable,
+	.disable	= sh_clk_div6_disable,
 };
 
 int __init sh_clk_div6_register(struct clk *clks, int nr)
--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-06-04 13:58:42.000000000 +0900
@@ -111,6 +111,25 @@ long clk_rate_table_round(struct clk *cl
 	return rate_best_fit;
 }
 
+int clk_rate_table_find(struct clk *clk,
+			struct cpufreq_frequency_table *freq_table,
+			unsigned long rate)
+{
+	int i;
+
+	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		unsigned long freq = freq_table[i].frequency;
+
+		if (freq = CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		if (freq = rate)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 /* Used for clocks that always have same value as the parent clock */
 unsigned long followparent_recalc(struct clk *clk)
 {
