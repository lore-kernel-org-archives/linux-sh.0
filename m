From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Jan 2015 08:10:21 +0000
Subject: [PATCH] dma: rcar-hpbdma: add dma_dev->directions
Message-Id: <87r3v8uy5p.wl%kuninori.morimoto.gx@renesas.com>
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
 drivers/dma/sh/rcar-hpbdma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 20a6f6f..0a1fdbd 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -595,6 +595,7 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
-- 
1.7.9.5

