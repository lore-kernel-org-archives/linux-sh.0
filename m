From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 03 Apr 2014 03:16:51 +0000
Subject: [PATCH 1/2] DMA: shdma: tidyup callback chunk finder
Message-Id: <87k3b7rtjw.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current shdma is using "last" which indicates last desc
which needs to have callback function.
but, that desc's chunks is always 1
We can use it as finder

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/shdma-base.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 5239677..6786ecb 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -73,8 +73,7 @@ static void shdma_chan_xfer_ld_queue(struct shdma_chan *schan)
 static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct shdma_desc *chunk, *c, *desc -		container_of(tx, struct shdma_desc, async_tx),
-		*last = desc;
+		container_of(tx, struct shdma_desc, async_tx);
 	struct shdma_chan *schan = to_shdma_chan(tx->chan);
 	dma_async_tx_callback callback = tx->callback;
 	dma_cookie_t cookie;
@@ -98,19 +97,20 @@ static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
 				      &chunk->node = &schan->ld_free))
 			break;
 		chunk->mark = DESC_SUBMITTED;
-		/* Callback goes to the last chunk */
-		chunk->async_tx.callback = NULL;
+		if (chunk->chunks = 1) {
+			chunk->async_tx.callback = callback;
+			chunk->async_tx.callback_param = tx->callback_param;
+		} else {
+			/* Callback goes to the last chunk */
+			chunk->async_tx.callback = NULL;
+		}
 		chunk->cookie = cookie;
 		list_move_tail(&chunk->node, &schan->ld_queue);
-		last = chunk;
 
 		dev_dbg(schan->dev, "submit #%d@%p on %d\n",
-			tx->cookie, &last->async_tx, schan->id);
+			tx->cookie, &chunk->async_tx, schan->id);
 	}
 
-	last->async_tx.callback = callback;
-	last->async_tx.callback_param = tx->callback_param;
-
 	if (power_up) {
 		int ret;
 		schan->pm_state = SHDMA_PM_BUSY;
-- 
1.7.9.5

