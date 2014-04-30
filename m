From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 22:21:10 +0000
Subject: [PATCH 6/6] i2c: sh_mobile: devm conversion, irq setup
Message-Id: <1398896470-24663-7-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is what devm was made for. No rollback mechanism needed, remove the
hook parameter from the irq setup function and simplify it. While we are
here change some variables to proper types.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 56 ++++++++++----------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index c47d11493b97..ddc9970fd724 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -611,42 +611,25 @@ static struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
-static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
+static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
 {
 	struct resource *res;
-	int ret = -ENXIO;
-	int n, k = 0;
+	resource_size_t n;
+	int k = 0, ret;
 
 	while ((res = platform_get_resource(dev, IORESOURCE_IRQ, k))) {
-		for (n = res->start; hook && n <= res->end; n++) {
-			if (request_irq(n, sh_mobile_i2c_isr, 0,
-					dev_name(&dev->dev), dev)) {
-				for (n--; n >= res->start; n--)
-					free_irq(n, dev);
-
-				goto rollback;
+		for (n = res->start; n <= res->end; n++) {
+			ret = devm_request_irq(&dev->dev, n, sh_mobile_i2c_isr,
+					  0, dev_name(&dev->dev), dev);
+			if (ret) {
+				dev_err(&dev->dev, "cannot request IRQ %pa\n", &n);
+				return ret;
 			}
 		}
 		k++;
 	}
 
-	if (hook)
-		return k > 0 ? 0 : -ENOENT;
-
-	ret = 0;
-
- rollback:
-	k--;
-
-	while (k >= 0) {
-		res = platform_get_resource(dev, IORESOURCE_IRQ, k);
-		for (n = res->start; n <= res->end; n++)
-			free_irq(n, dev);
-
-		k--;
-	}
-
-	return ret;
+	return k > 0 ? 0 : -ENOENT;
 }
 
 static int sh_mobile_i2c_probe(struct platform_device *dev)
@@ -668,11 +651,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return PTR_ERR(pd->clk);
 	}
 
-	ret = sh_mobile_i2c_hook_irqs(dev, 1);
-	if (ret) {
-		dev_err(&dev->dev, "cannot request IRQ\n");
+	ret = sh_mobile_i2c_hook_irqs(dev);
+	if (ret)
 		return ret;
-	}
 
 	pd->dev = &dev->dev;
 	platform_set_drvdata(dev, pd);
@@ -680,10 +661,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 
 	pd->reg = devm_ioremap_resource(&dev->dev, res);
-	if (IS_ERR(pd->reg)) {
-		ret = PTR_ERR(pd->reg);
-		goto err_irq;
-	}
+	if (IS_ERR(pd->reg))
+		return PTR_ERR(pd->reg);
 
 	/* Use platform data bus speed or STANDARD_MODE */
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
@@ -735,7 +714,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(&dev->dev, "cannot add numbered adapter\n");
-		goto err_irq;
+		return ret;
 	}
 
 	dev_info(&dev->dev,
@@ -743,10 +722,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		 adap->nr, pd->bus_speed, pd->iccl, pd->icch);
 
 	return 0;
-
- err_irq:
-	sh_mobile_i2c_hook_irqs(dev, 0);
-	return ret;
 }
 
 static int sh_mobile_i2c_remove(struct platform_device *dev)
@@ -754,7 +729,6 @@ static int sh_mobile_i2c_remove(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&pd->adap);
-	sh_mobile_i2c_hook_irqs(dev, 0);
 	pm_runtime_disable(&dev->dev);
 	return 0;
 }
-- 
1.9.2

