From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:32:07 +0000
Subject: [PATCH 2/2] drivers: sh: clk: Remove obsolete and unused clk_round_parent()
Message-Id: <1447957927-32738-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-clk@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

clk_round_parent() was only ever used by AP4EVB, until commit
b24bd7e97b3784af ("ARM: shmobile: Remove AP4EVB board support").

The Common Clock Framework does not provide clk_round_parent(), hence
remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/sh/clk/core.c  | 88 --------------------------------------------------
 include/linux/sh_clk.h |  4 ---
 2 files changed, 92 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index c9afc5681474..92863e3818e5 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -567,94 +567,6 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
-long clk_round_parent(struct clk *clk, unsigned long target,
-		      unsigned long *best_freq, unsigned long *parent_freq,
-		      unsigned int div_min, unsigned int div_max)
-{
-	struct cpufreq_frequency_table *freq, *best = NULL;
-	unsigned long error = ULONG_MAX, freq_high, freq_low, div;
-	struct clk *parent = clk_get_parent(clk);
-
-	if (!parent) {
-		*parent_freq = 0;
-		*best_freq = clk_round_rate(clk, target);
-		return abs(target - *best_freq);
-	}
-
-	cpufreq_for_each_valid_entry(freq, parent->freq_table) {
-		if (unlikely(freq->frequency / target <= div_min - 1)) {
-			unsigned long freq_max;
-
-			freq_max = (freq->frequency + div_min / 2) / div_min;
-			if (error > target - freq_max) {
-				error = target - freq_max;
-				best = freq;
-				if (best_freq)
-					*best_freq = freq_max;
-			}
-
-			pr_debug("too low freq %u, error %lu\n", freq->frequency,
-				 target - freq_max);
-
-			if (!error)
-				break;
-
-			continue;
-		}
-
-		if (unlikely(freq->frequency / target >= div_max)) {
-			unsigned long freq_min;
-
-			freq_min = (freq->frequency + div_max / 2) / div_max;
-			if (error > freq_min - target) {
-				error = freq_min - target;
-				best = freq;
-				if (best_freq)
-					*best_freq = freq_min;
-			}
-
-			pr_debug("too high freq %u, error %lu\n", freq->frequency,
-				 freq_min - target);
-
-			if (!error)
-				break;
-
-			continue;
-		}
-
-		div = freq->frequency / target;
-		freq_high = freq->frequency / div;
-		freq_low = freq->frequency / (div + 1);
-
-		if (freq_high - target < error) {
-			error = freq_high - target;
-			best = freq;
-			if (best_freq)
-				*best_freq = freq_high;
-		}
-
-		if (target - freq_low < error) {
-			error = target - freq_low;
-			best = freq;
-			if (best_freq)
-				*best_freq = freq_low;
-		}
-
-		pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
-			 freq->frequency, div, freq_high, div + 1, freq_low,
-			 *best_freq, best->frequency);
-
-		if (!error)
-			break;
-	}
-
-	if (parent_freq)
-		*parent_freq = best->frequency;
-
-	return error;
-}
-EXPORT_SYMBOL_GPL(clk_round_parent);
-
 #ifdef CONFIG_PM
 static void clks_core_resume(void)
 {
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 1f208b2a1ed6..645896b81244 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -113,10 +113,6 @@ long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
 long clk_rate_mult_range_round(struct clk *clk, unsigned int mult_min,
 			       unsigned int mult_max, unsigned long rate);
 
-long clk_round_parent(struct clk *clk, unsigned long target,
-		      unsigned long *best_freq, unsigned long *parent_freq,
-		      unsigned int div_min, unsigned int div_max);
-
 #define SH_CLK_MSTP(_parent, _enable_reg, _enable_bit, _status_reg, _flags) \
 {									\
 	.parent		= _parent,					\
-- 
1.9.1

