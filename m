From: Stratos Karafotis <stratosk@semaphore.gr>
Date: Mon, 14 Apr 2014 21:10:07 +0000
Subject: [PATCH 13/20] sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
Message-Id: <534C4EAF.6050307@semaphore.gr>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

The cpufreq core supports the cpufreq_for_each_valid_entry macro
helper for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/sh/clk/core.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index 7472785..e9d3a13 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -196,16 +196,11 @@ int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate)
 {
-	int i;
-
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = freq_table[i].frequency;
-
-		if (freq = CPUFREQ_ENTRY_INVALID)
-			continue;
+	struct cpufreq_frequency_table *pos;
 
-		if (freq = rate)
-			return i;
+	cpufreq_for_each_valid_entry(pos, freq_table) {
+		if (pos->frequency = rate)
+			return pos - freq_table;
 	}
 
 	return -ENOENT;
@@ -575,11 +570,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 		return abs(target - *best_freq);
 	}
 
-	for (freq = parent->freq_table; freq->frequency != CPUFREQ_TABLE_END;
-	     freq++) {
-		if (freq->frequency = CPUFREQ_ENTRY_INVALID)
-			continue;
-
+	cpufreq_for_each_valid_entry(freq, parent->freq_table) {
 		if (unlikely(freq->frequency / target <= div_min - 1)) {
 			unsigned long freq_max;
 
-- 
1.9.0
