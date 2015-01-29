From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 01:24:06 +0000
Subject: [PATCH 1/2][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <8761bqtm34.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
 <5155160.jFIrOp4XSG@avalon>
 <877fwab63w.wl%kuninori.morimoto.gx@renesas.com>
 <5977920.SJUic98Q2P@avalon>
 <CANqRtoREqLXGn43e3Jr90gdgpVoe-OGGuorgmjLSFaxt-22HDA@mail.gmail.com>
 <877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mark Brown <broonie@linaro.org>, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org

Current rcar-audmapp is assuming that CHCR value are specified
from platform data or DTS bindings. but, it is possible to
calculate CHCR settings from src/dst address.
DTS bindings node can be reduced by this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-audmapp.c |  136 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
index d95bbdd..9690291 100644
--- a/drivers/dma/sh/rcar-audmapp.c
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -48,7 +48,6 @@ struct audmapp_chan {
 	struct shdma_chan shdma_chan;
 	void __iomem *base;
 	dma_addr_t slave_addr;
-	u32 chcr;
 };
 
 struct audmapp_device {
@@ -100,6 +99,124 @@ static void audmapp_halt(struct shdma_chan *schan)
 	}
 }
 
+struct id_addr_table {
+	u8  id;
+	u16 addr;
+};
+
+static u32 audmapp_addr_to_id(struct device *dev, u32 addr)
+{
+	struct id_addr_table ssi_id_table[] = {
+		{0x00, 0x0000}, /* SSI00 */
+		{0x01, 0x0400}, /* SSI01 */
+		{0x02, 0x0800}, /* SSI02 */
+		{0x03, 0x0C00}, /* SSI03 */
+		{0x04, 0x1000}, /* SSI10 */
+		{0x05, 0x1400}, /* SSI11 */
+		{0x06, 0x1800}, /* SSI12 */
+		{0x07, 0x1C00}, /* SSI13 */
+		{0x08, 0x2000}, /* SSI20 */
+		{0x09, 0x2400}, /* SSI21 */
+		{0x0a, 0x2800}, /* SSI22 */
+		{0x0b, 0x2C00}, /* SSI23 */
+		{0x0c, 0x3000}, /* SSI3  */
+		{0x0d, 0x4000}, /* SSI4  */
+		{0x0e, 0x5000}, /* SSI5  */
+		{0x0f, 0x6000}, /* SSI6  */
+		{0x10, 0x7000}, /* SSI7  */
+		{0x11, 0x8000}, /* SSI8  */
+		{0x12, 0x9000}, /* SSI90 */
+		{0x13, 0x9400}, /* SSI91 */
+		{0x14, 0x9800}, /* SSI92 */
+		{0x15, 0x9C00}, /* SSI93 */
+	};
+	struct id_addr_table dtcp_id_tabel[] = {
+		{0x16, 0x0000}, /* DTCPPP0 */
+		{0x17, 0x0400}, /* DTCPPP1 */
+		{0x18, 0x4000}, /* DTCPCP0 */
+		{0x19, 0x4400}, /* DTCPCP1 */
+	};
+	struct id_addr_table mlm_id_table[] = {
+		{0x25, 0x0000}, /* MLM0 */
+		{0x26, 0x0400}, /* MLM1 */
+		{0x27, 0x0800}, /* MLM2 */
+		{0x28, 0x0C00}, /* MLM3 */
+		{0x29, 0x1000}, /* MLM4 */
+		{0x2a, 0x1400}, /* MLM5 */
+		{0x2b, 0x1800}, /* MLM6 */
+		{0x2c, 0x1C00}, /* MLM7 */
+	};
+	struct id_addr_table scu_id_table[] = {
+		{0x2d, 0x0000}, /* SCU_SRCI0 */
+		{0x2e, 0x0400}, /* SCU_SRCI1 */
+		{0x2f, 0x0800}, /* SCU_SRCI2 */
+		{0x30, 0x0C00}, /* SCU_SRCI3 */
+		{0x31, 0x1000}, /* SCU_SRCI4 */
+		{0x32, 0x1400}, /* SCU_SRCI5 */
+		{0x33, 0x1800}, /* SCU_SRCI6 */
+		{0x34, 0x1C00}, /* SCU_SRCI7 */
+		{0x35, 0x2000}, /* SCU_SRCI8 */
+		{0x36, 0x2400}, /* SCU_SRCI9 */
+
+		{0x2d, 0x4000}, /* SCU_SRCO0 */
+		{0x2e, 0x4400}, /* SCU_SRCO1 */
+		{0x2f, 0x4800}, /* SCU_SRCO2 */
+		{0x30, 0x4C00}, /* SCU_SRCO3 */
+		{0x31, 0x5000}, /* SCU_SRCO4 */
+		{0x32, 0x5400}, /* SCU_SRCO5 */
+		{0x33, 0x5800}, /* SCU_SRCO6 */
+		{0x34, 0x5C00}, /* SCU_SRCO7 */
+		{0x35, 0x6000}, /* SCU_SRCO8 */
+		{0x36, 0x6400}, /* SCU_SRCO9 */
+		{0x37, 0x8000}, /* SCU_CMD0 */
+		{0x38, 0x8400}, /* SCU_CMD1 */
+	};
+	struct id_addr_table *table = NULL;
+	int size;
+	int i;
+
+	switch (addr >> 16) {
+	case 0xEC40:	/* SSI */
+		table = ssi_id_table;
+		size = ARRAY_SIZE(ssi_id_table);
+		break;
+	case 0xEC42:	/* DTCP */
+		table = dtcp_id_tabel;
+		size = ARRAY_SIZE(dtcp_id_tabel);
+		break;
+	case 0xEC32:	/* MLM */
+		table = mlm_id_table;
+		size = ARRAY_SIZE(mlm_id_table);
+		break;
+	case 0xEC30:	/* SRC / CMD */
+		table = scu_id_table;
+		size = ARRAY_SIZE(scu_id_table);
+		break;
+	default:
+		table = NULL;
+		size = 0;
+	}
+
+	for (i = 0; i < size; i++) {
+		if (table[i].addr = (addr & 0xFFFF))
+			return table[i].id;
+	}
+
+	dev_err(dev, "unknown addr (%x)\n", addr);
+
+	return 0xFF;
+}
+
+static u32 audmapp_get_chcr(struct device *dev, struct audmapp_desc *desc)
+{
+	u32 src_id, dst_id;
+
+	src_id = audmapp_addr_to_id(dev, desc->src);
+	dst_id = audmapp_addr_to_id(dev, desc->dst);
+
+	return src_id << 24 | dst_id << 16;
+}
+
 static void audmapp_start_xfer(struct shdma_chan *schan,
 			       struct shdma_desc *sdesc)
 {
@@ -107,7 +224,7 @@ static void audmapp_start_xfer(struct shdma_chan *schan,
 	struct audmapp_device *audev = to_dev(auchan);
 	struct audmapp_desc *desc = to_desc(sdesc);
 	struct device *dev = audev->dev;
-	u32 chcr = auchan->chcr | PDMACHCR_DE;
+	u32 chcr = audmapp_get_chcr(dev, desc) | PDMACHCR_DE;
 
 	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
 		&desc->src, &desc->dst, chcr);
@@ -118,19 +235,17 @@ static void audmapp_start_xfer(struct shdma_chan *schan,
 }
 
 static int audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
-			      u32 *chcr, dma_addr_t *dst)
+			      dma_addr_t *dst)
 {
 	struct audmapp_device *audev = to_dev(auchan);
 	struct audmapp_pdata *pdata = audev->pdata;
 	struct audmapp_slave_config *cfg;
 	int i;
 
-	*chcr	= 0;
 	*dst	= 0;
 
 	if (!pdata) { /* DT */
-		*chcr = ((u32)slave_id) << 16;
-		auchan->shdma_chan.slave_id = (slave_id) >> 8;
+		auchan->shdma_chan.slave_id = slave_id;
 		return 0;
 	}
 
@@ -141,7 +256,6 @@ static int audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
 
 	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
 		if (cfg->slave_id = slave_id) {
-			*chcr	= cfg->chcr;
 			*dst	= cfg->dst;
 			return 0;
 		}
@@ -153,18 +267,16 @@ static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
 			     dma_addr_t slave_addr, bool try)
 {
 	struct audmapp_chan *auchan = to_chan(schan);
-	u32 chcr;
 	dma_addr_t dst;
 	int ret;
 
-	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
+	ret = audmapp_get_config(auchan, slave_id, &dst);
 	if (ret < 0)
 		return ret;
 
 	if (try)
 		return 0;
 
-	auchan->chcr		= chcr;
 	auchan->slave_addr	= slave_addr ? : dst;
 
 	return 0;
@@ -267,7 +379,7 @@ static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
 {
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
-	u32 chcr = dma_spec->args[0];
+	u32 id = dma_spec->args[0];
 
 	if (dma_spec->args_count != 1)
 		return NULL;
@@ -277,7 +389,7 @@ static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
 
 	chan = dma_request_channel(mask, shdma_chan_filter, NULL);
 	if (chan)
-		to_shdma_chan(chan)->hw_req = chcr;
+		to_shdma_chan(chan)->hw_req = id;
 
 	return chan;
 }
-- 
1.7.9.5

