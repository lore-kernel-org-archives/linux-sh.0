From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 08:56:19 +0000
Subject: [PATCH 07/12] ASoC: rsnd: use dmaengine_prep_dma_cyclic() instead of original method
Message-Id: <8738f2zjd7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current R-Car sound driver is using DMAEngine directly,
but, ASoC is requesting to use common DMA transfer method,
like snd_dmaengine_pcm_trigger() or dmaengine_pcm_ops.
It is difficult to switch at this point, since Renesas
driver is also supporting PIO transfer.
This patch uses dmaengine_prep_dma_cyclic() instead
of dmaengine_prep_slave_single().
It is used in requested method,
and is good first step to switch over.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |   76 +++++++++++-----------------------------------
 sound/soc/sh/rcar/rsnd.h |    4 ---
 2 files changed, 18 insertions(+), 62 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1a59602..5a4d7e0 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -164,26 +164,8 @@ void rsnd_mod_init(struct rsnd_priv *priv,
 /*
  *	rsnd_dma functions
  */
-static void __rsnd_dma_start(struct rsnd_dma *dma);
-static void rsnd_dma_continue(struct rsnd_dma *dma)
-{
-	/* push next A or B plane */
-	dma->submit_loop = 1;
-	schedule_work(&dma->work);
-}
-
-void rsnd_dma_start(struct rsnd_dma *dma)
-{
-	/* push both A and B plane*/
-	dma->offset = 0;
-	dma->submit_loop = 2;
-	__rsnd_dma_start(dma);
-}
-
 void rsnd_dma_stop(struct rsnd_dma *dma)
 {
-	dma->submit_loop = 0;
-	cancel_work_sync(&dma->work);
 	dmaengine_terminate_all(dma->chan);
 }
 
@@ -191,11 +173,7 @@ static void rsnd_dma_complete(void *data)
 {
 	struct rsnd_dma *dma = (struct rsnd_dma *)data;
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
-	struct rsnd_priv *priv = rsnd_mod_to_priv(rsnd_dma_to_mod(dma));
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	unsigned long flags;
-
-	rsnd_lock(priv, flags);
 
 	/*
 	 * Renesas sound Gen1 needs 1 DMAC,
@@ -208,57 +186,40 @@ static void rsnd_dma_complete(void *data)
 	 * rsnd_dai_pointer_update() will be called twice,
 	 * ant it will breaks io->byte_pos
 	 */
-	if (dma->submit_loop)
-		rsnd_dma_continue(dma);
-
-	rsnd_unlock(priv, flags);
 
 	rsnd_dai_pointer_update(io, io->byte_per_period);
 }
 
-static void __rsnd_dma_start(struct rsnd_dma *dma)
+void rsnd_dma_start(struct rsnd_dma *dma)
 {
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct snd_pcm_substream *substream = io->substream;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
-	dma_addr_t buf;
-	size_t len = io->byte_per_period;
-	int i;
-
-	for (i = 0; i < dma->submit_loop; i++) {
 
-		buf = runtime->dma_addr +
-			rsnd_dai_pointer_offset(io, dma->offset + len);
-		dma->offset = len;
+	desc = dmaengine_prep_dma_cyclic(dma->chan,
+					 substream->runtime->dma_addr,
+					 snd_pcm_lib_buffer_bytes(substream),
+					 snd_pcm_lib_period_bytes(substream),
+					 dma->dir,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
-		desc = dmaengine_prep_slave_single(
-			dma->chan, buf, len, dma->dir,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc) {
-			dev_err(dev, "dmaengine_prep_slave_sg() fail\n");
-			return;
-		}
-
-		desc->callback		= rsnd_dma_complete;
-		desc->callback_param	= dma;
+	if (!desc) {
+		dev_err(dev, "dmaengine_prep_slave_sg() fail\n");
+		return;
+	}
 
-		if (dmaengine_submit(desc) < 0) {
-			dev_err(dev, "dmaengine_submit() fail\n");
-			return;
-		}
+	desc->callback		= rsnd_dma_complete;
+	desc->callback_param	= dma;
 
-		dma_async_issue_pending(dma->chan);
+	if (dmaengine_submit(desc) < 0) {
+		dev_err(dev, "dmaengine_submit() fail\n");
+		return;
 	}
-}
-
-static void rsnd_dma_do_work(struct work_struct *work)
-{
-	struct rsnd_dma *dma = container_of(work, struct rsnd_dma, work);
 
-	__rsnd_dma_start(dma);
+	dma_async_issue_pending(dma->chan);
 }
 
 int rsnd_dma_available(struct rsnd_dma *dma)
@@ -372,7 +333,6 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
 		goto rsnd_dma_init_err;
 
 	dma->dir = is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	INIT_WORK(&dma->work, rsnd_dma_do_work);
 
 	return 0;
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index e492c13..be17136 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -156,12 +156,8 @@ u32 rsnd_get_adinr(struct rsnd_mod *mod);
  */
 struct rsnd_dma {
 	struct sh_dmae_slave	slave;
-	struct work_struct	work;
 	struct dma_chan		*chan;
 	enum dma_data_direction dir;
-
-	int submit_loop;
-	int offset; /* it cares A/B plane */
 };
 
 void rsnd_dma_start(struct rsnd_dma *dma);
-- 
1.7.9.5

