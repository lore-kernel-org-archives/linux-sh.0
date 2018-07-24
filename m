From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jul 2018 21:36:23 +0000
Subject: [PATCH v2 3/4] sh: remove unused rtc_sh_get/set_time infrastructure
Message-Id: <20180724213624.3899336-3-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180724213624.3899336-1-arnd@arndb.de>
In-Reply-To: <20180724213624.3899336-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dalias@libc.org
Cc: ysato@users.sourceforge.jp, baolin.wang@linaro.org, y2038@lists.linaro.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

All platforms are now converted to RTC drivers, so this has become
obsolete. The board_time_init() callback still has one caller, but
could otherwise also get killed.

This removes one more usage of the deprecated timespec structure,
which overflows in y2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/rtc.h |  2 --
 arch/sh/kernel/time.c     | 69 ---------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index c63555ee1255..fe55fbb181aa 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -4,8 +4,6 @@
 
 void time_init(void);
 extern void (*board_time_init)(void);
-extern void (*rtc_sh_get_time)(struct timespec *);
-extern int (*rtc_sh_set_time)(const time_t);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41977d1..eb0a91270499 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,75 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-/* Dummy RTC ops */
-static void null_rtc_get_time(struct timespec *tv)
-{
-	tv->tv_sec = mktime(2000, 1, 1, 0, 0, 0);
-	tv->tv_nsec = 0;
-}
-
-static int null_rtc_set_time(const time_t secs)
-{
-	return 0;
-}
-
-void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
-int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
-
-void read_persistent_clock(struct timespec *ts)
-{
-	rtc_sh_get_time(ts);
-}
-
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_sh_set_time(now.tv_sec);
-}
-#endif
-
-static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	struct timespec tv;
-
-	rtc_sh_get_time(&tv);
-	rtc_time_to_tm(tv.tv_sec, tm);
-	return 0;
-}
-
-static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned long secs;
-
-	rtc_tm_to_time(tm, &secs);
-	if ((rtc_sh_set_time = null_rtc_set_time) ||
-	    (rtc_sh_set_time(secs) < 0))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops rtc_generic_ops = {
-	.read_time = rtc_generic_get_time,
-	.set_time = rtc_generic_set_time,
-};
-
-static int __init rtc_generic_init(void)
-{
-	struct platform_device *pdev;
-
-	if (rtc_sh_get_time = null_rtc_get_time)
-		return -ENODEV;
-
-	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
-					     &rtc_generic_ops,
-					     sizeof(rtc_generic_ops));
-
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(rtc_generic_init);
-
 void (*board_time_init)(void);
 
 static void __init sh_late_time_init(void)
-- 
2.18.0

