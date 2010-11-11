From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Nov 2010 11:13:15 +0000
Subject: [PATCH] mmc: tmio_mmc: allow multi-element scatter-gather lists
Message-Id: <Pine.LNX.4.64.1011111210590.15747@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The driver is capable of handling multi-element sg lists in both PIO and DMA
modes. In DMA mode this also allows to use the DMA sg capability more
efficiently and almost doubles the throughput.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e7765a8..9034414 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -864,10 +864,14 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 		goto host_free;
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
-	mmc->caps |= pdata->capabilities;
+	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
+	mmc->max_segs = 32;
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = PAGE_CACHE_SIZE / mmc->max_blk_size * mmc->max_segs;
+	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+	mmc->max_seg_size = mmc->max_req_size;
 	if (pdata->ocr_mask)
 		mmc->ocr_avail = pdata->ocr_mask;
 	else
-- 
1.7.2.3

