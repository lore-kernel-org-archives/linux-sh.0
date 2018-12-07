From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 13:48:22 +0000
Subject: [PATCH 6/8] timekeeping: remove timespec_add/timespec_del
Message-Id: <20181207134824.300024-7-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>

The last users were removed a while ago since everyone moved to ktime_t,
so we can remove the two unused interfaces for old timespec structures.

With those two gone, set_normalized_timespec() is also unused, so
remove that as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time32.h | 25 -------------------------
 kernel/time/time.c     | 36 ------------------------------------
 2 files changed, 61 deletions(-)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index 61904a6c098f..118b9977080c 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -96,31 +96,6 @@ static inline int timespec_compare(const struct timespec *lhs, const struct time
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
-extern void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec);
-
-static inline struct timespec timespec_add(struct timespec lhs,
-						struct timespec rhs)
-{
-	struct timespec ts_delta;
-
-	set_normalized_timespec(&ts_delta, lhs.tv_sec + rhs.tv_sec,
-				lhs.tv_nsec + rhs.tv_nsec);
-	return ts_delta;
-}
-
-/*
- * sub = lhs - rhs, in normalized form
- */
-static inline struct timespec timespec_sub(struct timespec lhs,
-						struct timespec rhs)
-{
-	struct timespec ts_delta;
-
-	set_normalized_timespec(&ts_delta, lhs.tv_sec - rhs.tv_sec,
-				lhs.tv_nsec - rhs.tv_nsec);
-	return ts_delta;
-}
-
 /*
  * Returns true if the timespec is norm, false if denorm:
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ad204cf6d001..532bb560252d 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -386,42 +386,6 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-/**
- * set_normalized_timespec - set timespec sec and nsec parts and normalize
- *
- * @ts:		pointer to timespec variable to be set
- * @sec:	seconds to set
- * @nsec:	nanoseconds to set
- *
- * Set seconds and nanoseconds field of a timespec variable and
- * normalize to the timespec storage format
- *
- * Note: The tv_nsec part is always in the range of
- *	0 <= tv_nsec < NSEC_PER_SEC
- * For negative values only the tv_sec field is negative !
- */
-void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec)
-{
-	while (nsec >= NSEC_PER_SEC) {
-		/*
-		 * The following asm() prevents the compiler from
-		 * optimising this loop into a modulo operation. See
-		 * also __iter_div_u64_rem() in include/linux/time.h
-		 */
-		asm("" : "+rm"(nsec));
-		nsec -= NSEC_PER_SEC;
-		++sec;
-	}
-	while (nsec < 0) {
-		asm("" : "+rm"(nsec));
-		nsec += NSEC_PER_SEC;
-		--sec;
-	}
-	ts->tv_sec = sec;
-	ts->tv_nsec = nsec;
-}
-EXPORT_SYMBOL(set_normalized_timespec);
-
 /**
  * ns_to_timespec - Convert nanoseconds to timespec
  * @nsec:       the nanoseconds value to be converted
-- 
2.18.0
