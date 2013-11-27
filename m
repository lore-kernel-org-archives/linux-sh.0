From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:41:46 +0000
Subject: [PATCH 3/3] spi: rcar: Use devm_* managed allocators
Message-Id: <1385512906-13108-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This simplies error and cleanup code paths.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-rspi.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 621be5d..19c65c4 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -889,9 +889,6 @@ static int rspi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(rspi->master);
 	rspi_release_dma(rspi);
-	free_irq(platform_get_irq(pdev, 0), rspi);
-	clk_put(rspi->clk);
-	iounmap(rspi->addr);
 
 	return 0;
 }
@@ -913,12 +910,6 @@ static int rspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "there is no set_config_register\n");
 		return -ENODEV;
 	}
-	/* get base addr */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(res = NULL)) {
-		dev_err(&pdev->dev, "invalid resource\n");
-		return -EINVAL;
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -936,19 +927,20 @@ static int rspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rspi);
 	rspi->ops = ops;
 	rspi->master = master;
-	rspi->addr = ioremap(res->start, resource_size(res));
-	if (rspi->addr = NULL) {
-		dev_err(&pdev->dev, "ioremap error.\n");
-		ret = -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rspi->addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rspi->addr)) {
+		ret = PTR_ERR(rspi->addr);
 		goto error1;
 	}
 
 	snprintf(clk_name, sizeof(clk_name), "%s%d", id_entry->name, pdev->id);
-	rspi->clk = clk_get(&pdev->dev, clk_name);
+	rspi->clk = devm_clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(rspi->clk)) {
 		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(rspi->clk);
-		goto error2;
+		goto error1;
 	}
 	clk_enable(rspi->clk);
 
@@ -966,36 +958,32 @@ static int rspi_probe(struct platform_device *pdev)
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
 
-	ret = request_irq(irq, rspi_irq, 0, dev_name(&pdev->dev), rspi);
+	ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
+			       dev_name(&pdev->dev), rspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request_irq error\n");
-		goto error3;
+		goto error1;
 	}
 
 	rspi->irq = irq;
 	ret = rspi_request_dma(rspi, pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
-		goto error4;
+		goto error2;
 	}
 
 	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto error4;
+		goto error2;
 	}
 
 	dev_info(&pdev->dev, "probed\n");
 
 	return 0;
 
-error4:
-	rspi_release_dma(rspi);
-	free_irq(irq, rspi);
-error3:
-	clk_put(rspi->clk);
 error2:
-	iounmap(rspi->addr);
+	rspi_release_dma(rspi);
 error1:
 	spi_master_put(master);
 
-- 
1.8.3.2

