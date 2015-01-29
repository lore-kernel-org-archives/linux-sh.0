From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 29 Jan 2015 23:59:39 +0000
Subject: [PATCH v2 5/6] dmaengine: rcar-dmac: Work around descriptor mode IOMMU errata
Message-Id: <1422576013-7846-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When descriptor memory is accessed through an IOMMU the DMADAR register
isn't initialized automatically from the first descriptor at beginning
of transfer by the DMAC like it should. Initialize it manually with the
destination address of the first chunk.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index bb93038c48b9..711da01a200b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -325,6 +325,8 @@ static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
 
 	if (desc->hwdescs.use) {
+		struct rcar_dmac_xfer_chunk *chunk;
+
 		dev_dbg(chan->chan.device->dev,
 			"chan%u: queue desc %p: %u@%pad\n",
 			chan->index, desc, desc->nchunks, &desc->hwdescs.dma);
@@ -341,6 +343,18 @@ static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 				     RCAR_DMACHCRB_DRST);
 
 		/*
+		 * Errata: When descriptor memory is accessed through an IOMMU
+		 * the DMADAR register isn't initialized automatically from the
+		 * first descriptor at beginning of transfer by the DMAC like it
+		 * should. Initialize it manually with the destination address
+		 * of the first chunk.
+		 */
+		chunk = list_first_entry(&desc->chunks,
+					 struct rcar_dmac_xfer_chunk, node);
+		rcar_dmac_chan_write(chan, RCAR_DMADAR,
+				     chunk->dst_addr & 0xffffffff);
+
+		/*
 		 * Program the descriptor stage interrupt to occur after the end
 		 * of the first stage.
 		 */
-- 
2.0.5

