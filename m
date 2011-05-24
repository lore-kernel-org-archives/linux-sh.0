From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:31:20 +0000
Subject: [PATCH 02/03] dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling
Message-Id: <20110524103120.10334.38798.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the shdma.c handing of SH_DMAC_MAX_CHANNELS
to avoid overwriting the chan_irq[] and chan_flag[]
arrays in the case of pdata->channel_num is larger
than SH_DMAC_MAX_CHANNELS.

With this patch applied up to SH_DMAC_MAX_CHANNELS
will be used by the shdma.c driver. If more channels
are available in the platform data the user will
be notified on the console.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/dma/shdma.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- 0010/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2011-05-24 19:01:08.000000000 +0900
@@ -1052,7 +1052,7 @@ static int __init sh_dmae_probe(struct p
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
 	unsigned long flags;
 	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
-	int err, i, irq_cnt = 0, irqres = 0;
+	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
 
@@ -1177,8 +1177,13 @@ static int __init sh_dmae_probe(struct p
 	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
 		/* Special case - all multiplexed */
 		for (; irq_cnt < pdata->channel_num; irq_cnt++) {
-			chan_irq[irq_cnt] = chanirq_res->start;
-			chan_flag[irq_cnt] = IRQF_SHARED;
+			if (irq_cnt < SH_DMAC_MAX_CHANNELS) {
+				chan_irq[irq_cnt] = chanirq_res->start;
+				chan_flag[irq_cnt] = IRQF_SHARED;
+			} else {
+				irq_cap = 1;
+				break;
+			}
 		}
 	} else {
 		do {
@@ -1192,22 +1197,32 @@ static int __init sh_dmae_probe(struct p
 					"Found IRQ %d for channel %d\n",
 					i, irq_cnt);
 				chan_irq[irq_cnt++] = i;
+
+				if (irq_cnt >= SH_DMAC_MAX_CHANNELS)
+					break;
+			}
+
+			if (irq_cnt >= SH_DMAC_MAX_CHANNELS) {
+				irq_cap = 1;
+				break;
 			}
 			chanirq_res = platform_get_resource(pdev,
 						IORESOURCE_IRQ, ++irqres);
 		} while (irq_cnt < pdata->channel_num && chanirq_res);
 	}
 
-	if (irq_cnt < pdata->channel_num)
-		goto eirqres;
-
 	/* Create DMA Channel */
-	for (i = 0; i < pdata->channel_num; i++) {
+	for (i = 0; i < irq_cnt; i++) {
 		err = sh_dmae_chan_probe(shdev, i, chan_irq[i], chan_flag[i]);
 		if (err)
 			goto chan_probe_err;
 	}
 
+	if (irq_cap)
+		dev_notice(&pdev->dev, "Attempting to register %d DMA "
+			   "channels when a maximum of %d are supported.\n",
+			   pdata->channel_num, SH_DMAC_MAX_CHANNELS);
+
 	pm_runtime_put(&pdev->dev);
 
 	platform_set_drvdata(pdev, shdev);
@@ -1217,7 +1232,7 @@ static int __init sh_dmae_probe(struct p
 
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);
-eirqres:
+
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 	free_irq(errirq, shdev);
 eirq_err:
