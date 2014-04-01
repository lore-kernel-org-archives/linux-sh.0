From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 01 Apr 2014 10:25:51 +0000
Subject: [PATCH 3/6] mmc: sh-mmcif: use devm_ for clock management
Message-Id: <1396347954-13740-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

---
 drivers/mmc/host/sh_mmcif.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index be6be2b..c006310 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1393,7 +1393,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto eofparse;
+		goto err_host;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1423,19 +1423,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	host->power = false;
 
-	host->hclk = clk_get(&pdev->dev, NULL);
+	host->hclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->hclk)) {
 		ret = PTR_ERR(host->hclk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto eclkget;
+		goto err_pm;
 	}
 	ret = sh_mmcif_clk_update(host);
 	if (ret < 0)
-		goto eclkupdate;
+		goto err_clk;
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-		goto eresume;
+		goto err_clk;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
@@ -1486,13 +1486,11 @@ ereqirq1:
 	free_irq(irq[0], host);
 ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
-eresume:
+err_clk:
 	clk_disable_unprepare(host->hclk);
-eclkupdate:
-	clk_put(host->hclk);
-eclkget:
+err_pm:
 	pm_runtime_disable(&pdev->dev);
-eofparse:
+err_host:
 	mmc_free_host(mmc);
 	return ret;
 }
-- 
1.9.0

