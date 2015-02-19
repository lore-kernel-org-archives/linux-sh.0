From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:51:08 +0000
Subject: [PATCH 03/19] ASoC: rsnd: remove unused rsnd_dma_available()
Message-Id: <87r3tm1rt0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd_dma_available() is not used. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |    5 -----
 sound/soc/sh/rcar/rsnd.h |    1 -
 sound/soc/sh/rcar/src.c  |    2 --
 sound/soc/sh/rcar/ssi.c  |    2 --
 4 files changed, 10 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1edf4dc..1da94bf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -222,11 +222,6 @@ void rsnd_dma_start(struct rsnd_dma *dma)
 	dma_async_issue_pending(dma->chan);
 }
 
-int rsnd_dma_available(struct rsnd_dma *dma)
-{
-	return !!dma->chan;
-}
-
 #define DMA_NAME_SIZE 16
 #define MOD_MAX 4 /* MEM/SSI/SRC/DVC */
 static int _rsnd_dma_of_name(char *dma_name, struct rsnd_mod *mod)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 93a1a25..cb12861a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -178,7 +178,6 @@ struct rsnd_dma {
 
 void rsnd_dma_start(struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dma *dma);
-int rsnd_dma_available(struct rsnd_dma *dma);
 int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id);
 void  rsnd_dma_quit(struct rsnd_priv *priv,
 		    struct rsnd_dma *dma);
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 7fb8798..f12c8b3 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -30,8 +30,6 @@ struct rsnd_src {
 #define rsnd_src_convert_rate(p) ((p)->info->convert_rate)
 #define rsnd_mod_to_src(_mod)				\
 	container_of((_mod), struct rsnd_src, mod)
-#define rsnd_src_dma_available(src) \
-	rsnd_dma_available(rsnd_mod_to_dma(&(src)->mod))
 
 #define for_each_rsnd_src(pos, priv, i)				\
 	for ((i) = 0;						\
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 57e737c..fcc77ea 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -80,8 +80,6 @@ struct rsnd_ssi {
 #define rsnd_mod_to_ssi(_mod) container_of((_mod), struct rsnd_ssi, mod)
 #define rsnd_dma_to_ssi(dma)  rsnd_mod_to_ssi(rsnd_dma_to_mod(dma))
 #define rsnd_ssi_pio_available(ssi) ((ssi)->info->irq > 0)
-#define rsnd_ssi_dma_available(ssi) \
-	rsnd_dma_available(rsnd_mod_to_dma(&(ssi)->mod))
 #define rsnd_ssi_clk_from_parent(ssi) ((ssi)->parent)
 #define rsnd_ssi_mode_flags(p) ((p)->info->flags)
 #define rsnd_ssi_dai_id(ssi) ((ssi)->info->dai_id)
-- 
1.7.9.5

