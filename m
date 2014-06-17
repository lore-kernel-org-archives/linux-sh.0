From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:58 +0000
Subject: [PATCH 5/8] r8a66597-udc: cleanup error path
Message-Id: <1403018101-11062-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

With the updates for devm, the cleanup path no longer needs to
check for NULL device state, so remove it and return directly
if the irq resource missing

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 2662853..9ebe2c0 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1878,9 +1878,8 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	irq_trigger = ires->flags & IRQF_TRIGGER_MASK;
 
 	if (irq < 0) {
-		ret = -ENODEV;
 		dev_err(dev, "platform_get_irq error.\n");
-		goto clean_up;
+		return -ENODEV;
 	}
 
 	/* initialize ucd */
@@ -1979,11 +1978,8 @@ clean_up2:
 		clk_put(r8a66597->clk);
 	}
 clean_up:
-	if (r8a66597) {
-		if (r8a66597->ep0_req)
-			r8a66597_free_request(&r8a66597->ep[0].ep,
-						r8a66597->ep0_req);
-	}
+	if (r8a66597->ep0_req)
+		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
 	return ret;
 }
-- 
2.0.0

