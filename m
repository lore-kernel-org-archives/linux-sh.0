From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2009 06:37:53 +0000
Subject: [PATCH][RFC] sh: struct clk_cpg_div
Message-Id: <20090521063753.31513.20597.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds CPG divisor helper functions to clock-cpg.c.

CPG divisors (and the PLL) usually found in FRQCR can now
register multipier and divisor arrays together with callbacks
for getting and setting index values.

The value read out from the hardware is used as index in the
multiplier and divisor arrays to calculate frequency. Invalid
settings in the array should be set to zero.

Only getting rate is supported for now.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h    |   16 ++++++++++++++++
 arch/sh/kernel/cpu/clock-cpg.c |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-21 15:25:07.000000000 +0900
@@ -100,4 +100,20 @@ enum clk_sh_algo_id {
 	IP_N1,
 };
 
+struct clk_cpg_div {
+	struct clk clk;
+	int id;
+};
+
+struct clk_cpg_div_group {
+	int *multipliers;
+	int *divisors;
+	int nr_entries;
+	int (*get_index)(struct clk_cpg_div *div);
+	void (*set_index)(struct clk_cpg_div *div, int index);
+};
+
+int clk_cpg_div_register(struct clk_cpg_div *div,
+			 struct clk_cpg_div_group *group);
+
 #endif /* __ASM_SH_CLOCK_H */
--- 0005/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-05-21 15:25:01.000000000 +0900
@@ -2,6 +2,38 @@
 #include <linux/compiler.h>
 #include <asm/clock.h>
 
+static unsigned long clk_cpg_div_recalc(struct clk *clk)
+{
+	struct clk_cpg_div_group *group = clk->priv;
+	struct clk_cpg_div *div;
+	unsigned long multiplier, divisor;
+	int index;
+
+	div = (void *)((char *)clk - offsetof(struct clk_cpg_div, clk));
+	index = group->get_index(div);
+
+	BUG_ON(index >= group->nr_entries);
+
+	multiplier = group->multipliers[index];
+	divisor = group->divisors[index];
+
+	BUG_ON(!multiplier || !divisor);
+
+	return clk->parent->rate * multiplier / divisor;
+}
+
+static struct clk_ops clk_cpg_div_ops = {
+	.recalc = clk_cpg_div_recalc,
+};
+
+int clk_cpg_div_register(struct clk_cpg_div *div,
+			 struct clk_cpg_div_group *group)
+{
+	div->clk.ops = &clk_cpg_div_ops;
+	div->clk.priv = group;
+	return clk_register(&div->clk);
+}
+
 #ifndef CONFIG_SH_CLK_DISABLE_LEGACY
 
 static struct clk master_clk = {
