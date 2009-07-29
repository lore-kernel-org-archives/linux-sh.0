From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 29 Jul 2009 09:24:41 +0000
Subject: Re: [PATCH] usb: convert r8a66597-hcd to dev_pm_ops
Message-Id: <4A701559.5080605@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090717145205.17771.85105.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090717145205.17771.85105.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Convert the r8a66597-hcd driver to dev_pm_ops. This makes
> the driver a good PM citizen and removes a warning printout.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Tested on a ap325 board with sh7723 cpu using on-chip r8a66597.

When I checked this patch on sh7785lcr board, I looked a little problem.
The problem is that usb device cannot re-enumerate when resume from hibernation.
I made the new patch.

Thanks,
Yoshihiro Shimoda

---

Convert the r8a66597-hcd driver to dev_pm_ops. This makes
the driver a good PM citizen and removes warning printout.

Singed-off-by: Magnus Damm <damm@igel.co.jp>
Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/usb/host/r8a66597-hcd.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index e18f749..dc61f5d 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2305,9 +2305,9 @@ static struct hc_driver r8a66597_hc_driver = {
 };

 #if defined(CONFIG_PM)
-static int r8a66597_suspend(struct platform_device *pdev, pm_message_t state)
+static int r8a66597_suspend(struct device *dev)
 {
-	struct r8a66597		*r8a66597 = dev_get_drvdata(&pdev->dev);
+	struct r8a66597		*r8a66597 = dev_get_drvdata(dev);
 	int port;

 	dbg("%s", __func__);
@@ -2323,9 +2323,9 @@ static int r8a66597_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }

-static int r8a66597_resume(struct platform_device *pdev)
+static int r8a66597_resume(struct device *dev)
 {
-	struct r8a66597		*r8a66597 = dev_get_drvdata(&pdev->dev);
+	struct r8a66597		*r8a66597 = dev_get_drvdata(dev);
 	struct usb_hcd		*hcd = r8a66597_to_hcd(r8a66597);

 	dbg("%s", __func__);
@@ -2335,9 +2335,17 @@ static int r8a66597_resume(struct platform_device *pdev)

 	return 0;
 }
+
+static struct dev_pm_ops r8a66597_dev_pm_ops = {
+	.suspend = r8a66597_suspend,
+	.resume = r8a66597_resume,
+	.poweroff = r8a66597_suspend,
+	.restore = r8a66597_resume,
+};
+
+#define R8A66597_DEV_PM_OPS	(&r8a66597_dev_pm_ops)
 #else	/* if defined(CONFIG_PM) */
-#define r8a66597_suspend	NULL
-#define r8a66597_resume		NULL
+#define R8A66597_DEV_PM_OPS	NULL
 #endif

 static int __init_or_module r8a66597_remove(struct platform_device *pdev)
@@ -2473,11 +2481,10 @@ clean_up:
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

--
1.5.5

