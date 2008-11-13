From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Nov 2008 06:46:37 +0000
Subject: [PATCH] usb: m66592 and r8a66597 resource changes
Message-Id: <20081113064637.5215.76176.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use the more common platform_get_resource() together with index instead
of depending on the resource name and platform_get_resource_by_name().
Replace the resource_len() implementation with resource_size().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/usb/gadget/m66592-udc.c |    9 +++------
 drivers/usb/host/r8a66597-hcd.c |    8 +++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

--- 0001/drivers/usb/gadget/m66592-udc.c
+++ work/drivers/usb/gadget/m66592-udc.c	2008-11-13 13:43:49.000000000 +0900
@@ -1548,8 +1548,6 @@ static void nop_completion(struct usb_ep
 {
 }
 
-#define resource_len(r) (((r)->end - (r)->start) + 1)
-
 static int __init m66592_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1559,11 +1557,10 @@ static int __init m66592_probe(struct pl
 	int ret = 0;
 	int i;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			(char *)udc_name);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
-		pr_err("platform_get_resource_byname error.\n");
+		pr_err("platform_get_resource error.\n");
 		goto clean_up;
 	}
 
@@ -1574,7 +1571,7 @@ static int __init m66592_probe(struct pl
 		goto clean_up;
 	}
 
-	reg = ioremap(res->start, resource_len(res));
+	reg = ioremap(res->start, resource_size(res));
 	if (reg = NULL) {
 		ret = -ENOMEM;
 		pr_err("ioremap error.\n");
--- 0001/drivers/usb/host/r8a66597-hcd.c
+++ work/drivers/usb/host/r8a66597-hcd.c	2008-11-13 13:43:03.000000000 +0900
@@ -2264,7 +2264,6 @@ static int __init_or_module r8a66597_rem
 	return 0;
 }
 
-#define resource_len(r) (((r)->end - (r)->start) + 1)
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
 	struct resource *res = NULL, *ires;
@@ -2282,11 +2281,10 @@ static int __init r8a66597_probe(struct 
 		goto clean_up;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   (char *)hcd_name);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
-		dev_err(&pdev->dev, "platform_get_resource_byname error.\n");
+		dev_err(&pdev->dev, "platform_get_resource error.\n");
 		goto clean_up;
 	}
 
@@ -2301,7 +2299,7 @@ static int __init r8a66597_probe(struct 
 	irq = ires->start;
 	irq_trigger = ires->flags & IRQF_TRIGGER_MASK;
 
-	reg = ioremap(res->start, resource_len(res));
+	reg = ioremap(res->start, resource_size(res));
 	if (reg = NULL) {
 		ret = -ENOMEM;
 		dev_err(&pdev->dev, "ioremap error.\n");
