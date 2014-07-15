From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 22:45:13 +0000
Subject: [PATCH 03/11] mmc: sh_mmcif: Configure DMA slave bus width
Message-Id: <1405464321-4723-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

The data register is 4 bytes wide, hardcode the DMA transfer size to
4 bytes in both directions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 436d663..cc8ae09 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -418,10 +418,13 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 	cfg.slave_id = slave_id;
 	cfg.direction = direction;
 
-	if (direction = DMA_DEV_TO_MEM)
+	if (direction = DMA_DEV_TO_MEM) {
 		cfg.src_addr = res->start + MMCIF_CE_DATA;
-	else
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
 		cfg.dst_addr = res->start + MMCIF_CE_DATA;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret < 0) {
-- 
1.8.5.5

