From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 May 2015 03:47:03 +0000
Subject: [PATCH 3/4] ASoC: rsnd: add rsnd_dai_stream_quit()
Message-Id: <87y4kj3oab.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Renesas R-Car sound driver calls rsnd_dai_stream_init() when
start, but it didn't call paired function. This patch adds
rsnd_dai_stream_quit() for it. This is prepare for interrupt error
status check feature support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 sound/soc/sh/rcar/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 405cacd..2b7323c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -315,7 +315,7 @@ void rsnd_dai_pointer_update(struct rsnd_dai_stream *io, int byte)
 	}
 }
 
-static int rsnd_dai_stream_init(struct rsnd_dai_stream *io,
+static void rsnd_dai_stream_init(struct rsnd_dai_stream *io,
 				struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -327,8 +327,11 @@ static int rsnd_dai_stream_init(struct rsnd_dai_stream *io,
 				  runtime->channels *
 				  samples_to_bytes(runtime, 1);
 	io->next_period_byte	= io->byte_per_period;
+}
 
-	return 0;
+static void rsnd_dai_stream_quit(struct rsnd_dai_stream *io)
+{
+	io->substream		= NULL;
 }
 
 static
@@ -363,9 +366,7 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		ret = rsnd_dai_stream_init(io, substream);
-		if (ret < 0)
-			goto dai_trigger_end;
+		rsnd_dai_stream_init(io, substream);
 
 		ret = rsnd_platform_call(priv, dai, start, ssi_id);
 		if (ret < 0)
@@ -391,6 +392,8 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = rsnd_platform_call(priv, dai, stop, ssi_id);
 		if (ret < 0)
 			goto dai_trigger_end;
+
+		rsnd_dai_stream_quit(io);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.9.1

