From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 May 2010 15:30:12 +0000
Subject: [PATCH] sh: guard cookie consistency across termination in the DMA
Message-Id: <Pine.LNX.4.64.1005211728520.8450@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If all descriptors on a channel are terminated or the channel is released,
update the completed cookie counter to match the last cookie. This prevents
inconsistency warning on resumed DMA operation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 58563a0..041c6a3 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -714,6 +714,10 @@ static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all)
 {
 	while (__ld_cleanup(sh_chan, all))
 		;
+
+	if (all)
+		/* Terminating - forgive uncompleted cookies */
+		sh_chan->completed_cookie = sh_chan->common.cookie;
 }
 
 static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan)
-- 
1.6.2.4

