From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Jul 2013 16:29:31 +0000
Subject: [PATCH v2 06/15] DMA: shdma: make multiplexer platform data optional
Message-Id: <1374251374-30186-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Instead of supplying platform data to the shdma dmaengine driver via
AUXDATA in the DT case, we now support platform data via an OF match table.
Make platform data optional.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma-of.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 11bcb05..2acf7b6 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -45,9 +45,6 @@ static int shdma_of_probe(struct platform_device *pdev)
 	const struct of_dev_auxdata *lookup = pdev->dev.platform_data;
 	int ret;
 
-	if (!lookup)
-		return -EINVAL;
-
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 shdma_of_xlate, pdev);
 	if (ret < 0)
-- 
1.7.2.5

