From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:40 +0000
Subject: [PATCH 4/6] mmc: sdhi: don't use connection IDs to obtain a clock reference
Message-Id: <Pine.LNX.4.64.1204181325530.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All SDHI platforms have been switched to use device IDs in their SDHI
clock look-ups. The clock connection ID can now be also removed from the
driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 934b68e..5ac656e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -105,7 +105,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_data *mmc_data;
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
-	char clk_name[8];
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
 
@@ -124,11 +123,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 			goto einit;
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
+	priv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(priv->clk);
+		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto eclkget;
 	}
 
-- 
1.7.2.5

