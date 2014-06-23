From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jun 2014 00:57:04 +0000
Subject: [PATCH 06/10 v2] ASoC: rsnd: enable DVC when capture
Message-Id: <87wqc8sasb.wl%kuninori.morimoto.gx@renesas.com>
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

Current DVC can be enabled only when playback,
but, this came from misunderstanding.
It is not correct.

DVC <-> DMA relationship is...

Playback: MEM -> DMAC  -> SRC -> DVC -> DMACp -> SSI
Capture:  SSI -> DMACp -> SRC -> DVC -> DMAC  -> MEM

DVC can be used for both Playback/Capture

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/dvc.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index ed00070..deef310 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -191,24 +191,20 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			    struct snd_soc_pcm_runtime *rtd)
 {
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_kcontrol *kctrl;
 	static struct snd_kcontrol_new knew = {
 		.iface		= SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name		= "Playback Volume",
 		.info		= rsnd_dvc_volume_info,
 		.get		= rsnd_dvc_volume_get,
 		.put		= rsnd_dvc_volume_put,
 	};
 	int ret;
 
-	if (!rsnd_dai_is_play(rdai, io)) {
-		dev_err(dev, "DVC%d is connected to Capture DAI\n",
-			rsnd_mod_id(mod));
-		return -EINVAL;
-	}
+	if (rsnd_dai_is_play(rdai, io))
+		knew.name = "Playback Volume";
+	else
+		knew.name = "Capture Volume";
 
 	kctrl = snd_ctl_new1(&knew, mod);
 	if (!kctrl)
-- 
1.7.9.5

