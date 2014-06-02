From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 02 Jun 2014 13:38:19 +0000
Subject: [PATCH 17/18] spi: rspi: Extract rspi_common_transfer()
Message-Id: <1401716301-29612-18-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Extract the common parts of rspi_transfer_one(), rspi_rz_transfer_one(),
and qspi_transfer_out_in() into the new function rspi_common_transfer().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 61 ++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 4bc4138e002b..10112745bb17 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -586,12 +586,32 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
 	return __rspi_can_dma(rspi, xfer);
 }
 
+static int rspi_common_transfer(struct rspi_data *rspi,
+				struct spi_transfer *xfer)
+{
+	int ret;
+
+	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
+		return rspi_dma_transfer(rspi, &xfer->tx_sg,
+					 xfer->rx_buf ? &xfer->rx_sg : NULL);
+	}
+
+	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for the last transmission */
+	rspi_wait_for_tx_empty(rspi);
+
+	return 0;
+}
+
 static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
 			     struct spi_transfer *xfer)
 {
 	struct rspi_data *rspi = spi_master_get_devdata(master);
 	u8 spcr;
-	int ret;
 
 	spcr = rspi_read8(rspi, RSPI_SPCR);
 	if (xfer->rx_buf) {
@@ -602,18 +622,7 @@ static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
 	}
 	rspi_write8(rspi, spcr, RSPI_SPCR);
 
-	if (master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, &xfer->tx_sg,
-					 xfer->rx_buf ? &xfer->rx_sg : NULL);
-
-	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
-	if (ret < 0)
-		return ret;
-
-	/* Wait for the last transmission */
-	rspi_wait_for_tx_empty(rspi);
-
-	return 0;
+	return rspi_common_transfer(rspi, xfer);
 }
 
 static int rspi_rz_transfer_one(struct spi_master *master,
@@ -625,37 +634,15 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 
 	rspi_rz_receive_init(rspi);
 
-	if (master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, &xfer->tx_sg, &xfer->rx_sg);
-
-	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
-	if (ret < 0)
-		return ret;
-
-	/* Wait for the last transmission */
-	rspi_wait_for_tx_empty(rspi);
-
-	return 0;
+	return rspi_common_transfer(rspi, xfer);
 }
 
 static int qspi_transfer_out_in(struct rspi_data *rspi,
 				struct spi_transfer *xfer)
 {
-	int ret;
-
 	qspi_receive_init(rspi);
 
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, &xfer->tx_sg, &xfer->rx_sg);
-
-	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
-	if (ret < 0)
-		return ret;
-
-	/* Wait for the last transmission */
-	rspi_wait_for_tx_empty(rspi);
-
-	return 0;
+	return rspi_common_transfer(rspi, xfer);
 }
 
 static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
-- 
1.9.1

