From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:33:43 +0000
Subject: [PATCH 3/6] fbdev: sh_mipi_dsi: sh_mipi has pdata instead of dev
Message-Id: <87k48qctuk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index a87dcfe..e7a87de0 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -59,7 +59,7 @@ struct sh_mipi {
 	void __iomem	*base;
 	void __iomem	*linkbase;
 	struct clk	*dsit_clk;
-	struct device	*dev;
+	struct platform_device *pdev;
 
 	void	*next_board_data;
 	void	(*next_display_on)(void *board_data, struct fb_info *info);
@@ -135,7 +135,7 @@ static void mipi_display_on(void *arg, struct fb_info *info)
 {
 	struct sh_mipi *mipi = arg;
 
-	pm_runtime_get_sync(mipi->dev);
+	pm_runtime_get_sync(&mipi->pdev->dev);
 	sh_mipi_dsi_enable(mipi, true);
 
 	if (mipi->next_display_on)
@@ -150,7 +150,7 @@ static void mipi_display_off(void *arg)
 		mipi->next_display_off(mipi->next_board_data);
 
 	sh_mipi_dsi_enable(mipi, false);
-	pm_runtime_put(mipi->dev);
+	pm_runtime_put(&mipi->pdev->dev);
 }
 
 static int __init sh_mipi_setup(struct sh_mipi *mipi,
@@ -489,7 +489,7 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 		goto emap2;
 	}
 
-	mipi->dev = &pdev->dev;
+	mipi->pdev = pdev;
 
 	mipi->dsit_clk = clk_get(&pdev->dev, "dsit_clk");
 	if (IS_ERR(mipi->dsit_clk)) {
-- 
1.7.4.1

