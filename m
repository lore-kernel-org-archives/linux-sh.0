From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 10:10:44 +0000
Subject: [PATCH] sh:  sh-rtc invalid time rework
Message-Id: <20090319101044.9839.71473.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies invalid time handling in the
SuperH RTC driver. Instead of zeroing the returned
value at read-out time we just return an error code
and reset invalid values during probe.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/rtc/rtc-sh.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- 0008/drivers/rtc/rtc-sh.c
+++ work/drivers/rtc/rtc-sh.c	2009-03-19 18:39:23.000000000 +0900
@@ -431,12 +431,7 @@ static int sh_rtc_read_time(struct devic
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon + 1, tm->tm_year, tm->tm_wday);
 
-	if (rtc_valid_tm(tm) < 0) {
-		dev_err(dev, "invalid date\n");
-		rtc_time_to_tm(0, tm);
-	}
-
-	return 0;
+	return rtc_valid_tm(tm);
 }
 
 static int sh_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -641,6 +636,7 @@ static int __devinit sh_rtc_probe(struct
 {
 	struct sh_rtc *rtc;
 	struct resource *res;
+	struct rtc_time r;
 	int ret;
 
 	rtc = kzalloc(sizeof(struct sh_rtc), GFP_KERNEL);
@@ -752,6 +748,13 @@ static int __devinit sh_rtc_probe(struct
 	sh_rtc_setpie(&pdev->dev, 0);
 	sh_rtc_setaie(&pdev->dev, 0);
 	sh_rtc_setcie(&pdev->dev, 0);
+
+	/* reset rtc to epoch 0 if time is invalid */
+	if (rtc_read_time(rtc->rtc_dev, &r) < 0) {
+		rtc_time_to_tm(0, &r);
+		rtc_set_time(rtc->rtc_dev, &r);
+	}
+
 	return 0;
 
 err_unmap:
