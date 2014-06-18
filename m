From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:09:05 +0000
Subject: [PROTOTYPE 1/8] DMA: shdma: initial of common code
Message-Id: <87lhsuy47h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add support for building shdma internal data from the device tree to allow
converting the driver to be device tree enabled.

It includes a helper for the of case to build the internal data used to
select and filter out the DMA channels from the ID information in the
device tree. Also updates the documentation for the DT case.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 Documentation/devicetree/bindings/dma/shdma.txt |   23 ++-
 drivers/dma/sh/shdma-of.c                       |  174 ++++++++++++++++++++++-
 drivers/dma/sh/shdma.h                          |   29 ++++
 include/dt-bindings/dma/shdma.h                 |   45 ++++++
 4 files changed, 268 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/dma/shdma.h

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index 2a3f3b8..86d5c50 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -14,9 +14,9 @@ still has to be placed under such a multiplexer node.
 Required properties:
 - compatible:	should be "renesas,shdma-mux"
 - #dma-cells:	should be <1>, see "dmas" property below
+- dma-channels:	number of DMA channels
 
 Optional properties (currently unused):
-- dma-channels:	number of DMA channels
 - dma-requests:	number of DMA request signals
 
 * DMA controller
@@ -25,6 +25,7 @@ Required properties:
 - compatible:	should be of the form "renesas,shdma-<soc>", where <soc> should
 		be replaced with the desired SoC model, e.g.
 		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
+		"renesas,shdma-r8a7790" for the DMAC on the R8A7790.
 
 Example:
 	dmac: dma-multiplexer@0 {
@@ -70,15 +71,33 @@ Example:
 		};
 	};
 
+For r8a7790 and newer implementations, the information for the channel
+controll register is found in the dma phandle and #dma-cells is set to 2.
+
+	dma0: dma-mux@0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <2>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+	}
+
 * DMA client
 
 Required properties:
 - dmas:		a list of <[DMA multiplexer phandle] [MID/RID value]> pairs,
 		where MID/RID values are fixed handles, specified in the SoC
-		manual
+		manual as the value that would be written into the DMASR.
+
+		If the #dma-cells is 2, then the second value is the CHCR
+		register configuration for the channel.
+
 - dma-names:	a list of DMA channel names, one per "dmas" entry
 
 Example:
 	dmas = <&dmac 0xd1
 		&dmac 0xd2>;
 	dma-names = "tx", "rx";
+
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index b4ff9d3..696716b 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -3,12 +3,15 @@
  *
  * Copyright (C) 2013 Renesas Electronics Inc.
  * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (c) 2014 Codethink Limited
+ *	Ben Dooks <ben.dooks@codethink.co.uk>
  *
  * This is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
  * published by the Free Software Foundation.
  */
 
+#include <linux/slab.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -16,17 +19,117 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/shdma-base.h>
+#include <linux/sh_dma.h>
+
+#include <dt-bindings/dma/shdma.h>
 
 #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
 
