From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 08:56:11 +0000
Subject: [PATCH 06/12] ASoC: fsi: use dmaengine_prep_dma_cyclic() for DMA transfer
Message-Id: <874mzizjdf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current FSI driver is using DMAEngine directly,
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
 sound/soc/sh/fsi.c |   94 +++++++++++++++-------------------------------------
 1 file changed, 27 insertions(+), 67 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 820a408..a57eb96 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -232,10 +232,7 @@ struct fsi_stream {
 	 * these are for DMAEngine
 	 */
 	struct dma_chan		*chan;
-	struct work_struct	work;
 	int			dma_id;
-	int			loop_cnt;
-	int			additional_pos;
 };
 
 struct fsi_clk {
@@ -1281,24 +1278,9 @@ static int fsi_dma_init(struct fsi_priv *fsi, struct fsi_stream *io)
 	io->bus_option = BUSOP_SET(24, PACKAGE_24BITBUS_BACK) |
 			 BUSOP_SET(16, PACKAGE_16BITBUS_STREAM);
 
-	io->loop_cnt = 2; /* push 1st, 2nd period first, then 3rd, 4th... */
-	io->additional_pos = 0;
-
 	return 0;
 }
 
-static dma_addr_t fsi_dma_get_area(struct fsi_stream *io, int additional)
-{
-	struct snd_pcm_runtime *runtime = io->substream->runtime;
-	int period = io->period_pos + additional;
-
-	if (period >= runtime->periods)
-		period = 0;
-
-	return runtime->dma_addr +
-		samples_to_bytes(runtime, period * io->period_samples);
-}
-
 static void fsi_dma_complete(void *data)
 {
 	struct fsi_stream *io = (struct fsi_stream *)data;
@@ -1307,53 +1289,37 @@ static void fsi_dma_complete(void *data)
 	fsi_pointer_update(io, io->period_samples);
 
 	fsi_count_fifo_err(fsi);
-	fsi_stream_transfer(io);
 }
 
-static void fsi_dma_do_work(struct work_struct *work)
+static int fsi_dma_transfer(struct fsi_priv *fsi, struct fsi_stream *io)
 {
-	struct fsi_stream *io = container_of(work, struct fsi_stream, work);
-	struct fsi_priv *fsi = fsi_stream_to_priv(io);
-	struct snd_soc_dai *dai;
+	struct snd_soc_dai *dai = fsi_get_dai(io->substream);
+	struct snd_pcm_substream *substream = io->substream;
 	struct dma_async_tx_descriptor *desc;
-	struct snd_pcm_runtime *runtime;
-	enum dma_data_direction dir;
 	int is_play = fsi_stream_is_play(fsi, io);
-	int len, i;
-	dma_addr_t buf;
-
-	if (!fsi_stream_is_working(fsi, io))
-		return;
-
-	dai	= fsi_get_dai(io->substream);
-	runtime	= io->substream->runtime;
-	dir	= is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	len	= samples_to_bytes(runtime, io->period_samples);
-
-	for (i = 0; i < io->loop_cnt; i++) {
-		buf	= fsi_dma_get_area(io, io->additional_pos);
-
-		desc = dmaengine_prep_slave_single(io->chan, buf, len, dir,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc) {
-			dev_err(dai->dev, "dmaengine_prep_slave_sg() fail\n");
-			return;
-		}
-
-		desc->callback		= fsi_dma_complete;
-		desc->callback_param	= io;
-
-		if (dmaengine_submit(desc) < 0) {
-			dev_err(dai->dev, "tx_submit() fail\n");
-			return;
-		}
+	enum dma_data_direction dir = is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	int ret = -EIO;
+
+	desc = dmaengine_prep_dma_cyclic(io->chan,
+					 substream->runtime->dma_addr,
+					 snd_pcm_lib_buffer_bytes(substream),
+					 snd_pcm_lib_period_bytes(substream),
+					 dir,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(dai->dev, "dmaengine_prep_dma_cyclic() fail\n");
+		goto fsi_dma_transfer_err;
+	}
 
-		dma_async_issue_pending(io->chan);
+	desc->callback		= fsi_dma_complete;
+	desc->callback_param	= io;
 
-		io->additional_pos = 1;
+	if (dmaengine_submit(desc) < 0) {
+		dev_err(dai->dev, "tx_submit() fail\n");
+		goto fsi_dma_transfer_err;
 	}
 
-	io->loop_cnt = 1;
+	dma_async_issue_pending(io->chan);
 
 	/*
 	 * FIXME
@@ -1370,13 +1336,11 @@ static void fsi_dma_do_work(struct work_struct *work)
 			fsi_reg_write(fsi, DIFF_ST, 0);
 		}
 	}
-}
 
-static int fsi_dma_transfer(struct fsi_priv *fsi, struct fsi_stream *io)
-{
-	schedule_work(&io->work);
+	ret = 0;
 
-	return 0;
+fsi_dma_transfer_err:
+	return ret;
 }
 
 static int fsi_dma_push_start_stop(struct fsi_priv *fsi, struct fsi_stream *io,
@@ -1437,15 +1401,11 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
 		return fsi_stream_probe(fsi, dev);
 	}
 
-	INIT_WORK(&io->work, fsi_dma_do_work);
-
 	return 0;
 }
 
 static int fsi_dma_remove(struct fsi_priv *fsi, struct fsi_stream *io)
 {
-	cancel_work_sync(&io->work);
-
 	fsi_stream_stop(fsi, io);
 
 	if (io->chan)
@@ -1618,9 +1578,9 @@ static int fsi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (!ret)
 			ret = fsi_hw_startup(fsi, io, dai->dev);
 		if (!ret)
-			ret = fsi_stream_transfer(io);
+			ret = fsi_stream_start(fsi, io);
 		if (!ret)
-			fsi_stream_start(fsi, io);
+			ret = fsi_stream_transfer(io);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		if (!ret)
-- 
1.7.9.5

