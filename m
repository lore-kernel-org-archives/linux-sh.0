From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:59:02 +0000
Subject: [PATCH v2 5/7] spi: rspi: Increase bit rate range for QSPI
Message-Id: <20200819125904.20938-6-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Increase bit rate range for QSPI by extending the range of supported
dividers:
  1. QSPI supports a divider of 1, by setting SPBR to zero, increasing
     the upper limit from 48.75 to 97.5 MHz on R-Car Gen2,
  2. Make use of the Bit Rate Frequency Division Setting field in
     Command Registers, to decrease the lower limit from 191 to 24 kbps
     on R-Car Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ea3f2680d3c13e02..38c0cd7febabf114 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -334,14 +334,26 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
  */
 static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 {
-	int spbr;
+	unsigned long clksrc;
+	int brdv = 0, spbr;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz);
-	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
+	clksrc = clk_get_rate(rspi->clk);
+	if (rspi->speed_hz >= clksrc) {
+		spbr = 0;
+	} else {
+		spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz);
+		while (spbr > 255 && brdv < 3) {
+			brdv++;
+			spbr = DIV_ROUND_UP(spbr, 2);
+		}
+		spbr = clamp(spbr, 0, 255);
+	}
+	rspi_write8(rspi, spbr, RSPI_SPBR);
+	rspi->spcmd |= SPCMD_BRDV(brdv);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, 0, RSPI_SPDCR);
-- 
2.17.1
