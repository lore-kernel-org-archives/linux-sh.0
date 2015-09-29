From: hamzahfrq.sub@gmail.com
Date: Tue, 29 Sep 2015 20:44:44 +0000
Subject: [PATCH v3 2/6] dma: rcar-dma: Added dma_pause operation to rcar_dma driver
Message-Id: <1443559488-2416-3-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/dma/sh/rcar-dmac.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 2b28291..c7cd4ed 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -774,6 +774,26 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
 	}
 }
 
+static int rcar_dmac_chan_pause(struct dma_chan *chan)
+{
+	u32 chcr;
+	int ret;
+	unsigned long flags;
+	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
+
+	spin_lock_irqsave(&rchan->lock, flags);
+
+	chcr = rcar_dmac_chan_read(rchan, RCAR_DMACHCR);
+	chcr &= ~RCAR_DMACHCR_DE;
+	rcar_dmac_chan_write(rchan, RCAR_DMACHCR, chcr);
+	ret = rcar_dmac_wait_stop(rchan);
+
+	spin_unlock_irqrestore(&rchan->lock, flags);
+
+	WARN_ON(ret < 0);
+	return ret;
+}
+
 static void rcar_dmac_stop(struct rcar_dmac *dmac)
 {
 	rcar_dmac_write(dmac, RCAR_DMAOR, 0);
@@ -1740,6 +1760,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	engine->device_prep_slave_sg = rcar_dmac_prep_slave_sg;
 	engine->device_prep_dma_cyclic = rcar_dmac_prep_dma_cyclic;
 	engine->device_config = rcar_dmac_device_config;
+	engine->device_pause = rcar_dmac_chan_pause;
 	engine->device_terminate_all = rcar_dmac_chan_terminate_all;
 	engine->device_tx_status = rcar_dmac_tx_status;
 	engine->device_issue_pending = rcar_dmac_issue_pending;
-- 
1.9.1