+#include "shdma-arm.h"
+
+static const unsigned int arm_dma_ts_shift[] = SH_DMAE_TS_SHIFT;
+
+static struct sh_dmae_pdata arm_dmae_info = {
+	.ts_low_shift	= SHDMA_ARM_TS_LOW_SHIFT,
+	.ts_low_mask	= SHDMA_ARM_TS_LOW_BIT << SHDMA_ARM_TS_LOW_SHIFT,
+	.ts_high_shift	= SHDMA_ARM_TS_HI_SHIFT,
+	.ts_high_mask	= SHDMA_ARM_TS_HI_BIT << SHDMA_ARM_TS_HI_SHIFT,
+	.ts_shift	= arm_dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(arm_dma_ts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
+	.chclr_bitwise	= 1,
+};
+
+struct sh_dmae_of_info shdma_arm_info = {
+	.pdata_template	= &arm_dmae_info,
+	.channel_offset	= 0x8000-0x20,
+	.channel_stride	= 0x80,
+	.offset		= 0x0,
+	.dmars		= 0x40,
+	.chclr_offset	= 0x80,
+};
+
+/* Need global index due to shdma_slave_used being global */
+static atomic_t of_slave_index = ATOMIC_INIT(0);
+
+struct shdma_of_client {
+	int				index;
+	struct list_head		node;
+	struct sh_dmae_slave_config	cfg;
+};
+
+struct shdma_of_pdata {
+	struct sh_dmae_pdata	pdata;
+	struct shdma_of_state	*state;
+};
+
+struct shdma_of_state {
+	struct list_head	of_slaves;
+};
+
+#define to_of_pdata(_pd) container_of(_pd, struct shdma_of_pdata, pdata)
+
+struct shdma_of_client *shdma_of_find_client(struct shdma_of_state *state, int id)
+{
+	struct shdma_of_client *client;
+
+	list_for_each_entry(client, &state->of_slaves, node) {
+		if (client->cfg.slave_id = id)
+			return client;
+	}
+
+	return NULL;
+}
+
+struct sh_dmae_slave_config *
+shdma_find_slave_of(struct sh_dmae_device *shdev, int match, int *index)
+{
+	struct shdma_of_pdata *pdata = to_of_pdata(shdev->pdata);
+	struct sh_dmae_slave_config *cfg = NULL;
+	struct shdma_of_client *client;
+
+	pr_info("looking for %02x\n", match);
+
+	client = shdma_of_find_client(pdata->state, match);
+	if (client) {
+		*index = client->index;
+		cfg = &client->cfg;
+	}
+
+	return cfg;
+}
+
 static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 				       struct of_dma *ofdma)
 {
+	struct platform_device *pdev = ofdma->of_dma_data;
 	u32 id = dma_spec->args[0];
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 
-	if (dma_spec->args_count != 1)
+	if (dma_spec->args_count = 2) {
+		struct shdma_of_state *state = platform_get_drvdata(pdev);
+		struct shdma_of_client *client;
+
+		client = shdma_of_find_client(state, id);
+		if (!client) {
+			client = devm_kzalloc(&pdev->dev, sizeof(*client),
+					      GFP_KERNEL);
+			if (!client)
+				return NULL;
+
+			client->index = atomic_inc_return(&of_slave_index);
+			client->cfg.slave_id = id;
+			client->cfg.mid_rid = id;
+			client->cfg.chcr = dma_spec->args[1];
+
+			dev_dbg(&pdev->dev, "new client %d, %02x\n",
+				client->index, id);
+
+			list_add_tail(&client->node, &state->of_slaves);
+		}
+	} else if (dma_spec->args_count != 1)
 		return NULL;
 
 	dma_cap_zero(mask);
@@ -41,11 +144,80 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+const struct sh_dmae_pdata *
+sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	const struct sh_dmae_of_info *ofinf;
+	struct device *dev = &pdev->dev;
+	struct sh_dmae_pdata *pdata;
+	struct shdma_of_pdata *ofdata;
+	struct sh_dmae_channel *chan;
+	u32 nr_chan;
+	unsigned ch;
+	int ret;
+
+	if (!ofmatch)
+		return NULL;
+
+	ofdata = devm_kzalloc(dev, sizeof(struct shdma_of_pdata), GFP_KERNEL);
+	if (!ofdata)
+		return NULL;
+
+	ofinf = ofmatch->data;
+	pdata = &ofdata->pdata;
+	*pdata = *ofinf->pdata_template;	/* copy in template first */
+	ofdata->state = dev_get_drvdata(dev->parent);
+
+	ret = of_property_read_u32(np, "dma-channels", &nr_chan);
+	if (ret < 0) {
+		dev_err(dev, "failed to get number of channels\n");
+		return NULL;
+	}
+
+	chan = devm_kcalloc(dev, nr_chan, sizeof(struct sh_dmae_channel),
+			    GFP_KERNEL);
+	if (!chan) {
+		dev_err(dev, "cannot allocate %d channels\n", nr_chan);
+		return NULL;
+	}
+
+	pdata->channel = chan;
+	pdata->channel_num = nr_chan;
+
+	dev_dbg(dev, "%d dma channels allocated\n", nr_chan);
+
+	for (ch = 0; ch < nr_chan; ch++) {
+		struct sh_dmae_channel *cp = chan + ch;
+		u32 base = ofinf->channel_offset + ofinf->channel_stride * ch;
+
+		cp->offset = base + ofinf->offset;
+		cp->dmars = base + ofinf->dmars;
+		cp->chclr_bit = ch;
+		cp->chclr_offset = ofinf->chclr_offset;
+
+		dev_dbg(dev, "ch %d: off %08x, dmars %08x, bit %d, off %d\n",
+			ch, cp->offset, cp->dmars,
+			cp->chclr_bit, cp->chclr_offset);
+	}
+
+	pdev->dev.platform_data = pdata;
+	return pdata;
+};
+
 static int shdma_of_probe(struct platform_device *pdev)
 {
 	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
+	struct shdma_of_state *state;
 	int ret;
 
+	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&state->of_slaves);
+	platform_set_drvdata(pdev, state);
+
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 shdma_of_xlate, pdev);
 	if (ret < 0)
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 758a57b..05b84b9 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -56,6 +56,26 @@ struct sh_dmae_desc {
 	struct shdma_desc shdma_desc;
 };
 
