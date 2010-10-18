From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Oct 2010 03:50:29 +0000
Subject: [PATCH 1/2] sh: clkfwk: modify for_each_frequency end condition
Message-Id: <w3p4ockupkq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The end condition of for_each_frequency should care about
both clk_rate_table_round and clk_rate_div_range_round,
and using "correct max size" is a natural idea in later function.
To avoid data over flow, this patch didn't modify
clk_rate_div_range_round side as .max = div_max + 1.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/sh/clk.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index c76f972..dae64ee 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -82,7 +82,7 @@ struct clk_rate_round_data {
 
 #define for_each_frequency(pos, r, freq)			\
 	for (pos = r->min, freq = r->func(pos, r);		\
-	     pos < r->max; pos++, freq = r->func(pos, r))	\
+	     pos <= r->max; pos++, freq = r->func(pos, r))	\
 		if (unlikely(freq = 0))			\
 			;					\
 		else
@@ -139,12 +139,15 @@ long clk_rate_table_round(struct clk *clk,
 {
 	struct clk_rate_round_data table_round = {
 		.min	= 0,
-		.max	= clk->nr_freqs,
+		.max	= clk->nr_freqs - 1,
 		.func	= clk_rate_table_iter,
 		.arg	= freq_table,
 		.rate	= rate,
 	};
 
+	if (clk->nr_freqs < 1)
+		return 0;
+
 	return clk_rate_round_helper(&table_round);
 }
 
-- 
1.7.0.4

