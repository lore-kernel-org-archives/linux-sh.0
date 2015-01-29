From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 29 Jan 2015 23:59:39 +0000
Subject: [PATCH v2 6/6] dmaengine: rcar-dmac: Disable channel 0 when using IOMMU
Message-Id: <1422576013-7846-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A still unconfirmed hardware bug prevents the IPMMU microTLB 0 to be
flushed correctly, resulting in memory corruption. DMAC 0 channel 0 is
connected to microTLB 0 on currently supported platforms, so we can't
use it with the IPMMU. As the IOMMU API operates at the device level we
can't disable it selectively, so ignore channel 0 for now if the device
is part of an IOMMU group.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 711da01a200b..a18d16cc4795 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1593,6 +1593,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
 		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
+	unsigned int channels_offset = 0;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	struct resource *mem;
@@ -1612,6 +1613,19 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * A still unconfirmed hardware bug prevents the IPMMU microTLB 0 to be
+	 * flushed correctly, resulting in memory corruption. DMAC 0 channel 0
+	 * is connected to microTLB 0 on currently supported platforms, so we
+	 * can't use it with the IPMMU. As the IOMMU API operates at the device
+	 * level we can't disable it selectively, so ignore channel 0 for now if
+	 * the device is part of an IOMMU group.
+	 */
+	if (pdev->dev.iommu_group) {
+		dmac->n_channels--;
+		channels_offset = 1;
+	}
+
 	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
 				      sizeof(*dmac->channels), GFP_KERNEL);
 	if (!dmac->channels)
@@ -1662,7 +1676,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
 	for (i = 0; i < dmac->n_channels; ++i) {
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], i);
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i],
+					   i + channels_offset);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.0.5

