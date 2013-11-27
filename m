From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 10:17:28 +0000
Subject: [PATCH v2] mtd: sh_flctl: Fix warnings due to improper casts
Message-Id: <1385547448-13747-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>

Cast pointers to uintptr_t instead of unsigned int. This fixes warnings
on platforms where pointers have a different size than int.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mtd/nand/sh_flctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes compared to v1:

- Cast to uintptr_t instead of unsigned long

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index a3c84eb..0f135cb 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -151,7 +151,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	flctl->chan_fifo0_tx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_fifo0_tx);
+				(void *)(uintptr_t)pdata->slave_id_fifo0_tx);
 	dev_dbg(&pdev->dev, "%s: TX: got channel %p\n", __func__,
 		flctl->chan_fifo0_tx);
 
@@ -168,7 +168,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 		goto err;
 
 	flctl->chan_fifo0_rx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_fifo0_rx);
+				(void *)(uintptr_t)pdata->slave_id_fifo0_rx);
 	dev_dbg(&pdev->dev, "%s: RX: got channel %p\n", __func__,
 		flctl->chan_fifo0_rx);
 
-- 
1.8.3.2

