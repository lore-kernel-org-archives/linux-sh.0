From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 08 Jun 2020 09:59:33 +0000
Subject: [PATCH 1/8] spi: rspi: Remove useless .set_config_register() check
Message-Id: <20200608095940.30516-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200608095940.30516-1-geert+renesas@glider.be>
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
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
 drivers/spi/spi-rspi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 06192c9ea8132911..0e786af546c9f513 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1247,13 +1247,6 @@ static int rspi_probe(struct platform_device *pdev)
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
