From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 13:11:03 +0000
Subject: [PATCH] sh-rtc: Add Single IRQ Support
Message-Id: <20090224131103.11645.85047.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add support for single IRQ hardware to the sh-rtc driver.

This is useful for processors with limited interrupt masking
support such as sh7750 and sh7780. With this patch in place we
can add logic to the intc code that merges all RTC vectors into
a single linux interrupt with proper masking/unmasking support.

Specify a single IRQ in the platform data to use this new shared
IRQ feature. Separate Periodic/Carry/Alarm IRQs are still supported.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/rtc/rtc-sh.c |  190 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 117 insertions(+), 73 deletions(-)

--- 0001/drivers/rtc/rtc-sh.c
+++ work/drivers/rtc/rtc-sh.c	2009-02-24 21:40:48.000000000 +0900
@@ -99,56 +99,51 @@ struct sh_rtc {
 	unsigned short periodic_freq;
 };
 
-static irqreturn_t sh_rtc_interrupt(int irq, void *dev_id)
+static int __sh_rtc_interrupt(struct sh_rtc *rtc)
 {
-	struct sh_rtc *rtc = dev_id;
-	unsigned int tmp;
-
-	spin_lock(&rtc->lock);
+	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR1);
+	pending = tmp & RCR1_CF;
 	tmp &= ~RCR1_CF;
 	writeb(tmp, rtc->regbase + RCR1);
 
 	/* Users have requested One x Second IRQ */
-	if (rtc->periodic_freq & PF_OXS)
+	if (pending && rtc->periodic_freq & PF_OXS)
 		rtc_update_irq(rtc->rtc_dev, 1, RTC_UF | RTC_IRQF);
 
-	spin_unlock(&rtc->lock);
-
-	return IRQ_HANDLED;
+	return pending;
 }
 
-static irqreturn_t sh_rtc_alarm(int irq, void *dev_id)
+static int __sh_rtc_alarm(struct sh_rtc *rtc)
 {
-	struct sh_rtc *rtc = dev_id;
-	unsigned int tmp;
-
-	spin_lock(&rtc->lock);
+	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR1);
+	pending = tmp & RCR1_AF;
 	tmp &= ~(RCR1_AF | RCR1_AIE);
-		writeb(tmp, rtc->regbase + RCR1);
-
-	rtc_update_irq(rtc->rtc_dev, 1, RTC_AF | RTC_IRQF);
+	writeb(tmp, rtc->regbase + RCR1);
 
-	spin_unlock(&rtc->lock);
+	if (pending)
+		rtc_update_irq(rtc->rtc_dev, 1, RTC_AF | RTC_IRQF);
 
-	return IRQ_HANDLED;
+	return pending;
 }
 
-static irqreturn_t sh_rtc_periodic(int irq, void *dev_id)
+static int __sh_rtc_periodic(struct sh_rtc *rtc)
 {
-	struct sh_rtc *rtc = dev_id;
 	struct rtc_device *rtc_dev = rtc->rtc_dev;
-	unsigned int tmp;
-
-	spin_lock(&rtc->lock);
+	struct rtc_task *irq_task;
+	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR2);
+	pending = tmp & RCR2_PEF;
 	tmp &= ~RCR2_PEF;
 	writeb(tmp, rtc->regbase + RCR2);
 
+	if (!pending)
+		return 0;
+
 	/* Half period enabled than one skipped and the next notified */
 	if ((rtc->periodic_freq & PF_HP) && (rtc->periodic_freq & PF_COUNT))
 		rtc->periodic_freq &= ~PF_COUNT;
@@ -157,16 +152,65 @@ static irqreturn_t sh_rtc_periodic(int i
 			rtc->periodic_freq |= PF_COUNT;
 		if (rtc->periodic_freq & PF_KOU) {
 			spin_lock(&rtc_dev->irq_task_lock);
-			if (rtc_dev->irq_task)
-				rtc_dev->irq_task->func(rtc_dev->irq_task->private_data);
+			irq_task = rtc_dev->irq_task;
+			if (irq_task)
+				irq_task->func(irq_task->private_data);
 			spin_unlock(&rtc_dev->irq_task_lock);
 		} else
 			rtc_update_irq(rtc->rtc_dev, 1, RTC_PF | RTC_IRQF);
 	}
 
+	return pending;
+}
+
+static irqreturn_t sh_rtc_interrupt(int irq, void *dev_id)
+{
+	struct sh_rtc *rtc = dev_id;
+	int ret;
+
+	spin_lock(&rtc->lock);
+	ret = __sh_rtc_interrupt(rtc);
+	spin_unlock(&rtc->lock);
+
+	return IRQ_RETVAL(ret);
+}
+
+static irqreturn_t sh_rtc_alarm(int irq, void *dev_id)
+{
+	struct sh_rtc *rtc = dev_id;
+	int ret;
+
+	spin_lock(&rtc->lock);
+	ret = __sh_rtc_alarm(rtc);
+	spin_unlock(&rtc->lock);
+
+	return IRQ_RETVAL(ret);
+}
+
+static irqreturn_t sh_rtc_periodic(int irq, void *dev_id)
+{
+	struct sh_rtc *rtc = dev_id;
+	int ret;
+
+	spin_lock(&rtc->lock);
+	ret = __sh_rtc_periodic(rtc);
 	spin_unlock(&rtc->lock);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(ret);
+}
+
+static irqreturn_t sh_rtc_shared(int irq, void *dev_id)
+{
+	struct sh_rtc *rtc = dev_id;
+	int ret;
+
+	spin_lock(&rtc->lock);
+	ret = __sh_rtc_interrupt(rtc);
+	ret |= __sh_rtc_alarm(rtc);
+	ret |= __sh_rtc_periodic(rtc);
+	spin_unlock(&rtc->lock);
+
+	return IRQ_RETVAL(ret);
 }
 
 static inline void sh_rtc_setpie(struct device *dev, unsigned int enable)
