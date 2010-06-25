From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 07:19:39 +0000
Subject: [PATCH] sh: remove bogus highest / lowest logic from clock rate
Message-Id: <Pine.LNX.4.64.1006250918150.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The use of highest and lowest in clk_rate_table_round() is completely bogus
and superfluous. Remove it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/sh/clk.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 5d84ada..691f829 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -73,22 +73,14 @@ long clk_rate_table_round(struct clk *clk,
 {
 	unsigned long rate_error, rate_error_prev = ~0UL;
 	unsigned long rate_best_fit = rate;
-	unsigned long highest, lowest;
 	int i;
 
-	highest = lowest = 0;
-
 	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		unsigned long freq = freq_table[i].frequency;
 
 		if (freq = CPUFREQ_ENTRY_INVALID)
 			continue;
 
-		if (freq > highest)
-			highest = freq;
-		if (freq < lowest)
-			lowest = freq;
-
 		rate_error = abs(freq - rate);
 		if (rate_error < rate_error_prev) {
 			rate_best_fit = freq;
@@ -99,11 +91,6 @@ long clk_rate_table_round(struct clk *clk,
 			break;
 	}
 
-	if (rate >= highest)
-		rate_best_fit = highest;
-	if (rate <= lowest)
-		rate_best_fit = lowest;
-
 	return rate_best_fit;
 }
 
-- 
1.6.2.4

