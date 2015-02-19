From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:52:31 +0000
Subject: [PATCH 11/19] ASoC: rsnd: add Audio DMAC peri peri support rework
Message-Id: <87fva21rqr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

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
Audio DMAC peri peri is controlled from sound driver without DMAEngine
by this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |    1 +
 sound/soc/sh/rcar/dma.c  |  212 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/sh/rcar/rsnd.h |   11 ++-
 3 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 9beea9b..3b6e219 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -974,6 +974,7 @@ static int rsnd_probe(struct platform_device *pdev)
 			    const struct rsnd_of_data *of_data,
 			    struct rsnd_priv *priv) = {
 		rsnd_gen_probe,
+		rsnd_dma_probe,
 		rsnd_ssi_probe,
 		rsnd_src_probe,
 		rsnd_dvc_probe,
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 61fba17..9cb5785 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -8,8 +8,29 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/delay.h>
 #include "rsnd.h"
 
+/*
+ * Audio DMAC peri peri register
+ */
+#define PDMASAR		0x00
+#define PDMADAR		0x04
+#define PDMACHCR	0x0c
+
+/* PDMACHCR */
+#define PDMACHCR_DE		(1 << 0)
+
+struct rsnd_dma_ctrl {
+	void __iomem *base;
+	int dmapp_num;
+};
+
+#define rsnd_priv_to_dmac(p)	((struct rsnd_dma_ctrl *)(p)->dma)
+
+/*
+ *		Audio DMAC
+ */
 static void rsnd_dmaen_complete(void *data)
 {
 	struct rsnd_dma *dma = (struct rsnd_dma *)data;
@@ -109,6 +130,8 @@ static int rsnd_dmaen_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
 		return -EIO;
 	}
 
+	dev_dbg(dev, "Audio DMAC init\n");
+
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
@@ -169,6 +192,151 @@ static struct rsnd_dma_ops rsnd_dmaen_ops = {
 };
 
 /*
+ *		Audio DMAC peri peri
+ */
+static const u8 gen2_id_table_ssiu[] = {
+	0x00, /* SSI00 */
+	0x04, /* SSI10 */
+	0x08, /* SSI20 */
+	0x0c, /* SSI3  */
+	0x0d, /* SSI4  */
+	0x0e, /* SSI5  */
+	0x0f, /* SSI6  */
+	0x10, /* SSI7  */
+	0x11, /* SSI8  */
+	0x12, /* SSI90 */
+};
+static const u8 gen2_id_table_scu[] = {
+	0x2d, /* SCU_SRCI0 */
+	0x2e, /* SCU_SRCI1 */
+	0x2f, /* SCU_SRCI2 */
+	0x30, /* SCU_SRCI3 */
+	0x31, /* SCU_SRCI4 */
+	0x32, /* SCU_SRCI5 */
+	0x33, /* SCU_SRCI6 */
+	0x34, /* SCU_SRCI7 */
+	0x35, /* SCU_SRCI8 */
+	0x36, /* SCU_SRCI9 */
+};
+static const u8 gen2_id_table_cmd[] = {
+	0x37, /* SCU_CMD0 */
+	0x38, /* SCU_CMD1 */
+};
+
+static u32 rsnd_dmapp_get_id(struct rsnd_mod *mod)
+{
+	struct rsnd_dai_stream *io = rsnd_mod_to_io(mod);
+	struct rsnd_mod *ssi = rsnd_io_to_mod_ssi(io);
+	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
+	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
+	const u8 *entry = NULL;
+	int id = rsnd_mod_id(mod);
+	int size = 0;
+
+	if (mod = ssi) {
+		entry = gen2_id_table_ssiu;
+		size = ARRAY_SIZE(gen2_id_table_ssiu);
+	}
+	else if (mod = src) {
+		entry = gen2_id_table_scu;
+		size = ARRAY_SIZE(gen2_id_table_scu);
+	}
+	else if (mod = dvc) {
+		entry = gen2_id_table_cmd;
+		size = ARRAY_SIZE(gen2_id_table_cmd);
+	}
+
+	if (!entry)
+		return 0xFF;
+
+	if (size <= id)
+		return 0xFF;
+
+	return entry[id];
+}
+
+static u32 rsnd_dmapp_get_chcr(struct rsnd_mod *mod_from,
+			       struct rsnd_mod *mod_to)
+{
+	return	(rsnd_dmapp_get_id(mod_from) << 24) +
+		(rsnd_dmapp_get_id(mod_to) << 16);
+}
+
+#define rsnd_dmapp_addr(dmac, dma, reg) dmac->base + 0x20 + (0x10 * dma->dmapp_id) + reg
+static void rsnd_dmapp_write(struct rsnd_dma *dma, u32 data, u32 reg)
+{
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+
+	dev_dbg(dev, "w %p : %08x\n", rsnd_dmapp_addr(dmac, dma, reg), data);
+
+	iowrite32(data, rsnd_dmapp_addr(dmac, dma, reg));
+}
+
+static u32 rsnd_dmapp_read(struct rsnd_dma *dma, u32 reg)
+{
+	struct rsnd_mod *mod = rsnd_dma_to_mod(dma);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+
+	return ioread32(rsnd_dmapp_addr(dmac, dma, reg));
+}
+
+static void rsnd_dmapp_stop(struct rsnd_dma *dma)
+{
+	int i;
+
+	rsnd_dmapp_write(dma, 0, PDMACHCR);
+
+	for (i = 0; i < 1024; i++) {
+		if (0 = rsnd_dmapp_read(dma, PDMACHCR))
+			return;
+		udelay(1);
+	}
+}
+
+static void rsnd_dmapp_start(struct rsnd_dma *dma)
+{
+	rsnd_dmapp_write(dma, dma->src_addr,	PDMASAR);
+	rsnd_dmapp_write(dma, dma->dst_addr,	PDMADAR);
+	rsnd_dmapp_write(dma, dma->chcr,	PDMACHCR);
+}
+
+static int rsnd_dmapp_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id,
+			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
+{
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+
+	dev_dbg(dev, "Audio DMAC peri peri init\n");
+
+	dma->dmapp_id = dmac->dmapp_num;
+	dma->chcr = rsnd_dmapp_get_chcr(mod_from, mod_to) | PDMACHCR_DE;
+
+	dmac->dmapp_num++;
+
+	rsnd_dmapp_stop(dma);
+
+	dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
+		dma->dmapp_id, dma->src_addr, dma->dst_addr, dma->chcr);
+
+	return 0;
+}
+
+static struct rsnd_dma_ops rsnd_dmapp_ops = {
+	.start	= rsnd_dmapp_start,
+	.stop	= rsnd_dmapp_stop,
+	.init	= rsnd_dmapp_init,
+	.quit	= rsnd_dmapp_stop,
+};
+
+/*
+ *		Common DMAC Interface
+ */
+
+/*
  *	DMA read/write register offset
  *
  *	RSND_xxx_I_N	for Audio DMAC input
@@ -367,7 +535,49 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id)
 	dma->src_addr = rsnd_dma_addr(priv, mod_from, is_play, 1);
 	dma->dst_addr = rsnd_dma_addr(priv, mod_to,   is_play, 0);
 
-	dma->ops = &rsnd_dmaen_ops;
+	/* for Gen2 */
+	if (mod_from && mod_to)
+		dma->ops = &rsnd_dmapp_ops;
+	else
+		dma->ops = &rsnd_dmaen_ops;
+
+	/* for Gen1, overwrite */
+	if (rsnd_is_gen1(priv))
+		dma->ops = &rsnd_dmaen_ops;
 
 	return dma->ops->init(priv, dma, id, mod_from, mod_to);
 }
