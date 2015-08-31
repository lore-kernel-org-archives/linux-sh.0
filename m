From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 12:49:04 +0000
Subject: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <20150831124904.31057.19757.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple>
In-Reply-To: <20150831124842.31057.54534.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

This V5 patch adds initial CPG support for R-Car Generation 3 and in
particular the R8A7795 SoC.

The R-Car Gen3 clock hardware has a register write protection feature that
needs to be shared between the CPG function needs to be shared between
the CPG and MSTP hardware somehow. So far this feature is simply ignored.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
 - Simplified clks array handling - thanks Geert!
 - Updated th DT binding documentation to reflect latest state
 - of_property_count_strings() -> of_property_count_u32_elems() fix

 Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
 - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
 - Major things like syscon and driver model require more discussion.
 - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.

 Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
 - Reworked driver to rely on clock index instead of strings.
 - Dropped use of "clock-output-names".

 Earlier versions: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>

 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   32 +
 drivers/clk/Makefile                                                     |    1 
 drivers/clk/shmobile/Makefile                                            |    1 
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |  245 ++++++++++
 4 files changed, 279 insertions(+)

--- /dev/null
+++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt	2015-08-31 15:49:10.000000000 +0900
@@ -0,0 +1,32 @@
+* Renesas R-Car Gen3 Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three PLLs
+and several fixed ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be one of
+    - "renesas,r8a7795-cpg-clocks" for the r8a7795 CPG
+    - "renesas,rcar-gen3-cpg-clocks" for the generic R-Car Gen3 CPG
+
+  - reg: Base address and length of the memory resource used by the CPG
+
+  - clocks: References to the parent clocks: first to the EXTAL clock
+  - #clock-cells: Must be 1
+  - clock-indices: Indices of the exported clocks
+
+Example
+-------
+
+	cpg_clocks: cpg_clocks@e6150000 {
+		compatible = "renesas,r8a7795-cpg-clocks",
+			     "renesas,rcar-gen3-cpg-clocks";
+		reg = <0 0xe6150000 0 0x1000>;
+		clocks = <&extal_clk>;
+		#clock-cells = <1>;
+                clock-indices = <
+                             R8A7795_CLK_MAIN R8A7795_CLK_PLL0
+                             R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
+                             R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
+                >;
+	};
--- 0001/drivers/clk/Makefile
+++ work/drivers/clk/Makefile	2015-08-31 15:49:09.072366518 +0900
@@ -67,6 +67,7 @@ obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
+obj-$(CONFIG_ARCH_RENESAS)		+= shmobile/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
--- 0006/drivers/clk/shmobile/Makefile
+++ work/drivers/clk/shmobile/Makefile	2015-08-31 15:49:09.072366518 +0900
@@ -8,4 +8,5 @@ obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7795)		+= clk-rcar-gen3.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-mstp.o clk-div6.o
--- /dev/null
+++ work/drivers/clk/shmobile/clk-rcar-gen3.c	2015-08-31 21:10:01.102366518 +0900
@@ -0,0 +1,245 @@
+/*
+ * rcar_gen3 Core CPG Clocks
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * Based on rcar_gen2 Core CPG Clocks driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/shmobile.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define RCAR_GEN3_CLK_MAIN	0
+#define RCAR_GEN3_CLK_PLL0	1
+#define RCAR_GEN3_CLK_PLL1	2
+#define RCAR_GEN3_CLK_PLL2	3
+#define RCAR_GEN3_CLK_PLL3	4
+#define RCAR_GEN3_CLK_PLL4	5
+#define RCAR_GEN3_CLK_NR	6
+
+static const char * const rcar_gen3_clk_names[RCAR_GEN3_CLK_NR] = {
+	[RCAR_GEN3_CLK_MAIN] = "main",
+	[RCAR_GEN3_CLK_PLL0] = "pll0",
+	[RCAR_GEN3_CLK_PLL1] = "pll1",
+	[RCAR_GEN3_CLK_PLL2] = "pll2",
+	[RCAR_GEN3_CLK_PLL3] = "pll3",
+	[RCAR_GEN3_CLK_PLL4] = "pll4",
+};
+
+struct rcar_gen3_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+	struct clk *clks[RCAR_GEN3_CLK_NR];
+};
+
+#define CPG_PLL0CR	0x00d8
+#define CPG_PLL2CR	0x002c
+
+/*
+ * common function
+ */
+#define rcar_clk_readl(cpg, _reg) readl(cpg->reg + _reg)
+
+/*
+ * Reset register definitions.
+ */
+#define MODEMR 0xe6160060
+
+static u32 rcar_gen3_read_mode_pins(void)
+{
+	static u32 mode;
+	static bool mode_valid;
+
+	if (!mode_valid) {
+		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
+
+		BUG_ON(!modemr);
+		mode = ioread32(modemr);
+		iounmap(modemr);
+		mode_valid = true;
+	}
+
+	return mode;
+}
+
+/* -----------------------------------------------------------------------------
+ * CPG Clock Data
+ */
+
+/*
+ *   MD		EXTAL		PLL0	PLL1	PLL2	PLL3	PLL4
+ * 14 13 19 17	(MHz)		*1	*1	*1
+ *-------------------------------------------------------------------
+ * 0  0  0  0	16.66 x 1	x180/2	x192/2	x144/2	x192	x144
+ * 0  0  0  1	16.66 x 1	x180/2	x192/2	x144/2	x128	x144
+ * 0  0  1  0	Prohibited setting
+ * 0  0  1  1	16.66 x 1	x180/2	x192/2	x144/2	x192	x144
+ * 0  1  0  0	20    x 1	x150/2	x156/2	x120/2	x156	x120
+ * 0  1  0  1	20    x 1	x150/2	x156/2	x120/2	x106	x120
+ * 0  1  1  0	Prohibited setting
+ * 0  1  1  1	20    x 1	x150/2	x156/2	x120/2	x156	x120
+ * 1  0  0  0	25    x 1	x120/2	x128/2	x96/2	x128	x96
+ * 1  0  0  1	25    x 1	x120/2	x128/2	x96/2	x84	x96
+ * 1  0  1  0	Prohibited setting
+ * 1  0  1  1	25    x 1	x120/2	x128/2	x96/2	x128	x96
+ * 1  1  0  0	33.33 / 2	x180/2	x192/2	x144/2	x192	x144
+ * 1  1  0  1	33.33 / 2	x180/2	x192/2	x144/2	x128	x144
+ * 1  1  1  0	Prohibited setting
+ * 1  1  1  1	33.33 / 2	x180/2	x192/2	x144/2	x192	x144
+ *
+ * *1 : datasheet indicates VCO output (PLLx = VCO/2)
+ *
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 11) | \
+					 (((md) & BIT(13)) >> 11) | \
+					 (((md) & BIT(19)) >> 18) | \
+					 (((md) & BIT(17)) >> 17))
+struct cpg_pll_config {
+	unsigned int extal_div;
+	unsigned int pll1_mult;
+	unsigned int pll3_mult;
+	unsigned int pll4_mult;
+};
+
+static const struct cpg_pll_config cpg_pll_configs[16] __initconst = {
+/* EXTAL div	PLL1	PLL3	PLL4 */
+	{ 1,	192,	192,	144, },
+	{ 1,	192,	128,	144, },
+	{ 0,	0,	0,	0,   }, /* Prohibited setting */
+	{ 1,	192,	192,	144, },
+	{ 1,	156,	156,	120, },
+	{ 1,	156,	106,	120, },
+	{ 0,	0,	0,	0,   }, /* Prohibited setting */
+	{ 1,	156,	156,	120, },
+	{ 1,	128,	128,	96,  },
+	{ 1,	128,	84,	96,  },
+	{ 0,	0,	0,	0,   }, /* Prohibited setting */
+	{ 1,	128,	128,	96,  },
+	{ 2,	192,	192,	144, },
+	{ 2,	192,	128,	144, },
+	{ 0,	0,	0,	0,   }, /* Prohibited setting */
+	{ 2,	192,	192,	144, },
+};
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
+static struct clk * __init
+rcar_gen3_cpg_register_clock(struct device_node *np, struct rcar_gen3_cpg *cpg,
+			     const struct cpg_pll_config *config,
+			     unsigned int gen3_clk)
+{
+	const char *parent_name = rcar_gen3_clk_names[RCAR_GEN3_CLK_MAIN];
+	unsigned int mult = 1;
+	unsigned int div = 1;
+	u32 value;
+
+	switch (gen3_clk) {
+	case RCAR_GEN3_CLK_MAIN:
+		parent_name = of_clk_get_parent_name(np, 0);
+		div = config->extal_div;
+		break;
+	case RCAR_GEN3_CLK_PLL0:
+		/* PLL0 is a configurable multiplier clock. Register it as a
+		 * fixed factor clock for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		value = rcar_clk_readl(cpg, CPG_PLL0CR);
+		mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
+		break;
+	case RCAR_GEN3_CLK_PLL1:
+		mult = config->pll1_mult / 2;
+		break;
+	case RCAR_GEN3_CLK_PLL2:
+		/* PLL2 is a configurable multiplier clock. Register it as a
+		 * fixed factor clock for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		value = rcar_clk_readl(cpg, CPG_PLL2CR);
+		mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
+		break;
+	case RCAR_GEN3_CLK_PLL3:
+		mult = config->pll3_mult;
+		break;
+	case RCAR_GEN3_CLK_PLL4:
+		mult = config->pll4_mult;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk_register_fixed_factor(NULL, rcar_gen3_clk_names[gen3_clk],
+					 parent_name, 0, mult, div);
+}
+
+static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
+{
+	const struct cpg_pll_config *config;
+	struct rcar_gen3_cpg *cpg;
+	u32 cpg_mode;
+	unsigned int i;
+	int num_clks;
+
+	cpg_mode = rcar_gen3_read_mode_pins();
+
+	num_clks = of_property_count_u32_elems(np, "clock-indices");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks\n", __func__);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	if (!cpg)
+		return;
+
+	spin_lock_init(&cpg->lock);
+
+	cpg->data.clks = cpg->clks;
+	cpg->data.clk_num = num_clks;
+
+	cpg->reg = of_iomap(np, 0);
+	if (WARN_ON(cpg->reg = NULL))
+		return;
+
+	config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (!config->extal_div) {
+		pr_err("%s: Prohibited setting (cpg_mode=0x%x)\n",
+		       __func__, cpg_mode);
+		return;
+	}
+
+	for (i = 0; i < num_clks; ++i) {
+		struct clk *clk;
+		u32 idx;
+		int ret;
+
+		ret = of_property_read_u32_index(np, "clock-indices", i, &idx);
+		if (ret < 0)
+			break;
+
+		clk = rcar_gen3_cpg_register_clock(np, cpg, config, idx);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %u clock (%ld)\n",
+			       __func__, np->name, idx, PTR_ERR(clk));
+		else
+			cpg->data.clks[idx] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
+	       rcar_gen3_cpg_clocks_init);
