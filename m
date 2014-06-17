From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:55 +0000
Subject: [PATCH 2/8] r8a66597-udc: keep dev as reference to &pdev->dev
Message-Id: <1403018101-11062-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove usages of &pdev->dev in the driver probe function
with just dev to make the references to it easier to
write. Convert all the current users of it to use it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 7f3af74..1721e44 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1866,6 +1866,7 @@ static int __init r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
 
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	char clk_name[8];
 	struct resource *res, *ires;
 	int irq;
@@ -1886,7 +1887,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 
 	if (irq < 0) {
 		ret = -ENODEV;
-		dev_err(&pdev->dev, "platform_get_irq error.\n");
+		dev_err(dev, "platform_get_irq error.\n");
 		goto clean_up;
 	}
 
@@ -1894,13 +1895,13 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597 = kzalloc(sizeof(struct r8a66597), GFP_KERNEL);
 	if (r8a66597 = NULL) {
 		ret = -ENOMEM;
-		dev_err(&pdev->dev, "kzalloc error\n");
+		dev_err(dev, "kzalloc error\n");
 		goto clean_up;
 	}
 
 	spin_lock_init(&r8a66597->lock);
 	platform_set_drvdata(pdev, r8a66597);
-	r8a66597->pdata = dev_get_platdata(&pdev->dev);
+	r8a66597->pdata = dev_get_platdata(dev);
 	r8a66597->irq_sense_low = irq_trigger = IRQF_TRIGGER_LOW;
 
 	r8a66597->gadget.ops = &r8a66597_gadget_ops;
@@ -1914,10 +1915,9 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = clk_get(&pdev->dev, clk_name);
+		r8a66597->clk = clk_get(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
-			dev_err(&pdev->dev, "cannot get clock \"%s\"\n",
-				clk_name);
+			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
 			ret = PTR_ERR(r8a66597->clk);
 			goto clean_up;
 		}
@@ -1935,7 +1935,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	ret = request_irq(irq, r8a66597_irq, IRQF_SHARED,
 			udc_name, r8a66597);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq error (%d)\n", ret);
+		dev_err(dev, "request_irq error (%d)\n", ret);
 		goto clean_up2;
 	}
 
@@ -1973,11 +1973,11 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
-	ret = usb_add_gadget_udc(&pdev->dev, &r8a66597->gadget);
+	ret = usb_add_gadget_udc(dev, &r8a66597->gadget);
 	if (ret)
 		goto err_add_udc;
 
-	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
+	dev_info(dev, "version %s\n", DRIVER_VERSION);
 	return 0;
 
 err_add_udc:
-- 
2.0.0

