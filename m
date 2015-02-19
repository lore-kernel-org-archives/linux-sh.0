From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:51:59 +0000
Subject: [PATCH 08/19] ASoC: rsnd: add dma.c for Audio DMAC / Audio DMAC peri peri
Message-Id: <87k2ze1rrl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas sound driver had been assumed that Audio DMAC /
Audio DMAC peri peri are implemented by DMAEngine. But, result of DMA
ML discussion, it was concluded that it is not a general purpose DMAC.
And it should be moved from current DMAEngine to rsnd driver.
So, Audio DMAC peri peri become non DMAEngine.

OTOH, ALSA SoC has soc-generic-dmaengine-pcm implementation. but it
seems difficult to use this generic implementation on rsnd driver at
this point, since it needs to fallback to PIO mode if DMA can't use.
and additionally it needs 2 DMAC (= Audio DMAC / Audio DMAC peri peri).
These are not "generic" feature.

Of course I will try to use this generic dmaengine in the future somehow,
but just use current style at this point until it can formally use 2 DMACs.
This patch adds new dma.c and moves current dma code to dma.c from core.c.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/Makefile |    2 +-
 sound/soc/sh/rcar/core.c   |  218 -----------------------------------------
 sound/soc/sh/rcar/dma.c    |  231 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+), 219 deletions(-)
 create mode 100644 sound/soc/sh/rcar/dma.c

