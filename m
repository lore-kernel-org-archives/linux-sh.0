From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:57 +0000
Subject: [PATCH 4/8] r8a66597-udc: handle sudmac registers with devm_ioremap_resource()
Message-Id: <1403018101-11062-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Change the sudmac register handling in the devm_ioremap_resource
to use the devm variant.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 48a9e0b..2662853 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1826,8 +1826,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
-	if (r8a66597->pdata->sudmac)
-		iounmap(r8a66597->sudmac_reg);
 	free_irq(platform_get_irq(pdev, 0), r8a66597);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
@@ -1849,15 +1847,10 @@ static int __init r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sudmac");
-	if (!res) {
-		dev_err(&pdev->dev, "platform_get_resource error(sudmac).\n");
-		return -ENODEV;
-	}
-
-	r8a66597->sudmac_reg = ioremap(res->start, resource_size(res));
-	if (r8a66597->sudmac_reg = NULL) {
+	r8a66597->sudmac_reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(r8a66597->sudmac_reg)) {
 		dev_err(&pdev->dev, "ioremap error(sudmac).\n");
-		return -ENOMEM;
+		return PTR_ERR(r8a66597->sudmac_reg);
 	}
 
 	return 0;
@@ -1987,8 +1980,6 @@ clean_up2:
 	}
 clean_up:
 	if (r8a66597) {
-		if (r8a66597->sudmac_reg)
-			iounmap(r8a66597->sudmac_reg);
 		if (r8a66597->ep0_req)
 			r8a66597_free_request(&r8a66597->ep[0].ep,
 						r8a66597->ep0_req);
-- 
2.0.0

