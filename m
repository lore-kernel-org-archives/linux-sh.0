From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:15:00 +0000
Subject: [PATCH 7/8] r8a66597-udc: use devm_request_irq() to get device irq
Message-Id: <1403018101-11062-8-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the devm_request_irq() call to get the interrupt for the
device and have it automatically free on exit.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 51eaedd..8414ba5 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1826,7 +1826,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
-	free_irq(platform_get_irq(pdev, 0), r8a66597);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
 	if (r8a66597->pdata->on_chip) {
@@ -1918,8 +1917,8 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 
 	disable_controller(r8a66597); /* make sure controller is disabled */
 
-	ret = request_irq(irq, r8a66597_irq, IRQF_SHARED,
-			udc_name, r8a66597);
+	ret = devm_request_irq(dev, irq, r8a66597_irq, IRQF_SHARED,
+			       udc_name, r8a66597);
 	if (ret < 0) {
 		dev_err(dev, "request_irq error (%d)\n", ret);
 		goto clean_up2;
@@ -1969,7 +1968,6 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 clean_up3:
-	free_irq(irq, r8a66597);
 clean_up2:
 	if (r8a66597->pdata->on_chip)
 		clk_disable_unprepare(r8a66597->clk);
-- 
2.0.0

