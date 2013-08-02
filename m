From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 13:03:42 +0000
Subject: [PATCH] spi: rspi: provide port addresses to dmaengine driver via slave configuration
Message-Id: <Pine.LNX.4.64.1308021500041.28012@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Don't rely on shdma dhaengine driver getting DMA slave addresses from its
slave configuration. Instead provide those addresses, using a
dmaengine_slave_config() call.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/spi/spi-rspi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index b44a6ac..5f122d9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -664,12 +664,13 @@ static irqreturn_t rspi_irq(int irq, void *_sr)
 static int rspi_request_dma(struct rspi_data *rspi,
 				      struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct rspi_plat_data *rspi_pd = pdev->dev.platform_data;
 	dma_cap_mask_t mask;
 	struct dma_slave_config cfg;
 	int ret;
 
-	if (!rspi_pd)
+	if (!res || !rspi_pd)
 		return 0;	/* The driver assumes no error. */
 
 	rspi->dma_width_16bit = rspi_pd->dma_width_16bit;
@@ -683,6 +684,8 @@ static int rspi_request_dma(struct rspi_data *rspi,
 		if (rspi->chan_rx) {
 			cfg.slave_id = rspi_pd->dma_rx_id;
 			cfg.direction = DMA_DEV_TO_MEM;
+			cfg.dst_addr = 0;
+			cfg.src_addr = res->start + RSPI_SPDR;
 			ret = dmaengine_slave_config(rspi->chan_rx, &cfg);
 			if (!ret)
 				dev_info(&pdev->dev, "Use DMA when rx.\n");
@@ -698,6 +701,8 @@ static int rspi_request_dma(struct rspi_data *rspi,
 		if (rspi->chan_tx) {
 			cfg.slave_id = rspi_pd->dma_tx_id;
 			cfg.direction = DMA_MEM_TO_DEV;
+			cfg.dst_addr = res->start + RSPI_SPDR;
+			cfg.src_addr = 0;
 			ret = dmaengine_slave_config(rspi->chan_tx, &cfg);
 			if (!ret)
 				dev_info(&pdev->dev, "Use DMA when tx\n");
-- 
1.7.2.5

