From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:45:17 +0000
Subject: [PATCH] sh_rtc: use set_irq_wake()
Message-Id: <20090401144517.336.60634.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Modify the sh_rtc driver to use set_irq_wake() during suspend
and resume. These functions are used to enable the rtc interrupts
in the interrupt controller so the rtc can be used to wakeup the
system from suspend.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/rtc/rtc-sh.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- 0001/drivers/rtc/rtc-sh.c
+++ work/drivers/rtc/rtc-sh.c	2009-04-01 22:57:15.000000000 +0900
@@ -795,10 +795,46 @@ static int __devexit sh_rtc_remove(struc
 
 	return 0;
 }
+
+static void sh_rtc_set_irq_wake(struct device *dev, int enabled)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_rtc *rtc = platform_get_drvdata(pdev);
+
+	set_irq_wake(rtc->periodic_irq, enabled);
+	if (rtc->carry_irq > 0) {
+		set_irq_wake(rtc->carry_irq, enabled);
+		set_irq_wake(rtc->alarm_irq, enabled);
+	}
+
+}
+
+static int sh_rtc_suspend(struct device *dev)
+{
+	if (device_may_wakeup(dev))
+		sh_rtc_set_irq_wake(dev, 1);
+
+	return 0;
+}
+
+static int sh_rtc_resume(struct device *dev)
+{
+	if (device_may_wakeup(dev))
+		sh_rtc_set_irq_wake(dev, 0);
+
+	return 0;
+}
+
+static struct dev_pm_ops sh_rtc_dev_pm_ops = {
+	.suspend = sh_rtc_suspend,
+	.resume = sh_rtc_resume,
+};
+
 static struct platform_driver sh_rtc_platform_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.pm	= &sh_rtc_dev_pm_ops,
 	},
 	.probe		= sh_rtc_probe,
 	.remove		= __devexit_p(sh_rtc_remove),
