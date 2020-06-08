From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 08 Jun 2020 09:59:34 +0000
Subject: [PATCH 2/8] spi: rspi: Use requested instead of maximum bit rate
Message-Id: <20200608095940.30516-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200608095940.30516-1-geert+renesas@glider.be>
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently, the RSPI driver always tries to use the maximum configured
bit rate for communicating with a slave device, even if the transfer(s)
in the current message specify a lower rate.

Use the mininum rate specified in the message instead.
Rename rspi_data.max_speed_hz accordingly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0e786af546c9f513..1b635d6b7881f5b9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -179,7 +179,7 @@
 
 struct rspi_data {
 	void __iomem *addr;
-	u32 max_speed_hz;
+	u32 speed_hz;
 	struct spi_controller *ctlr;
 	struct platform_device *pdev;
 	wait_queue_head_t wait;
@@ -258,8 +258,7 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk),
-			    2 * rspi->max_speed_hz) - 1;
+	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Disable dummy transmission, set 16-bit word access, 1 frame */
@@ -299,14 +298,14 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 
 	clksrc = clk_get_rate(rspi->clk);
 	while (div < 3) {
-		if (rspi->max_speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
+		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
 			break;
 		div++;
 		clksrc /= 2;
 	}
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->max_speed_hz) - 1;
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= div << 2;
 
@@ -341,7 +340,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->max_speed_hz);
+	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz);
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Disable dummy transmission, set byte access */
@@ -949,9 +948,24 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = msg->spi;
+	const struct spi_transfer *xfer;
 	int ret;
 
-	rspi->max_speed_hz = spi->max_speed_hz;
+	/*
+	 * As the Bit Rate Register must not be changed while the device is
+	 * active, all transfers in a message must use the same bit rate.
+	 * In theory, the sequencer could be enabled, and each Command Register
+	 * could divide the base bit rate by a different value.
+	 * However, most RSPI variants do not have Transfer Data Length
+	 * Multiplier Setting Registers, so each sequence step would be limited
+	 * to a single word, making this feature unsuitable for large
+	 * transfers, which would gain most from it.
+	 */
+	rspi->speed_hz = spi->max_speed_hz;
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->speed_hz < rspi->speed_hz)
+			rspi->speed_hz = xfer->speed_hz;
+	}
 
 	rspi->spcmd = SPCMD_SSLKP;
 	if (spi->mode & SPI_CPOL)
-- 
2.17.1
