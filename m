From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 17 Jun 2014 15:14:56 +0000
Subject: [PATCH 3/8] r8a66597-udc: use devm_kzalloc() to allocate driver state
Message-Id: <1403018101-11062-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Update driver to use devm_kzalloc() to make tracking of resources
easier. Also remove the exit point via cleanup as there's no
cleanup necessary from this point now.

As a note, also removes the error print as the allocation calls
produce errors if they do not return memory.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/gadget/r8a66597-udc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 1721e44..48a9e0b 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1836,7 +1836,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 		clk_put(r8a66597->clk);
 	}
 
-	kfree(r8a66597);
 	return 0;
 }
 
@@ -1892,12 +1891,9 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	}
 
 	/* initialize ucd */
-	r8a66597 = kzalloc(sizeof(struct r8a66597), GFP_KERNEL);
-	if (r8a66597 = NULL) {
-		ret = -ENOMEM;
-		dev_err(dev, "kzalloc error\n");
-		goto clean_up;
-	}
+	r8a66597 = devm_kzalloc(dev, sizeof(struct r8a66597), GFP_KERNEL);
+	if (r8a66597 = NULL)
+		return -ENOMEM;
 
 	spin_lock_init(&r8a66597->lock);
 	platform_set_drvdata(pdev, r8a66597);
@@ -1996,7 +1992,6 @@ clean_up:
 		if (r8a66597->ep0_req)
 			r8a66597_free_request(&r8a66597->ep[0].ep,
 						r8a66597->ep0_req);
-		kfree(r8a66597);
 	}
 
 	return ret;
-- 
2.0.0

