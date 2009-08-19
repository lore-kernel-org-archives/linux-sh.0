From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 09:50:49 +0000
Subject: [PATCH] usb: add clock support to r8a66597 gadget driver
Message-Id: <20090819095049.11541.67276.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add support for the clock framework to the r8a66597 gadget driver.
This is needed to control the clock driving the USB block.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/usb/gadget/r8a66597-udc.c |   37 ++++++++++++++++++++++++++++++++++---
 drivers/usb/gadget/r8a66597-udc.h |    7 +++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

--- 0002/drivers/usb/gadget/r8a66597-udc.c
+++ work/drivers/usb/gadget/r8a66597-udc.c	2009-08-19 18:29:50.000000000 +0900
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -1475,6 +1476,12 @@ static int __exit r8a66597_remove(struct
 	iounmap((void *)r8a66597->reg);
 	free_irq(platform_get_irq(pdev, 0), r8a66597);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
+#ifdef CONFIG_HAVE_CLK
+	if (r8a66597->pdata->on_chip) {
+		clk_disable(r8a66597->clk);
+		clk_put(r8a66597->clk);
+	}
+#endif
 	kfree(r8a66597);
 	return 0;
 }
@@ -1485,6 +1492,9 @@ static void nop_completion(struct usb_ep
 
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
+#ifdef CONFIG_HAVE_CLK
+	char clk_name[8];
+#endif
 	struct resource *res, *ires;
 	int irq;
 	void __iomem *reg = NULL;
@@ -1545,13 +1555,27 @@ static int __init r8a66597_probe(struct 
 
 	r8a66597->bi_bufnum = R8A66597_BASE_BUFNUM;
 
+#ifdef CONFIG_HAVE_CLK
+	if (r8a66597->pdata->on_chip) {
+		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
+		r8a66597->clk = clk_get(&pdev->dev, clk_name);
+		if (IS_ERR(r8a66597->clk)) {
+			dev_err(&pdev->dev, "cannot get clock \"%s\"\n",
+				clk_name);
+			ret = PTR_ERR(r8a66597->clk);
+			goto clean_up;
+		}
+		clk_enable(r8a66597->clk);
+	}
+#endif
+
 	disable_controller(r8a66597); /* make sure controller is disabled */
 
 	ret = request_irq(irq, r8a66597_irq, IRQF_DISABLED | IRQF_SHARED,
 			udc_name, r8a66597);
 	if (ret < 0) {
 		printk(KERN_ERR "request_irq error (%d)\n", ret);
-		goto clean_up;
+		goto clean_up2;
 	}
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
@@ -1586,7 +1610,7 @@ static int __init r8a66597_probe(struct 
 	r8a66597->ep0_req = r8a66597_alloc_request(&r8a66597->ep[0].ep,
 							GFP_KERNEL);
 	if (r8a66597->ep0_req = NULL)
-		goto clean_up2;
+		goto clean_up3;
 	r8a66597->ep0_req->complete = nop_completion;
 
 	init_controller(r8a66597);
@@ -1594,8 +1618,15 @@ static int __init r8a66597_probe(struct 
 	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
 	return 0;
 
-clean_up2:
+clean_up3:
 	free_irq(irq, r8a66597);
+clean_up2:
+#ifdef CONFIG_HAVE_CLK
+	if (r8a66597->pdata->on_chip) {
+		clk_disable(r8a66597->clk);
+		clk_put(r8a66597->clk);
+	}
+#endif
 clean_up:
 	if (r8a66597) {
 		if (r8a66597->ep0_req)
--- 0002/drivers/usb/gadget/r8a66597-udc.h
+++ work/drivers/usb/gadget/r8a66597-udc.h	2009-08-19 18:22:48.000000000 +0900
@@ -23,6 +23,10 @@
 #ifndef __R8A66597_H__
 #define __R8A66597_H__
 
+#ifdef CONFIG_HAVE_CLK
+#include <linux/clk.h>
+#endif
+
 #include <linux/usb/r8a66597.h>
 
 #define R8A66597_MAX_SAMPLING	10
@@ -88,6 +92,9 @@ struct r8a66597 {
 	spinlock_t		lock;
 	unsigned long		reg;
 
+#ifdef CONFIG_HAVE_CLK
+	struct clk *clk;
+#endif
 	struct r8a66597_platdata	*pdata;
 
 	struct usb_gadget		gadget;
