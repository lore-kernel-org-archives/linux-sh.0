From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Jan 2015 04:59:14 +0000
Subject: [PATCH 11/17] mmc: tmio: enable SoC specific DMA buswidth settings
Message-Id: <87egqzuvg4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas SDHI which is based on TMIO driver has 2 type SoC. 1st one is
used as SH-Mobile series, and 2nd is R-Car series. R-Car series SoC has
DMA buswidth setting register which enables 32bit access.
This patch adds .dma_buswidth and enables it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     |    2 ++
 drivers/mmc/host/tmio_mmc_dma.c |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0699edb..fc3805e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -16,6 +16,7 @@
 #ifndef TMIO_MMC_H
 #define TMIO_MMC_H
 
+#include <linux/dmaengine.h>
 #include <linux/highmem.h>
 #include <linux/mmc/tmio.h>
 #include <linux/mutex.h>
@@ -46,6 +47,7 @@ struct tmio_mmc_dma {
 	void *chan_priv_rx;
 	int slave_id_tx;
 	int slave_id_rx;
+	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
 };
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index eb6b45c..aa5f4b6 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -293,7 +293,9 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 			cfg.slave_id = host->dma->slave_id_tx;
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.dst_addr_width = host->dma->dma_buswidth;
+		if (!cfg.dst_addr_width)
+			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.src_addr = 0;
 		ret = dmaengine_slave_config(host->chan_tx, &cfg);
 		if (ret < 0)
@@ -312,7 +314,9 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 			cfg.slave_id = host->dma->slave_id_rx;
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.src_addr_width = host->dma->dma_buswidth;
+		if (!cfg.src_addr_width)
+			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.dst_addr = 0;
 		ret = dmaengine_slave_config(host->chan_rx, &cfg);
 		if (ret < 0)
-- 
1.7.9.5

