From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Jan 2015 06:52:03 +0000
Subject: [PATCH] dmaengine: rcar-hpbdma: tidyup residue_granularity
Message-Id: <87y4oq9gok.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The driver doesn't support residue reporting at all.
residue_granularity should be set to DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
Special thanks to Laurent

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 6fef1b9..749f26e 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -600,7 +600,7 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 	dma_dev->src_addr_widths = widths;
 	dma_dev->dst_addr_widths = widths;
 	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
-	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
