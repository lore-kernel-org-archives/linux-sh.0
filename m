From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 10:21:17 +0000
Subject: [PATCH] spi: sh-msiof: Use correct device for DMA mapping with IOMMU
Message-Id: <1404901277-31107-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

To function correctly in the presence of an IOMMU, the DMA buffers must be
mapped using the DMA channel's device instead of the MSIOF platform
device's device.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9922ed3a4441..4f0f1cbc92ef 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1026,12 +1026,14 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 	if (!p->rx_dma_page)
 		goto free_tx_page;
 
-	p->tx_dma_addr = dma_map_single(dev, p->tx_dma_page, PAGE_SIZE,
+	p->tx_dma_addr = dma_map_single(&master->dma_tx->dev->device,
+					p->tx_dma_page, PAGE_SIZE,
 					DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, p->tx_dma_addr))
 		goto free_rx_page;
 
-	p->rx_dma_addr = dma_map_single(dev, p->rx_dma_page, PAGE_SIZE,
+	p->rx_dma_addr = dma_map_single(&master->dma_rx->dev->device,
+					p->rx_dma_page, PAGE_SIZE,
 					DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, p->rx_dma_addr))
 		goto unmap_tx_page;
-- 
1.9.1

