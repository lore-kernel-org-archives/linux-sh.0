From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:15:01 +0000
Subject: [PATCH 8/8] r8a66597-udc: remove now unused clean_up and clean_up3 label.
Message-Id: <1403018101-11062-9-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

With the devm additions, the clean_up and clean_up3 are now
not needed or used. Change clean_up3 and make everything use
clean_up2 and just remove clean_up.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 8414ba5..6ad6028 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1954,7 +1954,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 							GFP_KERNEL);
 	if (r8a66597->ep0_req = NULL) {
 		ret = -ENOMEM;
-		goto clean_up3;
+		goto clean_up2;
 	}
 	r8a66597->ep0_req->complete = nop_completion;
 
@@ -1967,11 +1967,10 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-clean_up3:
 clean_up2:
 	if (r8a66597->pdata->on_chip)
 		clk_disable_unprepare(r8a66597->clk);
-clean_up:
+
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
-- 
2.0.0

