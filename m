From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:50 +0000
Subject: [PATCH 6/6] spi: msiof: don't use connection IDs to obtain a clock reference
Message-Id: <Pine.LNX.4.64.1204181327110.30514@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All MSIOF platforms have been switched to use device IDs in their MSIOF
clock look-ups. The clock connection ID can now be also removed from the
driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi-sh-msiof.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 502ca7a..29bf717 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -593,7 +593,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct resource	*r;
 	struct spi_master *master;
 	struct sh_msiof_spi_priv *p;
-	char clk_name[16];
 	int i;
 	int ret;
 
@@ -610,11 +609,10 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->info = pdev->dev.platform_data;
 	init_completion(&p->done);
 
-	snprintf(clk_name, sizeof(clk_name), "msiof%d", pdev->id);
-	p->clk = clk_get(&pdev->dev, clk_name);
+	p->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		ret = PTR_ERR(p->clk);
+		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
 		goto err1;
 	}
 
-- 
1.7.2.5

