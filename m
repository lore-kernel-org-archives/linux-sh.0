From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 07 Apr 2014 20:07:09 +0000
Subject: [PATCH 9/9] DMA: shdma: wire r8a7790
Message-Id: <1396901229-29117-10-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

Add support for R8A7790 with new device tree code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdmac.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 0d765c0..84ba8d1 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -677,7 +677,8 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
-	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
+	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
@@ -693,10 +694,17 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	struct dma_device *dma_dev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
 
-	if (pdev->dev.of_node)
-		pdata = of_match_device(sh_dmae_of_match, &pdev->dev)->data;
-	else
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_device(sh_dmae_of_match, &pdev->dev);
+		if (match->data = r8a73a4_shdma_devid)
+			pdata = match->data;
+		else
+			pdata = sh_dma_probe_of(pdev, match);
+	} else {
 		pdata = dev_get_platdata(&pdev->dev);
+	}
 
 	/* get platform data */
 	if (!pdata || !pdata->channel_num)
-- 
1.9.1

