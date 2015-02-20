From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:28:07 +0000
Subject: [PATCH 13/24 v2] ASoC: rsnd: remove rsnd_dma::addr
Message-Id: <87wq3cnaev.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMAEngine for Renesas R-Car driver is used only for Audio DMAC now.
rsnd_dma::addr was added to support Audio DMAC peri peri,
but it is no longer needed. Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/dma.c  |    2 --
 sound/soc/sh/rcar/rsnd.h |    1 -
 2 files changed, 3 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index a01bb8c..c407fd2 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -89,7 +89,6 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 	struct dma_async_tx_descriptor *desc;
 
 	desc = dmaengine_prep_dma_cyclic(dma->chan,
-					 (dma->addr) ? dma->addr :
 					 substream->runtime->dma_addr,
 					 snd_pcm_lib_buffer_bytes(substream),
 					 snd_pcm_lib_period_bytes(substream),
@@ -157,7 +156,6 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	if (ret < 0)
 		goto rsnd_dma_init_err;
 
-	dma->addr = is_play ? cfg.src_addr : cfg.dst_addr;
 	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	return 0;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 9e67142..a295491 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -183,7 +183,6 @@ struct rsnd_dma {
 	struct dma_chan		*chan;
 	struct rsnd_dma_ops	*ops;
 	enum dma_transfer_direction dir;
-	dma_addr_t		addr;
 	int			dmapp_id;
 	u32			chcr;
 	dma_addr_t		src_addr;
-- 
1.7.9.5

