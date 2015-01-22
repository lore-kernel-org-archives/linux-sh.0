From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 02:32:41 +0000
Subject: [PATCH 1/2] dmaengine: rcar-hpbdma: fixup WARNING of slave caps retrieval
Message-Id: <877fwfmtmn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ecc19d17868be9c9f8f00ed928791533c420f3e0
(dmaengine: Add a warning for drivers not using the generic slave
caps retrieval) added WARN() for DMA_SLAVE.
Kernel will shows WARNING without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 20a6f6f..749f26e 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -534,6 +534,8 @@ static int hpb_dmae_chan_probe(struct hpb_dmae_device *hpbdev, int id)
 
 static int hpb_dmae_probe(struct platform_device *pdev)
 {
+	const enum dma_slave_buswidth widths = DMA_SLAVE_BUSWIDTH_1_BYTE |
+		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES;
 	struct hpb_dmae_pdata *pdata = pdev->dev.platform_data;
 	struct hpb_dmae_device *hpbdev;
 	struct dma_device *dma_dev;
@@ -595,6 +597,10 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_dev->src_addr_widths = widths;
+	dma_dev->dst_addr_widths = widths;
+	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
-- 
1.7.9.5

