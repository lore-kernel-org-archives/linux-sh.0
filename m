From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:34:02 +0000
Subject: [PATCH 4/6] fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()
Message-Id: <87ipoactu1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mipi_setup() should be called after setting of CPG

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |   79 ++++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index e7a87de0..005c9fd 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -131,28 +131,6 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void mipi_display_on(void *arg, struct fb_info *info)
-{
-	struct sh_mipi *mipi = arg;
-
-	pm_runtime_get_sync(&mipi->pdev->dev);
-	sh_mipi_dsi_enable(mipi, true);
-
-	if (mipi->next_display_on)
-		mipi->next_display_on(mipi->next_board_data, info);
-}
-
-static void mipi_display_off(void *arg)
-{
-	struct sh_mipi *mipi = arg;
-
-	if (mipi->next_display_off)
-		mipi->next_display_off(mipi->next_board_data);
-
-	sh_mipi_dsi_enable(mipi, false);
-	pm_runtime_put(&mipi->pdev->dev);
-}
-
 static int __init sh_mipi_setup(struct sh_mipi *mipi,
 				struct sh_mipi_dsi_info *pdata)
 {
@@ -434,6 +412,50 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	return 0;
 }
 
+static void mipi_display_on(void *arg, struct fb_info *info)
+{
+	struct sh_mipi *mipi = arg;
+	struct sh_mipi_dsi_info *pdata = mipi->pdev->dev.platform_data;
+	int ret;
+
+	pm_runtime_get_sync(&mipi->pdev->dev);
+
+	ret = pdata->set_dot_clock(mipi->pdev, mipi->base, 1);
+	if (ret < 0)
+		goto mipi_display_on_fail1;
+
+	ret = sh_mipi_setup(mipi, pdata);
+	if (ret < 0)
+		goto mipi_display_on_fail2;
+
+	sh_mipi_dsi_enable(mipi, true);
+
+	if (mipi->next_display_on)
+		mipi->next_display_on(mipi->next_board_data, info);
+
+	return;
+
+mipi_display_on_fail1:
+	pm_runtime_put_sync(&mipi->pdev->dev);
+mipi_display_on_fail2:
+	pdata->set_dot_clock(mipi->pdev, mipi->base, 0);
+}
+
+static void mipi_display_off(void *arg)
+{
+	struct sh_mipi *mipi = arg;
+	struct sh_mipi_dsi_info *pdata = mipi->pdev->dev.platform_data;
+
+	if (mipi->next_display_off)
+		mipi->next_display_off(mipi->next_board_data);
+
+	sh_mipi_dsi_enable(mipi, false);
+
+	pdata->set_dot_clock(mipi->pdev, mipi->base, 0);
+
+	pm_runtime_put_sync(&mipi->pdev->dev);
+}
+
 static int __init sh_mipi_probe(struct platform_device *pdev)
 {
 	struct sh_mipi *mipi;
@@ -518,14 +540,6 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
-	ret = sh_mipi_setup(mipi, pdata);
-	if (ret < 0)
-		goto emipisetup;
-
-	ret = pdata->set_dot_clock(pdev, mipi->base, 1);
-	if (ret < 0)
-		goto emipisetup;
-
 	mutex_unlock(&array_lock);
 	platform_set_drvdata(pdev, mipi);
 
@@ -542,10 +556,6 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 
 	return 0;
 
-emipisetup:
-	mipi_dsi[idx] = NULL;
-	pm_runtime_disable(&pdev->dev);
-	clk_disable(mipi->dsit_clk);
 eclkton:
 esettrate:
 	clk_put(mipi->dsit_clk);
@@ -599,7 +609,6 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(mipi->dsit_clk);
 	clk_put(mipi->dsit_clk);
-	pdata->set_dot_clock(pdev, mipi->base, 0);
 
 	iounmap(mipi->linkbase);
 	if (res2)
-- 
1.7.4.1

