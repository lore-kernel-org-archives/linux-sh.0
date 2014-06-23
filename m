From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jun 2014 00:55:41 +0000
Subject: [PATCH 02/10 v2] ASoC: fsi: add fsi_pointer_update() for common pointer method
Message-Id: <8738ewtpf2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
	<8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

fsi PIO/DMA handler are using each own pointer update method,
but these can be share.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- no change

 sound/soc/sh/fsi.c |   57 ++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 7a6b632..820a408 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1041,6 +1041,26 @@ static int fsi_clk_set_rate_cpg(struct device *dev,
 	return ret;
 }
 
+static void fsi_pointer_update(struct fsi_stream *io, int size)
+{
+	io->buff_sample_pos += size;
+
+	if (io->buff_sample_pos >+	    io->period_samples * (io->period_pos + 1)) {
+		struct snd_pcm_substream *substream = io->substream;
+		struct snd_pcm_runtime *runtime = substream->runtime;
+
+		io->period_pos++;
+
+		if (io->period_pos >= runtime->periods) {
+			io->buff_sample_pos = 0;
+			io->period_pos = 0;
+		}
+
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
 /*
  *		pio data transfer handler
  */
@@ -1107,31 +1127,11 @@ static int fsi_pio_transfer(struct fsi_priv *fsi, struct fsi_stream *io,
 		void (*run32)(struct fsi_priv *fsi, u8 *buf, int samples),
 		int samples)
 {
-	struct snd_pcm_runtime *runtime;
-	struct snd_pcm_substream *substream;
 	u8 *buf;
-	int over_period;
 
 	if (!fsi_stream_is_working(fsi, io))
 		return -EINVAL;
 
-	over_period	= 0;
-	substream	= io->substream;
-	runtime		= substream->runtime;
-
-	/* FSI FIFO has limit.
-	 * So, this driver can not send periods data at a time
-	 */
-	if (io->buff_sample_pos >-	    io->period_samples * (io->period_pos + 1)) {
-
-		over_period = 1;
-		io->period_pos = (io->period_pos + 1) % runtime->periods;
-
-		if (0 = io->period_pos)
-			io->buff_sample_pos = 0;
-	}
-
 	buf = fsi_pio_get_area(fsi, io);
 
 	switch (io->sample_width) {
@@ -1145,11 +1145,7 @@ static int fsi_pio_transfer(struct fsi_priv *fsi, struct fsi_stream *io,
 		return -EINVAL;
 	}
 
-	/* update buff_sample_pos */
-	io->buff_sample_pos += samples;
-
-	if (over_period)
-		snd_pcm_period_elapsed(substream);
+	fsi_pointer_update(io, samples);
 
 	return 0;
 }
@@ -1307,20 +1303,11 @@ static void fsi_dma_complete(void *data)
 {
 	struct fsi_stream *io = (struct fsi_stream *)data;
 	struct fsi_priv *fsi = fsi_stream_to_priv(io);
-	struct snd_pcm_runtime *runtime = io->substream->runtime;
 
-	io->buff_sample_pos += io->period_samples;
-	io->period_pos++;
-
-	if (io->period_pos >= runtime->periods) {
-		io->period_pos = 0;
-		io->buff_sample_pos = 0;
-	}
+	fsi_pointer_update(io, io->period_samples);
 
 	fsi_count_fifo_err(fsi);
 	fsi_stream_transfer(io);
-
-	snd_pcm_period_elapsed(io->substream);
 }
 
 static void fsi_dma_do_work(struct work_struct *work)
-- 
1.7.9.5

