From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 08 Jun 2020 09:59:35 +0000
Subject: [PATCH 3/8] spi: rspi: Clean up Bit Rate Division Setting handling
Message-Id: <20200608095940.30516-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200608095940.30516-1-geert+renesas@glider.be>
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a macro for configuring the Bit Rate Division Setting field in
Command Registers, instead of open-coding the same operation using a
hardcoded shift.
Rename "div" to "brdv", as it is not a plain divider value, but controls
a power-of-two divider.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 1b635d6b7881f5b9..450a42ec2141a895 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -161,6 +161,7 @@
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
 #define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
+#define SPCMD_BRDV(brdv)	((brdv) << 2)
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
 
@@ -290,24 +291,24 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 {
 	int spbr;
-	int div = 0;
+	int brdv = 0;
 	unsigned long clksrc;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	clksrc = clk_get_rate(rspi->clk);
-	while (div < 3) {
+	while (brdv < 3) {
 		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
 			break;
-		div++;
+		brdv++;
 		clksrc /= 2;
 	}
 
 	/* Sets transfer bit rate */
 	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
-	rspi->spcmd |= div << 2;
+	rspi->spcmd |= SPCMD_BRDV(brdv);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, SPDCR_SPLBYTE, RSPI_SPDCR);
-- 
2.17.1
