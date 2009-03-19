From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 10:14:41 +0000
Subject: [PATCH] sh: sh-rtc wakeup support
Message-Id: <20090319101441.9844.15289.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Flag that the SuperH RTC supports wakeup.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/rtc/rtc-sh.c |    1 +
 1 file changed, 1 insertion(+)

--- 0009/drivers/rtc/rtc-sh.c
+++ work/drivers/rtc/rtc-sh.c	2009-03-19 18:40:53.000000000 +0900
@@ -755,6 +755,7 @@ static int __devinit sh_rtc_probe(struct
 		rtc_set_time(rtc->rtc_dev, &r);
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 
 err_unmap:
