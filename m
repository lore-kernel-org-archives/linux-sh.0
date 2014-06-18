From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:10:03 +0000
Subject: [PROTOTYPE 2/8] DMA: shdma: wire r8a7790
Message-Id: <87k38ey45w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add support for R8A7790 with new device tree code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdmac.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 146d5df..f2ecec8 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -343,11 +343,21 @@ static const struct sh_dmae_slave_config *dmae_find_slave(
 			if (cfg->slave_id = match)
 				return cfg;
 	} else {
-		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
-			if (cfg->mid_rid = match) {
+		if (!pdata->slave) {
+			cfg = shdma_find_slave_of(shdev, match, &i);
+			if (cfg) {
 				sh_chan->shdma_chan.slave_id = i;
 				return cfg;
 			}
+
+			return NULL;
+		} else
+			for (i = 0, cfg = pdata->slave; i < pdata->slave_num;
+			     i++, cfg++)
+				if (cfg->mid_rid = match) {
+					sh_chan->shdma_chan.slave_id = i;
+					return cfg;
+				}
 	}
 
 	return NULL;
@@ -680,7 +690,8 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
-	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
+	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
@@ -699,10 +710,17 @@ static int sh_dmae_probe(struct platform_device *pdev)
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
@@ -751,7 +769,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	if (!pdata->slave_only)
 		dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
-	if (pdata->slave && pdata->slave_num)
+	if ((pdata->slave && pdata->slave_num) || pdev->dev.of_node)
 		dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
-- 
1.7.9.5

