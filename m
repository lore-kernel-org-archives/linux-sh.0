From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 08:20:51 +0000
Subject: [RFC][PATCH 2/6 v3] dmaengine: shdma: add chcr_ie_bit
Message-Id: <w3p62o4q36k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

IE bit position on CHCR register is not same in all DMAC.
This patch adds new "chcr_ie_bit" to decide it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

- same as v2 but based on v3 1/6 patch

 drivers/dma/shdma.c    |   11 +++++++++--
 drivers/dma/shdma.h    |    1 +
 include/linux/sh_dma.h |    1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 40900c1..9412de3 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -181,17 +181,19 @@ static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
 
 static void dmae_start(struct sh_dmae_chan *sh_chan)
 {
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	u32 chcr = chcr_read(sh_chan);
 
-	chcr |= CHCR_DE | CHCR_IE;
+	chcr |= CHCR_DE | shdev->chcr_ie_bit;
 	chcr_write(sh_chan, chcr & ~CHCR_TE);
 }
 
 static void dmae_halt(struct sh_dmae_chan *sh_chan)
 {
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	u32 chcr = chcr_read(sh_chan);
 
-	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
+	chcr &= ~(CHCR_DE | CHCR_TE | shdev->chcr_ie_bit);
 	chcr_write(sh_chan, chcr);
 }
 
@@ -1157,6 +1159,11 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	else
 		shdev->chcr_offset = CHCR;
 
+	if (pdata->chcr_ie_bit)
+		shdev->chcr_ie_bit = pdata->chcr_ie_bit;
+	else
+		shdev->chcr_ie_bit = CHCR_IE;
+
 	platform_set_drvdata(pdev, shdev);
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 6f064ca..dc56576 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -48,6 +48,7 @@ struct sh_dmae_device {
 	u32 __iomem *chan_reg;
 	u16 __iomem *dmars;
 	unsigned int chcr_offset;
+	u32 chcr_ie_bit;
 };
 
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 41fe4c2..96803aa 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -63,6 +63,7 @@ struct sh_dmae_pdata {
 	int ts_shift_num;
 	u16 dmaor_init;
 	unsigned int chcr_offset;
+	u32 chcr_ie_bit;
 };
 
 /* DMA register */
-- 
1.7.4.1

