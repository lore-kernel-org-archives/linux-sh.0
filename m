From: Stratos Karafotis <stratosk@semaphore.gr>
Date: Tue, 15 Apr 2014 22:27:04 +0000
Subject: [PATCH v2 8/8] sh: clk: Use cpufreq_for_each_valid_entry macro for iteration
Message-Id: <534DB238.5030201@semaphore.gr>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

The cpufreq core now supports the cpufreq_for_each_valid_entry macro
helper for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/sh/clk/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index 7472785..be56b22 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -196,17 +196,11 @@ int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate)
 {
-	int i;
-
-	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		unsigned long freq = freq_table[i].frequency;
+	struct cpufreq_frequency_table *pos;
 
-		if (freq = CPUFREQ_ENTRY_INVALID)
-			continue;
-
-		if (freq = rate)
-			return i;
-	}
+	cpufreq_for_each_valid_entry(pos, freq_table)
+		if (pos->frequency = rate)
+			return pos - freq_table;
 
 	return -ENOENT;
 }
@@ -575,11 +569,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
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