@@ -585,26 +629,12 @@ static int __devinit sh_rtc_probe(struct
 	ret = platform_get_irq(pdev, 0);
 	if (unlikely(ret <= 0)) {
 		ret = -ENOENT;
-		dev_err(&pdev->dev, "No IRQ for period\n");
+		dev_err(&pdev->dev, "No IRQ resource\n");
 		goto err_badres;
 	}
 	rtc->periodic_irq = ret;
-
-	ret = platform_get_irq(pdev, 1);
-	if (unlikely(ret <= 0)) {
-		ret = -ENOENT;
-		dev_err(&pdev->dev, "No IRQ for carry\n");
-		goto err_badres;
-	}
-	rtc->carry_irq = ret;
-
-	ret = platform_get_irq(pdev, 2);
-	if (unlikely(ret <= 0)) {
-		ret = -ENOENT;
-		dev_err(&pdev->dev, "No IRQ for alarm\n");
-		goto err_badres;
-	}
-	rtc->alarm_irq = ret;
+	rtc->carry_irq = platform_get_irq(pdev, 1);
+	rtc->alarm_irq = platform_get_irq(pdev, 2);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (unlikely(res = NULL)) {
@@ -651,35 +681,47 @@ static int __devinit sh_rtc_probe(struct
 
 	platform_set_drvdata(pdev, rtc);
 
-	/* register periodic/carry/alarm irqs */
-	ret = request_irq(rtc->periodic_irq, sh_rtc_periodic, IRQF_DISABLED,
-			  "sh-rtc period", rtc);
-	if (unlikely(ret)) {
-		dev_err(&pdev->dev,
-			"request period IRQ failed with %d, IRQ %d\n", ret,
-			rtc->periodic_irq);
-		goto err_unmap;
-	}
+	if (rtc->carry_irq <= 0) {
+		/* register shared periodic/carry/alarm irq */
+		ret = request_irq(rtc->periodic_irq, sh_rtc_shared,
+				  IRQF_DISABLED, "sh-rtc", rtc);
+		if (unlikely(ret)) {
+			dev_err(&pdev->dev,
+				"request IRQ failed with %d, IRQ %d\n", ret,
+				rtc->periodic_irq);
+			goto err_unmap;
+		}
+	} else {
+		/* register periodic/carry/alarm irqs */
+		ret = request_irq(rtc->periodic_irq, sh_rtc_periodic,
+				  IRQF_DISABLED, "sh-rtc period", rtc);
+		if (unlikely(ret)) {
+			dev_err(&pdev->dev,
+				"request period IRQ failed with %d, IRQ %d\n",
+				ret, rtc->periodic_irq);
+			goto err_unmap;
+		}
 
-	ret = request_irq(rtc->carry_irq, sh_rtc_interrupt, IRQF_DISABLED,
-			  "sh-rtc carry", rtc);
-	if (unlikely(ret)) {
-		dev_err(&pdev->dev,
-			"request carry IRQ failed with %d, IRQ %d\n", ret,
-			rtc->carry_irq);
-		free_irq(rtc->periodic_irq, rtc);
-		goto err_unmap;
-	}
+		ret = request_irq(rtc->carry_irq, sh_rtc_interrupt,
+				  IRQF_DISABLED, "sh-rtc carry", rtc);
+		if (unlikely(ret)) {
+			dev_err(&pdev->dev,
+				"request carry IRQ failed with %d, IRQ %d\n",
+				ret, rtc->carry_irq);
+			free_irq(rtc->periodic_irq, rtc);
+			goto err_unmap;
+		}
 
-	ret = request_irq(rtc->alarm_irq, sh_rtc_alarm, IRQF_DISABLED,
-			  "sh-rtc alarm", rtc);
-	if (unlikely(ret)) {
-		dev_err(&pdev->dev,
-			"request alarm IRQ failed with %d, IRQ %d\n", ret,
-			rtc->alarm_irq);
-		free_irq(rtc->carry_irq, rtc);
-		free_irq(rtc->periodic_irq, rtc);
-		goto err_unmap;
+		ret = request_irq(rtc->alarm_irq, sh_rtc_alarm,
+				  IRQF_DISABLED, "sh-rtc alarm", rtc);
+		if (unlikely(ret)) {
+			dev_err(&pdev->dev,
+				"request alarm IRQ failed with %d, IRQ %d\n",
+				ret, rtc->alarm_irq);
+			free_irq(rtc->carry_irq, rtc);
+			free_irq(rtc->periodic_irq, rtc);
+			goto err_unmap;
+		}
 	}
 
 	tmp = readb(rtc->regbase + RCR1);
@@ -709,9 +751,11 @@ static int __devexit sh_rtc_remove(struc
 	sh_rtc_setpie(&pdev->dev, 0);
 	sh_rtc_setaie(&pdev->dev, 0);
 
-	free_irq(rtc->carry_irq, rtc);
 	free_irq(rtc->periodic_irq, rtc);
-	free_irq(rtc->alarm_irq, rtc);
+	if (rtc->carry_irq > 0) {
+		free_irq(rtc->carry_irq, rtc);
+		free_irq(rtc->alarm_irq, rtc);
+	}
 
 	release_resource(rtc->res);
 
