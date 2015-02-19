From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:52:09 +0000
Subject: [PATCH 09/19] ASoC: rsnd: move rsnd_gen_dma_addr() from gen.c to dma.c
Message-Id: <87ioey1rrb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, we have dma.c for Audio DMAC / Audio DMAC peri peri.
rsnd_gen_dma_addr() should go there.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/dma.c  |  118 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/sh/rcar/gen.c  |  110 ------------------------------------------
 sound/soc/sh/rcar/rsnd.h |    3 --
 3 files changed, 116 insertions(+), 115 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 37acd40..9f909f1 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -97,6 +97,10 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 			     struct rsnd_mod **mod_from,
 			     struct rsnd_mod **mod_to);
 
+static dma_addr_t rsnd_dma_addr(struct rsnd_priv *priv,
+				struct rsnd_mod *mod,
+				int is_play, int is_from);
+
 int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
@@ -122,8 +126,8 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 	rsnd_dma_of_name(mod_from, mod_to, dma_name);
 
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.src_addr	= rsnd_gen_dma_addr(priv, mod_from, is_play, 1);
-	cfg.dst_addr	= rsnd_gen_dma_addr(priv, mod_to,   is_play, 0);
+	cfg.src_addr	= rsnd_dma_addr(priv, mod_from, is_play, 1);
+	cfg.dst_addr	= rsnd_dma_addr(priv, mod_to,   is_play, 0);
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
@@ -168,6 +172,116 @@ void rsnd_dma_quit(struct rsnd_dma *dma)
 	dma->chan = NULL;
 }
 
