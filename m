From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:51:49 +0000
Subject: [PATCH 07/19] ASoC: rsnd: add rsnd_gen_get_phy_addr() to get physical address
Message-Id: <87lhju1rru.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

physical address is required from Audio DMAC peri peri.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/gen.c  |   16 +++++++++++-----
 sound/soc/sh/rcar/rsnd.h |    1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index d08bcd3..789de4c 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -28,6 +28,7 @@ struct rsnd_gen {
 
 	struct regmap *regmap[RSND_BASE_MAX];
 	struct regmap_field *regs[RSND_REG_MAX];
+	phys_addr_t res[RSND_REG_MAX];
 };
 
 #define rsnd_priv_to_gen(p)	((struct rsnd_gen *)(p)->gen)
@@ -118,6 +119,13 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod,
 				  mask, data);
 }
 
+phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id)
+{
+	struct rsnd_gen *gen = rsnd_priv_to_gen(priv);
+
+	return 	gen->res[reg_id];
+}
+
 #define rsnd_gen_regmap_init(priv, id_size, reg_id, name, conf)		\
 	_rsnd_gen_regmap_init(priv, id_size, reg_id, name, conf, ARRAY_SIZE(conf))
 static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
@@ -159,6 +167,7 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 
 	gen->base[reg_id] = base;
 	gen->regmap[reg_id] = regmap;
+	gen->res[reg_id] = res->start;
 
 	for (i = 0; i < conf_size; i++) {
 
@@ -216,13 +225,10 @@ rsnd_gen2_dma_addr(struct rsnd_priv *priv,
 		   struct rsnd_mod *mod,
 		   int is_play, int is_from)
 {
-	struct platform_device *pdev = rsnd_priv_to_pdev(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	dma_addr_t ssi_reg = platform_get_resource(pdev,
-				IORESOURCE_MEM, RSND_GEN2_SSI)->start;
-	dma_addr_t src_reg = platform_get_resource(pdev,
-				IORESOURCE_MEM, RSND_GEN2_SCU)->start;
+	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SSI);
+	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SCU);
 	int is_ssi = !!(rsnd_io_to_mod_ssi(io) = mod);
 	int use_src = !!rsnd_io_to_mod_src(io);
 	int use_dvc = !!rsnd_io_to_mod_dvc(io);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ec77c9f..8a8a4d5 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -331,6 +331,7 @@ void __iomem *rsnd_gen_reg_get(struct rsnd_priv *priv,
 dma_addr_t rsnd_gen_dma_addr(struct rsnd_priv *priv,
 		       struct rsnd_mod *mod,
 		       int is_play,  int is_from);
+phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id);
 
 #define rsnd_is_gen1(s)		(((s)->info->flags & RSND_GEN_MASK) = RSND_GEN1)
 #define rsnd_is_gen2(s)		(((s)->info->flags & RSND_GEN_MASK) = RSND_GEN2)
-- 
1.7.9.5

