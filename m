From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 Jan 2014 10:27:43 +0000
Subject: [PATCH V2 7/8] spi: rspi: Add support for specifying CPHA/CPOL
Message-Id: <1389522464-1569-8-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389522464-1569-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add support for specifying the SPI clock phase and polarity, based on the
SDK reference code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V2:
  - Add Acked-by

 drivers/spi/spi-rspi.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 18c56d1feb8e..4b25c8617b02 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -190,6 +190,7 @@ struct rspi_data {
 	u8 spsr;
 	u8 spdcr;
 	u8 data_width;
+	u16 spcmd;
 	int irqs[MAX_NUM_IRQ];
 	unsigned int num_irqs;
 	const struct spi_ops *ops;
@@ -336,7 +337,7 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 		rspi_write8(rspi, 0x00, RSPI_SPCR2);
 
 	/* Sets SPCMD */
-	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | SPCMD_SSLKP,
+	rspi_write16(rspi, SPCMD_SPB_8_TO_16(access_size) | rspi->spcmd,
 		     RSPI_SPCMD0);
 
 	/* Sets RSPI mode */
@@ -391,7 +392,7 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 	else
 		spcmd = SPCMD_SPB_32BIT;
 
-	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | SPCMD_SSLKP | SPCMD_SPNDEN;
+	spcmd |= SPCMD_SCKDEN | SPCMD_SLNDEN | rspi->spcmd | SPCMD_SPNDEN;
 
 	/* Resets transfer data length */
 	rspi_write32(rspi, 0, QSPI_SPBMUL0);
@@ -911,6 +912,12 @@ static int rspi_setup(struct spi_device *spi)
 		spi->bits_per_word = 8;
 	rspi->max_speed_hz = spi->max_speed_hz;
 
+	rspi->spcmd = SPCMD_SSLKP;
+	if (spi->mode & SPI_CPOL)
+		rspi->spcmd |= SPCMD_CPOL;
+	if (spi->mode & SPI_CPHA)
+		rspi->spcmd |= SPCMD_CPHA;
+
 	set_config_register(rspi, 8);
 
 	return 0;
@@ -1088,6 +1095,7 @@ static int rspi_probe(struct platform_device *pdev)
 	master->setup = rspi_setup;
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
+	master->mode_bits = SPI_CPHA | SPI_CPOL;
 
 	ret = ops->parse_platform_data(rspi, rspi_pd);
 	if (ret < 0) {
-- 
1.7.9.5

