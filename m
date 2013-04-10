From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Apr 2013 22:19:44 +0000
Subject: [PATCH 1/6] DMA: shdma: (cosmetic) don't re-calculate a pointer
Message-Id: <1365632389-2249-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

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

