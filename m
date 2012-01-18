From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Jan 2012 09:14:25 +0000
Subject: [PATCH 1/2] dma: sh_dma: not all SH DMAC implementations support MEMCPY
Message-Id: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org

Add a flag to allow platforms to specify, whether a DMAC instance supports
the MEMCPY operation. To avoid regressions, preserve the current default.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c    |    3 ++-
 include/linux/sh_dma.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index cabcfe8..e4ed4da 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1267,7 +1267,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&shdev->common.channels);
 
-	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
+	if (!pdata->slave_only)
+		dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
 	if (pdata->slave && pdata->slave_num)
 		dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
 
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index e11e171..db637b9 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -70,6 +70,7 @@ struct sh_dmae_pdata {
 	unsigned int needs_tend_set:1;
 	unsigned int no_dmars:1;
 	unsigned int chclr_present:1;
+	unsigned int slave_only:1;
 };
 
 /* DMA register */
-- 
1.7.2.5

