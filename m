From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 01:03:20 +0000
Subject: [PATCH 7/9 v4] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <87bnlitn1o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rsnd sets dma_slave_config :: slave_id field for DMAEngine,
but it is no longer needed. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v3 -> v4

 - no change

 sound/soc/sh/rcar/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 75308bb..61473d9 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -316,7 +316,7 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
 		  int is_play, int id)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct dma_slave_config cfg;
+	struct dma_slave_config cfg = {};
 	struct rsnd_mod *mod_from;
 	struct rsnd_mod *mod_to;
 	char dma_name[DMA_NAME_SIZE];
@@ -334,7 +334,6 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma,
 	rsnd_dma_of_path(dma, is_play, &mod_from, &mod_to);
 	rsnd_dma_of_name(mod_from, mod_to, dma_name);
 
-	cfg.slave_id	= id;
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	cfg.src_addr	= rsnd_gen_dma_addr(priv, mod_from, is_play, 1);
 	cfg.dst_addr	= rsnd_gen_dma_addr(priv, mod_to,   is_play, 0);
-- 
1.7.9.5

