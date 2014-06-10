From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Jun 2014 23:03:29 +0000
Subject: [PATCH 02/07] DMA: shdma: 40-bit address prototype
Message-Id: <20140610230329.13594.85113.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hack up 40-bit address support via the FIXSAR and FIXDAR
addresses provided by the SYS-DMAC hardware in R-Car Gen2.

The data sheet says that auto increment overflow from SAR
to FIXSAR and DAR to FIXDAR does not happen, so based on
that limit size of DMA transactions that try to cross the
32-bit boundary.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/dma/sh/shdma.h  |    4 +--
 drivers/dma/sh/shdmac.c |   48 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/sh_dma.h  |    2 +
 3 files changed, 46 insertions(+), 8 deletions(-)

--- 0001/drivers/dma/sh/shdma.h
+++ work/drivers/dma/sh/shdma.h	2014-06-10 22:42:47.000000000 +0900
@@ -46,8 +46,8 @@ struct sh_dmae_device {
 };
 
 struct sh_dmae_regs {
-	u32 sar; /* SAR / source address */
-	u32 dar; /* DAR / destination address */
+	dma_addr_t sar; /* SAR / source address */
+	dma_addr_t dar; /* DAR / destination address */
 	u32 tcr; /* TCR / transfer count */
 };
 
--- 0001/drivers/dma/sh/shdmac.c
+++ work/drivers/dma/sh/shdmac.c	2014-06-10 23:08:46.000000000 +0900
@@ -42,6 +42,8 @@
 #define DAR	0x04
 #define TCR	0x08
 #define CHCR	0x0C
+#define FIXSAR  0x10
+#define FIXDAR  0x14
 #define DMAOR	0x40
 
 #define TEND	0x18 /* USB-DMAC */
@@ -217,8 +219,16 @@ static u32 log2size_to_chcr(struct sh_dm
 
 static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
 {
-	sh_dmae_writel(sh_chan, hw->sar, SAR);
-	sh_dmae_writel(sh_chan, hw->dar, DAR);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	if (shdev->pdata->fourty_bits_addr) {
+		sh_dmae_writel(sh_chan, hw->sar >> 32, FIXSAR);
+		sh_dmae_writel(sh_chan, hw->dar >> 32, FIXDAR);
+	}
+#endif
+	sh_dmae_writel(sh_chan, hw->sar & 0xffffffff, SAR);
+	sh_dmae_writel(sh_chan, hw->dar & 0xffffffff, DAR);
 	sh_dmae_writel(sh_chan, hw->tcr >> sh_chan->xmit_shift, TCR);
 }
 
@@ -290,9 +300,9 @@ static void sh_dmae_start_xfer(struct sh
 						    shdma_chan);
 	struct sh_dmae_desc *sh_desc = container_of(sdesc,
 					struct sh_dmae_desc, shdma_desc);
-	dev_dbg(sh_chan->shdma_chan.dev, "Queue #%d to %d: %u@%x -> %x\n",
+	dev_dbg(sh_chan->shdma_chan.dev, "Queue #%d to %d: %u@%pad-> %pad\n",
 		sdesc->async_tx.cookie, sh_chan->shdma_chan.id,
-		sh_desc->hw.tcr, sh_desc->hw.sar, sh_desc->hw.dar);
+		sh_desc->hw.tcr, &sh_desc->hw.sar, &sh_desc->hw.dar);
 	/* Get the ld start address from ld_queue */
 	dmae_set_reg(sh_chan, &sh_desc->hw);
 	dmae_start(sh_chan);
@@ -382,12 +392,30 @@ static int sh_dmae_desc_setup(struct shd
 			      struct shdma_desc *sdesc,
 			      dma_addr_t src, dma_addr_t dst, size_t *len)
 {
+	struct sh_dmae_chan *sh_chan = container_of(schan,
+					struct sh_dmae_chan, shdma_chan);
 	struct sh_dmae_desc *sh_desc = container_of(sdesc,
 					struct sh_dmae_desc, shdma_desc);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 
 	if (*len > schan->max_xfer_len)
 		*len = schan->max_xfer_len;
 
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* unsure if crossing 32-bit boundary really works, disable for now */
+	if (shdev->pdata->fourty_bits_addr) {
+		dma_addr_t limit = 0xffffffff;
+		dma_addr_t src_masked = src & limit;
+		dma_addr_t dst_masked = dst & limit;
+
+		if ((src_masked < limit) && ((src_masked + *len) > limit))
+			*len = limit - src_masked;
+
+		if ((dst_masked < limit) && ((dst_masked + *len) > limit))
+			*len = limit - dst_masked;
+	}
+#endif
+
 	sh_desc->hw.sar = src;
 	sh_desc->hw.dar = dst;
 	sh_desc->hw.tcr = *len;
@@ -463,8 +491,16 @@ static bool sh_dmae_desc_completed(struc
 					struct sh_dmae_chan, shdma_chan);
 	struct sh_dmae_desc *sh_desc = container_of(sdesc,
 					struct sh_dmae_desc, shdma_desc);
-	u32 sar_buf = sh_dmae_readl(sh_chan, SAR);
-	u32 dar_buf = sh_dmae_readl(sh_chan, DAR);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
+	dma_addr_t sar_buf = sh_dmae_readl(sh_chan, SAR);
+	dma_addr_t dar_buf = sh_dmae_readl(sh_chan, DAR);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	if (shdev->pdata->fourty_bits_addr) {
+		sar_buf |= (dma_addr_t)sh_dmae_readl(sh_chan, FIXSAR) << 32;
+		dar_buf |= (dma_addr_t)sh_dmae_readl(sh_chan, FIXDAR) << 32;
+	}
+#endif
 
 	return	(sdesc->direction = DMA_DEV_TO_MEM &&
 		 (sh_desc->hw.dar + sh_desc->hw.tcr) = dar_buf) ||
--- 0001/include/linux/sh_dma.h
+++ work/include/linux/sh_dma.h	2014-06-10 22:45:11.000000000 +0900
@@ -70,6 +70,7 @@ struct sh_dmae_channel {
  * @chclr_present:	DMAC has one or several CHCLR registers
  * @chclr_bitwise:	channel CHCLR registers are bitwise
  * @slave_only:		DMAC cannot be used for MEMCPY
+ * @fourty_bits_addr:	Hardware support dealing with 40 bit addresses
  */
 struct sh_dmae_pdata {
 	const struct sh_dmae_slave_config *slave;
@@ -92,6 +93,7 @@ struct sh_dmae_pdata {
 	unsigned int chclr_present:1;
 	unsigned int chclr_bitwise:1;
 	unsigned int slave_only:1;
+	unsigned int fourty_bits_addr:1;
 };
 
 /* DMAOR definitions */
