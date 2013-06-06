From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:37:13 +0000
Subject: [PATCH 1/2] DMA: shdma: (cosmetic) don't re-calculate a pointer
Message-Id: <1370533034-23511-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use an existing pointer instead of retrieving it again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index b70709b..a5a1887 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -729,7 +729,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 		goto eshdma;
 
 	/* platform data */
-	shdev->pdata = pdev->dev.platform_data;
+	shdev->pdata = pdata;
 
 	if (pdata->chcr_offset)
 		shdev->chcr_offset = pdata->chcr_offset;
-- 
1.7.2.5

