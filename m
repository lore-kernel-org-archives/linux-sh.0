From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 07 Nov 2012 11:40:04 +0000
Subject: [PATCH 1/4] spi: sh-msiof: Remove unneeded clock name
Message-Id: <1352288407-20594-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

clk_get() no longer needs a character string for associating the right
clock as this is done via the device struct now.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/spi/spi-sh-msiof.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1f466bc..96358d0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -597,7 +597,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct resource	*r;
 	struct spi_master *master;
 	struct sh_msiof_spi_priv *p;
-	char clk_name[16];
 	int i;
 	int ret;
 
@@ -614,10 +613,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->info = pdev->dev.platform_data;
 	init_completion(&p->done);
 
-	snprintf(clk_name, sizeof(clk_name), "msiof%d", pdev->id);
-	p->clk = clk_get(&pdev->dev, clk_name);
+	p->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
-- 
1.7.5.4

