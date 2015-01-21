From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:14:37 +0000
Subject: [PATCH 3/8 v3] mmc: tmio_mmc: remove slave_id settings for DMAEngine
Message-Id: <87bnlsojks.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current tmio_mmc sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2 -> v3

 - Add Ulf/Arnd's Acked-by

 drivers/mmc/host/sh_mobile_sdhi.c |    2 --
 drivers/mmc/host/tmio_mmc.h       |    2 --
 drivers/mmc/host/tmio_mmc_dma.c   |    4 ----
 3 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 6906a90..11991f5 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -261,8 +261,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			 */
 			dma_priv->chan_priv_tx = (void *)p->dma_slave_tx;
 			dma_priv->chan_priv_rx = (void *)p->dma_slave_rx;
-			dma_priv->slave_id_tx = p->dma_slave_tx;
-			dma_priv->slave_id_rx = p->dma_slave_rx;
 		}
 	}
 	dma_priv->filter = shdma_chan_filter;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index fc3805e..1aea5c6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -45,8 +45,6 @@ struct tmio_mmc_host;
 struct tmio_mmc_dma {
 	void *chan_priv_tx;
 	void *chan_priv_rx;
-	int slave_id_tx;
-	int slave_id_rx;
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 331bb61..8dbd785 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -286,8 +286,6 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_tx)
 			return;
 
-		if (host->dma->chan_priv_tx)
-			cfg.slave_id = host->dma->slave_id_tx;
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
 		cfg.dst_addr_width = host->dma->dma_buswidth;
@@ -307,8 +305,6 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_rx)
 			goto ereqrx;
 
-		if (host->dma->chan_priv_rx)
-			cfg.slave_id = host->dma->slave_id_rx;
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
 		cfg.src_addr_width = host->dma->dma_buswidth;
-- 
1.7.9.5

