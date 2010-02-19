From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 09:26:56 +0000
Subject: [PATCH] sh: add sh7724 kick callback to clk_div4_table
Message-Id: <20100219092656.638.74788.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a ->kick() callback to clk_div4_table
and ties it into sh_clk_div4_set_rate(). A sh7724
specific kick function is also added that updates the
KICK bit whenever div4 clocks in FRQCRA and FRQCRB
have been set. Allows us to set the VPU clock.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |    1 +
 arch/sh/kernel/cpu/clock-cpg.c         |    4 ++++
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   11 +++++++++++
 3 files changed, 16 insertions(+)

--- 0003/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-02-19 16:45:09.000000000 +0900
@@ -148,6 +148,7 @@ int sh_clk_mstp32_register(struct clk *c
 
 struct clk_div4_table {
 	struct clk_div_mult_table *div_mult_table;
+	void (*kick)(struct clk *clk);
 };
 
 int sh_clk_div4_register(struct clk *clks, int nr,
--- 0003/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-02-19 16:46:17.000000000 +0900
@@ -188,6 +188,7 @@ static int sh_clk_div4_set_parent(struct
 
 static int sh_clk_div4_set_rate(struct clk *clk, unsigned long rate, int algo_id)
 {
+	struct clk_div4_table *d4t = clk->priv;
 	unsigned long value;
 	int idx = clk_rate_table_find(clk, clk->freq_table, rate);
 	if (idx < 0)
@@ -198,6 +199,9 @@ static int sh_clk_div4_set_rate(struct c
 	value |= (idx << clk->enable_bit);
 	__raw_writel(value, clk->enable_reg);
 
+	if (d4t->kick)
+		d4t->kick(clk);
+
 	return 0;
 }
 
--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-02-19 16:51:22.000000000 +0900
@@ -127,6 +127,16 @@ struct clk *main_clks[] = {
 	&div3_clk,
 };
 
+static void div4_kick(struct clk *clk)
+{
+	unsigned long value;
+
+	/* set KICK bit in FRQCRA to update hardware setting */
+	value = __raw_readl(FRQCRA);
+	value |= (1 << 31);
+	__raw_writel(value, FRQCRA);
+}
+
 static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 0, 24, 32, 36, 48, 0, 72 };
 
 static struct clk_div_mult_table div4_div_mult_table = {
@@ -136,6 +146,7 @@ static struct clk_div_mult_table div4_di
 
 static struct clk_div4_table div4_table = {
 	.div_mult_table = &div4_div_mult_table,
+	.kick = div4_kick,
 };
 
 enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_P, DIV4_M1, DIV4_NR };
