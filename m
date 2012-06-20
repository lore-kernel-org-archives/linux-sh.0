From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 17:10:32 +0000
Subject: [PATCH 3/7 v4] mmc: sdhi: implement tmio-mmc clock enable-update and disable callbacks
Message-Id: <1340212236-647-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Instead of delivering one static clock frequency value, read from the
hardware during probing, enable the tmio-mmc driver to re-read the
frequency dynamically.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 934b68e..d8b167c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -39,6 +39,27 @@ struct sh_mobile_sdhi {
 	struct tmio_mmc_dma dma_priv;
 };
 
+static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int *f)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	int ret = clk_enable(priv->clk);
+	if (ret < 0)
+		return ret;
+
+	*f = clk_get_rate(priv->clk);
+	return 0;
+}
+
+static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	clk_disable(priv->clk);
+}
+
 static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
@@ -132,9 +153,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
+	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
-- 
1.7.2.5

