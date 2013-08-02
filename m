From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 14:18:09 +0000
Subject: [PATCH v2] DMA: shdma: make a pointer const
Message-Id: <Pine.LNX.4.64.1308021610240.28012@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, "Koul, Vinod" <vinod.koul@intel.com>

Platform data shouldn't be changed at run-time, so, pointers to it should
be const.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This is a re-send of a patch, previously submitted as a part of a 
patch-series, although it isn't really related to its topic:

https://lkml.org/lkml/2013/7/19/605

Should go on top of my other patch series "DMA: shdma: several stylistic 
improvements and support for new SoCs"
http://thread.gmane.org/gmane.linux.ports.sh.devel/24826

 drivers/dma/sh/shdma.c |   10 +++++-----
 drivers/dma/sh/shdma.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index b3f959c..7af64b9 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -177,7 +177,7 @@ static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
-	struct sh_dmae_pdata *pdata = shdev->pdata;
+	const struct sh_dmae_pdata *pdata = shdev->pdata;
 	int cnt = ((chcr & pdata->ts_low_mask) >> pdata->ts_low_shift) |
 		((chcr & pdata->ts_high_mask) >> pdata->ts_high_shift);
 
@@ -190,7 +190,7 @@ static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 static u32 log2size_to_chcr(struct sh_dmae_chan *sh_chan, int l2size)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
-	struct sh_dmae_pdata *pdata = shdev->pdata;
+	const struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
 	for (i = 0; i < pdata->ts_shift_num; i++)
@@ -250,7 +250,7 @@ static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
-	struct sh_dmae_pdata *pdata = shdev->pdata;
+	const struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->shdma_chan.id];
 	void __iomem *addr = shdev->dmars;
 	unsigned int shift = chan_pdata->dmars_bit;
@@ -319,7 +319,7 @@ static const struct sh_dmae_slave_config *dmae_find_slave(
 	struct sh_dmae_chan *sh_chan, int match)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
-	struct sh_dmae_pdata *pdata = shdev->pdata;
+	const struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_slave_config *cfg;
 	int i;
 
@@ -665,7 +665,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 
 static int sh_dmae_probe(struct platform_device *pdev)
 {
-	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
+	const struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int errirq, chan_irq[SH_DMAE_MAX_CHANNELS];
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 06aae6e..3d9dca1 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -36,7 +36,7 @@ struct sh_dmae_chan {
 struct sh_dmae_device {
 	struct shdma_dev shdma_dev;
 	struct sh_dmae_chan *chan[SH_DMAE_MAX_CHANNELS];
-	struct sh_dmae_pdata *pdata;
+	const struct sh_dmae_pdata *pdata;
 	struct list_head node;
 	void __iomem *chan_reg;
 	void __iomem *dmars;
-- 
1.7.2.5