+/*
+ *	DMA read/write register offset
+ *
+ *	RSND_xxx_I_N	for Audio DMAC input
+ *	RSND_xxx_O_N	for Audio DMAC output
+ *	RSND_xxx_I_P	for Audio DMAC peri peri input
+ *	RSND_xxx_O_P	for Audio DMAC peri peri output
+ *
+ *	ex) R-Car H2 case
+ *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp out
+ *	SSI : 0xec541000 / 0xec241008 / 0xec24100c
+ *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec400000
+ *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec304000
+ *	CMD : 0xec500000 /            / 0xec008000                0xec308000
+ */
+#define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
+#define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
+
+#define RDMA_SSIU_I_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
+#define RDMA_SSIU_O_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
+
+#define RDMA_SSIU_I_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
+#define RDMA_SSIU_O_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
+
+#define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
+#define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
+
+#define RDMA_SRC_I_P(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
+#define RDMA_SRC_O_P(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
+
+#define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
+#define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
+
+static dma_addr_t
+rsnd_gen2_dma_addr(struct rsnd_priv *priv,
+		   struct rsnd_mod *mod,
+		   int is_play, int is_from)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SSI);
+	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SCU);
+	int is_ssi = !!(rsnd_io_to_mod_ssi(io) = mod);
+	int use_src = !!rsnd_io_to_mod_src(io);
+	int use_dvc = !!rsnd_io_to_mod_dvc(io);
+	int id = rsnd_mod_id(mod);
+	struct dma_addr {
+		dma_addr_t out_addr;
+		dma_addr_t in_addr;
+	} dma_addrs[3][2][3] = {
+		/* SRC */
+		{{{ 0,				0 },
+		  /* Capture */
+		  { RDMA_SRC_O_N(src, id),	RDMA_SRC_I_P(src, id) },
+		  { RDMA_CMD_O_N(src, id),	RDMA_SRC_I_P(src, id) } },
+		 /* Playback */
+		 {{ 0,				0, },
+		  { RDMA_SRC_O_P(src, id),	RDMA_SRC_I_N(src, id) },
+		  { RDMA_CMD_O_P(src, id),	RDMA_SRC_I_N(src, id) } }
+		},
+		/* SSI */
+		/* Capture */
+		{{{ RDMA_SSI_O_N(ssi, id),	0 },
+		  { RDMA_SSIU_O_P(ssi, id),	0 },
+		  { RDMA_SSIU_O_P(ssi, id),	0 } },
+		 /* Playback */
+		 {{ 0,				RDMA_SSI_I_N(ssi, id) },
+		  { 0,				RDMA_SSIU_I_P(ssi, id) },
+		  { 0,				RDMA_SSIU_I_P(ssi, id) } }
+		},
+		/* SSIU */
+		/* Capture */
+		{{{ RDMA_SSIU_O_N(ssi, id),	0 },
+		  { RDMA_SSIU_O_P(ssi, id),	0 },
+		  { RDMA_SSIU_O_P(ssi, id),	0 } },
+		 /* Playback */
+		 {{ 0,				RDMA_SSIU_I_N(ssi, id) },
+		  { 0,				RDMA_SSIU_I_P(ssi, id) },
+		  { 0,				RDMA_SSIU_I_P(ssi, id) } } },
+	};
+
+	/* it shouldn't happen */
+	if (use_dvc && !use_src)
+		dev_err(dev, "DVC is selected without SRC\n");
+
+	/* use SSIU or SSI ? */
+	if (is_ssi && (0 = strcmp(rsnd_mod_dma_name(mod), "ssiu")))
+		is_ssi++;
+
+	return (is_from) ?
+		dma_addrs[is_ssi][is_play][use_src + use_dvc].out_addr :
+		dma_addrs[is_ssi][is_play][use_src + use_dvc].in_addr;
+}
+
+static dma_addr_t rsnd_dma_addr(struct rsnd_priv *priv,
+				struct rsnd_mod *mod,
+				int is_play, int is_from)
+{
+	/*
+	 * gen1 uses default DMA addr
+	 */
+	if (rsnd_is_gen1(priv))
+		return 0;
+
+	if (!mod)
+		return 0;
+
+	return rsnd_gen2_dma_addr(priv, mod, is_play, is_from);
+}
+
 static void rsnd_dma_of_path(struct rsnd_dma *dma,
 			     int is_play,
 			     struct rsnd_mod **mod_from,
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 789de4c..5863a61 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -188,116 +188,6 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 }
 
 /*
- *	DMA read/write register offset
- *
- *	RSND_xxx_I_N	for Audio DMAC input
- *	RSND_xxx_O_N	for Audio DMAC output
- *	RSND_xxx_I_P	for Audio DMAC peri peri input
- *	RSND_xxx_O_P	for Audio DMAC peri peri output
- *
- *	ex) R-Car H2 case
- *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp out
- *	SSI : 0xec541000 / 0xec241008 / 0xec24100c
- *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec400000
- *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec304000
- *	CMD : 0xec500000 /            / 0xec008000                0xec308000
- */
-#define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
-#define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
-
-#define RDMA_SSIU_I_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
-#define RDMA_SSIU_O_N(addr, i)	(addr ##_reg - 0x00441000 + (0x1000 * i))
-
-#define RDMA_SSIU_I_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
-#define RDMA_SSIU_O_P(addr, i)	(addr ##_reg - 0x00141000 + (0x1000 * i))
-
-#define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
-#define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 * i))
-
-#define RDMA_SRC_I_P(addr, i)	(addr ##_reg - 0x00200000 + (0x400 * i))
-#define RDMA_SRC_O_P(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 * i))
-
-#define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 * i))
-#define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 * i))
-
-static dma_addr_t
-rsnd_gen2_dma_addr(struct rsnd_priv *priv,
-		   struct rsnd_mod *mod,
-		   int is_play, int is_from)
-{
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	phys_addr_t ssi_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SSI);
-	phys_addr_t src_reg = rsnd_gen_get_phy_addr(priv, RSND_GEN2_SCU);
-	int is_ssi = !!(rsnd_io_to_mod_ssi(io) = mod);
-	int use_src = !!rsnd_io_to_mod_src(io);
-	int use_dvc = !!rsnd_io_to_mod_dvc(io);
-	int id = rsnd_mod_id(mod);
-	struct dma_addr {
-		dma_addr_t out_addr;
-		dma_addr_t in_addr;
-	} dma_addrs[3][2][3] = {
-		/* SRC */
-		{{{ 0,				0 },
-		/* Capture */
-		  { RDMA_SRC_O_N(src, id),	RDMA_SRC_I_P(src, id) },
-		  { RDMA_CMD_O_N(src, id),	RDMA_SRC_I_P(src, id) } },
-		 /* Playback */
-		 {{ 0,				0, },
-		  { RDMA_SRC_O_P(src, id),	RDMA_SRC_I_N(src, id) },
-		  { RDMA_CMD_O_P(src, id),	RDMA_SRC_I_N(src, id) } }
-		},
-		/* SSI */
-		/* Capture */
-		{{{ RDMA_SSI_O_N(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 } },
-		 /* Playback */
-		 {{ 0,				RDMA_SSI_I_N(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) } }
-		},
-		/* SSIU */
-		/* Capture */
-		{{{ RDMA_SSIU_O_N(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 },
-		  { RDMA_SSIU_O_P(ssi, id),	0 } },
-		 /* Playback */
-		 {{ 0,				RDMA_SSIU_I_N(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) },
-		  { 0,				RDMA_SSIU_I_P(ssi, id) } } },
-	};
-
-	/* it shouldn't happen */
-	if (use_dvc && !use_src)
-		dev_err(dev, "DVC is selected without SRC\n");
-
-	/* use SSIU or SSI ? */
-	if (is_ssi && (0 = strcmp(rsnd_mod_dma_name(mod), "ssiu")))
-		is_ssi++;
-
-	return (is_from) ?
-		dma_addrs[is_ssi][is_play][use_src + use_dvc].out_addr :
-		dma_addrs[is_ssi][is_play][use_src + use_dvc].in_addr;
-}
-
-dma_addr_t rsnd_gen_dma_addr(struct rsnd_priv *priv,
-			     struct rsnd_mod *mod,
-			     int is_play, int is_from)
-{
-	/*
-	 * gen1 uses default DMA addr
-	 */
-	if (rsnd_is_gen1(priv))
-		return 0;
-
-	if (!mod)
-		return 0;
-
-	return rsnd_gen2_dma_addr(priv, mod, is_play, is_from);
-}
-
-/*
  *		Gen2
  */
 static int rsnd_gen2_probe(struct platform_device *pdev,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 8a8a4d5..a73e94c 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -328,9 +328,6 @@ int rsnd_gen_probe(struct platform_device *pdev,
 void __iomem *rsnd_gen_reg_get(struct rsnd_priv *priv,
 			       struct rsnd_mod *mod,
 			       enum rsnd_reg reg);
-dma_addr_t rsnd_gen_dma_addr(struct rsnd_priv *priv,
-		       struct rsnd_mod *mod,
-		       int is_play,  int is_from);
 phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id);
 
 #define rsnd_is_gen1(s)		(((s)->info->flags & RSND_GEN_MASK) = RSND_GEN1)
-- 
1.7.9.5

