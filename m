From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 10:16:44 +0000
Subject: [PATCH v2 2/2] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
Message-Id: <1385547404-13703-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512480-10432-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512480-10432-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Casting an integer to a void * generates a "cast to pointer from integer
of different size" warning. Cast the integer to an uintptr_t first to
fix it.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes compared to v1:

- Cast to uintptr_t instead of unsigned long

Patch 1/2 hasn't been changed.

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bebf2fe..dff55da 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -403,7 +403,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 		slave_id = 0;
 
 	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				(void *)slave_id, &host->pd->dev,
+				(void *)(uintptr_t)slave_id, &host->pd->dev,
 				direction = DMA_MEM_TO_DEV ? "tx" : "rx");
 
 	dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
-- 
1.8.3.2

