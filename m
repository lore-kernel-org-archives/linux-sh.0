From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:11 +0000
Subject: [PATCH v2 05/10] i2c: sh_mobile: devm conversion, low hanging fruits
Message-Id: <1399058116-7721-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Convert the easy parts to devm. irqs will be converted in a seperate
patch to keep diffs readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 41 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 2e481abd50ce..c47d11493b97 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -655,45 +655,33 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
-	int size;
 	int ret;
 	u32 bus_speed;
 
-	pd = kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
-	if (pd = NULL) {
-		dev_err(&dev->dev, "cannot allocate private data\n");
+	pd = devm_kzalloc(&dev->dev, sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
+	if (!pd)
 		return -ENOMEM;
-	}
 
-	pd->clk = clk_get(&dev->dev, NULL);
+	pd->clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(pd->clk)) {
 		dev_err(&dev->dev, "cannot get clock\n");
-		ret = PTR_ERR(pd->clk);
-		goto err;
+		return PTR_ERR(pd->clk);
 	}
 
 	ret = sh_mobile_i2c_hook_irqs(dev, 1);
 	if (ret) {
 		dev_err(&dev->dev, "cannot request IRQ\n");
-		goto err_clk;
+		return ret;
 	}
 
 	pd->dev = &dev->dev;
 	platform_set_drvdata(dev, pd);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (res = NULL) {
-		dev_err(&dev->dev, "cannot find IO resource\n");
-		ret = -ENOENT;
-		goto err_irq;
-	}
 
-	size = resource_size(res);
-
-	pd->reg = ioremap(res->start, size);
-	if (pd->reg = NULL) {
-		dev_err(&dev->dev, "cannot map IO\n");
-		ret = -ENXIO;
+	pd->reg = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(pd->reg)) {
+		ret = PTR_ERR(pd->reg);
 		goto err_irq;
 	}
 
@@ -710,7 +698,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	/* The IIC blocks on SH-Mobile ARM processors
 	 * come with two new bits in ICIC.
 	 */
-	if (size > 0x17)
+	if (resource_size(res) > 0x17)
 		pd->flags |= IIC_FLAG_HAS_ICIC67;
 
 	sh_mobile_i2c_init(pd);
@@ -747,7 +735,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(&dev->dev, "cannot add numbered adapter\n");
-		goto err_all;
+		goto err_irq;
 	}
 
 	dev_info(&dev->dev,
@@ -756,14 +744,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 	return 0;
 
- err_all:
-	iounmap(pd->reg);
  err_irq:
 	sh_mobile_i2c_hook_irqs(dev, 0);
- err_clk:
-	clk_put(pd->clk);
- err:
-	kfree(pd);
 	return ret;
 }
 
@@ -772,11 +754,8 @@ static int sh_mobile_i2c_remove(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&pd->adap);
-	iounmap(pd->reg);
 	sh_mobile_i2c_hook_irqs(dev, 0);
-	clk_put(pd->clk);
 	pm_runtime_disable(&dev->dev);
-	kfree(pd);
 	return 0;
 }
 
-- 
1.9.2

