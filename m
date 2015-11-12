From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Nov 2015 15:54:46 +0000
Subject: [PATCH v6 5/5] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <1447343686-2038-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a new R-Car H3 Clock Pulse Generator / Module Standby and Software
Reset driver, using the new CPG/MSSR driver core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Correct PLL1 and PLL3 multipliers from 156 to 160[*],
  - Correct CPG_PLL0CR multiplier factor from x1 to x2, and multiplier
    mask from 0x3f to 0x7f (.pll0: 217 MHz => 1500 MHz),
  - Correct CPG_PLL2CR multiplier factor from x1 to x2[*], and
    multiplier mask from 0x3f to 0x7f (.pll2: 67 MHz => 1200 MHz),
  - Add and use CPG_PLL4CR for PLL4 instead of using the fixed value in
    cpg_pll_configs[],
  - Tidy up cpg_pll_configs[],
  - Add PCIe module clocks (from Phil Edworthy
    <phil.edworthy@renesas.com>),

    [*] Fixes from Manual Errata for Rev 0.50 of the R-Car Gen3
	datasheet.

v5:
  - Convert to real platform_driver,
  - Drop dependency on undocumented "renesas,modemr" property,
  - Move conversion from Module Clock numbers to IDs from run time (C
    code) to compile time (CPP macros for filling in tables),
  - Rename driver from clk-r8a7795-cpg-mssr to r8a7795-cpg-mssr,
  - Enter shmobile subdir if CONFIG_ARCH_RENESAS=y,
  - Clean up debugging code,
  - Drop RFC state,

v4:
  - New.
---
 drivers/clk/Makefile                    |   1 +
 drivers/clk/shmobile/Makefile           |   2 +
 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 382 ++++++++++++++++++++++++++++++++
 drivers/clk/shmobile/renesas-cpg-mssr.c |   6 +
 drivers/clk/shmobile/renesas-cpg-mssr.h |   1 +
 5 files changed, 392 insertions(+)
 create mode 100644 drivers/clk/shmobile/r8a7795-cpg-mssr.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d3e1910eebaba6ed..8cf50f9554318d2b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
+obj-$(CONFIG_ARCH_RENESAS)		+= shmobile/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 1eb947db6f5926a0..7e2579b303267d8b 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -8,4 +8,6 @@ obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7795)		+= renesas-cpg-mssr.o \
+					   r8a7795-cpg-mssr.o clk-div6.o
 obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-mstp.o clk-div6.o
diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
new file mode 100644
index 0000000000000000..57c413635d1af135
--- /dev/null
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -0,0 +1,382 @@
+/*
+ * r8a7795 Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * Based on clk-rcar-gen3.c
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bug.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include <dt-bindings/clock/r8a7795-cpg-mssr.h>
+
+#include "renesas-cpg-mssr.h"
+
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R8A7795_CLK_OSC,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+	CLK_EXTALR,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_PLL0,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL3,
+	CLK_PLL4,
+	CLK_PLL1_DIV2,
+	CLK_PLL1_DIV4,
+	CLK_S0,
+	CLK_S1,
+	CLK_S2,
+	CLK_S3,
+	CLK_SDSRC,
+	CLK_SSPSRC,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+enum r8a7795_clk_types {
+	CLK_TYPE_GEN3_MAIN = CLK_TYPE_CUSTOM,
+	CLK_TYPE_GEN3_PLL0,
+	CLK_TYPE_GEN3_PLL1,
+	CLK_TYPE_GEN3_PLL2,
+	CLK_TYPE_GEN3_PLL3,
+	CLK_TYPE_GEN3_PLL4,
+};
+
+static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",  CLK_EXTAL),
+	DEF_INPUT("extalr", CLK_EXTALR),
+
+	/* Internal Core Clocks */
+	DEF_BASE(".main",       CLK_MAIN, CLK_TYPE_GEN3_MAIN, CLK_EXTAL),
+	DEF_BASE(".pll0",       CLK_PLL0, CLK_TYPE_GEN3_PLL0, CLK_MAIN),
+	DEF_BASE(".pll1",       CLK_PLL1, CLK_TYPE_GEN3_PLL1, CLK_MAIN),
+	DEF_BASE(".pll2",       CLK_PLL2, CLK_TYPE_GEN3_PLL2, CLK_MAIN),
+	DEF_BASE(".pll3",       CLK_PLL3, CLK_TYPE_GEN3_PLL3, CLK_MAIN),
+	DEF_BASE(".pll4",       CLK_PLL4, CLK_TYPE_GEN3_PLL4, CLK_MAIN),
+
+	DEF_FIXED(".pll1_div2", CLK_PLL1_DIV2,     CLK_PLL1,       2, 1),
+	DEF_FIXED(".pll1_div4", CLK_PLL1_DIV4,     CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED(".s0",        CLK_S0,            CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED(".s1",        CLK_S1,            CLK_PLL1_DIV2,  3, 1),
+	DEF_FIXED(".s2",        CLK_S2,            CLK_PLL1_DIV2,  4, 1),
+	DEF_FIXED(".s3",        CLK_S3,            CLK_PLL1_DIV2,  6, 1),
+
+	/* Core Clock Outputs */
+	DEF_FIXED("ztr",        R8A7795_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
+	DEF_FIXED("ztrd2",      R8A7795_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
+	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
+	DEF_FIXED("zx",         R8A7795_CLK_ZX,    CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED("s0d1",       R8A7795_CLK_S0D1,  CLK_S0,         1, 1),
+	DEF_FIXED("s0d4",       R8A7795_CLK_S0D4,  CLK_S0,         4, 1),
+	DEF_FIXED("s1d1",       R8A7795_CLK_S1D1,  CLK_S1,         1, 1),
+	DEF_FIXED("s1d2",       R8A7795_CLK_S1D2,  CLK_S1,         2, 1),
+	DEF_FIXED("s1d4",       R8A7795_CLK_S1D4,  CLK_S1,         4, 1),
+	DEF_FIXED("s2d1",       R8A7795_CLK_S2D1,  CLK_S2,         1, 1),
+	DEF_FIXED("s2d2",       R8A7795_CLK_S2D2,  CLK_S2,         2, 1),
+	DEF_FIXED("s2d4",       R8A7795_CLK_S2D4,  CLK_S2,         4, 1),
+	DEF_FIXED("s3d1",       R8A7795_CLK_S3D1,  CLK_S3,         1, 1),
+	DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2, 1),
+	DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4, 1),
+	DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
+	DEF_FIXED("cp",         R8A7795_CLK_CP,    CLK_EXTAL,      2, 1),
+
+	DEF_DIV6P1("mso",       R8A7795_CLK_MSO,   CLK_PLL1_DIV4, 0x014),
+	DEF_DIV6P1("hdmi",      R8A7795_CLK_HDMI,  CLK_PLL1_DIV2, 0x250),
+};
+
+static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
+	DEF_MOD("scif5",		 202,	R8A7795_CLK_S3D4),
+	DEF_MOD("scif4",		 203,	R8A7795_CLK_S3D4),
+	DEF_MOD("scif3",		 204,	R8A7795_CLK_S3D4),
+	DEF_MOD("scif1",		 206,	R8A7795_CLK_S3D4),
+	DEF_MOD("scif0",		 207,	R8A7795_CLK_S3D4),
+	DEF_MOD("msiof3",		 208,	R8A7795_CLK_MSO),
+	DEF_MOD("msiof2",		 209,	R8A7795_CLK_MSO),
+	DEF_MOD("msiof1",		 210,	R8A7795_CLK_MSO),
+	DEF_MOD("msiof0",		 211,	R8A7795_CLK_MSO),
+	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S3D1),
+	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
+	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
+	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
+	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
+	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
+	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
+	DEF_MOD("audmac0",		 502,	R8A7795_CLK_S3D4),
+	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S3D4),
+	DEF_MOD("hscif4",		 516,	R8A7795_CLK_S3D1),
+	DEF_MOD("hscif3",		 517,	R8A7795_CLK_S3D1),
+	DEF_MOD("hscif2",		 518,	R8A7795_CLK_S3D1),
+	DEF_MOD("hscif1",		 519,	R8A7795_CLK_S3D1),
+	DEF_MOD("hscif0",		 520,	R8A7795_CLK_S3D1),
+	DEF_MOD("vspd3",		 620,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspd2",		 621,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspd1",		 622,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspd0",		 623,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspbc",		 624,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspbd",		 626,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspi2",		 629,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S2D1),
+	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S2D1),
+	DEF_MOD("ehci2",		 701,	R8A7795_CLK_S3D4),
+	DEF_MOD("ehci1",		 702,	R8A7795_CLK_S3D4),
+	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D4),
+	DEF_MOD("hsusb",		 704,	R8A7795_CLK_S3D4),
+	DEF_MOD("du3",			 721,	R8A7795_CLK_S2D1),
+	DEF_MOD("du2",			 722,	R8A7795_CLK_S2D1),
+	DEF_MOD("du1",			 723,	R8A7795_CLK_S2D1),
+	DEF_MOD("du0",			 724,	R8A7795_CLK_S2D1),
+	DEF_MOD("hdmi1",		 728,	R8A7795_CLK_HDMI),
+	DEF_MOD("hdmi0",		 729,	R8A7795_CLK_HDMI),
+	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S3D2),
+	DEF_MOD("gpio7",		 905,	R8A7795_CLK_CP),
+	DEF_MOD("gpio6",		 906,	R8A7795_CLK_CP),
+	DEF_MOD("gpio5",		 907,	R8A7795_CLK_CP),
+	DEF_MOD("gpio4",		 908,	R8A7795_CLK_CP),
+	DEF_MOD("gpio3",		 909,	R8A7795_CLK_CP),
+	DEF_MOD("gpio2",		 910,	R8A7795_CLK_CP),
+	DEF_MOD("gpio1",		 911,	R8A7795_CLK_CP),
+	DEF_MOD("gpio0",		 912,	R8A7795_CLK_CP),
+	DEF_MOD("i2c6",			 918,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c5",			 919,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c4",			 927,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c3",			 928,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c2",			 929,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c1",			 930,	R8A7795_CLK_S3D2),
+	DEF_MOD("i2c0",			 931,	R8A7795_CLK_S3D2),
+	DEF_MOD("ssi-all",		1005,	R8A7795_CLK_S3D4),
+	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi7",			1008,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi6",			1009,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi5",			1010,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi4",			1011,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi3",			1012,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi2",			1013,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi1",			1014,	MOD_CLK_ID(1005)),
+	DEF_MOD("ssi0",			1015,	MOD_CLK_ID(1005)),
+	DEF_MOD("scu-all",		1017,	R8A7795_CLK_S3D4),
+	DEF_MOD("scu-dvc1",		1018,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-dvc0",		1019,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-ctu1-mix1",	1020,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-ctu0-mix0",	1021,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src9",		1022,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src8",		1023,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src7",		1024,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src6",		1025,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src5",		1026,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src4",		1027,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src3",		1028,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src2",		1029,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src1",		1030,	MOD_CLK_ID(1017)),
+	DEF_MOD("scu-src0",		1031,	MOD_CLK_ID(1017)),
+};
+
+static const unsigned int r8a7795_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
+};
+
+
+#define CPG_PLL0CR	0x00d8
+#define CPG_PLL2CR	0x002c
+#define CPG_PLL4CR	0x01f4
+
+/*
+ * CPG Clock Data
+ */
+
+/*
+ *   MD		EXTAL		PLL0	PLL1	PLL2	PLL3	PLL4
+ * 14 13 19 17	(MHz)
+ *-------------------------------------------------------------------
+ * 0  0  0  0	16.66 x 1	x180	x192	x144	x192	x144
+ * 0  0  0  1	16.66 x 1	x180	x192	x144	x128	x144
+ * 0  0  1  0	Prohibited setting
+ * 0  0  1  1	16.66 x 1	x180	x192	x144	x192	x144
+ * 0  1  0  0	20    x 1	x150	x160	x120	x160	x120
+ * 0  1  0  1	20    x 1	x150	x160	x120	x106	x120
+ * 0  1  1  0	Prohibited setting
+ * 0  1  1  1	20    x 1	x150	x160	x120	x160	x120
+ * 1  0  0  0	25    x 1	x120	x128	x96	x128	x96
+ * 1  0  0  1	25    x 1	x120	x128	x96	x84	x96
+ * 1  0  1  0	Prohibited setting
+ * 1  0  1  1	25    x 1	x120	x128	x96	x128	x96
+ * 1  1  0  0	33.33 / 2	x180	x192	x144	x192	x144
+ * 1  1  0  1	33.33 / 2	x180	x192	x144	x128	x144
+ * 1  1  1  0	Prohibited setting
+ * 1  1  1  1	33.33 / 2	x180	x192	x144	x192	x144
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 11) | \
+					 (((md) & BIT(13)) >> 11) | \
+					 (((md) & BIT(19)) >> 18) | \
+					 (((md) & BIT(17)) >> 17))
+
+struct cpg_pll_config {
+	unsigned int extal_div;
+	unsigned int pll1_mult;
+	unsigned int pll3_mult;
+};
+
+static const struct cpg_pll_config cpg_pll_configs[16] __initconst = {
+	/* EXTAL div	PLL1 mult	PLL3 mult */
+	{ 1,		192,		192,	},
+	{ 1,		192,		128,	},
+	{ 0, /* Prohibited setting */		},
+	{ 1,		192,		192,	},
+	{ 1,		160,		160,	},
+	{ 1,		160,		106,	},
+	{ 0, /* Prohibited setting */		},
+	{ 1,		160,		160,	},
+	{ 1,		128,		128,	},
+	{ 1,		128,		84,	},
+	{ 0, /* Prohibited setting */		},
+	{ 1,		128,		128,	},
+	{ 2,		192,		192,	},
+	{ 2,		192,		128,	},
+	{ 0, /* Prohibited setting */		},
+	{ 2,		192,		192,	},
+};
+
+static const struct cpg_pll_config *cpg_pll_config __initdata;
+
+static
+struct clk * __init r8a7795_cpg_clk_register(struct device *dev,
+					     const struct cpg_core_clk *core,
+					     const struct cpg_mssr_info *info,
+					     struct clk **clks,
+					     void __iomem *base)
+{
+	const struct clk *parent;
+	unsigned int mult = 1;
+	unsigned int div = 1;
+	u32 value;
+
+	parent = clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	switch (core->type) {
+	case CLK_TYPE_GEN3_MAIN:
+		div = cpg_pll_config->extal_div;
+		break;
+
+	case CLK_TYPE_GEN3_PLL0:
+		/*
+		 * PLL0 is a configurable multiplier clock. Register it as a
+		 * fixed factor clock for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		value = readl(base + CPG_PLL0CR);
+		mult = (((value >> 24) & 0x7f) + 1) * 2;
+		break;
+
+	case CLK_TYPE_GEN3_PLL1:
+		mult = cpg_pll_config->pll1_mult;
+		break;
+
+	case CLK_TYPE_GEN3_PLL2:
+		/*
+		 * PLL2 is a configurable multiplier clock. Register it as a
+		 * fixed factor clock for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		value = readl(base + CPG_PLL2CR);
+		mult = (((value >> 24) & 0x7f) + 1) * 2;
+		break;
+
+	case CLK_TYPE_GEN3_PLL3:
+		mult = cpg_pll_config->pll3_mult;
+		break;
+
+	case CLK_TYPE_GEN3_PLL4:
+		/*
+		 * PLL4 is a configurable multiplier clock. Register it as a
+		 * fixed factor clock for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		value = readl(base + CPG_PLL4CR);
+		mult = (((value >> 24) & 0x7f) + 1) * 2;
+		break;
+
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk_register_fixed_factor(NULL, core->name,
+					 __clk_get_name(parent), 0, mult, div);
+}
+
+/*
+ * Reset register definitions.
+ */
+#define MODEMR	0xe6160060
+
+static u32 rcar_gen3_read_mode_pins(void)
+{
+	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
+	u32 mode;
+
+	BUG_ON(!modemr);
+	mode = ioread32(modemr);
+	iounmap(modemr);
+
+	return mode;
+}
+
+static int __init r8a7795_cpg_mssr_init(struct device *dev)
+{
+	u32 cpg_mode = rcar_gen3_read_mode_pins();
+
+	cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (!cpg_pll_config->extal_div) {
+		dev_err(dev, "Prohibited setting (cpg_mode=0x%x)\n", cpg_mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+const struct cpg_mssr_info r8a7795_cpg_mssr_info __initconst = {
+	/* Core Clocks */
+	.core_clks = r8a7795_core_clks,
+	.num_core_clks = ARRAY_SIZE(r8a7795_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks = r8a7795_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r8a7795_mod_clks),
+	.num_hw_mod_clks = 12 * 32,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r8a7795_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r8a7795_crit_mod_clks),
+
+	/* Callbacks */
+	.init = r8a7795_cpg_mssr_init,
+	.cpg_clk_register = r8a7795_cpg_clk_register,
+};
diff --git a/drivers/clk/shmobile/renesas-cpg-mssr.c b/drivers/clk/shmobile/renesas-cpg-mssr.c
index e4382ba4e1e31aca..a2cccc40fca783bf 100644
--- a/drivers/clk/shmobile/renesas-cpg-mssr.c
+++ b/drivers/clk/shmobile/renesas-cpg-mssr.c
@@ -498,6 +498,12 @@ static inline int cpg_mssr_add_clk_domain(struct device *dev,
 
 
 static const struct of_device_id cpg_mssr_match[] = {
+#ifdef CONFIG_ARCH_R8A7795
+	{
+		.compatible = "renesas,r8a7795-cpg-mssr",
+		.data = &r8a7795_cpg_mssr_info,
+	},
+#endif
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/shmobile/renesas-cpg-mssr.h b/drivers/clk/shmobile/renesas-cpg-mssr.h
index e6d24875b56f7755..e09f03cbf086b1d3 100644
--- a/drivers/clk/shmobile/renesas-cpg-mssr.h
+++ b/drivers/clk/shmobile/renesas-cpg-mssr.h
@@ -128,4 +128,5 @@ struct cpg_mssr_info {
 					struct clk **clks, void __iomem *base);
 };
 
+extern const struct cpg_mssr_info r8a7795_cpg_mssr_info;
 #endif
-- 
1.9.1

