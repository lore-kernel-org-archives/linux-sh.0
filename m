From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:27:12 +0000
Subject: [PATCH 11/24 v2] ASoC: rsnd: enable to care 1st / 2nd DMAC on rsnd_dma_xxx()
Message-Id: <87zj88nagd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd driver needs to care about Audio DAMC (via DMAEngine),
Audio DMAC peri peri (via local method) on rsnd driver.
This patch adds new rsnd_dma_ops and care it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/dma.c  |   78 +++++++++++++++++++++++++++++++---------------
 sound/soc/sh/rcar/rsnd.h |   12 +++++++
 2 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 188b463..c911c07 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -10,7 +10,7 @@
  */
 #include "rsnd.h"
 
-static void rsnd_dma_complete(void *data)
+static void rsnd_dmaen_complete(void *data)
 {
 	struct rsnd_dma *dma = (struct rsnd_dma *)data;
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
@@ -32,7 +32,7 @@ static void rsnd_dma_complete(void *data)
 }
 
 #define DMA_NAME_SIZE 16
-static int _rsnd_dma_of_name(char *dma_name, struct rsnd_mod *mod)
+static int _rsnd_dmaen_of_name(char *dma_name, struct rsnd_mod *mod)
 {
 	if (mod)
 		return snprintf(dma_name, DMA_NAME_SIZE / 2, "%s%d",
@@ -42,23 +42,23 @@ static int _rsnd_dma_of_name(char *dma_name, struct rsnd_mod *mod)
 
 }
 
-static void rsnd_dma_of_name(struct rsnd_mod *mod_from,
+static void rsnd_dmaen_of_name(struct rsnd_mod *mod_from,
 			     struct rsnd_mod *mod_to,
 			     char *dma_name)
 {
 	int index = 0;
 
-	index = _rsnd_dma_of_name(dma_name + index, mod_from);
+	index = _rsnd_dmaen_of_name(dma_name + index, mod_from);
 	*(dma_name + index++) = '_';
-	index = _rsnd_dma_of_name(dma_name + index, mod_to);
+	index = _rsnd_dmaen_of_name(dma_name + index, mod_to);
 }
 
-void rsnd_dma_stop(struct rsnd_dma *dma)
+static void rsnd_dmaen_stop(struct rsnd_dma *dma)
 {
 	dmaengine_terminate_all(dma->chan);
 }
 
-void rsnd_dma_start(struct rsnd_dma *dma)
+static void rsnd_dmaen_start(struct rsnd_dma *dma)
 {
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
@@ -80,7 +80,7 @@ void rsnd_dma_start(struct rsnd_dma *dma)
 		return;
 	}
 
-	desc->callback		= rsnd_dma_complete;
+	desc->callback		= rsnd_dmaen_complete;
 	desc->callback_param	= dma;
 
 	if (dmaengine_submit(desc) < 0) {
@@ -91,22 +91,12 @@ void rsnd_dma_start(struct rsnd_dma *dma)
 	dma_async_issue_pending(dma->chan);
 }
 
-static void rsnd_dma_of_path(struct rsnd_dma *dma,
-			     int is_play,
-			     struct rsnd_mod **mod_from,
-			     struct rsnd_mod **mod_to);
-
-static dma_addr_t rsnd_dma_addr(struct rsnd_priv *priv,
-				struct rsnd_mod *mod,
-				int is_play, int is_from);
-
-int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
+static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
+			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_slave_config cfg = {};
 	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
-	struct rsnd_mod *mod_from;
-	struct rsnd_mod *mod_to;
 	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
 	int is_play = rsnd_io_is_play(io);
 	char dma_name[DMA_NAME_SIZE];
@@ -121,12 +111,11 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	rsnd_dma_of_path(dma, is_play, &mod_from, &mod_to);
-	rsnd_dma_of_name(mod_from, mod_to, dma_name);
+	rsnd_dmaen_of_name(mod_from, mod_to, dma_name);
 
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.src_addr	= rsnd_dma_addr(priv, mod_from, is_play, 1);
-	cfg.dst_addr	= rsnd_dma_addr(priv, mod_to,   is_play, 0);
+	cfg.src_addr	= dma->src_addr;
+	cfg.dst_addr	= dma->dst_addr;
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
@@ -163,7 +152,7 @@ rsnd_dma_channel_err:
 	return -EAGAIN;
 }
 
-void rsnd_dma_quit(struct rsnd_dma *dma)
+static void rsnd_dmaen_quit(struct rsnd_dma *dma)
 {
 	if (dma->chan)
 		dma_release_channel(dma->chan);
@@ -171,6 +160,13 @@ void rsnd_dma_quit(struct rsnd_dma *dma)
 	dma->chan = NULL;
 }
 
+static struct rsnd_dma_ops rsnd_dmaen_ops = {
+	.start	= rsnd_dmaen_start,
+	.stop	= rsnd_dmaen_stop,
+	.init	= rsnd_dmaen_init,
+	.quit	= rsnd_dmaen_quit,
+};
+
 /*
  *	DMA read/write register offset
  *
@@ -343,3 +339,35 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 	}
 }
 
+void rsnd_dma_stop(struct rsnd_dma *dma)
+{
+	dma->ops->stop(dma);
+}
+
+void rsnd_dma_start(struct rsnd_dma *dma)
+{
+	dma->ops->start(dma);
+}
+
+void rsnd_dma_quit(struct rsnd_dma *dma)
+{
+	dma->ops->quit(dma);
+}
+
+int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
+{
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_mod *mod_from;
+	struct rsnd_mod *mod_to;
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	int is_play = rsnd_io_is_play(io);
+
+	rsnd_dma_of_path(dma, is_play, &mod_from, &mod_to);
+
+	dma->src_addr = rsnd_dma_addr(priv, mod_from, is_play, 1);
+	dma->dst_addr = rsnd_dma_addr(priv, mod_to,   is_play, 0);
+
+	dma->ops = &rsnd_dmaen_ops;
+
+	return dma->ops->init(priv, dma, id, mod_from, mod_to);
+}
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index a73e94c..c7299f7 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -170,10 +170,22 @@ u32 rsnd_get_adinr(struct rsnd_mod *mod);
 /*
  *	R-Car DMA
  */
+struct rsnd_dma;
+struct rsnd_dma_ops {
+	void (*start)(struct rsnd_dma *dma);
+	void (*stop)(struct rsnd_dma *dma);
+	int (*init)(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
+		    struct rsnd_mod *mod_from, struct rsnd_mod *mod_to);
+	void  (*quit)(struct rsnd_dma *dma);
+};
+
 struct rsnd_dma {
 	struct dma_chan		*chan;
+	struct rsnd_dma_ops	*ops;
 	enum dma_transfer_direction dir;
 	dma_addr_t		addr;
+	dma_addr_t		src_addr;
+	dma_addr_t		dst_addr;
 };
 
 void rsnd_dma_start(struct rsnd_dma *dma);
-- 
1.7.9.5

