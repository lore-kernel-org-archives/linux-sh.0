From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 May 2009 08:10:36 +0000
Subject: [PATCH 03/04] sh: use shared frequency tables on sh7785
Message-Id: <20090525081036.7893.45142.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch converts the sh7785 clock code to make use
of clk_rate_table_build() and clk_rate_table_round().
The ->build_rate_table() callback is removed, the
table building is instead handled in ->recalc().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 For the clkfwk topic branch.

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   77 ++++----------------------------
 1 file changed, 12 insertions(+), 65 deletions(-)

--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-25 16:20:54.000000000 +0900
@@ -19,6 +19,12 @@
 
 static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
 			       24, 32, 36, 48 };
+
+static struct clk_div_mult_table cpg_div = {
+	.divisors = div2,
+	.nr_divisors = ARRAY_SIZE(div2),
+};
+
 struct clk_priv {
 	unsigned int			shift;
 
@@ -52,82 +58,23 @@ FRQMR_CLK_DATA(ifc, 28, 0x000e);
 static unsigned long frqmr_recalc(struct clk *clk)
 {
 	struct clk_priv *data = clk->priv;
-	unsigned int idx;
-
-	idx = (__raw_readl(FRQMR1) >> data->shift) & 0x000f;
-
-	return clk->parent->rate / div2[idx];
-}
-
-static void frqmr_build_rate_table(struct clk *clk)
-{
-	struct clk_priv *data = clk->priv;
-	int i, entry;
+	unsigned int idx = (__raw_readl(FRQMR1) >> data->shift) & 0x000f;
 
-	for (i = entry = 0; i < ARRAY_SIZE(div2); i++) {
-		if ((data->div_bitmap & (1 << i)) = 0)
-			continue;
-
-		data->freq_table[entry].index = entry;
-		data->freq_table[entry].frequency -			clk->parent->rate / div2[i];
-
-		entry++;
-	}
-
-	if (entry = 0) {
-		pr_warning("clkfwk: failed to build frequency table "
-			   "for \"%s\" clk!\n", clk->name);
-		return;
-	}
-
-	/* Termination entry */
-	data->freq_table[entry].index = entry;
-	data->freq_table[entry].frequency = CPUFREQ_TABLE_END;
+	clk_rate_table_build(clk, data->freq_table, ARRAY_SIZE(div2),
+			     &cpg_div, &data->div_bitmap);
+	
+	return data->freq_table[idx].frequency;
 }
 
 static long frqmr_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk_priv *data = clk->priv;
-	unsigned long rate_error, rate_error_prev = ~0UL;
-	unsigned long rate_best_fit = rate;
-	unsigned long highest, lowest;
-	int i;
-
-	highest = lowest = 0;
-
-	for (i = 0; data->freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = data->freq_table[i].frequency;
-
-		if (freq = CPUFREQ_ENTRY_INVALID)
-			continue;
-
-		if (freq > highest)
-			highest = freq;
-		if (freq < lowest)
-			lowest = freq;
-
-		rate_error = abs(freq - rate);
-		if (rate_error < rate_error_prev) {
-			rate_best_fit = freq;
-			rate_error_prev = rate_error;
-		}
-
-		if (rate_error = 0)
-			break;
-	}
-
-	if (rate >= highest)
-		rate_best_fit = highest;
-	if (rate <= lowest)
-		rate_best_fit = lowest;
 
-	return rate_best_fit;
+	return clk_rate_table_round(clk, data->freq_table, rate);
 }
 
 static struct clk_ops frqmr_clk_ops = {
 	.recalc			= frqmr_recalc,
-	.build_rate_table	= frqmr_build_rate_table,
 	.round_rate		= frqmr_round_rate,
 };
 
