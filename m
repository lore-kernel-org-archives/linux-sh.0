From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 00:29:51 +0000
Subject: [PATCH 2/3] DMA: shdma: Fix warnings due to declared but unused symbols
Message-Id: <1385512192-10303-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Several functions and variables are use on SH_CPU4 or ARM only. Guard
their declaration with conditional compilation directives to avoid
warnings.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 0d765c0..2150987 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -443,6 +443,7 @@ static bool sh_dmae_reset(struct sh_dmae_device *shdev)
 	return ret;
 }
 
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
 	struct sh_dmae_device *shdev = data;
@@ -453,6 +454,7 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	sh_dmae_reset(shdev);
 	return IRQ_HANDLED;
 }
+#endif
 
 static bool sh_dmae_desc_completed(struct shdma_chan *schan,
 				   struct shdma_desc *sdesc)
@@ -685,9 +687,12 @@ MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
 static int sh_dmae_probe(struct platform_device *pdev)
 {
 	const struct sh_dmae_pdata *pdata;
-	unsigned long irqflags = 0,
-		chan_flag[SH_DMAE_MAX_CHANNELS] = {};
-	int errirq, chan_irq[SH_DMAE_MAX_CHANNELS];
+	unsigned long chan_flag[SH_DMAE_MAX_CHANNELS] = {};
+	int chan_irq[SH_DMAE_MAX_CHANNELS];
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARM)
+	unsigned long irqflags = 0;
+	int errirq;
+#endif
 	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
 	struct dma_device *dma_dev;
-- 
1.8.3.2

