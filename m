From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:32 +0000
Subject: [PATCH 2/6] mmc: sh_mmcif: do not manage PM clocks manually
Message-Id: <Pine.LNX.4.64.1204181323290.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sh-mobile platforms the MMC clock frequency for the MMCIF unit is
obtained from the same clock, as the one, that runtime power-manages the
controller. The MMCIF driver has to access that clock directly,
bypassing the runtime PM framework, to get its frequency, but it
shouldn't enable or disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 724b35e..b0bf19c 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -213,7 +213,6 @@ struct sh_mmcif_host {
 	struct platform_device *pd;
 	struct sh_dmae_slave dma_slave_tx;
 	struct sh_dmae_slave dma_slave_rx;
-	struct clk *hclk;
 	unsigned int clk;
 	int bus_width;
 	bool sd_error;
@@ -1249,6 +1248,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	struct sh_mmcif_host *host;
 	struct sh_mmcif_plat_data *pd;
 	struct resource *res;
+	struct clk *hclk;
 	void __iomem *reg;
 	char clk_name[8];
 
@@ -1285,14 +1285,14 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->timeout	= 1000;
 
 	snprintf(clk_name, sizeof(clk_name), "mmc%d", pdev->id);
-	host->hclk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(host->hclk)) {
+	hclk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(hclk)) {
 		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		ret = PTR_ERR(host->hclk);
+		ret = PTR_ERR(hclk);
 		goto clean_up1;
 	}
-	clk_enable(host->hclk);
-	host->clk = clk_get_rate(host->hclk);
+	host->clk = clk_get_rate(hclk);
+	clk_put(hclk);
 	host->pd = pdev;
 
 	spin_lock_init(&host->lock);
@@ -1355,7 +1355,6 @@ clean_up3:
 	pm_runtime_suspend(&pdev->dev);
 clean_up2:
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(host->hclk);
 clean_up1:
 	mmc_free_host(mmc);
 clean_up:
@@ -1395,7 +1394,6 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1410,10 +1408,8 @@ static int sh_mmcif_suspend(struct device *dev)
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 	int ret = mmc_suspend_host(host->mmc);
 
-	if (!ret) {
+	if (!ret)
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
-		clk_disable(host->hclk);
-	}
 
 	return ret;
 }
@@ -1423,8 +1419,6 @@ static int sh_mmcif_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 
-	clk_enable(host->hclk);
-
 	return mmc_resume_host(host->mmc);
 }
 #else
-- 
1.7.2.5

