From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:24:06 +0000
Subject: [PATCH 05/24 v2] ASoC: rsnd: remove un-needed parameter from rsnd_dma_quit()
Message-Id: <878ufsop62.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

priv is not used on rsnd_dma_quit()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/core.c |    5 ++---
 sound/soc/sh/rcar/rsnd.h |    3 +--
 sound/soc/sh/rcar/src.c  |    2 +-
 sound/soc/sh/rcar/ssi.c  |    2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 1da94bf..7db686d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -358,7 +358,7 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 	return 0;
 
 rsnd_dma_init_err:
-	rsnd_dma_quit(priv, dma);
+	rsnd_dma_quit(dma);
 rsnd_dma_channel_err:
 
 	/*
@@ -370,8 +370,7 @@ rsnd_dma_channel_err:
 	return -EAGAIN;
 }
 
-void  rsnd_dma_quit(struct rsnd_priv *priv,
-		    struct rsnd_dma *dma)
+void  rsnd_dma_quit(struct rsnd_dma *dma)
 {
 	if (dma->chan)
 		dma_release_channel(dma->chan);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index cb12861a..6ee97e7 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -179,8 +179,7 @@ struct rsnd_dma {
 void rsnd_dma_start(struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dma *dma);
 int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id);
-void  rsnd_dma_quit(struct rsnd_priv *priv,
-		    struct rsnd_dma *dma);
+void  rsnd_dma_quit(struct rsnd_dma *dma);
 
 
 /*
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index f12c8b3..e279205 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -730,7 +730,7 @@ rsnd_src_probe_gen2_fail:
 static int rsnd_src_remove_gen2(struct rsnd_mod *mod,
 				struct rsnd_priv *priv)
 {
-	rsnd_dma_quit(priv, rsnd_mod_to_dma(mod));
+	rsnd_dma_quit(rsnd_mod_to_dma(mod));
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index fcc77ea..a0d902a 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -499,7 +499,7 @@ static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	int irq = ssi->info->irq;
 
-	rsnd_dma_quit(priv, rsnd_mod_to_dma(mod));
+	rsnd_dma_quit(rsnd_mod_to_dma(mod));
 
 	/* PIO will request IRQ again */
 	devm_free_irq(dev, irq, ssi);
-- 
1.7.9.5

