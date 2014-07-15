From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 22:45:15 +0000
Subject: [PATCH 05/11] mmc: tmio: Fix DMA source address
Message-Id: <1405464321-4723-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

DMA reads from the data buffer register must be offset by 0x2000
according to the hardware documentation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index eb8f1d5..4da7be1 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -312,7 +312,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (pdata->dma->chan_priv_rx)
 			cfg.slave_id = pdata->dma->slave_id_rx;
 		cfg.direction = DMA_DEV_TO_MEM;
-		cfg.src_addr = cfg.dst_addr;
+		cfg.src_addr = cfg.dst_addr + 0x2000;
 		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.dst_addr = 0;
 		ret = dmaengine_slave_config(host->chan_rx, &cfg);
-- 
1.8.5.5

