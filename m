From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Jun 2011 06:14:07 +0000
Subject: [PATCH 3/5] dmaengine: shdma: tidyup spin_unlock_bh on
Message-Id: <w3pd3if62q9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is not readable that there is any spin_unlock_bh on same function.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/dma/shdma.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 8748df3..f7b3c06 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -766,10 +766,8 @@ static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 
 	spin_lock_bh(&sh_chan->desc_lock);
 	/* DMA work check */
-	if (dmae_is_busy(sh_chan)) {
-		spin_unlock_bh(&sh_chan->desc_lock);
-		return;
-	}
+	if (dmae_is_busy(sh_chan))
+		goto sh_chan_xfer_ld_queue_end;
 
 	/* Find the first not transferred descriptor */
 	list_for_each_entry(desc, &sh_chan->ld_queue, node)
@@ -783,6 +781,7 @@ static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
 			break;
 		}
 
+sh_chan_xfer_ld_queue_end:
 	spin_unlock_bh(&sh_chan->desc_lock);
 }
 
-- 
1.7.4.1

