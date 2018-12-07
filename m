From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 13:48:24 +0000
Subject: [PATCH 8/8] timekeeping: remove obsolete time accessors
Message-Id: <20181207134824.300024-9-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>

There are no more remaining users of these deprecated wrappers, so
let's remove them before new users have a chance to make it in.

See Documentation/core-api/timekeeping.rst for replacements when
porting old drivers that contain calls to this function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h   | 14 --------------
 include/linux/timekeeping32.h |  9 ---------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 29975e93fcb8..a8ab0f143ac4 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -262,18 +262,4 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 					  struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
-/*
- * deprecated aliases, don't use in new code
- */
-#define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
-
-static inline struct timespec64 current_kernel_time64(void)
-{
-	struct timespec64 ts;
-
-	ktime_get_coarse_real_ts64(&ts);
-
-	return ts;
-}
-
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 0036ff314ac5..cc59cc9e0e84 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -6,15 +6,6 @@
  * over time so we can remove the file here.
  */
 
-static inline void do_gettimeofday(struct timeval *tv)
-{
-	struct timespec64 now;
-
-	ktime_get_real_ts64(&now);
-	tv->tv_sec = now.tv_sec;
-	tv->tv_usec = now.tv_nsec/1000;
-}
-
 static inline unsigned long get_seconds(void)
 {
 	return ktime_get_real_seconds();
-- 
2.18.0
