From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 22:45:12 +0000
Subject: [PATCH 02/11] mmc: sh_mmcif: Fix DMA slave address configuration
Message-Id: <1405464321-4723-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

Commit e5a233cb647d749de2f188477c9a54b94d90477f ("mmc: sh_mmcif:
Factorize DMA channel request and configuration code") incorrectly
set the destination address for both slave channels instead of setting
the source address for the receive channel. Fix that.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 656fbba..436d663 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -386,7 +386,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 			 struct sh_mmcif_plat_data *pdata,
 			 enum dma_transfer_direction direction)
 {
-	struct dma_slave_config cfg;
+	struct dma_slave_config cfg = { 0, };
 	struct dma_chan *chan;
 	unsigned int slave_id;
 	struct resource *res;
@@ -417,8 +417,12 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 	/* In the OF case the driver will get the slave ID from the DT */
 	cfg.slave_id = slave_id;
 	cfg.direction = direction;
-	cfg.dst_addr = res->start + MMCIF_CE_DATA;
-	cfg.src_addr = 0;
+
+	if (direction = DMA_DEV_TO_MEM)
+		cfg.src_addr = res->start + MMCIF_CE_DATA;
+	else
+		cfg.dst_addr = res->start + MMCIF_CE_DATA;
+
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret < 0) {
 		dma_release_channel(chan);
-- 
1.8.5.5

