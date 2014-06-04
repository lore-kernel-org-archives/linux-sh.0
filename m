From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:12 +0000
Subject: [PATCH 5/8] shdmac: fdt: wire r8a7790 for device tree usage.
Message-Id: <1401898455-31064-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for R8A7790 with new device tree code

Note, not yet converted the only other user to dt yet

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdmac.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 146d5df..e525f80 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -680,7 +680,8 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
-	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
+	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
@@ -699,10 +700,17 @@ static int sh_dmae_probe(struct platform_device *pdev)
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
2.0.0.rc2

