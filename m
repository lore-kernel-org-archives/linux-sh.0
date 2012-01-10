From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 06:38:20 +0000
Subject: [PATCH v3 3/3] dmaengine: shdma: add support for SUDMAC
Message-Id: <4F0BDCDC.2010907@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH7757's USB module has SUDMAC. The SUDMAC's registers are imcompatible
with SH DMAC. However, since the SUDMAC is a very simple module, we can
reuse the shdma driver for SUDMAC by a few modification.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v3:
  - No change

 drivers/dma/shdma.c    |  102 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/sh_dma.h |   46 +++++++++++++++++++++
 2 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 4e0ddd6..4ca8921 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -58,6 +58,11 @@ static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SH_DMA_SLAVE_NUMBER)];

 static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);

+static int sh_dmae_is_sudmac(struct sh_dmae_device *shdev)
+{
+	return shdev->pdata->sudmac;
+}
+
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
 {
 	__raw_writel(data, sh_dc->base + reg / sizeof(u32));
@@ -68,6 +73,39 @@ static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 	return __raw_readl(sh_dc->base + reg / sizeof(u32));
 }

+static void sh_dmae_sudmac_chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
+{
+	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+
+	if (!(data & CHCR_TE))	/* clear interrupt status only */
+		sh_dmae_writel(sh_dc, CH0ENDC, DINTSTSCLR);
+
+	if (data & shdev->chcr_ie_bit)
+		sh_dmae_writel(sh_dc, CH0ENDE, DINTCTRL);
+	else
+		sh_dmae_writel(sh_dc, 0, DINTCTRL);
+
+	if (data & CHCR_DE)
+		sh_dmae_writel(sh_dc, DEN, CH0DEN);
+	else
+		sh_dmae_writel(sh_dc, 0, CH0DEN);
+}
+
+static u32 sh_dmae_sudmac_chcr_read(struct sh_dmae_chan *sh_dc)
+{
+	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+	u32 chcr = 0;
+
+	if (sh_dmae_readl(sh_dc, DINTSTS) & CH0ENDS)
+		chcr |= CHCR_TE;
+	if (sh_dmae_readl(sh_dc, DINTCTRL) & CH0ENDE)
+		chcr |= shdev->chcr_ie_bit;
+	if (sh_dmae_readl(sh_dc, CH0DEN) & DEN)
+		chcr |= CHCR_DE;
+
+	return chcr;
+}
+
 static u16 dmaor_read(struct sh_dmae_device *shdev)
 {
 	u32 __iomem *addr = shdev->chan_reg + DMAOR / sizeof(u32);
@@ -92,14 +130,20 @@ static void chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);

-	sh_dmae_writel(sh_dc, data, shdev->chcr_offset);
+	if (sh_dmae_is_sudmac(shdev))
+		sh_dmae_sudmac_chcr_write(sh_dc, data);
+	else
+		sh_dmae_writel(sh_dc, data, shdev->chcr_offset);
 }

 static u32 chcr_read(struct sh_dmae_chan *sh_dc)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);

-	return sh_dmae_readl(sh_dc, shdev->chcr_offset);
+	if (sh_dmae_is_sudmac(shdev))
+		return sh_dmae_sudmac_chcr_read(sh_dc);
+	else
+		return sh_dmae_readl(sh_dc, shdev->chcr_offset);
 }

 /*
@@ -112,6 +156,9 @@ static void sh_dmae_ctl_stop(struct sh_dmae_device *shdev)
 	unsigned short dmaor;
 	unsigned long flags;

+	if (sh_dmae_is_sudmac(shdev))
+		return;
+
 	spin_lock_irqsave(&sh_dmae_lock, flags);

 	dmaor = dmaor_read(shdev);
@@ -125,6 +172,9 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 	unsigned short dmaor;
 	unsigned long flags;

+	if (sh_dmae_is_sudmac(shdev))
+		return 0;
+
 	spin_lock_irqsave(&sh_dmae_lock, flags);

 	dmaor = dmaor_read(shdev) & ~(DMAOR_NMIF | DMAOR_AE | DMAOR_DME);
@@ -159,6 +209,9 @@ static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 	int cnt = ((chcr & pdata->ts_low_mask) >> pdata->ts_low_shift) |
 		((chcr & pdata->ts_high_mask) >> pdata->ts_high_shift);

+	if (sh_dmae_is_sudmac(shdev))
+		return 0;
+
 	if (cnt >= pdata->ts_shift_num)
 		cnt = 0;

@@ -171,6 +224,9 @@ static u32 log2size_to_chcr(struct sh_dmae_chan *sh_chan, int l2size)
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;

+	if (sh_dmae_is_sudmac(shdev))
+		return 0;
+
 	for (i = 0; i < pdata->ts_shift_num; i++)
 		if (pdata->ts_shift[i] = l2size)
 			break;
@@ -184,9 +240,17 @@ static u32 log2size_to_chcr(struct sh_dmae_chan *sh_chan, int l2size)

 static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
 {
-	sh_dmae_writel(sh_chan, hw->sar, SAR);
-	sh_dmae_writel(sh_chan, hw->dar, DAR);
-	sh_dmae_writel(sh_chan, hw->tcr >> sh_chan->xmit_shift, TCR);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
+
+	if (sh_dmae_is_sudmac(shdev)) {
+		sh_dmae_writel(sh_chan, LBA_WAIT | RCVENDM, CH0CFG);
+		sh_dmae_writel(sh_chan, hw->sar, CH0BA);
+		sh_dmae_writel(sh_chan, hw->tcr, CH0BBC);
+	} else {
+		sh_dmae_writel(sh_chan, hw->sar, SAR);
+		sh_dmae_writel(sh_chan, hw->dar, DAR);
+		sh_dmae_writel(sh_chan, hw->tcr >> sh_chan->xmit_shift, TCR);
+	}
 }

 static void dmae_start(struct sh_dmae_chan *sh_chan)
@@ -493,6 +557,7 @@ static struct sh_desc *sh_dmae_add_desc(struct sh_dmae_chan *sh_chan,
 	unsigned long flags, dma_addr_t *dest, dma_addr_t *src, size_t *len,
 	struct sh_desc **first, enum dma_data_direction direction)
 {
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_desc *new;
 	size_t copy_size;

@@ -508,7 +573,14 @@ static struct sh_desc *sh_dmae_add_desc(struct sh_dmae_chan *sh_chan,

 	copy_size = min(*len, (size_t)SH_DMA_TCR_MAX + 1);

-	new->hw.sar = *src;
+	/*
+	 * SUDMAC has a CHnBA register only. So, the driver uses "hw.sar"
+	 * even if transfer direction is DMA_FROM_DEVICE.
+	 */
+	if (sh_dmae_is_sudmac(shdev) && direction = DMA_FROM_DEVICE)
+		new->hw.sar = *dest;
+	else
+		new->hw.sar = *src;
 	new->hw.dar = *dest;
 	new->hw.tcr = copy_size;

