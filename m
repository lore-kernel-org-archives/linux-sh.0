From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:14:11 +0000
Subject: [PATCH 2/8 v3] mmc: sh_mmcif: remove slave_id settings for DMAEngine
Message-Id: <87d268ojlk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current sh_mmcif sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2 -> v3

 - slave_data = NULL

 drivers/mmc/host/sh_mmcif.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7d9d6a3..e83b126 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -388,7 +388,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 {
 	struct dma_slave_config cfg = { 0, };
 	struct dma_chan *chan;
-	unsigned int slave_id;
+	void *slave_data;
 	struct resource *res;
 	dma_cap_mask_t mask;
 	int ret;
@@ -397,13 +397,13 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 	dma_cap_set(DMA_SLAVE, mask);
 
 	if (pdata)
-		slave_id = direction = DMA_MEM_TO_DEV
-			 ? pdata->slave_id_tx : pdata->slave_id_rx;
+		slave_data = direction = DMA_MEM_TO_DEV
+			? (void *)pdata->slave_id_tx : (void *)pdata->slave_id_rx;
 	else
-		slave_id = 0;
+		slave_data = NULL;
 
 	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				(void *)(unsigned long)slave_id, &host->pd->dev,
+				slave_data, &host->pd->dev,
 				direction = DMA_MEM_TO_DEV ? "tx" : "rx");
 
 	dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
@@ -414,8 +414,6 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 
 	res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
 
-	/* In the OF case the driver will get the slave ID from the DT */
-	cfg.slave_id = slave_id;
 	cfg.direction = direction;
 
 	if (direction = DMA_DEV_TO_MEM) {
-- 
1.7.9.5

