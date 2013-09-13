From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 13:13:08 +0000
Subject: [PATCH 122/228] cpufreq: sh: don't initialize part of policy that is set by core too
Message-Id: <b7aefeb7f7e756d9608039d58a11ab907096e6e6.1379063063.git.viresh.kumar@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index c681b86..387af12 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -111,8 +111,6 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return PTR_ERR(cpuclk);
 	}
 
-	policy->cur = sh_cpufreq_get(cpu);
-
 	freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
 	if (freq_table) {
 		int result;
-- 
1.7.12.rc2.18.g61b472e

