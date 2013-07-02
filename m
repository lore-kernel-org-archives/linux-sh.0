From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Jul 2013 15:46:06 +0000
Subject: [PATCH 3/3] DMA: shdma: support the new CHCLR register layout
Message-Id: <Pine.LNX.4.64.1307021745140.1965@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307021738500.1965@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307021738500.1965@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On newer r-car SoCs the CHCLR register only contains one bit per channel,
to which a 1 has to be written to reset the channel. Older SoC versions had
one CHCLR register per channel, to which a 0 must be written to reset the
channel and clear its buffers. This patch adds support for the newer
layout.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma.c |    6 ++++--
 include/linux/sh_dma.h |   12 +++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 64eb7fb..883a4de 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -54,9 +54,11 @@ static LIST_HEAD(sh_dmae_devices);
 static void channel_clear(struct sh_dmae_chan *sh_dc)
 {
 	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+	const struct sh_dmae_channel *chan_pdata = shdev->pdata->channel +
+		sh_dc->shdma_chan.id;
+	u32 val = chan_pdata->chclr_bit < 0 ? 0 : 1 << chan_pdata->chclr_bit;
 
-	__raw_writel(0, shdev->chan_reg +
-		shdev->pdata->channel[sh_dc->shdma_chan.id].chclr_offset);
+	__raw_writel(val, shdev->chan_reg + chan_pdata->chclr_offset);
 }
 
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 4e83f3e..9316a1d 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -33,11 +33,21 @@ struct sh_dmae_slave_config {
 	char		mid_rid;
 };
 
+/**
+ * struct sh_dmae_channel - DMAC channel platform data
+ * @offset:		register offset within the main IOMEM resource
+ * @dmars:		channel DMARS register offset
+ * @chclr_offset:	channel CHCLR register offset
+ * @dmars_bit:		channel DMARS field offset within the register
+ * @chclr_bit:		> 0: bit position, to be set to reset the channel
+ *			< 0: CHCLR has to be cleared to clear channel's buffers
+ */
 struct sh_dmae_channel {
 	unsigned int	offset;
 	unsigned int	dmars;
-	unsigned int	dmars_bit;
 	unsigned int	chclr_offset;
+	unsigned char	dmars_bit;
+	signed char	chclr_bit;
 };
 
 struct sh_dmae_pdata {
-- 
1.7.2.5

