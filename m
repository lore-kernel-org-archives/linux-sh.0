From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 09:22:25 +0000
Subject: [PATCH] sh: introduce struct clk_div4_table
Message-Id: <20100219092225.479.69458.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch introduces struct clk_div4_table. The structure
will be used to keep div4 specific data, and is with this
patch replacing the struct clk_div_mult_table pointer arg
used by the sh_clk_div4_register() functions.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   10 +++++++---
 arch/sh/kernel/cpu/clock-cpg.c         |   16 +++++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    6 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    6 +++++-
 9 files changed, 51 insertions(+), 17 deletions(-)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-02-19 16:27:37.000000000 +0900
@@ -146,12 +146,16 @@ int sh_clk_mstp32_register(struct clk *c
 	.flags = _flags,						\
 }
 
+struct clk_div4_table {
+	struct clk_div_mult_table *div_mult_table;
+};
+
 int sh_clk_div4_register(struct clk *clks, int nr,
-			 struct clk_div_mult_table *table);
+			 struct clk_div4_table *table);
 int sh_clk_div4_enable_register(struct clk *clks, int nr,
-			 struct clk_div_mult_table *table);
+			 struct clk_div4_table *table);
 int sh_clk_div4_reparent_register(struct clk *clks, int nr,
-			 struct clk_div_mult_table *table);
+			 struct clk_div4_table *table);
 
 #define SH_CLK_DIV6(_name, _parent, _reg, _flags)	\
 {							\
--- 0002/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-02-19 16:30:45.000000000 +0900
@@ -149,7 +149,8 @@ int __init sh_clk_div6_register(struct c
 
 static unsigned long sh_clk_div4_recalc(struct clk *clk)
 {
-	struct clk_div_mult_table *table = clk->priv;
+	struct clk_div4_table *d4t = clk->priv;
+	struct clk_div_mult_table *table = d4t->div_mult_table;
 	unsigned int idx;
 
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
@@ -162,7 +163,8 @@ static unsigned long sh_clk_div4_recalc(
 
 static int sh_clk_div4_set_parent(struct clk *clk, struct clk *parent)
 {
-	struct clk_div_mult_table *table = clk->priv;
+	struct clk_div4_table *d4t = clk->priv;
+	struct clk_div_mult_table *table = d4t->div_mult_table;
 	u32 value;
 	int ret;
 
@@ -234,11 +236,11 @@ static struct clk_ops sh_clk_div4_repare
 };
 
 static int __init sh_clk_div4_register_ops(struct clk *clks, int nr,
-			struct clk_div_mult_table *table, struct clk_ops *ops)
+			struct clk_div4_table *table, struct clk_ops *ops)
 {
 	struct clk *clkp;
 	void *freq_table;
-	int nr_divs = table->nr_divisors;
+	int nr_divs = table->div_mult_table->nr_divisors;
 	int freq_table_size = sizeof(struct cpufreq_frequency_table);
 	int ret = 0;
 	int k;
@@ -267,20 +269,20 @@ static int __init sh_clk_div4_register_o
 }
 
 int __init sh_clk_div4_register(struct clk *clks, int nr,
-				struct clk_div_mult_table *table)
+				struct clk_div4_table *table)
 {
 	return sh_clk_div4_register_ops(clks, nr, table, &sh_clk_div4_clk_ops);
 }
 
 int __init sh_clk_div4_enable_register(struct clk *clks, int nr,
-				struct clk_div_mult_table *table)
+				struct clk_div4_table *table)
 {
 	return sh_clk_div4_register_ops(clks, nr, table,
 					&sh_clk_div4_enable_clk_ops);
 }
 
 int __init sh_clk_div4_reparent_register(struct clk *clks, int nr,
-				struct clk_div_mult_table *table)
+				struct clk_div4_table *table)
 {
 	return sh_clk_div4_register_ops(clks, nr, table,
 					&sh_clk_div4_reparent_clk_ops);
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-02-19 16:39:04.000000000 +0900
@@ -107,13 +107,17 @@ struct clk *main_clks[] = {
 static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
 static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
 	.nr_divisors = ARRAY_SIZE(divisors),
 	.multipliers = multipliers,
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
        DIV4_SIUA, DIV4_SIUB, DIV4_NR };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-02-19 16:38:42.000000000 +0900
@@ -110,13 +110,17 @@ struct clk *main_clks[] = {
 static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
 static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
 	.nr_divisors = ARRAY_SIZE(divisors),
 	.multipliers = multipliers,
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
        DIV4_SIUA, DIV4_SIUB, DIV4_NR };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-02-19 16:38:05.000000000 +0900
@@ -110,13 +110,17 @@ struct clk *main_clks[] = {
 static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
 static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
 	.nr_divisors = ARRAY_SIZE(divisors),
 	.multipliers = multipliers,
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 #define DIV4(_str, _reg, _bit, _mask, _flags) \
   SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-02-19 16:36:09.000000000 +0900
@@ -110,13 +110,17 @@ struct clk *main_clks[] = {
 static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
 static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
 	.nr_divisors = ARRAY_SIZE(divisors),
 	.multipliers = multipliers,
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P, DIV4_NR };
 
 #define DIV4(_str, _reg, _bit, _mask, _flags) \
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-02-19 16:41:16.000000000 +0900
@@ -129,11 +129,15 @@ struct clk *main_clks[] = {
 
 static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 0, 24, 32, 36, 48, 0, 72 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
 	.nr_divisors = ARRAY_SIZE(divisors),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_P, DIV4_M1, DIV4_NR };
 
 #define DIV4(_str, _reg, _bit, _mask, _flags) \
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-02-19 16:37:45.000000000 +0900
@@ -57,11 +57,15 @@ static struct clk *clks[] = {
 static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
 			       24, 32, 36, 48 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = div2,
 	.nr_divisors = ARRAY_SIZE(div2),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_DDR, DIV4_GA,
 	DIV4_DU, DIV4_P, DIV4_NR };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-02-19 16:37:34.000000000 +0900
@@ -59,11 +59,15 @@ static struct clk *clks[] = {
 static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
 			       24, 32, 36, 48 };
 
-static struct clk_div_mult_table div4_table = {
+static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = div2,
 	.nr_divisors = ARRAY_SIZE(div2),
 };
 
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
 enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_DDR, DIV4_DU, DIV4_P, DIV4_NR };
 
 #define DIV4(_str, _bit, _mask, _flags) \
