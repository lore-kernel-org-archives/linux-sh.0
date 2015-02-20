From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:29:41 +0000
Subject: [PATCH 16/24 v2] ASoC: rsnd: enable rsnd_ssi_use_busif() for DMA
Message-Id: <87sie0naca.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car sound driver uses SSI, but the DMA interfaces are
SSI/SSIU. This interface is based on SSI/SRC/DVC connection.
And DMA function needs to know which interface is used somehow.
This patch enables rsnd_ssi_use_busif() for DMA.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/sh/rcar/dma.c  |    2 +-
 sound/soc/sh/rcar/rsnd.h |    1 +
 sound/soc/sh/rcar/ssi.c  |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index b449763..3f34461 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -427,7 +427,7 @@ rsnd_gen2_dma_addr(struct rsnd_priv *priv,
 		dev_err(dev, "DVC is selected without SRC\n");
 
 	/* use SSIU or SSI ? */
-	if (is_ssi && (0 = strcmp(rsnd_mod_dma_name(mod), "ssiu")))
+	if (is_ssi && rsnd_ssi_use_busif(mod))
 		is_ssi++;
 
 	return (is_from) ?
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 0d36e38..68bc3f4 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -514,6 +514,7 @@ int rsnd_ssi_probe(struct platform_device *pdev,
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
 int rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
+int rsnd_ssi_use_busif(struct rsnd_mod *mod);
 
 /*
  *	R-Car DVC
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a0d902a..7e48d56 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -84,7 +84,7 @@ struct rsnd_ssi {
 #define rsnd_ssi_mode_flags(p) ((p)->info->flags)
 #define rsnd_ssi_dai_id(ssi) ((ssi)->info->dai_id)
 
-static int rsnd_ssi_use_busif(struct rsnd_mod *mod)
+int rsnd_ssi_use_busif(struct rsnd_mod *mod)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-- 
1.7.9.5

