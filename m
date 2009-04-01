From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:39:20 +0000
Subject: [PATCH] sh_keysc: use enable/disable_irq_wake()
Message-Id: <20090401143920.32738.82373.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Modify the sh_keysc driver to use enable/disable_irq_wake()
during suspend and resume. These functions are used to enable
the sh_keysc interrupt in the interrupt controller so the
keypad can be used to wakeup the system from suspend.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested with wakeup disabled and enabled on a Migo-R board.

 drivers/input/keyboard/sh_keysc.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2009-04-01 22:55:59.000000000 +0900
@@ -259,12 +259,15 @@ static int sh_keysc_suspend(struct devic
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
 	unsigned short value;
 
 	value = ioread16(priv->iomem_base + KYCR1_OFFS);
 
-	if (device_may_wakeup(dev))
+	if (device_may_wakeup(dev)) {
 		value |= 0x80;
+		enable_irq_wake(irq);
+	}
 	else
 		value &= ~0x80;
 
@@ -272,8 +275,20 @@ static int sh_keysc_suspend(struct devic
 	return 0;
 }
 
+static int sh_keysc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq = platform_get_irq(pdev, 0);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(irq);
+
+	return 0;
+}
+
 static struct dev_pm_ops sh_keysc_dev_pm_ops = {
 	.suspend = sh_keysc_suspend,
+	.resume = sh_keysc_resume,
 };
 
 struct platform_driver sh_keysc_device_driver = {
