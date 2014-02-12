From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 12 Feb 2014 17:59:22 +0000
Subject: [PATCH 3/5] shdma: initial of common code
Message-Id: <1392227964-7088-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is an initial helper to go with the shdma-of code
to allow binding of devices via fdt and extraction of
information aobut the system's DMA setup from the DT
for the shdmac code and possibly other code to use.

Still to be decided:

- should arm speciifc shdma-of.c additions be in an shdma-of-arm.c file?
- do we want to be able ot bind a single dma engine w/o shdma-mux code?
---
 drivers/dma/sh/shdma-of.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sh/shdma.h    |  18 ++++++
 2 files changed, 156 insertions(+)

diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 06473a0..6475172 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -9,6 +9,9 @@
  * published by the Free Software Foundation.
  */
 
+#define DEBUG
+
+#include <linux/slab.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -16,9 +19,37 @@
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
 static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 				       struct of_dma *ofdma)
 {
@@ -26,6 +57,8 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 
+	pr_info("xlate id %02x\n", id);
+
 	if (dma_spec->args_count != 1)
 		return NULL;
 
@@ -40,6 +73,111 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+const struct sh_dmae_pdata *
+sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	const struct sh_dmae_of_info *ofinf;
+	struct device *dev = &pdev->dev;
+	struct sh_dmae_pdata *pdata;
+	struct sh_dmae_channel *chan;
+	struct property *prop;
+	u32 nr_chan;
+	unsigned ch;
+	int ret;
+	int len;
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
+	/* look in current, or parent node for the slave mappings */
+	prop = of_find_property(np, "renesas,slaves", &len);
+	if (!prop)
+		prop = of_find_property(np->parent, "renesas,slaves", &len);
+
+	if (prop) {
+		struct sh_dmae_slave_config *slaves;
+		int nr_slaves = len / (sizeof(u32) * 3);
+		const __be32 *of_ptr;
+		u32 of_idx;
+
+		slaves = devm_kzalloc(dev, sizeof(*slaves) * nr_slaves,
+				      GFP_KERNEL);
+		if (!slaves) {
+			dev_err(dev, "cannot allocate %d slaves\n", nr_slaves);
+			return NULL;
+		}
+
+		pdata->slave = slaves;
+		pdata->slave_num = nr_slaves;
+		of_idx = 0;
+		of_ptr = NULL;
+
+		dev_dbg(dev, "building %d slaves\n", nr_slaves);
+
+		for (; nr_slaves > 0; nr_slaves--, slaves++) {
+			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
+			slaves->mid_rid = be32_to_cpu(*of_ptr);
+			slaves->slave_id = slaves->mid_rid;
+
+			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
+			slaves->chcr = be32_to_cpu(*of_ptr);
+
+			of_ptr= of_prop_next_u32(prop, of_ptr, &of_idx);
+			slaves->addr = be32_to_cpu(*of_ptr) ;
+
+			dev_dbg(dev, "slave: id %02x, chcr %08x, addr %08x\n",
+				slaves->mid_rid, slaves->chcr, slaves->addr);
+		}
+	} else
+		dev_warn(dev, "did not find any slave information\n");
+
+	pdev->dev.platform_data = pdata;
+	return pdata;
+};
+
 static int shdma_of_probe(struct platform_device *pdev)
 {
 	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 758a57b..4a6779f 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -56,6 +56,24 @@ struct sh_dmae_desc {
 	struct shdma_desc shdma_desc;
 };
 
+/* template information for building shdma data, provided as part of the
+ * data field in the of_device_id structure.
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
1.8.5.3

