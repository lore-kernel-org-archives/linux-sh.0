From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Dec 2014 16:20:49 +0000
Subject: [PATCH] i2c: sh_mobile: optimize irq entry
Message-Id: <1417710049-6894-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We can simply pass the pointer to the private structure to the irq
routine instead of passing the platform device and looking up its
driver_data.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index c2362a4bec25..429778280b6d 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -470,8 +470,7 @@ static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
 
 static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 {
-	struct platform_device *dev = dev_id;
-	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
+	struct sh_mobile_i2c_data *pd = dev_id;
 	unsigned char sr;
 	int wakeup = 0;
 
@@ -806,7 +805,7 @@ static void sh_mobile_i2c_release_dma(struct sh_mobile_i2c_data *pd)
 	}
 }
 
-static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
+static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, struct sh_mobile_i2c_data *pd)
 {
 	struct resource *res;
 	resource_size_t n;
@@ -815,7 +814,7 @@ static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
 	while ((res = platform_get_resource(dev, IORESOURCE_IRQ, k))) {
 		for (n = res->start; n <= res->end; n++) {
 			ret = devm_request_irq(&dev->dev, n, sh_mobile_i2c_isr,
-					  0, dev_name(&dev->dev), dev);
+					  0, dev_name(&dev->dev), pd);
 			if (ret) {
 				dev_err(&dev->dev, "cannot request IRQ %pa\n", &n);
 				return ret;
@@ -846,7 +845,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return PTR_ERR(pd->clk);
 	}
 
-	ret = sh_mobile_i2c_hook_irqs(dev);
+	ret = sh_mobile_i2c_hook_irqs(dev, pd);
 	if (ret)
 		return ret;
 
-- 
2.1.3