+/*
+ * Template information for building shdma data, provided as part of the
+ * data field in the of_device_id structure. This is then used to build
+ * the platform data for the dma code.
+ */
+struct sh_dmae_of_info {
+	struct sh_dmae_pdata	*pdata_template;
+	unsigned int		channel_offset;
+	unsigned int		channel_stride;
+	int			offset;
+	int			dmars;
+	int			chclr_offset;
+	int			chclr_bit;
+};
+
+extern struct sh_dmae_of_info shdma_arm_info;
+
+extern const struct sh_dmae_pdata *sh_dma_probe_of(struct platform_device *pdev,
+						   const struct of_device_id *match);
+
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, shdma_chan)
 #define to_sh_desc(lh) container_of(lh, struct sh_desc, node)
 #define tx_to_sh_desc(tx) container_of(tx, struct sh_desc, async_tx)
@@ -69,4 +89,13 @@ extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
 #define r8a73a4_shdma_devid NULL
 #endif
 
+#ifdef CONFIG_OF
+extern struct sh_dmae_slave_config *shdma_find_slave_of(struct sh_dmae_device *shdev, int match, int *index);
+#else
+static inline struct sh_dmae_slave_config *shdma_find_slave_of(struct sh_dmae_device *shdev, int match, int *index)
+{
+	return NULL;
+}
+#endif
+
 #endif	/* __DMA_SHDMA_H */
diff --git a/include/dt-bindings/dma/shdma.h b/include/dt-bindings/dma/shdma.h
new file mode 100644
index 0000000..0c8fc9e
--- /dev/null
+++ b/include/dt-bindings/dma/shdma.h
@@ -0,0 +1,45 @@
+/* DMA binding definitions for SH-DMAC engines.
+ *
+ * Moved from sh_dma.h to share with device tree by Ben Dooks.
+ * Orignal code from:
+ *   shdma.h: Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *   shdma-arm.h: Copyright (C) 2013 Renesas Electronics, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define SHDMA_DM_INC	0x00004000
+#define SHDMA_DM_DEC	0x00008000
+#define SHDMA_DM_FIX	0x0000c000
+#define SHDMA_SM_INC	0x00001000
+#define SHDMA_SM_DEC	0x00002000
+#define SHDMA_SM_FIX	0x00003000
+#define SHDMA_CHCR_DE	0x00000001
+#define SHDMA_CHCR_TE	0x00000002
+#define SHDMA_CHCR_IE	0x00000004
+
+/* ARM specific definitions */
+
+#define SHDMA_ARM_SZ_8BIT	(0)
+#define SHDMA_ARM_SZ_16BIT	(1)
+#define SHDMA_ARM_SZ_32BIT	(2)
+#define SHDMA_ARM_SZ_64BIT	(7)
+#define SHDMA_ARM_SZ_128BIT	(3)
+#define SHDMA_ARM_SZ_256BIT	(4)
+#define SHDMA_ARM_SZ_512BIT	(5)
+
+#define SHDMA_ARM_TS_LOW_BIT	(0x3)
+#define SHDMA_ARM_TS_HI_BIT	(0xc)
+
+#define SHDMA_ARM_TS_LOW_SHIFT	(3)
+#define SHDMA_ARM_TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+
+#define SHDMA_ARM_TS_INDEX2VAL(i) \
+	((((i) & SHDMA_ARM_TS_LOW_BIT) << SHDMA_ARM_TS_LOW_SHIFT) |\
+	 (((i) & SHDMA_ARM_TS_HI_BIT)  << SHDMA_ARM_TS_HI_SHIFT))
+
+#define SHDMA_ARM_CHCR_RX(size) (SHDMA_DM_INC | SHDMA_SM_FIX | 0x800 | SHDMA_ARM_TS_INDEX2VAL(size))
+#define SHDMA_ARM_CHCR_TX(size) (SHDMA_DM_FIX | SHDMA_SM_INC | 0x800 | SHDMA_ARM_TS_INDEX2VAL(size))
+
-- 
1.7.9.5

