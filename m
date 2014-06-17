From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:59 +0000
Subject: [PATCH 6/8] r8a66597-udc: use devm_clk_get() to get clock
Message-Id: <1403018101-11062-7-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Change to using the devm_clk_get() to get the clock and
have it automatically freed on exit.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 9ebe2c0..51eaedd 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1831,7 +1831,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		clk_disable_unprepare(r8a66597->clk);
-		clk_put(r8a66597->clk);
 	}
 
 	return 0;
@@ -1903,11 +1902,10 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
-		r8a66597->clk = clk_get(dev, clk_name);
+		r8a66597->clk = devm_clk_get(dev, clk_name);
 		if (IS_ERR(r8a66597->clk)) {
 			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
-			ret = PTR_ERR(r8a66597->clk);
-			goto clean_up;
+			return PTR_ERR(r8a66597->clk);
 		}
 		clk_prepare_enable(r8a66597->clk);
 	}
@@ -1973,10 +1971,8 @@ err_add_udc:
 clean_up3:
 	free_irq(irq, r8a66597);
 clean_up2:
-	if (r8a66597->pdata->on_chip) {
+	if (r8a66597->pdata->on_chip)
 		clk_disable_unprepare(r8a66597->clk);
-		clk_put(r8a66597->clk);
-	}
 clean_up:
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-- 
2.0.0

