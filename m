From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 05 Sep 2018 08:49:36 +0000
Subject: [PATCH 1/4] spi: sh-msiof: Fix invalid SPI use during system suspend
Message-Id: <20180905084939.7401-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180905084939.7401-1-geert+renesas@glider.be>
In-Reply-To: <20180905084939.7401-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Gaku Inami <gaku.inami.xw@bp.renesas.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

If the SPI queue is running during system suspend, the system may lock
up.

Fix this by stopping/restarting the queue during system suspend/resume
by calling spi_master_suspend()/spi_master_resume() from the PM
callbacks.  In-kernel users will receive an -ESHUTDOWN error while
system suspend/resume is in progress.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: Cleanup, reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 539d6d1a277a6179..bfe4e6d4f7bff66c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,12 +1426,37 @@ static const struct platform_device_id spi_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int sh_msiof_spi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_suspend(p->master);
+}
+
+static int sh_msiof_spi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+
+	return spi_master_resume(p->master);
+}
+
+static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
+			 sh_msiof_spi_resume);
+#define DEV_PM_OPS	&sh_msiof_spi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
 	.remove		= sh_msiof_spi_remove,
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
+		.pm		= DEV_PM_OPS,
 		.of_match_table = of_match_ptr(sh_msiof_match),
 	},
 };
-- 
2.17.1
