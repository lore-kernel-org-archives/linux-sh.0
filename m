From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 07 Apr 2014 20:07:08 +0000
Subject: [PATCH 8/9] DMA: shdma: initial of common code
Message-Id: <1396901229-29117-9-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

Add support for building shdma internal data from the device tree to allow
converting the driver to be device tree enabled.

It includes a helper for the of case to build the internal data used to
select and filter out the DMA channels from the ID information in the
device tree. Also updates the documentation for the DT case.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 Documentation/devicetree/bindings/dma/shdma.txt |  24 +++++
 drivers/dma/sh/shdma-of.c                       | 134 ++++++++++++++++++++++++
 drivers/dma/sh/shdma.h                          |  20 ++++
 include/dt-bindings/dma/shdma.h                 |  45 ++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 include/dt-bindings/dma/shdma.h

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index 2a3f3b8..7d9e7bd 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -15,6 +15,12 @@ Required properties:
 - compatible:	should be "renesas,shdma-mux"
 - #dma-cells:	should be <1>, see "dmas" property below
 
+New properites, required for renesas,dma-r8a7790.
+- reneasa,slaves: A list of DMA channel MID/RID and the configuration to
+		go with them. These pairs are in the form of:
+			< mid+rid configuration>
+
+
 Optional properties (currently unused):
 - dma-channels:	number of DMA channels
 - dma-requests:	number of DMA request signals
@@ -25,6 +31,7 @@ Required properties:
 - compatible:	should be of the form "renesas,shdma-<soc>", where <soc> should
 		be replaced with the desired SoC model, e.g.
 		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
+		"renesas,dma-r8a7790" for the DMAC on the R8A7790.
 
 Example:
 	dmac: dma-multiplexer@0 {
@@ -70,6 +77,23 @@ Example:
 		};
 	};
 
+For r8a7790, the following is an example of using the reneasas,slaves to
+configure the slave channels on the controller:
+
+	dma0: dma-mux@0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+
+		renesas,slaves = <R8A7790_DMA_SDHI0_RX  CHCR_RX_256BIT>,
+                                 <R8A7790_DMA_SDHI0_TX  CHCR_TX_256BIT>;
+	}
+
 * DMA client
 
 Required properties:
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 06473a0..386fd9e 100644
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
@@ -40,6 +71,109 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
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
+			dev_dbg(dev, "slave: id %02x, chcr %08x, addr %08x\n",
+				slaves->mid_rid, slaves->chcr, slaves->addr);
+		}
+	} else {
+		dev_warn(dev, "did not find any slave information\n");
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
index 758a57b..0db8327 100644
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
1.9.1

