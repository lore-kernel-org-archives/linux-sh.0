From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 May 2009 08:10:28 +0000
Subject: [PATCH 02/04] sh: add shared clock framework frequency table code
Message-Id: <20090525081028.7893.20643.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add SuperH-specific clock framework helper functions:
- clk_rate_table_build() - build cpufreq table from divisors/multipliers
- clk_rate_table_round() - use cpufreq table to find matching frequency

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 For the clkfwk topic branch.

 arch/sh/include/asm/clock.h |   18 ++++++++++
 arch/sh/kernel/cpu/clock.c  |   75 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-25 16:12:20.000000000 +0900
@@ -100,4 +100,22 @@ enum clk_sh_algo_id {
 	IP_N1,
 };
 
+struct clk_div_mult_table {
+	unsigned int *divisors;
+	unsigned int nr_divisors;
+	unsigned int *multipliers;
+	unsigned int nr_multipliers;
+};
+
+struct cpufreq_frequency_table;
+void clk_rate_table_build(struct clk *clk,
+			  struct cpufreq_frequency_table *freq_table,
+			  int nr_freqs,
+			  struct clk_div_mult_table *src_table,
+			  unsigned long *bitmap);
+
+long clk_rate_table_round(struct clk *clk,
+			  struct cpufreq_frequency_table *freq_table,
+			  unsigned long rate);
+
 #endif /* __ASM_SH_CLOCK_H */
--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-05-25 16:12:20.000000000 +0900
@@ -29,6 +29,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/debugfs.h>
+#include <linux/cpufreq.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 
@@ -36,6 +37,80 @@ static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
 static DEFINE_MUTEX(clock_list_sem);
 
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
 /* Used for clocks that always have same value as the parent clock */
 unsigned long followparent_recalc(struct clk *clk)
 {
