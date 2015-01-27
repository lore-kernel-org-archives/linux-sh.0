From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 17:25:14 +0000
Subject: [PATCH 4/6] dmaengine: rcar-dmac: Allocate hardware descriptors with DMAC device
Message-Id: <1422379516-1633-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When wired to an IOMMU to access data, the DMAC accesses the hardware
descriptors through the IOMMU as well. We're using the DMA mapping API
to allocate the descriptors, but with a NULL device at the moment, which
prevents IOMMU mappings from being created. Fix this by passing the DMAC
device instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index e76f5e21f666..9daa7f59e7b0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -655,8 +655,8 @@ static void rcar_dmac_realloc_hwdesc(struct rcar_dmac_chan *chan,
 		return;
 
 	if (desc->hwdescs.mem) {
-		dma_free_coherent(NULL, desc->hwdescs.size, desc->hwdescs.mem,
-				   desc->hwdescs.dma);
+		dma_free_coherent(chan->chan.device->dev, desc->hwdescs.size,
+				  desc->hwdescs.mem, desc->hwdescs.dma);
 		desc->hwdescs.mem = NULL;
 		desc->hwdescs.size = 0;
 	}
@@ -664,8 +664,8 @@ static void rcar_dmac_realloc_hwdesc(struct rcar_dmac_chan *chan,
 	if (!size)
 		return;
 
-	desc->hwdescs.mem = dma_alloc_coherent(NULL, size, &desc->hwdescs.dma,
-					       GFP_NOWAIT);
+	desc->hwdescs.mem = dma_alloc_coherent(chan->chan.device->dev, size,
+					       &desc->hwdescs.dma, GFP_NOWAIT);
 	if (!desc->hwdescs.mem)
 		return;
 
-- 
2.0.5

