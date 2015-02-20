From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:31:23 +0000
Subject: [PATCH 20/24 v2] ASoC: rsnd: 1st DMAC dma-names cares subnode
Message-Id: <87mw48na9e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
not a general purpose DMAC (2nd DMAC is for Device to Device inside
sound system). Additionally, current DMAEngine can't support Device to
Device, and we don't have correct DT bindings for it at this point.
So the easiest solution for it is that move it from DMAEngine to rsnd
driver.

dma-names on DT was implemented as no difference between 1st / 2nd
DMAC's, since rsnd had assumed that both DMACs are implemented as
DMAEngine. That style was "src_dst". But now, 2nd DMAC was implemented
as non DMAEngine, and it doesn't need dma-names anymore. So, this
dma-names rule is no longer needed.

And additionally, dma-names was assumed that it has all
(= SSI/SSIU/SRC/DVC) nodes under sound node.

In upstream code, no SoC/platform is supporting DMA for rsnd driver yet.
This means there is no compatible issue if this patch changes
dma-names's rule of DT.

This patch assumes dma-names for 1st DMAC are tx/rx base, and listed
in each SSI/SRC/DVC subnode
ex)
	rcar_sound,dvc {
		dvc0: dvc@0 {
			dmas = <&audma0 0xbc>;
			dma-names = "tx";
		};
	...

	rcar_sound,src {
		src0: src@0 {
			...
			dmas = <&audma0 0x85>, <&audma1 0x9a>;
			dma-names = "rx", "tx";
		};
	...

	rcar_sound,ssi {
		ssi0: ssi@0 {
			...
			dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
			dma-names = "rx", "tx", "rxu", "txu";
		};
	...

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - remake version
 - supprts subnode dma-names

 sound/soc/sh/rcar/core.c |   11 +++---
 sound/soc/sh/rcar/dma.c  |   88 +++++++++++++++++++++++++++-------------------
 sound/soc/sh/rcar/dvc.c  |    9 +++++
 sound/soc/sh/rcar/rsnd.h |    6 ++--
 sound/soc/sh/rcar/src.c  |   13 +++++++
 sound/soc/sh/rcar/ssi.c  |   17 +++++++--
 6 files changed, 95 insertions(+), 49 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3b6e219..7b995f0 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -137,15 +137,12 @@ char *rsnd_mod_name(struct rsnd_mod *mod)
 	return mod->ops->name;
 }
 
-char *rsnd_mod_dma_name(struct rsnd_mod *mod)
+struct dma_chan *rsnd_mod_dma_req(struct rsnd_mod *mod)
 {
-	if (!mod || !mod->ops)
-		return "unknown";
-
-	if (!mod->ops->dma_name)
-		return mod->ops->name;
+	if (!mod || !mod->ops || !mod->ops->dma_req)
+		return NULL;
 
-	return mod->ops->dma_name(mod);
+	return mod->ops->dma_req(mod);
 }
 
 void rsnd_mod_init(struct rsnd_mod *mod,
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 3f34461..92fd550 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/delay.h>
+#include <linux/of_dma.h>
 #include "rsnd.h"
 
 /*
@@ -52,28 +53,6 @@ static void rsnd_dmaen_complete(void *data)
 	rsnd_dai_pointer_update(io, io->byte_per_period);
 }
 
-#define DMA_NAME_SIZE 16
-static int _rsnd_dmaen_of_name(char *dma_name, struct rsnd_mod *mod)
-{
-	if (mod)
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "%s%d",
-				rsnd_mod_dma_name(mod), rsnd_mod_id(mod));
-	else
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "mem");
-
-}
-
-static void rsnd_dmaen_of_name(struct rsnd_mod *mod_from,
-			     struct rsnd_mod *mod_to,
-			     char *dma_name)
-{
-	int index = 0;
-
-	index = _rsnd_dmaen_of_name(dma_name + index, mod_from);
-	*(dma_name + index++) = '_';
-	index = _rsnd_dmaen_of_name(dma_name + index, mod_to);
-}
-
 static void rsnd_dmaen_stop(struct rsnd_dma *dma)
 {
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
@@ -115,6 +94,40 @@ static void rsnd_dmaen_start(struct rsnd_dma *dma)
 	dma_async_issue_pending(dmaen->chan);
 }
 
+struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
+					  struct rsnd_mod *mod, char *name)
+{
+	struct dma_chan *chan;
+	struct device_node *np;
+	int i = 0;
+
+	for_each_child_of_node(of_node, np) {
+		if (i = rsnd_mod_id(mod))
+			break;
+		i++;
+	}
+
+	chan = of_dma_request_slave_channel(np, name);
+
+	of_node_put(np);
+	of_node_put(of_node);
+
+	return chan;
+}
+
+static struct dma_chan *rsnd_dmaen_request_channel(struct rsnd_mod *mod_from,
+						   struct rsnd_mod *mod_to)
+{
+	if ((!mod_from && !mod_to) ||
+	    (mod_from && mod_to))
+		return NULL;
+
+	if (mod_from)
+		return rsnd_mod_dma_req(mod_from);
+	else
+		return rsnd_mod_dma_req(mod_to);
+}
+
 static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
@@ -124,8 +137,6 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
 	int is_play = rsnd_io_is_play(io);
-	char dma_name[DMA_NAME_SIZE];
-	dma_cap_mask_t mask;
 	int ret;
 
 	if (dmaen->chan) {
@@ -135,10 +146,21 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 
 	dev_dbg(dev, "Audio DMAC init\n");
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	if (dev->of_node) {
+		dmaen->chan = rsnd_dmaen_request_channel(mod_from, mod_to);
+	} else {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
 
-	rsnd_dmaen_of_name(mod_from, mod_to, dma_name);
+		dmaen->chan = dma_request_channel(mask, shdma_chan_filter,
+						  (void *)id);
+	}
+	if (IS_ERR_OR_NULL(dmaen->chan)) {
+		dev_err(dev, "can't get dma channel\n");
+		goto rsnd_dma_channel_err;
+	}
 
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	cfg.src_addr	= dma->src_addr;
@@ -146,16 +168,8 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	dev_dbg(dev, "dma : %s %pad -> %pad\n",
-		dma_name, &cfg.src_addr, &cfg.dst_addr);
-
-	dmaen->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-						     (void *)id, dev,
-						     dma_name);
-	if (!dmaen->chan) {
-		dev_err(dev, "can't get dma channel\n");
-		goto rsnd_dma_channel_err;
-	}
+	dev_dbg(dev, "dma : %pad -> %pad\n",
+		&cfg.src_addr, &cfg.dst_addr);
 
 	ret = dmaengine_slave_config(dmaen->chan, &cfg);
 	if (ret < 0)
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index e099018..aeeef13 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -272,8 +272,17 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	return 0;
 }
 
+static struct dma_chan *rsnd_dvc_dma_req(struct rsnd_mod *mod)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+
+	return rsnd_dma_request_channel(rsnd_dvc_of_node(priv),
+					mod, "tx");
+}
+
 static struct rsnd_mod_ops rsnd_dvc_ops = {
 	.name		= DVC_NAME,
+	.dma_req	= rsnd_dvc_dma_req,
 	.probe		= rsnd_dvc_probe_gen2,
 	.remove		= rsnd_dvc_remove_gen2,
 	.init		= rsnd_dvc_init,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 68bc3f4..52c401c 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -207,6 +207,8 @@ void  rsnd_dma_quit(struct rsnd_dma *dma);
 int rsnd_dma_probe(struct platform_device *pdev,
 		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
+struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
+					  struct rsnd_mod *mod, char *name);
 
 #define rsnd_dma_to_mod(_dma) container_of((_dma), struct rsnd_mod, dma)
 
@@ -222,7 +224,7 @@ enum rsnd_mod_type {
 
 struct rsnd_mod_ops {
 	char *name;
-	char* (*dma_name)(struct rsnd_mod *mod);
+	struct dma_chan* (*dma_req)(struct rsnd_mod *mod);
 	int (*probe)(struct rsnd_mod *mod,
 		     struct rsnd_priv *priv);
 	int (*remove)(struct rsnd_mod *mod,
@@ -292,7 +294,7 @@ void rsnd_mod_init(struct rsnd_mod *mod,
 		   enum rsnd_mod_type type,
 		   int id);
 char *rsnd_mod_name(struct rsnd_mod *mod);
-char *rsnd_mod_dma_name(struct rsnd_mod *mod);
+struct dma_chan *rsnd_mod_dma_req(struct rsnd_mod *mod);
 
 /*
  *	R-Car sound DAI
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 5a601be..6ce8985 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -114,6 +114,17 @@ struct rsnd_src {
 /*
  *		Gen1/Gen2 common functions
  */
+static struct dma_chan *rsnd_src_dma_req(struct rsnd_mod *mod)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	int is_play = rsnd_io_is_play(io);
+
+	return rsnd_dma_request_channel(rsnd_src_of_node(priv),
+					mod,
+					is_play ? "rx" : "tx");
+}
+
 int rsnd_src_ssiu_start(struct rsnd_mod *ssi_mod,
 			int use_busif)
 {
@@ -506,6 +517,7 @@ static int rsnd_src_stop_gen1(struct rsnd_mod *mod,
 
 static struct rsnd_mod_ops rsnd_src_gen1_ops = {
 	.name	= SRC_NAME,
+	.dma_req = rsnd_src_dma_req,
 	.probe	= rsnd_src_probe_gen1,
 	.init	= rsnd_src_init_gen1,
 	.quit	= rsnd_src_quit,
@@ -780,6 +792,7 @@ static int rsnd_src_stop_gen2(struct rsnd_mod *mod,
 
 static struct rsnd_mod_ops rsnd_src_gen2_ops = {
 	.name	= SRC_NAME,
+	.dma_req = rsnd_src_dma_req,
 	.probe	= rsnd_src_probe_gen2,
 	.remove	= rsnd_src_remove_gen2,
 	.init	= rsnd_src_init_gen2,
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 2133eb3..fea4aa5 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -553,14 +553,25 @@ static int rsnd_ssi_dma_stop(struct rsnd_mod *mod,
 	return 0;
 }
 
-static char *rsnd_ssi_dma_name(struct rsnd_mod *mod)
+static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_mod *mod)
 {
-	return rsnd_ssi_use_busif(mod) ? "ssiu" : SSI_NAME;
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	int is_play = rsnd_io_is_play(io);
+	char *name;
+
+	if (rsnd_ssi_use_busif(mod))
+		name = is_play ? "rxu" : "txu";
+	else
+		name = is_play ? "rx" : "tx";
+
+	return rsnd_dma_request_channel(rsnd_ssi_of_node(priv),
+					mod, name);
 }
 
 static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.name	= SSI_NAME,
-	.dma_name = rsnd_ssi_dma_name,
+	.dma_req = rsnd_ssi_dma_req,
 	.probe	= rsnd_ssi_dma_probe,
 	.remove	= rsnd_ssi_dma_remove,
 	.init	= rsnd_ssi_init,
-- 
1.7.9.5

