From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:39:42 +0000
Subject: [PATCH 1/2] spi: sh-msiof: Use devm_* managed allocators
Message-Id: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

This simplifies error and cleanup code paths.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-sh-msiof.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index c74298c..541e1ec 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -635,8 +635,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	master = spi_alloc_master(&pdev->dev, sizeof(struct sh_msiof_spi_priv));
 	if (master = NULL) {
 		dev_err(&pdev->dev, "failed to allocate spi master\n");
-		ret = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
 	p = spi_master_get_devdata(master);
@@ -655,32 +654,32 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	init_completion(&p->done);
 
-	p->clk = clk_get(&pdev->dev, NULL);
+	p->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
 		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i = platform_get_irq(pdev, 0);
-	if (!r || i < 0) {
-		dev_err(&pdev->dev, "cannot get platform resources\n");
+	if (i < 0) {
+		dev_err(&pdev->dev, "cannot get platform IRQ\n");
 		ret = -ENOENT;
-		goto err2;
+		goto err1;
 	}
-	p->mapbase = ioremap_nocache(r->start, resource_size(r));
-	if (!p->mapbase) {
-		dev_err(&pdev->dev, "unable to ioremap\n");
-		ret = -ENXIO;
-		goto err2;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	p->mapbase = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(p->mapbase)) {
+		ret = PTR_ERR(p->mapbase);
+		goto err1;
 	}
 
-	ret = request_irq(i, sh_msiof_spi_irq, 0,
-			  dev_name(&pdev->dev), p);
+	ret = devm_request_irq(&pdev->dev, i, sh_msiof_spi_irq, 0,
+			       dev_name(&pdev->dev), p);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to request irq\n");
-		goto err3;
+		goto err1;
 	}
 
 	p->pdev = pdev;
@@ -719,13 +718,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(&pdev->dev);
- err3:
-	iounmap(p->mapbase);
- err2:
-	clk_put(p->clk);
  err1:
 	spi_master_put(master);
- err0:
 	return ret;
 }
 
@@ -737,9 +731,6 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 	ret = spi_bitbang_stop(&p->bitbang);
 	if (!ret) {
 		pm_runtime_disable(&pdev->dev);
-		free_irq(platform_get_irq(pdev, 0), p);
-		iounmap(p->mapbase);
-		clk_put(p->clk);
 		spi_master_put(p->bitbang.master);
 	}
 	return ret;
-- 
1.8.3.2

