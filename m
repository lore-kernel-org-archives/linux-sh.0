From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:59:00 +0000
Subject: [PATCH v2 3/7] spi: rspi: Increase bit rate accuracy on RZ/A
Message-Id: <20200819125904.20938-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

rspi_rz_set_config_register() favors high values of "brdv" over high
values of "spbr".  As "brdv" is not a plain divider, but controls a
power-of-two divider, this may cause the selection of non-optimal
divider values.  E.g. on RSK+RZA1, when 3.8 MHz is requested, the actual
configured bit rate is 2.08 MHz (spbr = 1, brdv = 3), while 3.7 MHz
would be possible (spbr = 8, brdv = 0).

Fix this by only resorting to higher "brdv" values when really needed.
This makes the driver always pick optimal divider values on RZ/A.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 450a42ec2141a895..ad4ac867170b101a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -298,15 +298,13 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	clksrc = clk_get_rate(rspi->clk);
-	while (brdv < 3) {
-		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
-			break;
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
+	while (spbr > 255 && brdv < 3) {
 		brdv++;
-		clksrc /= 2;
+		spbr = DIV_ROUND_UP(spbr + 1, 2) - 1;
 	}
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= SPCMD_BRDV(brdv);
 
-- 
2.17.1
