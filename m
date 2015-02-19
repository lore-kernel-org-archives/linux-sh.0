From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:53:00 +0000
Subject: [PATCH 14/19] ASoC: rsnd: remove rsnd_dma::dir
Message-Id: <87bnkq1rpv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMAEngine direction can be calculated from rsnd_dai_stream,
So, rsnd_dma::dir does not make sense now.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/dma.c  |    5 ++---
 sound/soc/sh/rcar/rsnd.h |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 2ab00e8..c03e769 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -91,12 +91,13 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 	struct snd_pcm_substream *substream = io->substream;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
+	int is_play = rsnd_io_is_play(io);
 
 	desc = dmaengine_prep_dma_cyclic(dma->chan,
 					 substream->runtime->dma_addr,
 					 snd_pcm_lib_buffer_bytes(substream),
 					 snd_pcm_lib_period_bytes(substream),
-					 dma->dir,
+					 is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
@@ -160,8 +161,6 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	if (ret < 0)
 		goto rsnd_dma_init_err;
 
-	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-
 	return 0;
 
 rsnd_dma_init_err:
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 9e67142..dccf2ef 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -182,7 +182,6 @@ struct rsnd_dma_ops {
 struct rsnd_dma {
 	struct dma_chan		*chan;
 	struct rsnd_dma_ops	*ops;
-	enum dma_transfer_direction dir;
 	dma_addr_t		addr;
 	int			dmapp_id;
 	u32			chcr;
-- 
1.7.9.5

