From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 19 Apr 2018 06:06:35 +0000
Subject: [PATCH] sh: time: Remove the read_persistent_clock()
Message-Id: <c52709fe323b56916b3f621dac1baf6d49225188.1524117883.git.baolin.wang@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The read_persistent_clock() uses a timespec, which is not year 2038 safe
on 32bit systems. Moreover on sh platform, we have RTC drivers that can
be used to compensate the system suspend time. Thus we can remove the
read_persistent_clock() safely.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/sh/kernel/time.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41..326004c 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -37,11 +37,6 @@ static int null_rtc_set_time(const time_t secs)
 void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
 int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
 
-void read_persistent_clock(struct timespec *ts)
-{
-	rtc_sh_get_time(ts);
-}
-
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
 int update_persistent_clock(struct timespec now)
 {
-- 
1.7.9.5

