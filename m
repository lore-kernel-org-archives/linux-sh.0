From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:11 +0000
Subject: [PATCH 4/8] shdma: fdt: initial of probe code to create pdata
Message-Id: <1401898455-31064-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add helper to produce driver data when the probe is via the fdt. Extract
the data from a template and device-tree ndoe and create the driver internal
data from it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdma-of.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sh/shdma.h    | 20 +++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 894c48e..6c45ffe 100644
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
@@ -16,6 +19,9 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/shdma-base.h>
+#include <linux/sh_dma.h>
+
+#include "shdma-arm.h"
 
 struct shdma_of_state {
 	unsigned long	slave_used[256 / sizeof(unsigned long)];
@@ -23,6 +29,29 @@ struct shdma_of_state {
 
 #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
 
+static const unsigned int arm_dma_ts_shift[] = SH_DMAE_ARM_TS_SHIFT;
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
 static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 				       struct of_dma *ofdma)
 {
@@ -52,6 +81,67 @@ void shdma_of_setup(struct device *dev, struct shdma_dev *shdev)
 	shdev->slave_used = ofs->slave_used;
 }
 
+const struct sh_dmae_pdata *
+sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	const struct sh_dmae_of_info *ofinf;
+	struct device *dev = &pdev->dev;
+	struct sh_dmae_pdata *pdata;
+	struct sh_dmae_channel *chan;
+	u32 nr_chan;
+	unsigned ch;
+	int ret;
+
+	if (!ofmatch)
+		return NULL;
+
+	ofinf = ofmatch->data;
+
+	pdata = devm_kzalloc(dev, sizeof(struct sh_dmae_pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "failed to make platform data\n");
+		return NULL;
+	}
+
+	*pdata = *ofinf->pdata_template;	/* copy in template first */
+
+	ret = of_property_read_u32(np, "dma-channels", &nr_chan);
+	if (ret < 0) {
+		dev_err(dev, "failed to get number of channels\n");
+		return NULL;
+	}
+
+	chan = devm_kzalloc(dev, nr_chan * sizeof(struct sh_dmae_channel),
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
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 758a57b..d2707e1 100644
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
-- 
2.0.0.rc2

