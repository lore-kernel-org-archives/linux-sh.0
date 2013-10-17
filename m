From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Oct 2013 10:51:20 +0000
Subject: [PATCH 1/3] rcar-hpbdma: add max transfer size
Message-Id: <87ioww187v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

shdma_chan_probe() can set max transfer size,
but it will be PAGE_SIZE with out this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index ebad845..b1ae8dc 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -510,6 +510,8 @@ static int hpb_dmae_chan_probe(struct hpb_dmae_device *hpbdev, int id)
 	}
 
 	schan = &new_hpb_chan->shdma_chan;
+	schan->max_xfer_len = HPB_DMA_TCR_MAX + 1;
+
 	shdma_chan_probe(sdev, schan, id);
 
 	if (pdev->id >= 0)
-- 
1.7.9.5

