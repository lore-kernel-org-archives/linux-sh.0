From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 05 Sep 2018 08:49:39 +0000
Subject: [PATCH 4/4] spi: rspi: Fix interrupted DMA transfers
Message-Id: <20180905084939.7401-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180905084939.7401-1-geert+renesas@glider.be>
In-Reply-To: <20180905084939.7401-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Gaku Inami <gaku.inami.xw@bp.renesas.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When interrupted, wait_event_interruptible_timeout() returns
-ERESTARTSYS, and the SPI transfer in progress will fail, as expected:

    m25p80 spi0.0: SPI transfer failed: -512
    spi_master spi0: failed to transfer one message from queue

However, as the underlying DMA transfers may not have completed, all
subsequent SPI transfers may start to fail:

    spi_master spi0: receive timeout
    qspi_transfer_out_in() returned -110
    m25p80 spi0.0: SPI transfer failed: -110
    spi_master spi0: failed to transfer one message from queue

Fix this by calling dmaengine_terminate_all() not only for timeouts, but
also for errors.

This can be reproduced on r8a7991/koelsch, using "hd /dev/mtd0" followed
by CTRL-C.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 45faa390747b1166..98a839d286b8e82b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -598,11 +598,13 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 	ret = wait_event_interruptible_timeout(rspi->wait,
 					       rspi->dma_callbacked, HZ);
-	if (ret > 0 && rspi->dma_callbacked)
+	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
-	else if (!ret) {
-		dev_err(&rspi->master->dev, "DMA timeout\n");
-		ret = -ETIMEDOUT;
+	} else {
+		if (!ret) {
+			dev_err(&rspi->master->dev, "DMA timeout\n");
+			ret = -ETIMEDOUT;
+		}
 		if (tx)
 			dmaengine_terminate_all(rspi->master->dma_tx);
 		if (rx)
-- 
2.17.1
