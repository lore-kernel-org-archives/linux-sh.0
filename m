From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:54 +0000
Subject: [PATCH 1/8] r8a66597-udc: use devm_request_and_ioremap() for registers
Message-Id: <1403018101-11062-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

---
 drivers/usb/gadget/r8a66597-udc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index aff0a67..7f3af74 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1826,7 +1826,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
-	iounmap(r8a66597->reg);
 	if (r8a66597->pdata->sudmac)
 		iounmap(r8a66597->sudmac_reg);
 	free_irq(platform_get_irq(pdev, 0), r8a66597);
@@ -1877,11 +1876,9 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	unsigned long irq_trigger;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		dev_err(&pdev->dev, "platform_get_resource error.\n");
-		goto clean_up;
-	}
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (!reg)
+		return -ENODEV;
 
 	ires = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	irq = ires->start;
@@ -1893,13 +1890,6 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 		goto clean_up;
 	}
 
-	reg = ioremap(res->start, resource_size(res));
-	if (reg = NULL) {
-		ret = -ENOMEM;
-		dev_err(&pdev->dev, "ioremap error.\n");
-		goto clean_up;
-	}
-
 	/* initialize ucd */
 	r8a66597 = kzalloc(sizeof(struct r8a66597), GFP_KERNEL);
 	if (r8a66597 = NULL) {
@@ -2008,8 +1998,6 @@ clean_up:
 						r8a66597->ep0_req);
 		kfree(r8a66597);
 	}
-	if (reg)
-		iounmap(reg);
 
 	return ret;
 }
-- 
2.0.0

