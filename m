From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 10:05:58 +0000
Subject: [PATCH] sh: sh-rtc carry interrupt rework
Message-Id: <20090319100558.9820.49100.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the SuperH RTC driver to only
enable carry interrupts when needed. So by default
no interrupts are enabled with this patch. Without
this patch a suspending system will most likely
wake up by the carry interrupt regardless if the
alarm interrupt has been enabled or not.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on sh7723/ap320 hardware.

 drivers/rtc/rtc-sh.c |   40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

--- 0001/drivers/rtc/rtc-sh.c
+++ work/drivers/rtc/rtc-sh.c	2009-03-19 18:29:29.000000000 +0900
@@ -319,6 +319,25 @@ static int sh_rtc_proc(struct device *de
 	return 0;
 }
 
+static inline void sh_rtc_setcie(struct device *dev, unsigned int enable)
+{
+	struct sh_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int tmp;
+
+	spin_lock_irq(&rtc->lock);
+
+	tmp = readb(rtc->regbase + RCR1);
+
+	if (!enable)
+		tmp &= ~RCR1_CIE;
+	else
+		tmp |= RCR1_CIE;
+
+	writeb(tmp, rtc->regbase + RCR1);
+
+	spin_unlock_irq(&rtc->lock);
+}
+
 static int sh_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct sh_rtc *rtc = dev_get_drvdata(dev);
@@ -335,9 +354,11 @@ static int sh_rtc_ioctl(struct device *d
 		break;
 	case RTC_UIE_OFF:
 		rtc->periodic_freq &= ~PF_OXS;
+		sh_rtc_setcie(dev, 0);
 		break;
 	case RTC_UIE_ON:
 		rtc->periodic_freq |= PF_OXS;
+		sh_rtc_setcie(dev, 1);
 		break;
 	case RTC_IRQP_READ:
 		ret = put_user(rtc->rtc_dev->irq_freq,
@@ -400,6 +421,10 @@ static int sh_rtc_read_time(struct devic
 		tm->tm_sec--;
 #endif
 
+	/* only keep the carry interrupt enabled if UIE is on */
+	if (!(rtc->periodic_freq & PF_OXS))
+		sh_rtc_setcie(dev, 0);
+
 	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
@@ -616,7 +641,6 @@ static int __devinit sh_rtc_probe(struct
 {
 	struct sh_rtc *rtc;
 	struct resource *res;
-	unsigned int tmp;
 	int ret;
 
 	rtc = kzalloc(sizeof(struct sh_rtc), GFP_KERNEL);
@@ -676,8 +700,6 @@ static int __devinit sh_rtc_probe(struct
 	}
 
 	rtc->rtc_dev->max_user_freq = 256;
-	rtc->rtc_dev->irq_freq = 1;
-	rtc->periodic_freq = 0x60;
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -724,11 +746,12 @@ static int __devinit sh_rtc_probe(struct
 		}
 	}
 
-	tmp = readb(rtc->regbase + RCR1);
-	tmp &= ~RCR1_CF;
-	tmp |= RCR1_CIE;
-	writeb(tmp, rtc->regbase + RCR1);
-
+	/* everything disabled by default */
+	rtc->periodic_freq = 0;
+	rtc->rtc_dev->irq_freq = 0;
+	sh_rtc_setpie(&pdev->dev, 0);
+	sh_rtc_setaie(&pdev->dev, 0);
+	sh_rtc_setcie(&pdev->dev, 0);
 	return 0;
 
 err_unmap:
@@ -750,6 +773,7 @@ static int __devexit sh_rtc_remove(struc
 
 	sh_rtc_setpie(&pdev->dev, 0);
 	sh_rtc_setaie(&pdev->dev, 0);
+	sh_rtc_setcie(&pdev->dev, 0);
 
 	free_irq(rtc->periodic_irq, rtc);
 	if (rtc->carry_irq > 0) {
