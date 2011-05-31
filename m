From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 31 May 2011 09:25:16 +0000
Subject: [PATCH] dmaengine: shdma: fix a regression: initialise DMA channels
Message-Id: <Pine.LNX.4.64.1105311123230.10863@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A recent patch has introduced a regression, where repeating a memcpy
DMA test with shdma module unloading between them skips the DMA channel
configuration. Fix this regression by always configuring the channel
during its allocation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 636e409..6eb8454 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -343,7 +343,7 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 
 		dmae_set_dmars(sh_chan, cfg->mid_rid);
 		dmae_set_chcr(sh_chan, cfg->chcr);
-	} else if ((sh_dmae_readl(sh_chan, CHCR) & 0xf00) != 0x400) {
+	} else {
 		dmae_init(sh_chan);
 	}
 
-- 
1.7.2.5

