From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:51:28 +0000
Subject: [PATCH 05/19] ASoC: rsnd: tidyup rsnd_dma_to_mod() macro declaration position
Message-Id: <87oaoq1rsi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/rsnd.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6ee97e7..ec77c9f 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -182,6 +182,8 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id);
 void  rsnd_dma_quit(struct rsnd_dma *dma);
 
 
+#define rsnd_dma_to_mod(_dma) container_of((_dma), struct rsnd_mod, dma)
+
 /*
  *	R-Car sound mod
  */
@@ -253,7 +255,6 @@ struct rsnd_mod {
 
 #define rsnd_mod_to_priv(mod) (rsnd_io_to_priv(rsnd_mod_to_io(mod)))
 #define rsnd_mod_to_dma(mod) (&(mod)->dma)
-#define rsnd_dma_to_mod(_dma) container_of((_dma), struct rsnd_mod, dma)
 #define rsnd_mod_to_io(mod) ((mod)->io)
 #define rsnd_mod_id(mod) ((mod)->id)
 #define rsnd_mod_hw_start(mod)	clk_prepare_enable((mod)->clk)
-- 
1.7.9.5

