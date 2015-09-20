From: hamzahfrq.sub@gmail.com
Date: Sun, 20 Sep 2015 19:10:57 +0000
Subject: [RESEND PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <1442776262-2503-2-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

DMA engine does not stop instantaneously when transaction is going on
(see datasheet). Wait has been added

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/dma/sh/rcar-dmac.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07..b5b5e89 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -716,14 +716,38 @@ static int rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
 /* -----------------------------------------------------------------------------
  * Stop and reset
  */
+#define NR_READS_TO_WAIT (5) /* number of times to check if DE = 0 */
+static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
+{
+	unsigned int i = 0;
+
+	do {
+		u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
+
+		if (!(chcr & RCAR_DMACHCR_DE))
+			return 0;
+		cpu_relax();
+		dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be stopped");
+	} while (++i < NR_READS_TO_WAIT);
 
-static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
+	return -EBUSY;
+}
+
+/* Called with chan lock held */
+static int rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
 {
-	u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
+	u32 chcr;
+	int ret;
 
+	chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
 	chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
-		  RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
+			RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
+	ret = rcar_dmac_wait_stop(chan);
+
+	WARN_ON(ret < 0);
+
+	return ret;
 }
 
 static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
-- 
1.9.1

