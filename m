From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:52:51 +0000
Subject: [PATCH 13/19] ASoC: rsnd: remove rsnd_dma::addr
Message-Id: <87d2561rq6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMAEngine for Renesas R-Car driver is used only for Audio DMAC now.
rsnd_dma::addr was added to support Audio DMAC peri peri,
but it is no longer needed. Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/dma.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 5b0c344..2ab00e8 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -93,7 +93,6 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 	struct dma_async_tx_descriptor *desc;
 
 	desc = dmaengine_prep_dma_cyclic(dma->chan,
-					 (dma->addr) ? dma->addr :
 					 substream->runtime->dma_addr,
 					 snd_pcm_lib_buffer_bytes(substream),
 					 snd_pcm_lib_period_bytes(substream),
@@ -161,7 +160,6 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	if (ret < 0)
 		goto rsnd_dma_init_err;
 
-	dma->addr = is_play ? cfg.src_addr : cfg.dst_addr;
 	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	return 0;
-- 
1.7.9.5

