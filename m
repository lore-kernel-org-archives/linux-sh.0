From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:24:27 +0000
Subject: [PATCH 06/24 v2] ASoC: rsnd: tidyup rsnd_dma_to_mod() macro declaration position
Message-Id: <877fvcop5f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

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

