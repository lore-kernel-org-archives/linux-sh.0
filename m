From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 03:39:23 +0000
Subject: [RFC][PATCH 1/6] dmaengine: shdma: add chcr_write/read function
Message-Id: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CHCR register position is not same in all DMAC.
This patch adds new "int chcr_offset" to decide it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/shdma.c    |   35 +++++++++++++++++++++++++++--------
 drivers/dma/shdma.h    |    1 +
 include/linux/sh_dma.h |    1 +
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 41a21b3..40900c1 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -78,6 +78,20 @@ static void dmaor_write(struct sh_dmae_device *shdev, u16 data)
 	__raw_writew(data, shdev->chan_reg + DMAOR / sizeof(u32));
 }
 
+static void chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
+{
+	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+
+	__raw_writel(data, sh_dc->base + shdev->chcr_offset / sizeof(u32));
+}
+
+static u32 chcr_read(struct sh_dmae_chan *sh_dc)
+{
+	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+
+	return __raw_readl(sh_dc->base + shdev->chcr_offset / sizeof(u32));
+}
+
 /*
  * Reset DMA controller
  *
@@ -120,7 +134,7 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 
 static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 {
-	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+	u32 chcr = chcr_read(sh_chan);
 
 	if ((chcr & (CHCR_DE | CHCR_TE)) = CHCR_DE)
 		return true; /* working */
@@ -167,18 +181,18 @@ static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
 
 static void dmae_start(struct sh_dmae_chan *sh_chan)
 {
-	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+	u32 chcr = chcr_read(sh_chan);
 
 	chcr |= CHCR_DE | CHCR_IE;
-	sh_dmae_writel(sh_chan, chcr & ~CHCR_TE, CHCR);
+	chcr_write(sh_chan, chcr & ~CHCR_TE);
 }
 
 static void dmae_halt(struct sh_dmae_chan *sh_chan)
 {
-	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
+	u32 chcr = chcr_read(sh_chan);
 
 	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
-	sh_dmae_writel(sh_chan, chcr, CHCR);
+	chcr_write(sh_chan, chcr);
 }
 
 static void dmae_init(struct sh_dmae_chan *sh_chan)
@@ -190,7 +204,7 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
 	u32 chcr = DM_INC | SM_INC | 0x400 | log2size_to_chcr(sh_chan,
 						   LOG2_DEFAULT_XFER_SIZE);
 	sh_chan->xmit_shift = calc_xmit_shift(sh_chan, chcr);
-	sh_dmae_writel(sh_chan, chcr, CHCR);
+	chcr_write(sh_chan, chcr);
 }
 
 static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
@@ -200,7 +214,7 @@ static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 		return -EBUSY;
 
 	sh_chan->xmit_shift = calc_xmit_shift(sh_chan, val);
-	sh_dmae_writel(sh_chan, val, CHCR);
+	chcr_write(sh_chan, val);
 
 	return 0;
 }
@@ -840,7 +854,7 @@ static irqreturn_t sh_dmae_interrupt(int irq, void *data)
 
 	spin_lock(&sh_chan->desc_lock);
 
-	chcr = sh_dmae_readl(sh_chan, CHCR);
+	chcr = chcr_read(sh_chan);
 
 	if (chcr & CHCR_TE) {
 		/* DMA stop */
@@ -1138,6 +1152,11 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	/* platform data */
 	shdev->pdata = pdata;
 
+	if (pdata->chcr_offset)
+		shdev->chcr_offset = pdata->chcr_offset;
+	else
+		shdev->chcr_offset = CHCR;
+
 	platform_set_drvdata(pdev, shdev);
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 6c73b65..1305b67 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -47,6 +47,7 @@ struct sh_dmae_device {
 	struct list_head node;
 	u32 __iomem *chan_reg;
 	u16 __iomem *dmars;
+	u32 chcr_offset;
 };
 
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index b08cd4e..4f2cad9 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -62,6 +62,7 @@ struct sh_dmae_pdata {
 	const unsigned int *ts_shift;
 	int ts_shift_num;
 	u16 dmaor_init;
+	u32 chcr_offset;
 };
 
 /* DMA register */
-- 
1.7.4.1

