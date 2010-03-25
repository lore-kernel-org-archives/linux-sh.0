From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Mar 2010 07:08:16 +0000
Subject: [PATCH 04/06] sh: move sh clock-cpg.c contents to drivers/sh/clk-cpg.c
Message-Id: <20100325070816.24148.65290.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the CPG helpers to drivers/sh/clk-cpg.c to
allow SH-Mobile ARM to make use of them. All
functions except the legacy CPG stuff is moved.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/Makefile    |    2 
 arch/sh/kernel/cpu/clock-cpg.c |  289 ---------------------------------------
 drivers/sh/Makefile            |    2 
 drivers/sh/clk-cpg.c           |  294 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+), 290 deletions(-)

--- 0001/arch/sh/kernel/cpu/Makefile
+++ work/arch/sh/kernel/cpu/Makefile	2010-03-25 13:23:00.000000000 +0900
@@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 # Common interfaces.
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
-obj-$(CONFIG_SH_CLK_CPG)	+= clock-cpg.o
+obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 obj-$(CONFIG_SH_FPU)		+= fpu.o
 obj-$(CONFIG_SH_FPU_EMU)	+= fpu.o
 
--- 0004/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-03-25 13:23:16.000000000 +0900
@@ -4,295 +4,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 
-static int sh_clk_mstp32_enable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
-		     clk->enable_reg);
-	return 0;
-}
-
-static void sh_clk_mstp32_disable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) | (1 << clk->enable_bit),
-		     clk->enable_reg);
-}
-
-static struct clk_ops sh_clk_mstp32_clk_ops = {
-	.enable		= sh_clk_mstp32_enable,
-	.disable	= sh_clk_mstp32_disable,
-	.recalc		= followparent_recalc,
-};
-
-int __init sh_clk_mstp32_register(struct clk *clks, int nr)
-{
-	struct clk *clkp;
-	int ret = 0;
-	int k;
-
-	for (k = 0; !ret && (k < nr); k++) {
-		clkp = clks + k;
-		clkp->ops = &sh_clk_mstp32_clk_ops;
-		ret |= clk_register(clkp);
-	}
-
-	return ret;
-}
-
-static long sh_clk_div_round_rate(struct clk *clk, unsigned long rate)
-{
-	return clk_rate_table_round(clk, clk->freq_table, rate);
-}
-
-static int sh_clk_div6_divisors[64] = {
-	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
-	17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
-	33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
-	49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
-};
-
-static struct clk_div_mult_table sh_clk_div6_table = {
-	.divisors = sh_clk_div6_divisors,
-	.nr_divisors = ARRAY_SIZE(sh_clk_div6_divisors),
-};
-
-static unsigned long sh_clk_div6_recalc(struct clk *clk)
-{
-	struct clk_div_mult_table *table = &sh_clk_div6_table;
-	unsigned int idx;
-
-	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
-			     table, NULL);
-
-	idx = __raw_readl(clk->enable_reg) & 0x003f;
-
-	return clk->freq_table[idx].frequency;
-}
-
-static int sh_clk_div6_set_rate(struct clk *clk,
-				unsigned long rate, int algo_id)
-{
-	unsigned long value;
-	int idx;
-
-	idx = clk_rate_table_find(clk, clk->freq_table, rate);
-	if (idx < 0)
-		return idx;
-
-	value = __raw_readl(clk->enable_reg);
-	value &= ~0x3f;
-	value |= idx;
-	__raw_writel(value, clk->enable_reg);
-	return 0;
-}
-
-static int sh_clk_div6_enable(struct clk *clk)
-{
-	unsigned long value;
-	int ret;
-
-	ret = sh_clk_div6_set_rate(clk, clk->rate, 0);
-	if (ret = 0) {
-		value = __raw_readl(clk->enable_reg);
-		value &= ~0x100; /* clear stop bit to enable clock */
-		__raw_writel(value, clk->enable_reg);
-	}
-	return ret;
-}
-
-static void sh_clk_div6_disable(struct clk *clk)
-{
-	unsigned long value;
-
-	value = __raw_readl(clk->enable_reg);
-	value |= 0x100; /* stop clock */
-	value |= 0x3f; /* VDIV bits must be non-zero, overwrite divider */
-	__raw_writel(value, clk->enable_reg);
-}
-
-static struct clk_ops sh_clk_div6_clk_ops = {
-	.recalc		= sh_clk_div6_recalc,
-	.round_rate	= sh_clk_div_round_rate,
-	.set_rate	= sh_clk_div6_set_rate,
-	.enable		= sh_clk_div6_enable,
-	.disable	= sh_clk_div6_disable,
-};
-
-int __init sh_clk_div6_register(struct clk *clks, int nr)
-{
-	struct clk *clkp;
-	void *freq_table;
-	int nr_divs = sh_clk_div6_table.nr_divisors;
-	int freq_table_size = sizeof(struct cpufreq_frequency_table);
-	int ret = 0;
-	int k;
-
-	freq_table_size *= (nr_divs + 1);
-	freq_table = kzalloc(freq_table_size * nr, GFP_KERNEL);
-	if (!freq_table) {
-		pr_err("sh_clk_div6_register: unable to alloc memory\n");
-		return -ENOMEM;
-	}
-
-	for (k = 0; !ret && (k < nr); k++) {
-		clkp = clks + k;
-
-		clkp->ops = &sh_clk_div6_clk_ops;
-		clkp->id = -1;
-		clkp->freq_table = freq_table + (k * freq_table_size);
-		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
-
-		ret = clk_register(clkp);
-	}
-
-	return ret;
-}
-
-static unsigned long sh_clk_div4_recalc(struct clk *clk)
-{
-	struct clk_div4_table *d4t = clk->priv;
-	struct clk_div_mult_table *table = d4t->div_mult_table;
-	unsigned int idx;
-
-	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
-			     table, &clk->arch_flags);
-
-	idx = (__raw_readl(clk->enable_reg) >> clk->enable_bit) & 0x000f;
-
-	return clk->freq_table[idx].frequency;
-}
-
-static int sh_clk_div4_set_parent(struct clk *clk, struct clk *parent)
-{
-	struct clk_div4_table *d4t = clk->priv;
-	struct clk_div_mult_table *table = d4t->div_mult_table;
-	u32 value;
-	int ret;
-
-	if (!strcmp("pll_clk", parent->name))
-		value = __raw_readl(clk->enable_reg) & ~(1 << 7);
-	else
-		value = __raw_readl(clk->enable_reg) | (1 << 7);
-
-	ret = clk_reparent(clk, parent);
-	if (ret < 0)
-		return ret;
-
-	__raw_writel(value, clk->enable_reg);
-
-	/* Rebiuld the frequency table */
-	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
-			     table, &clk->arch_flags);
-
-	return 0;
-}
-
-static int sh_clk_div4_set_rate(struct clk *clk, unsigned long rate, int algo_id)
-{
-	struct clk_div4_table *d4t = clk->priv;
-	unsigned long value;
-	int idx = clk_rate_table_find(clk, clk->freq_table, rate);
-	if (idx < 0)
-		return idx;
-
-	value = __raw_readl(clk->enable_reg);
-	value &= ~(0xf << clk->enable_bit);
-	value |= (idx << clk->enable_bit);
-	__raw_writel(value, clk->enable_reg);
-
-	if (d4t->kick)
-		d4t->kick(clk);
-
-	return 0;
-}
-
-static int sh_clk_div4_enable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << 8), clk->enable_reg);
-	return 0;
-}
-
-static void sh_clk_div4_disable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) | (1 << 8), clk->enable_reg);
-}
-
-static struct clk_ops sh_clk_div4_clk_ops = {
-	.recalc		= sh_clk_div4_recalc,
-	.set_rate	= sh_clk_div4_set_rate,
-	.round_rate	= sh_clk_div_round_rate,
-};
-
-static struct clk_ops sh_clk_div4_enable_clk_ops = {
-	.recalc		= sh_clk_div4_recalc,
-	.set_rate	= sh_clk_div4_set_rate,
-	.round_rate	= sh_clk_div_round_rate,
-	.enable		= sh_clk_div4_enable,
-	.disable	= sh_clk_div4_disable,
-};
-
-static struct clk_ops sh_clk_div4_reparent_clk_ops = {
-	.recalc		= sh_clk_div4_recalc,
-	.set_rate	= sh_clk_div4_set_rate,
-	.round_rate	= sh_clk_div_round_rate,
-	.enable		= sh_clk_div4_enable,
-	.disable	= sh_clk_div4_disable,
-	.set_parent	= sh_clk_div4_set_parent,
-};
-
-static int __init sh_clk_div4_register_ops(struct clk *clks, int nr,
-			struct clk_div4_table *table, struct clk_ops *ops)
-{
-	struct clk *clkp;
-	void *freq_table;
-	int nr_divs = table->div_mult_table->nr_divisors;
-	int freq_table_size = sizeof(struct cpufreq_frequency_table);
-	int ret = 0;
-	int k;
-
-	freq_table_size *= (nr_divs + 1);
-	freq_table = kzalloc(freq_table_size * nr, GFP_KERNEL);
-	if (!freq_table) {
-		pr_err("sh_clk_div4_register: unable to alloc memory\n");
-		return -ENOMEM;
-	}
-
-	for (k = 0; !ret && (k < nr); k++) {
-		clkp = clks + k;
-
-		clkp->ops = ops;
-		clkp->id = -1;
-		clkp->priv = table;
-
-		clkp->freq_table = freq_table + (k * freq_table_size);
-		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
-
-		ret = clk_register(clkp);
-	}
-
-	return ret;
-}
-
-int __init sh_clk_div4_register(struct clk *clks, int nr,
-				struct clk_div4_table *table)
-{
-	return sh_clk_div4_register_ops(clks, nr, table, &sh_clk_div4_clk_ops);
-}
-
-int __init sh_clk_div4_enable_register(struct clk *clks, int nr,
-				struct clk_div4_table *table)
-{
-	return sh_clk_div4_register_ops(clks, nr, table,
-					&sh_clk_div4_enable_clk_ops);
-}
-
-int __init sh_clk_div4_reparent_register(struct clk *clks, int nr,
-				struct clk_div4_table *table)
-{
-	return sh_clk_div4_register_ops(clks, nr, table,
-					&sh_clk_div4_reparent_clk_ops);
-}
 
