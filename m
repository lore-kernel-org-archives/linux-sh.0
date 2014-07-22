From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:49 +0000
Subject: [PATCH/RFC 3/5] dmaengine: rcar-dmac: Compute maximum chunk size at runtime
Message-Id: <1406032431-3807-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DMAC expressed DMA request lengths as a number of transfers, limited
to 16777216 by the hardware. As a single transfer transfers a
configurable number of bytes (from 1 to 64), the chunk size limit isn't
fixed and must be computed at runtime by multiplying the transfers
number limit by the transfer size.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 09df914..371cca3 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -242,7 +242,6 @@ struct rcar_dmac {
 
 /* Hardcode the MEMCPY transfer size to 4 bytes. */
 #define RCAR_DMAC_MEMCPY_XFER_SIZE	4
-#define RCAR_DMAC_MAX_XFER_LEN		(RCAR_DMATCR_MASK + 1)
 
 /* -----------------------------------------------------------------------------
  * Device access
@@ -701,6 +700,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 	struct rcar_dmac_xfer_chunk *chunk;
 	struct rcar_dmac_desc *desc;
 	struct scatterlist *sg = sgl;
+	size_t max_chunk_size;
 	size_t full_size = 0;
 	unsigned int i;
 
@@ -716,6 +716,8 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 
 	rcar_dmac_chan_configure_desc(chan, desc);
 
+	max_chunk_size = (RCAR_DMATCR_MASK + 1) << desc->xfer_shift;
+
 	/*
 	 * Allocate and fill the transfer chunk descriptors. We own the only
 	 * reference to the DMA descriptor, there's no need for locking.
@@ -727,7 +729,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 		full_size += len;
 
 		while (len) {
-			size_t size = min_t(size_t, len, RCAR_DMAC_MAX_XFER_LEN);
+			size_t size = min_t(size_t, len, max_chunk_size);
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 			/*
-- 
1.8.5.5

