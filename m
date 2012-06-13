From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 13 Jun 2012 13:37:23 +0000
Subject: [PATCH 3/5 v4] mmc: sh_mmcif: re-read the clock frequency every time the clock is turned on
Message-Id: <Pine.LNX.4.64.1206131533560.17854@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

With aggressive clock gating the clock can be disabled during interface
inactivity. During this time its frequency can be changed by another its
user. Therefore when the interface is activated again and the clock is
re-enabled, its frequency has to be re-read.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6a93b04..3ffb92f 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -910,6 +910,19 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sh_mmcif_start_cmd(host, mrq);
 }
 
+static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
+{
+	int ret = clk_enable(host->hclk);
+
+	if (!ret) {
+		host->clk = clk_get_rate(host->hclk);
+		host->mmc->f_max = host->clk / 2;
+		host->mmc->f_min = host->clk / 512;
+	}
+
+	return ret;
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
@@ -955,7 +968,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!host->power) {
 			if (p->set_pwr)
 				p->set_pwr(host->pd, ios->power_mode);
-			clk_enable(host->hclk);
+			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
 			sh_mmcif_sync_reset(host);
@@ -1308,10 +1321,9 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get clock \"%s\": %d\n", clk_name, ret);
 		goto eclkget;
 	}
-	clk_enable(host->hclk);
-	host->clk = clk_get_rate(host->hclk);
-	mmc->f_max = host->clk / 2;
-	mmc->f_min = host->clk / 512;
+	ret = sh_mmcif_clk_update(host);
+	if (ret < 0)
+		goto eclkupdate;
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
@@ -1353,6 +1365,7 @@ ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
 eresume:
 	clk_disable(host->hclk);
+eclkupdate:
 	clk_put(host->hclk);
 eclkget:
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.2.5

