From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 05 Sep 2018 08:49:38 +0000
Subject: [PATCH 3/4] spi: rspi: Fix invalid SPI use during system suspend
Message-Id: <20180905084939.7401-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180905084939.7401-1-geert+renesas@glider.be>
In-Reply-To: <20180905084939.7401-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Gaku Inami <gaku.inami.xw@bp.renesas.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the SPI queue is running during system suspend, the system may lock
up.

Fix this by stopping/restarting the queue during system suspend/resume,
by calling spi_master_suspend()/spi_master_resume() from the PM
callbacks.  In-kernel users will receive an -ESHUTDOWN error while
system suspend/resume is in progress.

Based on a patch for sh-msiof by Gaku Inami.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index d710954b45954ca9..45faa390747b1166 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1348,12 +1348,36 @@ static const struct platform_device_id spi_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int rspi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
+
+	return spi_master_suspend(rspi->master);
+}
+
+static int rspi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
+
+	return spi_master_resume(rspi->master);
+}
+
+static SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
+#define DEV_PM_OPS	&rspi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver rspi_driver = {
 	.probe =	rspi_probe,
 	.remove =	rspi_remove,
 	.id_table =	spi_driver_ids,
 	.driver		= {
 		.name = "renesas_spi",
+		.pm = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(rspi_of_match),
 	},
 };
-- 
2.17.1
