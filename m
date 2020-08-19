From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:59:01 +0000
Subject: [PATCH v2 4/7] spi: rspi: Increase bit rate range for RSPI on SH
Message-Id: <20200819125904.20938-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Increase bit rate range for RSPI on legacy SH by making use of the Bit
Rate Frequency Division Setting field in Command Registers, just like is
already done on RZ/A.  This decreases the lower limit by a factor of 8.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware, but the formulas in the datasheets for
SH7753, RZ/A1H, and RZ/A2M are the same.

v2:
  - No changes.

---
 drivers/spi/spi-rspi.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ad4ac867170b101a..ea3f2680d3c13e02 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -248,19 +248,32 @@ struct spi_ops {
 	u8 num_hw_ss;
 };
 
+static void rspi_set_rate(struct rspi_data *rspi)
+{
+	unsigned long clksrc;
+	int brdv = 0, spbr;
+
+	clksrc = clk_get_rate(rspi->clk);
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
+	while (spbr > 255 && brdv < 3) {
+		brdv++;
+		spbr = DIV_ROUND_UP(spbr + 1, 2) - 1;
+	}
+
+	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
+	rspi->spcmd |= SPCMD_BRDV(brdv);
+}
+
 /*
  * functions for RSPI on legacy SH
  */
 static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 {
-	int spbr;
-
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz) - 1;
-	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
+	rspi_set_rate(rspi);
 
 	/* Disable dummy transmission, set 16-bit word access, 1 frame */
 	rspi_write8(rspi, 0, RSPI_SPDCR);
@@ -290,23 +303,11 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
  */
 static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 {
-	int spbr;
-	int brdv = 0;
-	unsigned long clksrc;
-
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
-	clksrc = clk_get_rate(rspi->clk);
-	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
-	while (spbr > 255 && brdv < 3) {
-		brdv++;
-		spbr = DIV_ROUND_UP(spbr + 1, 2) - 1;
-	}
-
 	/* Sets transfer bit rate */
-	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
-	rspi->spcmd |= SPCMD_BRDV(brdv);
+	rspi_set_rate(rspi);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, SPDCR_SPLBYTE, RSPI_SPDCR);
-- 
2.17.1
