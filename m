From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 13:11:31 +0000
Subject: [PATCH] sh: shared div4 clock code
Message-Id: <20090528131131.6691.13869.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add shared code for 4-bit divisor clocks.

Processor specific code can use SH_CLK_DIV4()
to initialize div4 clocks, and then use
sh_clk_div4_register() for registration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h    |   15 ++++++++++
 arch/sh/kernel/cpu/clock-cpg.c |   55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

--- 0006/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-28 17:49:19.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/seq_file.h>
+#include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -41,6 +42,7 @@ struct clk {
 	unsigned long		arch_flags;
 	void			*priv;
 	struct dentry		*dentry;
+	struct cpufreq_frequency_table *freq_table;
 };
 
 struct clk_lookup {
@@ -130,4 +132,17 @@ long clk_rate_table_round(struct clk *cl
 
 int sh_clk_mstp32_register(struct clk *clks, int nr);
 
+#define SH_CLK_DIV4(_name, _parent, _reg, _shift, _div_bitmap, _flags)	\
+{									\
+	.name = _name,							\
+	.parent = _parent,						\
+	.enable_reg = (void __iomem *)_reg,				\
+	.enable_bit = _shift,						\
+	.arch_flags = _div_bitmap,					\
+	.flags = _flags,						\
+}
+
+int sh_clk_div4_register(struct clk *clks, int nr,
+			 struct clk_div_mult_table *table);
+
 #endif /* __ASM_SH_CLOCK_H */
--- 0006/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-05-28 18:28:09.000000000 +0900
@@ -1,5 +1,6 @@
 #include <linux/clk.h>
 #include <linux/compiler.h>
+#include <linux/bootmem.h>
 #include <linux/io.h>
 #include <asm/clock.h>
 
@@ -37,6 +38,60 @@ int __init sh_clk_mstp32_register(struct
        return ret;
 }
 
+static unsigned long sh_clk_div4_recalc(struct clk *clk)
+{
+	struct clk_div_mult_table *table = clk->priv;
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
+static long sh_clk_div4_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_rate_table_round(clk, clk->freq_table, rate);
+}
+
+static struct clk_ops sh_clk_div4_clk_ops = {
+	.recalc		= sh_clk_div4_recalc,
+	.round_rate	= sh_clk_div4_round_rate,
+};
+
+int __init sh_clk_div4_register(struct clk *clks, int nr,
+				struct clk_div_mult_table *table)
+{
+	struct clk *clkp;
+	void *freq_table;
+	int nr_divs = table->nr_divisors;
+	int freq_table_size = sizeof(struct cpufreq_frequency_table);
+	int ret = 0;
+	int k;
+
+	k = nr_divs + 1;
+	freq_table = alloc_bootmem(freq_table_size * nr * (nr_divs + 1));
+	if (!freq_table)
+		return -ENOMEM;
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+
+		clkp->ops = &sh_clk_div4_clk_ops;
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
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 static struct clk master_clk = {
 	.name		= "master_clk",