-#ifdef CONFIG_SH_CLK_CPG_LEGACY
 static struct clk master_clk = {
 	.name		= "master_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -349,4 +61,3 @@ int __init __weak arch_clk_init(void)
 {
 	return cpg_clk_init();
 }
-#endif /* CONFIG_SH_CPG_CLK_LEGACY */
--- 0005/drivers/sh/Makefile
+++ work/drivers/sh/Makefile	2010-03-25 13:22:41.000000000 +0900
@@ -5,4 +5,6 @@ obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
 obj-$(CONFIG_SUPERH)		+= clk.o
+# both clk.o and clk-cpg.o needed by SH-Mobile ARM
+obj-$(CONFIG_SH_CLK_CPG)	+= clk.o clk-cpg.o
 obj-y				+= intc.o
--- /dev/null
+++ work/drivers/sh/clk-cpg.c	2010-03-25 13:22:34.000000000 +0900
@@ -0,0 +1,294 @@
+#include <linux/clk.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/sh_clk.h>
+
+static int sh_clk_mstp32_enable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
+		     clk->enable_reg);
+	return 0;
+}
+
+static void sh_clk_mstp32_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) | (1 << clk->enable_bit),
+		     clk->enable_reg);
+}
+
+static struct clk_ops sh_clk_mstp32_clk_ops = {
+	.enable		= sh_clk_mstp32_enable,
+	.disable	= sh_clk_mstp32_disable,
+	.recalc		= followparent_recalc,
+};
+
+int __init sh_clk_mstp32_register(struct clk *clks, int nr)
+{
+	struct clk *clkp;
+	int ret = 0;
+	int k;
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+		clkp->ops = &sh_clk_mstp32_clk_ops;
+		ret |= clk_register(clkp);
+	}
+
+	return ret;
+}
+
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
+static struct clk_ops sh_clk_div6_clk_ops = {
+	.recalc		= sh_clk_div6_recalc,
+	.round_rate	= sh_clk_div_round_rate,
+	.set_rate	= sh_clk_div6_set_rate,
+	.enable		= sh_clk_div6_enable,
+	.disable	= sh_clk_div6_disable,
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
+	freq_table = kzalloc(freq_table_size * nr, GFP_KERNEL);
+	if (!freq_table) {
+		pr_err("sh_clk_div6_register: unable to alloc memory\n");
+		return -ENOMEM;
+	}
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
+static unsigned long sh_clk_div4_recalc(struct clk *clk)
+{
+	struct clk_div4_table *d4t = clk->priv;
+	struct clk_div_mult_table *table = d4t->div_mult_table;
+	unsigned int idx;
+
+	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
+			     table, &clk->arch_flags);
+
+	idx = (__raw_readl(clk->enable_reg) >> clk->enable_bit) & 0x000f;
+
+	return clk->freq_table[idx].frequency;
+}
+
+static int sh_clk_div4_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_div4_table *d4t = clk->priv;
+	struct clk_div_mult_table *table = d4t->div_mult_table;
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
+	struct clk_div4_table *d4t = clk->priv;
+	unsigned long value;
+	int idx = clk_rate_table_find(clk, clk->freq_table, rate);
+	if (idx < 0)
+		return idx;
+
+	value = __raw_readl(clk->enable_reg);
+	value &= ~(0xf << clk->enable_bit);
+	value |= (idx << clk->enable_bit);
+	__raw_writel(value, clk->enable_reg);
+
+	if (d4t->kick)
+		d4t->kick(clk);
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
+static struct clk_ops sh_clk_div4_clk_ops = {
+	.recalc		= sh_clk_div4_recalc,
+	.set_rate	= sh_clk_div4_set_rate,
+	.round_rate	= sh_clk_div_round_rate,
+};
+
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
+			struct clk_div4_table *table, struct clk_ops *ops)
+{
+	struct clk *clkp;
+	void *freq_table;
+	int nr_divs = table->div_mult_table->nr_divisors;
+	int freq_table_size = sizeof(struct cpufreq_frequency_table);
+	int ret = 0;
+	int k;
+
+	freq_table_size *= (nr_divs + 1);
+	freq_table = kzalloc(freq_table_size * nr, GFP_KERNEL);
+	if (!freq_table) {
+		pr_err("sh_clk_div4_register: unable to alloc memory\n");
+		return -ENOMEM;
+	}
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+
+		clkp->ops = ops;
+		clkp->id = -1;
+		clkp->priv = table;
+
+		clkp->freq_table = freq_table + (k * freq_table_size);
+		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
+
+		ret = clk_register(clkp);
+	}
+
+	return ret;
+}
+
+int __init sh_clk_div4_register(struct clk *clks, int nr,
+				struct clk_div4_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table, &sh_clk_div4_clk_ops);
+}
+
+int __init sh_clk_div4_enable_register(struct clk *clks, int nr,
+				struct clk_div4_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table,
+					&sh_clk_div4_enable_clk_ops);
+}
+
+int __init sh_clk_div4_reparent_register(struct clk *clks, int nr,
+				struct clk_div4_table *table)
+{
+	return sh_clk_div4_register_ops(clks, nr, table,
+					&sh_clk_div4_reparent_clk_ops);
+}
+