+
+int rsnd_dma_probe(struct platform_device *pdev,
+		   const struct rsnd_of_data *of_data,
+		   struct rsnd_priv *priv)
+{
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_dma_ctrl *dmac;
+	struct resource *res;
+
+	/*
+	 * for Gen1
+	 */
+	if (rsnd_is_gen1(priv))
+		return 0;
+
+	/*
+	 * for Gen2
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "audmapp");
+	dmac = devm_kzalloc(dev, sizeof(*dmac), GFP_KERNEL);
+	if (!dmac || !res) {
+		dev_err(dev, "dma allocate failed\n");
+		return -ENOMEM;
+	}
+
+	dmac->dmapp_num = 0;
+	dmac->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dmac->base))
+		return PTR_ERR(dmac->base);
+
+	priv->dma = dmac;
+
+	return 0;
+}
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c7299f7..9e67142 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -184,6 +184,8 @@ struct rsnd_dma {
 	struct rsnd_dma_ops	*ops;
 	enum dma_transfer_direction dir;
 	dma_addr_t		addr;
+	int			dmapp_id;
+	u32			chcr;
 	dma_addr_t		src_addr;
 	dma_addr_t		dst_addr;
 };
@@ -192,7 +194,9 @@ void rsnd_dma_start(struct rsnd_dma *dma);
 void rsnd_dma_stop(struct rsnd_dma *dma);
 int rsnd_dma_init(struct rsnd_priv *priv, struct rsnd_dma *dma, int id);
 void  rsnd_dma_quit(struct rsnd_dma *dma);
-
+int rsnd_dma_probe(struct platform_device *pdev,
+		   const struct rsnd_of_data *of_data,
+		   struct rsnd_priv *priv);
 
 #define rsnd_dma_to_mod(_dma) container_of((_dma), struct rsnd_mod, dma)
 
@@ -396,6 +400,11 @@ struct rsnd_priv {
 	void *adg;
 
 	/*
+	 * below value will be filled on rsnd_dma_probe()
+	 */
+	void *dma;
+
+	/*
 	 * below value will be filled on rsnd_ssi_probe()
 	 */
 	void *ssi;
-- 
1.7.9.5

