From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:44 +0000
Subject: [PATCH 5/6] mmc: mmcif: don't use connection IDs to obtain a clock reference
Message-Id: <Pine.LNX.4.64.1204181326280.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All MMCIF platforms have been switched to use device IDs in their MMCIF
clock look-ups. The clock connection ID can now be also removed from the
driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index b0bf19c..efac927 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1250,7 +1250,6 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct clk *hclk;
 	void __iomem *reg;
-	char clk_name[8];
 
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
@@ -1284,11 +1283,10 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->addr	= reg;
 	host->timeout	= 1000;
 
-	snprintf(clk_name, sizeof(clk_name), "mmc%d", pdev->id);
-	hclk = clk_get(&pdev->dev, clk_name);
+	hclk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hclk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(hclk);
+		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto clean_up1;
 	}
 	host->clk = clk_get_rate(hclk);
-- 
1.7.2.5

