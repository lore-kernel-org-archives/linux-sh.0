From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 13:48:21 +0000
Subject: [PATCH 5/8] timekeeping: remove unused {read,update}_persistent_clock
Message-Id: <20181207134824.300024-6-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>

After arch/sh has removed the last reference to these functions,
we can remove them completely and just rely on the 64-bit time_t
based versions. This cleans up a rather ugly use of __weak
functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping32.h |  6 ------
 kernel/time/ntp.c             | 10 +---------
 kernel/time/timekeeping.c     | 12 ++----------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index a502616f7e1c..0036ff314ac5 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -52,10 +52,4 @@ static inline void getboottime(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-/*
- * Persistent clock related interfaces
- */
-extern void read_persistent_clock(struct timespec *ts);
-extern int update_persistent_clock(struct timespec now);
-
 #endif
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index c5e0cba3b39c..e23be418d015 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -555,17 +555,9 @@ static void sync_rtc_clock(void)
 }
 
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
-int __weak update_persistent_clock(struct timespec now)
-{
-	return -ENODEV;
-}
-
 int __weak update_persistent_clock64(struct timespec64 now64)
 {
-	struct timespec now;
-
-	now = timespec64_to_timespec(now64);
-	return update_persistent_clock(now);
+	return -ENODEV;
 }
 #endif
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2d110c948805..eb09be4871b3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1467,7 +1467,7 @@ u64 timekeeping_max_deferment(void)
 }
 
 /**
- * read_persistent_clock -  Return time from the persistent clock.
+ * read_persistent_clock64 -  Return time from the persistent clock.
  *
  * Weak dummy function for arches that do not yet support it.
  * Reads the time from the battery backed persistent clock.
@@ -1475,20 +1475,12 @@ u64 timekeeping_max_deferment(void)
  *
  *  XXX - Do be sure to remove it once all arches implement it.
  */
-void __weak read_persistent_clock(struct timespec *ts)
+void __weak read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
 }
 
-void __weak read_persistent_clock64(struct timespec64 *ts64)
-{
-	struct timespec ts;
-
-	read_persistent_clock(&ts);
-	*ts64 = timespec_to_timespec64(ts);
-}
-
 /**
  * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
  *                                        from the boot.
-- 
2.18.0
