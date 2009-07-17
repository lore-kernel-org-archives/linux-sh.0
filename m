From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Jul 2009 14:52:05 +0000
Subject: [PATCH] usb: convert r8a66597-hcd to dev_pm_ops
Message-Id: <20090717145205.17771.85105.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the r8a66597-hcd driver to dev_pm_ops. This makes
the driver a good PM citizen and removes a warning printout.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on a ap325 board with sh7723 cpu using on-chip r8a66597.

 drivers/usb/host/r8a66597-hcd.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- 0001/drivers/usb/host/r8a66597-hcd.c
+++ work/drivers/usb/host/r8a66597-hcd.c	2009-07-17 23:03:50.000000000 +0900
@@ -2306,9 +2306,9 @@ static struct hc_driver r8a66597_hc_driv
 };
 
 #if defined(CONFIG_PM)
-static int r8a66597_suspend(struct platform_device *pdev, pm_message_t state)
+static int r8a66597_suspend(struct device *dev)
 {
-	struct r8a66597		*r8a66597 = dev_get_drvdata(&pdev->dev);
+	struct r8a66597		*r8a66597 = dev_get_drvdata(dev);
 	int port;
 
 	dbg("%s", __func__);
@@ -2324,9 +2324,9 @@ static int r8a66597_suspend(struct platf
 	return 0;
 }
 
-static int r8a66597_resume(struct platform_device *pdev)
+static int r8a66597_resume(struct device *dev)
 {
-	struct r8a66597		*r8a66597 = dev_get_drvdata(&pdev->dev);
+	struct r8a66597		*r8a66597 = dev_get_drvdata(dev);
 	struct usb_hcd		*hcd = r8a66597_to_hcd(r8a66597);
 
 	dbg("%s", __func__);
@@ -2336,9 +2336,15 @@ static int r8a66597_resume(struct platfo
 
 	return 0;
 }
+
+static struct dev_pm_ops r8a66597_dev_pm_ops = {
+	.suspend = r8a66597_suspend,
+	.resume = r8a66597_resume,
+};
+
+#define R8A66597_DEV_PM_OPS	(&r8a66597_dev_pm_ops)
 #else	/* if defined(CONFIG_PM) */
-#define r8a66597_suspend	NULL
-#define r8a66597_resume		NULL
+#define R8A66597_DEV_PM_OPS	NULL
 #endif
 
 static int __init_or_module r8a66597_remove(struct platform_device *pdev)
@@ -2474,11 +2480,10 @@ clean_up:
 static struct platform_driver r8a66597_driver = {
 	.probe =	r8a66597_probe,
 	.remove =	r8a66597_remove,
-	.suspend =	r8a66597_suspend,
-	.resume =	r8a66597_resume,
 	.driver		= {
 		.name = (char *) hcd_name,
 		.owner	= THIS_MODULE,
+		.pm	= R8A66597_DEV_PM_OPS,
 	},
 };
 
