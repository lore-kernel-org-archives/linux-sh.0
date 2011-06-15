From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Jun 2011 06:13:55 +0000
Subject: [PATCH 1/5] dmaengine: shdma: tidyup addr definition
Message-Id: <w3pfwnb62qk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

"void __iomem *" is useful

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/dma/shdma.c |   16 ++++++++--------
 drivers/dma/shdma.h |    6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 2a638f9..8bb77b5 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -60,22 +60,22 @@ static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
 
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
 {
-	__raw_writel(data, sh_dc->base + reg / sizeof(u32));
+	__raw_writel(data, sh_dc->base + reg);
 }
 
 static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 {
-	return __raw_readl(sh_dc->base + reg / sizeof(u32));
+	return __raw_readl(sh_dc->base + reg);
 }
 
 static u16 dmaor_read(struct sh_dmae_device *shdev)
 {
-	return __raw_readw(shdev->chan_reg + DMAOR / sizeof(u32));
+	return __raw_readw(shdev->chan_reg + DMAOR);
 }
 
 static void dmaor_write(struct sh_dmae_device *shdev, u16 data)
 {
-	__raw_writew(data, shdev->chan_reg + DMAOR / sizeof(u32));
+	__raw_writew(data, shdev->chan_reg + DMAOR);
 }
 
 /*
@@ -213,7 +213,7 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 						struct sh_dmae_device, common);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
-	u16 __iomem *addr = shdev->dmars;
+	void __iomem *addr = shdev->dmars;
 	int shift = chan_pdata->dmars_bit;
 
 	if (dmae_is_busy(sh_chan))
@@ -221,8 +221,8 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 
 	/* in the case of a missing DMARS resource use first memory window */
 	if (!addr)
-		addr = (u16 __iomem *)shdev->chan_reg;
-	addr += chan_pdata->dmars / sizeof(u16);
+		addr = (void __iomem *)shdev->chan_reg;
+	addr += chan_pdata->dmars;
 
 	__raw_writew((__raw_readw(addr) & (0xff00 >> shift)) | (val << shift),
 		     addr);
@@ -1016,7 +1016,7 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 	new_sh_chan->dev = shdev->common.dev;
 	new_sh_chan->id = id;
 	new_sh_chan->irq = irq;
-	new_sh_chan->base = shdev->chan_reg + chan_pdata->offset / sizeof(u32);
+	new_sh_chan->base = shdev->chan_reg + chan_pdata->offset;
 
 	/* Init DMA tasklet */
 	tasklet_init(&new_sh_chan->tasklet, dmae_do_tasklet,
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 5ae9fc5..7f5c58f 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -35,7 +35,7 @@ struct sh_dmae_chan {
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
 	int irq;
 	int id;				/* Raw id of this channel */
-	u32 __iomem *base;
+	void __iomem *base;
 	char dev_id[16];		/* unique name per DMAC of channel */
 	int pm_error;
 };
@@ -45,8 +45,8 @@ struct sh_dmae_device {
 	struct sh_dmae_chan *chan[SH_DMAC_MAX_CHANNELS];
 	struct sh_dmae_pdata *pdata;
 	struct list_head node;
-	u32 __iomem *chan_reg;
-	u16 __iomem *dmars;
+	void __iomem *chan_reg;
+	void __iomem *dmars;
 };
 
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
-- 
1.7.4.1

