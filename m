From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:23:08 +0000
Subject: [PATCH 03/24 v2] ASoC: rsnd: remove un-needed parameter from rsnd_dma_init()
Message-Id: <87bnkoop7q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It can get DMA direction via rsnd_dai_stream.
Remove un-needed is_play from rsnd_dma_init().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

  - no change

 sound/soc/sh/rcar/core.c |    6 ++++--
 sound/soc/sh/rcar/rsnd.h |   16 +---------------
 sound/soc/sh/rcar/src.c  |    1 -
 sound/soc/sh/rcar/ssi.c  |    1 -
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 0b14d37..1edf4dc 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -311,13 +311,15 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	}
 }
 
-int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
-		  int is_play, int id)
+int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_slave_config cfg;
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
 	struct rsnd_mod *mod_from;
 	struct rsnd_mod *mod_to;
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	int is_play = rsnd_io_is_play(io);
 	char dma_name[DMA_NAME_SIZE];
 	dma_cap_mask_t mask;
 	int ret;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 5ffde9b..93a1a25 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -179,8 +179,7 @@ struct rsnd_dma {
 void rsnd_dma_start(struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dma *dma);
 int rsnd_dma_available(struct rsnd_dma *dma);
-int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
-	int is_play, int id);
+int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id);
 void  rsnd_dma_quit(struct rsnd_priv *priv,
 		    struct rsnd_dma *dma);
 
@@ -413,19 +412,6 @@ struct rsnd_priv {
 #define rsnd_lock(priv, flags) spin_lock_irqsave(&priv->lock, flags)
 #define rsnd_unlock(priv, flags) spin_unlock_irqrestore(&priv->lock, flags)
 
-#define rsnd_info_is_playback(priv, type)				\
-({									\
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);		\
-	int i, is_play = 0;						\
-	for (i = 0; i < info->dai_info_nr; i++) {			\
-		if (info->dai_info[i].playback.type = (type)->info) {	\
-			is_play = 1;					\
-			break;						\
-		}							\
-	}								\
-	is_play;							\
-})
-
 /*
  *	rsnd_kctrl
  */
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 81c182b..7fb8798 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -713,7 +713,6 @@ static int rsnd_src_probe_gen2(struct rsnd_mod *mod,
 
 	ret = rsnd_dma_init(priv,
 			    rsnd_mod_to_dma(mod),
-			    rsnd_info_is_playback(priv, src),
 			    src->info->dma_id);
 	if (ret)
 		goto rsnd_src_probe_gen2_fail;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 9e7b627..57e737c 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -478,7 +478,6 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 
 	ret = rsnd_dma_init(
 		priv, rsnd_mod_to_dma(mod),
-		rsnd_info_is_playback(priv, ssi),
 		dma_id);
 	if (ret)
 		goto rsnd_ssi_dma_probe_fail;
-- 
1.7.9.5

