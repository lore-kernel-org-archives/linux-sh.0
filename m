From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 06:35:08 +0000
Subject: [PATCH] dmaengine: shdma: SH_DMAC_MAX_CHANNELS message fix
Message-Id: <20110609063508.900.47534.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the recently added SH_DMAC_MAX_CHANNELS handling code in
300e5f9 dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling

Without this fix the shdma driver outputs silly messages in
case SH_DMAC_MAX_CHANNELS happens to match the platform data:

sh-dma-engine sh-dma-engine.0: Attempting to register 20 DMA channels when a max
imum of 20 are supported.            

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/dma/shdma.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- 0001/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2011-05-27 18:42:06.000000000 +0900
@@ -1219,6 +1219,11 @@ static int __init sh_dmae_probe(struct p
 	} else {
 		do {
 			for (i = chanirq_res->start; i <= chanirq_res->end; i++) {
+				if (irq_cnt >= SH_DMAC_MAX_CHANNELS) {
+					irq_cap = 1;
+					break;
+				}
+
 				if ((errirq_res->flags & IORESOURCE_BITS) =
 				    IORESOURCE_IRQ_SHAREABLE)
 					chan_flag[irq_cnt] = IRQF_SHARED;
@@ -1228,15 +1233,11 @@ static int __init sh_dmae_probe(struct p
 					"Found IRQ %d for channel %d\n",
 					i, irq_cnt);
 				chan_irq[irq_cnt++] = i;
-
-				if (irq_cnt >= SH_DMAC_MAX_CHANNELS)
-					break;
 			}
 
-			if (irq_cnt >= SH_DMAC_MAX_CHANNELS) {
-				irq_cap = 1;
+			if (irq_cnt >= SH_DMAC_MAX_CHANNELS)
 				break;
-			}
+
 			chanirq_res = platform_get_resource(pdev,
 						IORESOURCE_IRQ, ++irqres);
 		} while (irq_cnt < pdata->channel_num && chanirq_res);
