From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Jun 2011 05:08:18 +0000
Subject: [PATCH 2/3 v2] dmaengine: shdma: tidyup spin_unlock_bh on
Message-Id: <w3paadiicsd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is not readable that there is any spin_unlock_bh on same function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/shdma.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index d2fb16d..3d22eb8 100644
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