@@ -701,8 +773,10 @@ static int sh_dmae_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		/* Record partial transfer */
 		struct sh_desc *desc = list_entry(sh_chan->ld_queue.next,
 						  struct sh_desc, node);
-		desc->partial = (desc->hw.tcr - sh_dmae_readl(sh_chan, TCR)) <<
-			sh_chan->xmit_shift;
+		struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
+		if (!sh_dmae_is_sudmac(shdev))
+			desc->partial = (desc->hw.tcr - sh_dmae_readl(sh_chan,
+						TCR)) << sh_chan->xmit_shift;
 	}
 	spin_unlock_irqrestore(&sh_chan->desc_lock, flags);

@@ -989,9 +1063,17 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 static void dmae_do_tasklet(unsigned long data)
 {
 	struct sh_dmae_chan *sh_chan = (struct sh_dmae_chan *)data;
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_desc *desc;
-	u32 sar_buf = sh_dmae_readl(sh_chan, SAR);
-	u32 dar_buf = sh_dmae_readl(sh_chan, DAR);
+	u32 sar_buf, dar_buf;
+
+	if (sh_dmae_is_sudmac(shdev)) {
+		sar_buf = sh_dmae_readl(sh_chan, CH0CA);
+		dar_buf = sh_dmae_readl(sh_chan, CH0CA);
+	} else {
+		sar_buf = sh_dmae_readl(sh_chan, SAR);
+		dar_buf = sh_dmae_readl(sh_chan, DAR);
+	}

 	spin_lock_irq(&sh_chan->desc_lock);
 	list_for_each_entry(desc, &sh_chan->ld_queue, node) {
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index cb2dd11..9997445 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -68,6 +68,7 @@ struct sh_dmae_pdata {
 	unsigned int dmaor_is_32bit:1;
 	unsigned int needs_tend_set:1;
 	unsigned int no_dmars:1;
+	unsigned int sudmac:1;
 };

 /* DMA register */
@@ -107,4 +108,49 @@ struct sh_dmae_pdata {
 #define CHCR_TE	0x00000002
 #define CHCR_IE	0x00000004

+/* SUDMAC register */
+#define CH0CFG		0x00
+#define CH1CFG		0x04
+#define CH0BA		0x10
+#define CH1BA		0x14
+#define CH0BBC		0x18
+#define CH1BBC		0x1C
+#define CH0CA		0x20
+#define CH1CA		0x24
+#define CH0CBC		0x28
+#define CH1CBC		0x2C
+#define CH0DEN		0x30
+#define CH1DEN		0x34
+#define DSTSCLR		0x38
+#define DBUFCTRL	0x3C
+#define DINTCTRL	0x40
+#define DINTSTS		0x44
+#define DINTSTSCLR	0x48
+#define CH0SHCTRL	0x50
+#define CH1SHCTRL	0x54
+
+/* Definitions for the SUDMAC */
+#define SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
+#define RCVENDM		0x0100 /* b8: Receive Data Transfer End Mode */
+#define LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
+#define DEN		0x0001 /* b0: DMA Transfer Enable */
+#define CH1STCLR	0x0002 /* b1: Ch1 DMA Status Clear */
+#define CH0STCLR	0x0001 /* b0: Ch0 DMA Status Clear */
+#define CH1BUFW		0x0200 /* b9: Ch1 DMA Buffer Data Transfer Enable */
+#define CH0BUFW		0x0100 /* b8: Ch0 DMA Buffer Data Transfer Enable */
+#define CH1BUFS		0x0002 /* b1: Ch1 DMA Buffer Data Status */
+#define CH0BUFS		0x0001 /* b0: Ch0 DMA Buffer Data Status */
+#define CH1ERRE		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Enable */
+#define CH0ERRE		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Enable */
+#define CH1ENDE		0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
+#define CH0ENDE		0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
+#define CH1ERRS		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Status */
+#define CH0ERRS		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Status */
+#define CH1ENDS		0x0002 /* b1: Ch1 DMA Transfer End Int Status */
+#define CH0ENDS		0x0001 /* b0: Ch0 DMA Transfer End Int Status */
+#define CH1ERRC		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Stat Clear */
+#define CH0ERRC		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Stat Clear */
+#define CH1ENDC		0x0002 /* b1: Ch1 DMA Transfer End Int Stat Clear */
+#define CH0ENDC		0x0001 /* b0: Ch0 DMA Transfer End Int Stat Clear */
+
 #endif
-- 
1.7.1
