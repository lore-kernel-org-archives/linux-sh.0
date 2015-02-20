From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:29:13 +0000
Subject: [PATCH 15/24 v2] ASoC: rsnd: use union with rsnd_dmaen / rsnd_dmapp
Message-Id: <87twygnad0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car needs 2 DMACs.1st DMAC is DMAEngine, and 2nd DMAC is
implemented as local code. These 2 DMACs are never shared.
We can use union for these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/sh/rcar/dma.c  |   40 +++++++++++++++++++++++++---------------
 sound/soc/sh/rcar/rsnd.h |   16 ++++++++++++++--
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 3f1ea58..b449763 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -76,11 +76,14 @@ static void rsnd_dmaen_of_name(struct rsnd_mod *mod_from,
 
 static void rsnd_dmaen_stop(struct rsnd_dma *dma)
 {
-	dmaengine_terminate_all(dma->chan);
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
+
+	dmaengine_terminate_all(dmaen->chan);
 }
 
 static void rsnd_dmaen_start(struct rsnd_dma *dma)
 {
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
@@ -89,7 +92,7 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 	struct dma_async_tx_descriptor *desc;
 	int is_play = rsnd_io_is_play(io);
 
-	desc = dmaengine_prep_dma_cyclic(dma->chan,
+	desc = dmaengine_prep_dma_cyclic(dmaen->chan,
 					 substream->runtime->dma_addr,
 					 snd_pcm_lib_buffer_bytes(substream),
 					 snd_pcm_lib_period_bytes(substream),
@@ -109,12 +112,13 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 		return;
 	}
 
-	dma_async_issue_pending(dma->chan);
+	dma_async_issue_pending(dmaen->chan);
 }
 
 static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_slave_config cfg = {};
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
@@ -124,7 +128,7 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	dma_cap_mask_t mask;
 	int ret;
 
-	if (dma->chan) {
+	if (dmaen->chan) {
 		dev_err(dev, "it already has dma channel\n");
 		return -EIO;
 	}
@@ -145,15 +149,15 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	dev_dbg(dev, "dma : %s %pad -> %pad\n",
 		dma_name, &cfg.src_addr, &cfg.dst_addr);
 
-	dma->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+	dmaen->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
 						     (void *)id, dev,
 						     dma_name);
-	if (!dma->chan) {
+	if (!dmaen->chan) {
 		dev_err(dev, "can't get dma channel\n");
 		goto rsnd_dma_channel_err;
 	}
 
-	ret = dmaengine_slave_config(dma->chan, &cfg);
+	ret = dmaengine_slave_config(dmaen->chan, &cfg);
 	if (ret < 0)
 		goto rsnd_dma_init_err;
 
@@ -174,10 +178,12 @@ rsnd_dma_channel_err:
 
 static void rsnd_dmaen_quit(struct rsnd_dma *dma)
 {
-	if (dma->chan)
-		dma_release_channel(dma->chan);
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
+
+	if (dmaen->chan)
+		dma_release_channel(dmaen->chan);
 
-	dma->chan = NULL;
+	dmaen->chan = NULL;
 }
 
 static struct rsnd_dma_ops rsnd_dmaen_ops = {
@@ -257,7 +263,8 @@ static u32 rsnd_dmapp_get_chcr(struct rsnd_mod *mod_from,
 }
 
 #define rsnd_dmapp_addr(dmac, dma, reg) \
-	(dmac->base + 0x20 + (0x10 * dma->dmapp_id) + reg)
+	(dmac->base + 0x20 + reg + \
+	 (0x10 * rsnd_dma_to_dmapp(dma)->dmapp_id))
 static void rsnd_dmapp_write(struct rsnd_dma *dma, u32 data, u32 reg)
 {
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
@@ -294,28 +301,31 @@ static void rsnd_dmapp_stop(struct rsnd_dma *dma)
 
 static void rsnd_dmapp_start(struct rsnd_dma *dma)
 {
+	struct rsnd_dmapp *dmapp = rsnd_dma_to_dmapp(dma);
+
 	rsnd_dmapp_write(dma, dma->src_addr,	PDMASAR);
 	rsnd_dmapp_write(dma, dma->dst_addr,	PDMADAR);
-	rsnd_dmapp_write(dma, dma->chcr,	PDMACHCR);
+	rsnd_dmapp_write(dma, dmapp->chcr,	PDMACHCR);
 }
 
 static int rsnd_dmapp_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
+	struct rsnd_dmapp *dmapp = rsnd_dma_to_dmapp(dma);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
 	dev_dbg(dev, "Audio DMAC peri peri init\n");
 
-	dma->dmapp_id = dmac->dmapp_num;
-	dma->chcr = rsnd_dmapp_get_chcr(mod_from, mod_to) | PDMACHCR_DE;
+	dmapp->dmapp_id = dmac->dmapp_num;
+	dmapp->chcr = rsnd_dmapp_get_chcr(mod_from, mod_to) | PDMACHCR_DE;
 
 	dmac->dmapp_num++;
 
 	rsnd_dmapp_stop(dma);
 
 	dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
-		dma->dmapp_id, dma->src_addr, dma->dst_addr, dma->chcr);
+		dmapp->dmapp_id, dma->src_addr, dma->dst_addr, dmapp->chcr);
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 5d65a4b..0d36e38 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -179,14 +179,26 @@ struct rsnd_dma_ops {
 	void  (*quit)(struct rsnd_dma *dma);
 };
 
-struct rsnd_dma {
+struct rsnd_dmaen {
 	struct dma_chan		*chan;
-	struct rsnd_dma_ops	*ops;
+};
+
+struct rsnd_dmapp {
 	int			dmapp_id;
 	u32			chcr;
+};
+
+struct rsnd_dma {
+	struct rsnd_dma_ops	*ops;
 	dma_addr_t		src_addr;
 	dma_addr_t		dst_addr;
+	union {
+		struct rsnd_dmaen en;
+		struct rsnd_dmapp pp;
+	} dma;
 };
+#define rsnd_dma_to_dmaen(dma)	(&(dma)->dma.en)
+#define rsnd_dma_to_dmapp(dma)	(&(dma)->dma.pp)
 
 void rsnd_dma_start(struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dma *dma);
-- 
1.7.9.5

