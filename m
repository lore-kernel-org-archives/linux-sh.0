From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:59:03 +0000
Subject: [PATCH v2 6/7] spi: rspi: Fill in spi_transfer.effective_speed_hz
Message-Id: <20200819125904.20938-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Fill in the effective bit rate used for transfers, so the SPI core can
calculate instead of estimate delays.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 38c0cd7febabf114..2b5334e22ae421b5 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -262,6 +262,7 @@ static void rspi_set_rate(struct rspi_data *rspi)
 
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
+	rspi->speed_hz = DIV_ROUND_UP(clksrc, (2U << brdv) * (spbr + 1));
 }
 
 /*
@@ -344,6 +345,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	clksrc = clk_get_rate(rspi->clk);
 	if (rspi->speed_hz >= clksrc) {
 		spbr = 0;
+		rspi->speed_hz = clksrc;
 	} else {
 		spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz);
 		while (spbr > 255 && brdv < 3) {
@@ -351,6 +353,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 			spbr = DIV_ROUND_UP(spbr, 2);
 		}
 		spbr = clamp(spbr, 0, 255);
+		rspi->speed_hz = DIV_ROUND_UP(clksrc, (2U << brdv) * spbr);
 	}
 	rspi_write8(rspi, spbr, RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
@@ -698,6 +701,8 @@ static int rspi_common_transfer(struct rspi_data *rspi,
 {
 	int ret;
 
+	xfer->effective_speed_hz = rspi->speed_hz;
+
 	ret = rspi_dma_check_then_transfer(rspi, xfer);
 	if (ret != -EAGAIN)
 		return ret;
@@ -853,6 +858,7 @@ static int qspi_transfer_one(struct spi_controller *ctlr,
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
 
+	xfer->effective_speed_hz = rspi->speed_hz;
 	if (spi->mode & SPI_LOOP) {
 		return qspi_transfer_out_in(rspi, xfer);
 	} else if (xfer->tx_nbits > SPI_NBITS_SINGLE) {
-- 
2.17.1
