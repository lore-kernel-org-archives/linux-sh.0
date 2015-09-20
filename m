From: hamzahfrq.sub@gmail.com
Date: Sun, 20 Sep 2015 19:11:01 +0000
Subject: [RESEND PATCH 5/6] dma: rcar-dma: warn if transfer cannot start as TE = 1
Message-Id: <1442776262-2503-6-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/dma/sh/rcar-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index ce21575..d007351 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -327,7 +327,8 @@ static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
 	struct rcar_dmac_desc *desc = chan->desc.running;
 	u32 chcr = desc->chcr;
 
-	WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan));
+	WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan) ||
+			rcar_dmac_last_tx_complete(chan));
 
 	if (chan->mid_rid >= 0)
 		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
-- 
1.9.1

