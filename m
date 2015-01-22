From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 03:48:17 +0000
Subject: [PATCH 4/9 v4] mtd: sh_flctl: remove slave_id settings for DMAEngine
Message-Id: <87y4ovlbk7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Current sh_flctl sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - no change

 drivers/mtd/nand/sh_flctl.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index a21c378..c3ce81c 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -159,7 +159,6 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 		return;
 
 	memset(&cfg, 0, sizeof(cfg));
-	cfg.slave_id = pdata->slave_id_fifo0_tx;
 	cfg.direction = DMA_MEM_TO_DEV;
 	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
 	cfg.src_addr = 0;
@@ -175,7 +174,6 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 	if (!flctl->chan_fifo0_rx)
 		goto err;
 
-	cfg.slave_id = pdata->slave_id_fifo0_rx;
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.dst_addr = 0;
 	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
-- 
1.7.9.5

