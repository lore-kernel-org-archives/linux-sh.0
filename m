From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2014 08:44:01 +0000
Subject: [PATCH v2 11/14] spi: rspi: Convert to clk_prepare_enable/disable_unprepare
Message-Id: <1390553044-11860-12-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1390553044-11860-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Get the driver ready for the migration to the common clock framework by
calling clk_prepare_enable() and clk_disable_unprepare().

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
v2:
  - No changes

 drivers/spi/spi-rspi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 28db8770aaf3..a648b40c271b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -980,7 +980,7 @@ static int rspi_remove(struct platform_device *pdev)
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	rspi_release_dma(rspi);
-	clk_disable(rspi->clk);
+	clk_disable_unprepare(rspi->clk);
 
 	return 0;
 }
@@ -1041,7 +1041,12 @@ static int rspi_probe(struct platform_device *pdev)
 		ret = PTR_ERR(rspi->clk);
 		goto error1;
 	}
-	clk_enable(rspi->clk);
+
+	ret = clk_prepare_enable(rspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to prepare/enable clock\n");
+		goto error1;
+	}
 
 	init_waitqueue_head(&rspi->wait);
 
@@ -1112,7 +1117,7 @@ static int rspi_probe(struct platform_device *pdev)
 error3:
 	rspi_release_dma(rspi);
 error2:
-	clk_disable(rspi->clk);
+	clk_disable_unprepare(rspi->clk);
 error1:
 	spi_master_put(master);
 
-- 
1.7.9.5

