From: hamzahfrq.sub@gmail.com
Date: Tue, 29 Sep 2015 20:44:46 +0000
Subject: [PATCH v3 4/6] dma: rcar-dma: use result of updated get_residue in tx_status
Message-Id: <1443559488-2416-5-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/dma/sh/rcar-dmac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 6c806d0..0b5a367 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1258,6 +1258,10 @@ static enum dma_status rcar_dmac_tx_status(struct dma_chan *chan,
 	residue = rcar_dmac_chan_get_residue(rchan, cookie);
 	spin_unlock_irqrestore(&rchan->lock, flags);
 
+	/* if there's no residue, the cookie is complete */
+	if (!residue)
+		return DMA_COMPLETE;
+
 	dma_set_residue(txstate, residue);
 
 	return status;
-- 
1.9.1

