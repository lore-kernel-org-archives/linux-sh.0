From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 May 2009 08:10:19 +0000
Subject: [PATCH 01/04] sh: add pll_clk to sh7785
Message-Id: <20090525081019.7893.81544.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch converts the sh7785 pll implementation from the
all-in-one code in frqmr_recalc() and frqmr_build_rate_table()
to a separate struct clk. This allows us to remove the processor
specific multiplier and use generic rate table functions.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 For the clkfwk topic branch.

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   48 ++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-25 16:09:17.000000000 +0900
@@ -56,12 +56,7 @@ static unsigned long frqmr_recalc(struct
 
 	idx = (__raw_readl(FRQMR1) >> data->shift) & 0x000f;
 
-	/*
-	 * XXX: PLL1 multiplier is locked for the default clock mode,
-	 * when mode pin detection and configuration support is added,
-	 * select the multiplier dynamically.
-	 */
-	return clk->parent->rate * 36 / div2[idx];
+	return clk->parent->rate / div2[idx];
 }
 
 static void frqmr_build_rate_table(struct clk *clk)
@@ -75,7 +70,7 @@ static void frqmr_build_rate_table(struc
 
 		data->freq_table[entry].index = entry;
 		data->freq_table[entry].frequency -			clk->parent->rate * 36 / div2[i];
+			clk->parent->rate / div2[i];
 
 		entry++;
 	}
@@ -136,6 +131,20 @@ static struct clk_ops frqmr_clk_ops = {
 	.round_rate		= frqmr_round_rate,
 };
 
+static unsigned long pll_recalc(struct clk *clk)
+{
+	/*
+	 * XXX: PLL1 multiplier is locked for the default clock mode,
+	 * when mode pin detection and configuration support is added,
+	 * select the multiplier dynamically.
+	 */
+	return clk->parent->rate * 36;
+}
+
+static struct clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
+};
+
 /*
  * Default rate for the root input clock, reset this with clk_set_rate()
  * from the platform code.
@@ -146,11 +155,19 @@ static struct clk extal_clk = {
 	.rate		= 33333333,
 };
 
+static struct clk pll_clk = {
+	.name		= "pll_clk",
+	.id		= -1,
+	.ops		= &pll_clk_ops,
+	.parent		= &extal_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
 static struct clk cpu_clk = {
 	.name		= "cpu_clk",		/* Ick */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &ifc_data,
 };
@@ -159,7 +176,7 @@ static struct clk shyway_clk = {
 	.name		= "shyway_clk",		/* SHck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &sfc_data,
 };
@@ -168,7 +185,7 @@ static struct clk peripheral_clk = {
 	.name		= "peripheral_clk",	/* Pck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &pfc_data,
 };
@@ -177,7 +194,7 @@ static struct clk ddr_clk = {
 	.name		= "ddr_clk",		/* DDRck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &mfc_data,
 };
@@ -186,7 +203,7 @@ static struct clk bus_clk = {
 	.name		= "bus_clk",		/* Bck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &bfc_data,
 };
@@ -195,7 +212,7 @@ static struct clk ga_clk = {
 	.name		= "ga_clk",		/* GAck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.priv		= &s2fc_data,
 };
 
@@ -203,7 +220,7 @@ static struct clk du_clk = {
 	.name		= "du_clk",		/* DUck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.priv		= &s3fc_data,
 };
 
@@ -211,13 +228,14 @@ static struct clk umem_clk = {
 	.name		= "umem_clk",		/* uck */
 	.id		= -1,
 	.ops		= &frqmr_clk_ops,
-	.parent		= &extal_clk,
+	.parent		= &pll_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.priv		= &ufc_data,
 };
 
 static struct clk *clks[] = {
 	&extal_clk,
+	&pll_clk,
 	&cpu_clk,
 	&shyway_clk,
 	&peripheral_clk,
