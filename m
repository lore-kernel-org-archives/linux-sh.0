From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 08 Aug 2013 13:54:27 +0000
Subject: [PATCH 31/35] cpufreq: sh: use cpufreq_table_validate_and_show()
Message-Id: <59aad752560cd39629fa415382ba0fb0e4541ac6.1375964117.git.viresh.kumar@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index ffc6d24..1362e88 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -120,9 +120,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (freq_table) {
 		int result;
 
-		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
-			cpufreq_frequency_table_get_attr(freq_table, cpu);
+		result = cpufreq_table_validate_and_show(policy, freq_table);
+		if (result)
+			return result;
 	} else {
 		dev_notice(dev, "no frequency table found, falling back "
 			   "to rate rounding.\n");
-- 
1.7.12.rc2.18.g61b472e

