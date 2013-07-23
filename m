From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 10:49:58 +0000
Subject: [PATCH v4 04/15] DMA: shdma: make a pointer const
Message-Id: <1374576609-27748-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Platform data shouldn't be changed at run-time, so, pointers to it should
be const.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma.h  |    2 +-
 drivers/dma/sh/shdmac.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 82a83f8..ae0c65f 100644
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
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 6546bf9..859ddbe 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
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
-	struct sh_dmae_pdata *pdata;
+	const struct sh_dmae_pdata *pdata;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAE_MAX_CHANNELS] = {};
 	int errirq, chan_irq[SH_DMAE_MAX_CHANNELS];
-- 
1.7.2.5

