From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:58:58 +0000
Subject: [PATCH v2 1/7] spi: rspi: Remove useless .set_config_register() check
Message-Id: <20200819125904.20938-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Not implementing spi_ops.set_config_register() is a driver bug that
would prevent the driver from working at all.
Hence remove the run-time check.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index cbc2387d450cd4c2..1b635d6b7881f5b9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1261,13 +1261,6 @@ static int rspi_probe(struct platform_device *pdev)
 			ctlr->num_chipselect = 2; /* default */
 	}
 
-	/* ops parameter check */
-	if (!ops->set_config_register) {
-		dev_err(&pdev->dev, "there is no set_config_register\n");
-		ret = -ENODEV;
-		goto error1;
-	}
-
 	rspi = spi_controller_get_devdata(ctlr);
 	platform_set_drvdata(pdev, rspi);
 	rspi->ops = ops;
-- 
2.17.1