diff --git a/sound/soc/sh/rcar/Makefile b/sound/soc/sh/rcar/Makefile
index 9ac5364..7b20492 100644
--- a/sound/soc/sh/rcar/Makefile
+++ b/sound/soc/sh/rcar/Makefile
@@ -1,2 +1,2 @@
-snd-soc-rcar-objs	:= core.o gen.o src.o adg.o ssi.o dvc.o
+snd-soc-rcar-objs	:= core.o gen.o dma.o src.o adg.o ssi.o dvc.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
\ No newline at end of file
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 7db686d..9beea9b 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -161,224 +161,6 @@ void rsnd_mod_init(struct rsnd_mod *mod,
 }
 
 /*
- *	rsnd_dma functions
- */
-void rsnd_dma_stop(struct rsnd_dma *dma)
-{
-	dmaengine_terminate_all(dma->chan);
-}
-
-static void rsnd_dma_complete(void *data)
-{
-	struct rsnd_dma *dma = (struct rsnd_dma *)data;
-	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
-	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-
-	/*
-	 * Renesas sound Gen1 needs 1 DMAC,
-	 * Gen2 needs 2 DMAC.
-	 * In Gen2 case, it are Audio-DMAC, and Audio-DMAC-peri-peri.
-	 * But, Audio-DMAC-peri-peri doesn't have interrupt,
-	 * and this driver is assuming that here.
-	 *
-	 * If Audio-DMAC-peri-peri has interrpt,
-	 * rsnd_dai_pointer_update() will be called twice,
-	 * ant it will breaks io->byte_pos
-	 */
-
-	rsnd_dai_pointer_update(io, io->byte_per_period);
-}
-
-void rsnd_dma_start(struct rsnd_dma *dma)
-{
-	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	struct snd_pcm_substream *substream = io->substream;
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct dma_async_tx_descriptor *desc;
-
-	desc = dmaengine_prep_dma_cyclic(dma->chan,
-					 (dma->addr) ? dma->addr :
-					 substream->runtime->dma_addr,
-					 snd_pcm_lib_buffer_bytes(substream),
-					 snd_pcm_lib_period_bytes(substream),
-					 dma->dir,
-					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-
-	if (!desc) {
-		dev_err(dev, "dmaengine_prep_slave_sg() fail\n");
-		return;
-	}
-
-	desc->callback		= rsnd_dma_complete;
-	desc->callback_param	= dma;
-
-	if (dmaengine_submit(desc) < 0) {
-		dev_err(dev, "dmaengine_submit() fail\n");
-		return;
-	}
-
-	dma_async_issue_pending(dma->chan);
-}
-
-#define DMA_NAME_SIZE 16
-#define MOD_MAX 4 /* MEM/SSI/SRC/DVC */
-static int _rsnd_dma_of_name(char *dma_name, struct rsnd_mod *mod)
-{
-	if (mod)
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "%s%d",
-			 rsnd_mod_dma_name(mod), rsnd_mod_id(mod));
-	else
-		return snprintf(dma_name, DMA_NAME_SIZE / 2, "mem");
-
-}
-
-static void rsnd_dma_of_name(struct rsnd_mod *mod_from,
-			     struct rsnd_mod *mod_to,
-			     char *dma_name)
-{
-	int index = 0;
-
-	index = _rsnd_dma_of_name(dma_name + index, mod_from);
-	*(dma_name + index++) = '_';
-	index = _rsnd_dma_of_name(dma_name + index, mod_to);
-}
-
-static void rsnd_dma_of_path(struct rsnd_dma *dma,
-			     int is_play,
-			     struct rsnd_mod **mod_from,
-			     struct rsnd_mod **mod_to)
-{
-	struct rsnd_mod *this = rsnd_dma_to_mod(dma);
-	struct rsnd_dai_stream *io = rsnd_mod_to_io(this);
-	struct rsnd_mod *ssi = rsnd_io_to_mod_ssi(io);
-	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
-	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
-	struct rsnd_mod *mod[MOD_MAX];
-	int i, index;
-
-
-	for (i = 0; i < MOD_MAX; i++)
-		mod[i] = NULL;
-
-	/*
-	 * in play case...
-	 *
-	 * src -> dst
-	 *
-	 * mem -> SSI
-	 * mem -> SRC -> SSI
-	 * mem -> SRC -> DVC -> SSI
-	 */
-	mod[0] = NULL; /* for "mem" */
-	index = 1;
-	for (i = 1; i < MOD_MAX; i++) {
-		if (!src) {
-			mod[i] = ssi;
-		} else if (!dvc) {
-			mod[i] = src;
-			src = NULL;
-		} else {
-			if ((!is_play) && (this = src))
-				this = dvc;
-
-			mod[i] = (is_play) ? src : dvc;
-			i++;
-			mod[i] = (is_play) ? dvc : src;
-			src = NULL;
-			dvc = NULL;
-		}
-
-		if (mod[i] = this)
-			index = i;
-
-		if (mod[i] = ssi)
-			break;
-	}
-
-	if (is_play) {
-		*mod_from = mod[index - 1];
-		*mod_to   = mod[index];
-	} else {
-		*mod_from = mod[index];
-		*mod_to   = mod[index - 1];
-	}
-}
-
-int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
-{
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct dma_slave_config cfg;
-	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
-	struct rsnd_mod *mod_from;
-	struct rsnd_mod *mod_to;
-	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
-	int is_play = rsnd_io_is_play(io);
-	char dma_name[DMA_NAME_SIZE];
-	dma_cap_mask_t mask;
-	int ret;
-
-	if (dma->chan) {
-		dev_err(dev, "it already has dma channel\n");
-		return -EIO;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	rsnd_dma_of_path(dma, is_play, &mod_from, &mod_to);
-	rsnd_dma_of_name(mod_from, mod_to, dma_name);
-
-	cfg.slave_id	= id;
-	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.src_addr	= rsnd_gen_dma_addr(priv, mod_from, is_play, 1);
-	cfg.dst_addr	= rsnd_gen_dma_addr(priv, mod_to,   is_play, 0);
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-
-	dev_dbg(dev, "dma : %s %pad -> %pad\n",
-		dma_name, &cfg.src_addr, &cfg.dst_addr);
-
-	dma->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-						     (void *)id, dev,
-						     dma_name);
-	if (!dma->chan) {
-		dev_err(dev, "can't get dma channel\n");
-		goto rsnd_dma_channel_err;
-	}
-
-	ret = dmaengine_slave_config(dma->chan, &cfg);
-	if (ret < 0)
-		goto rsnd_dma_init_err;
-
-	dma->addr = is_play ? cfg.src_addr : cfg.dst_addr;
-	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-
-	return 0;
-
-rsnd_dma_init_err:
-	rsnd_dma_quit(dma);
-rsnd_dma_channel_err:
-
-	/*
-	 * DMA failed. try to PIO mode
-	 * see
-	 *	rsnd_ssi_fallback()
-	 *	rsnd_rdai_continuance_probe()
-	 */
-	return -EAGAIN;
-}
-
-void  rsnd_dma_quit(struct rsnd_dma *dma)
-{
-	if (dma->chan)
-		dma_release_channel(dma->chan);
-
-	dma->chan = NULL;
-}
-
-/*
  *	settting function
  */
 u32 rsnd_get_adinr(struct rsnd_mod *mod)
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
new file mode 100644
index 0000000..37acd40
--- /dev/null
+++ b/sound/soc/sh/rcar/dma.c
@@ -0,0 +1,231 @@
+/*
+ * Renesas R-Car Audio DMAC support
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "rsnd.h"
+
+static void rsnd_dma_complete(void *data)
+{
+	struct rsnd_dma *dma = (struct rsnd_dma *)data;
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+
+	/*
+	 * Renesas sound Gen1 needs 1 DMAC,
+	 * Gen2 needs 2 DMAC.
+	 * In Gen2 case, it are Audio-DMAC, and Audio-DMAC-peri-peri.
+	 * But, Audio-DMAC-peri-peri doesn't have interrupt,
+	 * and this driver is assuming that here.
+	 *
+	 * If Audio-DMAC-peri-peri has interrpt,
+	 * rsnd_dai_pointer_update() will be called twice,
+	 * ant it will breaks io->byte_pos
+	 */
+
+	rsnd_dai_pointer_update(io, io->byte_per_period);
+}
+
+#define DMA_NAME_SIZE 16
+#define MOD_MAX 4 /* MEM/SSI/SRC/DVC */
+static int _rsnd_dma_of_name(char *dma_name, struct rsnd_mod *mod)
+{
+	if (mod)
+		return snprintf(dma_name, DMA_NAME_SIZE / 2, "%s%d",
+				rsnd_mod_dma_name(mod), rsnd_mod_id(mod));
+	else
+		return snprintf(dma_name, DMA_NAME_SIZE / 2, "mem");
+
+}
+
+static void rsnd_dma_of_name(struct rsnd_mod *mod_from,
+			     struct rsnd_mod *mod_to,
+			     char *dma_name)
+{
+	int index = 0;
+
+	index = _rsnd_dma_of_name(dma_name + index, mod_from);
+	*(dma_name + index++) = '_';
+	index = _rsnd_dma_of_name(dma_name + index, mod_to);
+}
+
+void rsnd_dma_stop(struct rsnd_dma *dma)
+{
+	dmaengine_terminate_all(dma->chan);
+}
+
+void rsnd_dma_start(struct rsnd_dma *dma)
+{
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	struct snd_pcm_substream *substream = io->substream;
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct dma_async_tx_descriptor *desc;
+
+	desc = dmaengine_prep_dma_cyclic(dma->chan,
+					 (dma->addr) ? dma->addr :
+					 substream->runtime->dma_addr,
+					 snd_pcm_lib_buffer_bytes(substream),
+					 snd_pcm_lib_period_bytes(substream),
+					 dma->dir,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (!desc) {
+		dev_err(dev, "dmaengine_prep_slave_sg() fail\n");
+		return;
+	}
+
+	desc->callback		= rsnd_dma_complete;
+	desc->callback_param	= dma;
+
+	if (dmaengine_submit(desc) < 0) {
+		dev_err(dev, "dmaengine_submit() fail\n");
+		return;
+	}
+
+	dma_async_issue_pending(dma->chan);
+}
+
+static void rsnd_dma_of_path(struct rsnd_dma *dma,
+			     int is_play,
+			     struct rsnd_mod **mod_from,
+			     struct rsnd_mod **mod_to);
+
+int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct dma_slave_config cfg = {};
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_mod *mod_from;
+	struct rsnd_mod *mod_to;
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	int is_play = rsnd_io_is_play(io);
+	char dma_name[DMA_NAME_SIZE];
+	dma_cap_mask_t mask;
+	int ret;
+
+	if (dma->chan) {
+		dev_err(dev, "it already has dma channel\n");
+		return -EIO;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	rsnd_dma_of_path(dma, is_play, &mod_from, &mod_to);
+	rsnd_dma_of_name(mod_from, mod_to, dma_name);
+
+	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	cfg.src_addr	= rsnd_gen_dma_addr(priv, mod_from, is_play, 1);
+	cfg.dst_addr	= rsnd_gen_dma_addr(priv, mod_to,   is_play, 0);
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	dev_dbg(dev, "dma : %s %pad -> %pad\n",
+		dma_name, &cfg.src_addr, &cfg.dst_addr);
+
+	dma->chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+						     (void *)id, dev,
+						     dma_name);
+	if (!dma->chan) {
+		dev_err(dev, "can't get dma channel\n");
+		goto rsnd_dma_channel_err;
+	}
+
+	ret = dmaengine_slave_config(dma->chan, &cfg);
+	if (ret < 0)
+		goto rsnd_dma_init_err;
+
+	dma->addr = is_play ? cfg.src_addr : cfg.dst_addr;
+	dma->dir = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+
+	return 0;
+
+rsnd_dma_init_err:
+	rsnd_dma_quit(dma);
+rsnd_dma_channel_err:
+
+	/*
+	 * DMA failed. try to PIO mode
+	 * see
+	 *	rsnd_ssi_fallback()
+	 *	rsnd_rdai_continuance_probe()
+	 */
+	return -EAGAIN;
+}
+
+void rsnd_dma_quit(struct rsnd_dma *dma)
+{
+	if (dma->chan)
+		dma_release_channel(dma->chan);
+
+	dma->chan = NULL;
+}
+
+static void rsnd_dma_of_path(struct rsnd_dma *dma,
+			     int is_play,
+			     struct rsnd_mod **mod_from,
+			     struct rsnd_mod **mod_to)
+{
+	struct rsnd_mod *this = rsnd_dma_to_mod(dma);
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(this);
+	struct rsnd_mod *ssi = rsnd_io_to_mod_ssi(io);
+	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
+	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
+	struct rsnd_mod *mod[MOD_MAX];
+	int i, index;
+
+
+	for (i = 0; i < MOD_MAX; i++)
+		mod[i] = NULL;
+
+	/*
+	 * in play case...
+	 *
+	 * src -> dst
+	 *
+	 * mem -> SSI
+	 * mem -> SRC -> SSI
+	 * mem -> SRC -> DVC -> SSI
+	 */
+	mod[0] = NULL; /* for "mem" */
+	index = 1;
+	for (i = 1; i < MOD_MAX; i++) {
+		if (!src) {
+			mod[i] = ssi;
+		} else if (!dvc) {
+			mod[i] = src;
+			src = NULL;
+		} else {
+			if ((!is_play) && (this = src))
+				this = dvc;
+
+			mod[i] = (is_play) ? src : dvc;
+			i++;
+			mod[i] = (is_play) ? dvc : src;
+			src = NULL;
+			dvc = NULL;
+		}
+
+		if (mod[i] = this)
+			index = i;
+
+		if (mod[i] = ssi)
+			break;
+	}
+
+	if (is_play) {
+		*mod_from = mod[index - 1];
+		*mod_to   = mod[index];
+	} else {
+		*mod_from = mod[index];
+		*mod_to   = mod[index - 1];
+	}
+}
+
-- 
1.7.9.5

