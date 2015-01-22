From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 02:32:51 +0000
Subject: [PATCH 2/2] dmaengine: shdmac: fixup WARNING of slave caps retrieval
Message-Id: <8761bzmtmd.wl%kuninori.morimoto.gx@renesas.com>
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
 drivers/dma/sh/shdmac.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index aec8a84..ce4cd6b 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -684,6 +684,10 @@ MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
 
 static int sh_dmae_probe(struct platform_device *pdev)
 {
+	const enum dma_slave_buswidth widths +		DMA_SLAVE_BUSWIDTH_1_BYTE   | DMA_SLAVE_BUSWIDTH_2_BYTES |
+		DMA_SLAVE_BUSWIDTH_4_BYTES  | DMA_SLAVE_BUSWIDTH_8_BYTES |
+		DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES;
 	const struct sh_dmae_pdata *pdata;
 	unsigned long chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int chan_irq[SH_DMAE_MAX_CHANNELS];
@@ -746,6 +750,11 @@ static int sh_dmae_probe(struct platform_device *pdev)
 			return PTR_ERR(shdev->dmars);
 	}
 
+	dma_dev->src_addr_widths = widths;
+	dma_dev->dst_addr_widths = widths;
+	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
 	if (!pdata->slave_only)
 		dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	if (pdata->slave && pdata->slave_num)
-- 
1.7.9.5

