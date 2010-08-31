From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 31 Aug 2010 10:09:28 +0000
Subject: [PATCH] sh/shmobile: move clk-cpg related functions from clc.c to clk-cpg.c
Message-Id: <1283249368-28857-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

move clk_rate_table_build, clk_rate_table_round and clk_rate_table_find
from clc.c to clk-cpg.c as there are only for CPG clock support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/sh/clk-cpg.c |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/sh/clk.c     |   94 -------------------------------------------------
 2 files changed, 95 insertions(+), 94 deletions(-)

diff --git a/drivers/sh/clk-cpg.c b/drivers/sh/clk-cpg.c
index 8c024b9..54886a0 100644
--- a/drivers/sh/clk-cpg.c
+++ b/drivers/sh/clk-cpg.c
@@ -2,8 +2,103 @@
 #include <linux/compiler.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
 #include <linux/sh_clk.h>
 
+void clk_rate_table_build(struct clk *clk,
+			  struct cpufreq_frequency_table *freq_table,
+			  int nr_freqs,
+			  struct clk_div_mult_table *src_table,
+			  unsigned long *bitmap)
+{
+	unsigned long mult, div;
+	unsigned long freq;
+	int i;
+
+	for (i = 0; i < nr_freqs; i++) {
+		div = 1;
+		mult = 1;
+
+		if (src_table->divisors && i < src_table->nr_divisors)
+			div = src_table->divisors[i];
+
+		if (src_table->multipliers && i < src_table->nr_multipliers)
+			mult = src_table->multipliers[i];
+
+		if (!div || !mult || (bitmap && !test_bit(i, bitmap)))
+			freq = CPUFREQ_ENTRY_INVALID;
+		else
+			freq = clk->parent->rate * mult / div;
+
+		freq_table[i].index = i;
+		freq_table[i].frequency = freq;
+	}
+
+	/* Termination entry */
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+}
+
+long clk_rate_table_round(struct clk *clk,
+			  struct cpufreq_frequency_table *freq_table,
+			  unsigned long rate)
+{
+	unsigned long rate_error, rate_error_prev = ~0UL;
+	unsigned long rate_best_fit = rate;
+	unsigned long highest, lowest;
+	int i;
+
+	highest = lowest = 0;
+
+	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		unsigned long freq = freq_table[i].frequency;
+
+		if (freq = CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		if (freq > highest)
+			highest = freq;
+		if (freq < lowest)
+			lowest = freq;
+
+		rate_error = abs(freq - rate);
+		if (rate_error < rate_error_prev) {
+			rate_best_fit = freq;
+			rate_error_prev = rate_error;
+		}
+
+		if (rate_error = 0)
+			break;
+	}
+
+	if (rate >= highest)
+		rate_best_fit = highest;
+	if (rate <= lowest)
+		rate_best_fit = lowest;
+
+	return rate_best_fit;
+}
+
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
 static int sh_clk_mstp32_enable(struct clk *clk)
 {
 	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 5d84ada..05add46 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -25,7 +25,6 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/debugfs.h>
-#include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/sh_clk.h>
 
@@ -33,99 +32,6 @@ static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
 static DEFINE_MUTEX(clock_list_sem);
 
-void clk_rate_table_build(struct clk *clk,
-			  struct cpufreq_frequency_table *freq_table,
-			  int nr_freqs,
-			  struct clk_div_mult_table *src_table,
-			  unsigned long *bitmap)
-{
-	unsigned long mult, div;
-	unsigned long freq;
-	int i;
-
-	for (i = 0; i < nr_freqs; i++) {
-		div = 1;
-		mult = 1;
-
-		if (src_table->divisors && i < src_table->nr_divisors)
-			div = src_table->divisors[i];
-
-		if (src_table->multipliers && i < src_table->nr_multipliers)
-			mult = src_table->multipliers[i];
-
-		if (!div || !mult || (bitmap && !test_bit(i, bitmap)))
-			freq = CPUFREQ_ENTRY_INVALID;
-		else
-			freq = clk->parent->rate * mult / div;
-
-		freq_table[i].index = i;
-		freq_table[i].frequency = freq;
-	}
-
-	/* Termination entry */
-	freq_table[i].index = i;
-	freq_table[i].frequency = CPUFREQ_TABLE_END;
-}
-
-long clk_rate_table_round(struct clk *clk,
-			  struct cpufreq_frequency_table *freq_table,
-			  unsigned long rate)
-{
-	unsigned long rate_error, rate_error_prev = ~0UL;
-	unsigned long rate_best_fit = rate;
-	unsigned long highest, lowest;
-	int i;
-
-	highest = lowest = 0;
-
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = freq_table[i].frequency;
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
-
-	return rate_best_fit;
-}
-
-int clk_rate_table_find(struct clk *clk,
-			struct cpufreq_frequency_table *freq_table,
-			unsigned long rate)
-{
-	int i;
-
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = freq_table[i].frequency;
-
-		if (freq = CPUFREQ_ENTRY_INVALID)
-			continue;
-
-		if (freq = rate)
-			return i;
-	}
-
-	return -ENOENT;
-}
-
 /* Used for clocks that always have same value as the parent clock */
 unsigned long followparent_recalc(struct clk *clk)
 {
-- 
1.7.1

