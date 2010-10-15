From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 09:39:23 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101015093922.GC7489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 15, 2010 at 03:42:55PM +0900, Kuninori Morimoto wrote:
> > Is there some particular reason why you can't just construct a rate table
> > for FSIDIV instead? sh_clk_div6_register_ops() in drivers/sh/clk-cpg.c is
> > an example of how to set it up. It's provided generically in the struct
> > clk largely for these sorts of cases.
> 
> Sorry I didn't explain for detail.
> The reason is treq table size.
> 
> FSIDIV dividing frequency bit is 16.
> And struct cpufreq_frequency_table size is 8byte.
> 
> So, the table size will be 8 x 65535 = 512K byte if FSIDIV have it.
> (ex) div6 case is 8 x 64 = 512 byte
>      div4 case is 8 x 16 = 128 byte
> 
> I thought 512K byte is too big for kernel.
> 
Ok, that's certainly a valid reason. As we'll presumably see more of
these in the future, how about something like this?

---

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 813d97c..018be37 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -45,6 +45,8 @@ void clk_rate_table_build(struct clk *clk,
 	unsigned long freq;
 	int i;
 
+	clk->nr_freqs = nr_freqs;
+
 	for (i = 0; i < nr_freqs; i++) {
 		div = 1;
 		mult = 1;
@@ -69,30 +71,39 @@ void clk_rate_table_build(struct clk *clk,
 	freq_table[i].frequency = CPUFREQ_TABLE_END;
 }
 
-long clk_rate_table_round(struct clk *clk,
-			  struct cpufreq_frequency_table *freq_table,
-			  unsigned long rate)
+struct clk_rate_round_data;
+
+struct clk_rate_round_data {
+	unsigned long rate;
+	unsigned int min, max;
+	long (*func)(unsigned int, struct clk_rate_round_data *);
+	void *arg;
+};
+
+#define for_each_frequency(pos, r, freq)			\
+	for (pos = r->min, freq = r->func(pos, r->arg);		\
+	     pos < r->max; pos++, freq = r->func(pos, r))	\
+		if (unlikely(freq = 0))			\
+			;					\
+		else
+
+static long clk_rate_round_helper(struct clk_rate_round_data *rounder)
 {
 	unsigned long rate_error, rate_error_prev = ~0UL;
-	unsigned long rate_best_fit = rate;
-	unsigned long highest, lowest;
+	unsigned long rate_best_fit = rounder->rate;
+	unsigned long highest, lowest, freq;
 	int i;
 
 	highest = 0;
 	lowest = ~0UL;
 
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = freq_table[i].frequency;
-
-		if (freq = CPUFREQ_ENTRY_INVALID)
-			continue;
-
+	for_each_frequency(i, rounder, freq) {
 		if (freq > highest)
 			highest = freq;
 		if (freq < lowest)
 			lowest = freq;
 
-		rate_error = abs(freq - rate);
+		rate_error = abs(freq - rounder->rate);
 		if (rate_error < rate_error_prev) {
 			rate_best_fit = freq;
 			rate_error_prev = rate_error;
@@ -102,14 +113,61 @@ long clk_rate_table_round(struct clk *clk,
 			break;
 	}
 
-	if (rate >= highest)
+	if (rounder->rate >= highest)
 		rate_best_fit = highest;
-	if (rate <= lowest)
+	if (rounder->rate <= lowest)
 		rate_best_fit = lowest;
 
 	return rate_best_fit;
 }
 
+static long clk_rate_table_iter(unsigned int pos,
+				struct clk_rate_round_data *rounder)
+{
+	struct cpufreq_frequency_table *freq_table = rounder->arg;
+	unsigned long freq = freq_table[pos].frequency;
+
+	if (freq = CPUFREQ_ENTRY_INVALID)
+		freq = 0;
+
+	return freq;
+}
+
+long clk_rate_table_round(struct clk *clk,
+			  struct cpufreq_frequency_table *freq_table,
+			  unsigned long rate)
+{
+	struct clk_rate_round_data table_round = {
+		.min	= 0,
+		.max	= clk->nr_freqs,
+		.func	= clk_rate_table_iter,
+		.arg	= freq_table,
+		.rate	= rate,
+	};
+
+	return clk_rate_round_helper(&table_round);
+}
+
+static long clk_rate_div_range_iter(unsigned int pos,
+				    struct clk_rate_round_data *rounder)
+{
+	return clk_get_rate(rounder->arg) / pos;
+}
+
+long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
+			      unsigned int div_max, unsigned long rate)
+{
+	struct clk_rate_round_data div_range_round = {
+		.min	= div_min,
+		.max	= div_max,
+		.func	= clk_rate_div_range_iter,
+		.arg	= clk_get_parent(clk),
+		.rate	= rate,
+	};
+
+	return clk_rate_round_helper(&div_range_round);
+}
+
 int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate)
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 8ae3770..4dca992 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -53,6 +53,7 @@ struct clk {
 	struct dentry		*dentry;
 	struct clk_mapping	*mapping;
 	struct cpufreq_frequency_table *freq_table;
+	unsigned int		nr_freqs;
 };
 
 #define CLK_ENABLE_ON_INIT	(1 << 0)
@@ -118,6 +119,9 @@ int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate);
 
+long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
+			      unsigned int div_max, unsigned long rate);
+
 #define SH_CLK_MSTP32(_parent, _enable_reg, _enable_bit, _flags)	\
 {									\
 	.parent		= _parent,					\
