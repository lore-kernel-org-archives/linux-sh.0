From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:27:43 +0000
Subject: [PATCH 07/10] sh: clkfwk: add clk_rate_multi_range_round()
Message-Id: <87hb4mqack.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some Clock Pulse Generator has PLL multiplication.
clk_rate_multi_range_round() will be good helper for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/sh/clk/core.c  |   20 ++++++++++++++++++++
 include/linux/sh_clk.h |    3 +++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index dc8d022..f4323a3 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -173,6 +173,26 @@ long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
 	return clk_rate_round_helper(&div_range_round);
 }
 
+static long clk_rate_multi_range_iter(unsigned int pos,
+				      struct clk_rate_round_data *rounder)
+{
+	return clk_get_rate(rounder->arg) * pos;
+}
+
+long clk_rate_multi_range_round(struct clk *clk, unsigned int div_min,
+				unsigned int div_max, unsigned long rate)
+{
+	struct clk_rate_round_data div_range_round = {
+		.min	= div_min,
+		.max	= div_max,
+		.func	= clk_rate_multi_range_iter,
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
index 3ccf186..1fc9f28 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -94,6 +94,9 @@ int clk_rate_table_find(struct clk *clk,
 long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
 			      unsigned int div_max, unsigned long rate);
 
+long clk_rate_multi_range_round(struct clk *clk, unsigned int div_min,
+				unsigned int div_max, unsigned long rate);
+
 long clk_round_parent(struct clk *clk, unsigned long target,
 		      unsigned long *best_freq, unsigned long *parent_freq,
 		      unsigned int div_min, unsigned int div_max);
-- 
1.7.4.1

