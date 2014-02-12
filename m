From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 12 Feb 2014 17:59:24 +0000
Subject: [PATCH 5/5] shdmac: wire r8a7790
Message-Id: <1392227964-7088-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for R8a7790 with new device tree code

Note, does not yet moved the other of-dma user yet.
---
 drivers/dma/sh/shdmac.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 0d765c0..8af2082 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -677,7 +677,8 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
-	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
@@ -693,9 +694,15 @@ static int sh_dmae_probe(struct platform_device *pdev)
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
+	} else
 		pdata = dev_get_platdata(&pdev->dev);
 
 	/* get platform data */
-- 
1.8.5.3

