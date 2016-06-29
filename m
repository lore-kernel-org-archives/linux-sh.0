From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:40:56 +0000
Subject: [PATCH v4 11/22] sh: SH7750/51 CPG Driver
Message-Id: <1467207667-15768-12-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Convert SH specific clock framework to CCF.

Changes v4
Add acked-by

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/renesas,sh7750-cpg.txt          |  25 ++
 arch/sh/boards/Kconfig                             |   1 +
 arch/sh/kernel/cpu/Makefile                        |   8 +-
 arch/sh/kernel/cpu/clock.c                         |   6 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +-
 drivers/clk/sh/Kconfig                             |   2 +
 drivers/clk/sh/Makefile                            |   1 +
 drivers/clk/sh/clk-sh7750cpg.c                     | 344 +++++++++++++++++++++
 9 files changed, 387 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.txt
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750cpg.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.txt
new file mode 100644
index 0000000..e763e2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.txt
@@ -0,0 +1,25 @@
+* Renesas SH7750/51 CPG
+
+Required Properties:
+
+  - compatible: Must be "renesas,sh7750-cpg"
+
+  - clocks: Reference to the parent clocks (xtal or external)
+
+  - #clock-cells: Must be 1
+
+  - reg: Base address and length of the FREQCR
+         and Base address and length of the CLKSTP00 (optional)
+
+  - renesas,mult: PLL1 multiply rate
+
+Example
+-------
+
+        cpg: cpg@ffc00000 {
+                compatible = "renesas,sh7750-cpg";
+                clocks = <&oclk>;
+                #clock-cells = <1>;
+                renesas,mult = <12>;
+                reg = <0xffc00000 32>, <0xfe0a0000 16>;
+        };
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 9e4ccd0..b6ff9df 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -13,6 +13,7 @@ config SH_DEVICE_TREE
 	select CLKSRC_OF
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IOMAP
+	select COMMON_CLK
 	help
 	  Select Board Described by Device Tree to build a kernel that
 	  does not hard-code any board-specific knowledge but instead uses
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index accc7ca..22ad0ee 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -16,6 +16,10 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 # Common interfaces.
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
+ifndef CONFIG_COMMON_CLK
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
-
-obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
+endif
+ifndef CONFIG_GENERIC_IRQ_CHIP
+obj-y	+= irq/
+endif
+obj-y	+= init.o clock.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 4187cf4..8e66e23 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -22,13 +22,15 @@
 
 int __init clk_init(void)
 {
-	int ret;
+	int ret = 0;
 
+#ifndef CONFIG_COMMON_CLK
 	ret = arch_clk_init();
 	if (unlikely(ret)) {
 		pr_err("%s: CPU clock registration failed.\n", __func__);
 		return ret;
 	}
+#endif
 
 	if (sh_mv.mv_clk_init) {
 		ret = sh_mv.mv_clk_init();
@@ -39,11 +41,13 @@ int __init clk_init(void)
 		}
 	}
 
+#ifndef CONFIG_COMMON_CLK
 	/* Kick the child clocks.. */
 	recalculate_root_clocks();
 
 	/* Enable the necessary init clocks */
 	clk_enable_init_clocks();
+#endif
 
 	return ret;
 }
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98efbfc..60d19d0 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -213,6 +213,7 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/samsung/Kconfig"
+source "drivers/clk/sh/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dcc5e69..c4bfbb9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -86,5 +86,6 @@ obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
-obj-$(CONFIG_H8300)		+= h8300/
+obj-$(CONFIG_H8300)			+= h8300/
 obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
+obj-$(CONFIG_SUPERH)			+= sh/
diff --git a/drivers/clk/sh/Kconfig b/drivers/clk/sh/Kconfig
new file mode 100644
index 0000000..2090415
--- /dev/null
+++ b/drivers/clk/sh/Kconfig
@@ -0,0 +1,2 @@
+config COMMON_CLK_SH7750
+	bool "CPG driver for SH7750/SH7751"
diff --git a/drivers/clk/sh/Makefile b/drivers/clk/sh/Makefile
new file mode 100644
index 0000000..7ce4da3
--- /dev/null
+++ b/drivers/clk/sh/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_COMMON_CLK_SH7750) += clk-sh7750cpg.o
diff --git a/drivers/clk/sh/clk-sh7750cpg.c b/drivers/clk/sh/clk-sh7750cpg.c
new file mode 100644
index 0000000..a538be4
--- /dev/null
+++ b/drivers/clk/sh/clk-sh7750cpg.c
@@ -0,0 +1,344 @@
+/*
+ * Renesas SH7750/51 clock driver
+ *
+ * Copyright 2016 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/* Available FREQCR settings */
+static const int freqcr_table[] = {
+	0x0400, 0x0401, 0x0402, 0x0403, 0x0404, 0x0408,
+	0x0409, 0x040a, 0x040b, 0x040c, 0x0411, 0x0412,
+	0x0413, 0x0414, 0x041a, 0x041b, 0x041c, 0x0423,
+	0x0424, 0x0448, 0x0449, 0x044a, 0x044b, 0x044c,
+	0x0451, 0x0452, 0x0453, 0x0454, 0x045a, 0x045b,
+	0x045c, 0x0463, 0x0464, 0x0491, 0x0492, 0x0493,
+	0x0494, 0x049a, 0x049b, 0x049c, 0x04a3, 0x04a4,
+	0x04da, 0x04db, 0x04dc, 0x04e3, 0x04e4, 0x0523,
+	0x0524, 0x0000, 0x0001, 0x0002, 0x0003, 0x0004,
+	0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x0011,
+	0x0012, 0x0013, 0x0014, 0x0019, 0x001a, 0x001b,
+	0x001c, 0x0023, 0x0024, 0x0048, 0x0049, 0x004a,
+	0x004b, 0x004c, 0x0051, 0x0052, 0x0053, 0x0054,
+	0x0059, 0x005a, 0x005b, 0x005c, 0x0063, 0x0064,
+	0x0091, 0x0092, 0x0093, 0x0094, 0x0099, 0x009a,
+	0x009b, 0x009c, 0x00a3, 0x00a4, 0x00d1, 0x00d2,
+	0x00d3, 0x00d4, 0x00d9, 0x00da, 0x00db, 0x00dc,
+	0x00e3, 0x00e4, 0x0123, 0x0124, 0x0163, 0x0164,
+};
+
+struct priv {
+	void __iomem *freqcr;
+	void __iomem *clkstp;
+	int mult;
+	struct clk **clks;
+};
+
+struct cpg_clock {
+	struct clk_hw hw;
+	struct priv *priv;
+	int index;
+};
+
+struct clockname {
+	char *name;
+	int index;
+};
+
+static const struct clockname clocknames[] __initconst = {
+	{ .name = "sci", .index = 0 },
+	{ .name = "rtc", .index = 1 },
+	{ .name = "tmu0", .index = 2 },
+	{ .name = "tmu1", .index = 2 },
+	{ .name = "tmu2", .index = 2 },
+	{ .name = "scif", .index = 3 },
+	{ .name = "dmac", .index = 4 },
+	{ .name = "ubc", .index = 8 },
+	{ .name = "sq", .index = 9 },
+	{ .name = "intc", .index = 16 },
+	{ .name = "tmu3", .index = 17 },
+	{ .name = "tmu4", .index = 17 },
+	{ .name = "pcic", .index = 18 },
+	{ .name = "core", .index = 128 },
+};
+
+static const int iclk_div[] = {1, 2, 3, 4, 6, 8, 0, 0};
+static const int pclk_div[] = {2, 3, 4, 6, 8, 0, 0, 0};
+
+static DEFINE_SPINLOCK(clklock);
+
+#define to_cpg_clock(_hw) container_of(_hw, struct cpg_clock, hw)
+
+static unsigned long pllout(u16 freqcr, unsigned long parent_rate, int mult)
+{
+	if ((freqcr >> 10) & 1)
+		return parent_rate * mult;
+	else
+		return parent_rate;
+}
+
+static unsigned long cpg_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct cpg_clock *cpg_clock = to_cpg_clock(hw);
+	struct priv *priv = cpg_clock->priv;
+	unsigned long div;
+	u16 freqcr;
+
+	freqcr = ioread16(priv->freqcr);
+	if (cpg_clock->index = 128)
+		div = iclk_div[(freqcr >> 6) & 7];
+	else
+		div = pclk_div[freqcr & 7];
+	return pllout(freqcr, parent_rate, priv->mult) / div;
+}
+
+static u16 get_best_freqcr(unsigned long rate,
+			   unsigned long pclk_rate,
+			   unsigned long parent, int mult)
+{
+	int i;
+	int div;
+	u16 freqcr;
+
+	for (i = 0; i < ARRAY_SIZE(freqcr_table); i++) {
+		freqcr = freqcr_table[i];
+		if (pllout(freqcr, parent, mult) / pclk_div[freqcr & 7]
+		    != pclk_rate)
+			continue;
+		div = iclk_div[(freqcr >> 6) & 7];
+		if (pllout(freqcr, parent, mult) / div < rate)
+			return freqcr;
+	}
+	return 0;
+}
+
+static long cpg_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct cpg_clock *cpg_clock = to_cpg_clock(hw);
+	struct priv *priv = cpg_clock->priv;
+	unsigned long pclk_rate;
+	u16 freqcr;
+	int div;
+
+	freqcr = ioread16(priv->freqcr);
+	pclk_rate = pllout(freqcr, *prate, priv->mult) / pclk_div[freqcr & 7];
+
+	freqcr = get_best_freqcr(rate, pclk_rate, *prate, priv->mult);
+	if (cpg_clock->index = 128)
+		div = iclk_div[(freqcr >> 6) & 7];
+	else
+		div = pclk_div[freqcr & 7];
+
+	return pllout(freqcr, *prate, priv->mult) / div;
+}
+
+static int cpg_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct cpg_clock *cpg_clock = to_cpg_clock(hw);
+	struct priv *priv = cpg_clock->priv;
+	unsigned long flags;
+	unsigned long pclk_rate;
+	u16 freqcr, new_freqcr;
+
+	if (cpg_clock->index != 128)
+		return 0;
+
+	freqcr = ioread16(priv->freqcr);
+	pclk_rate = pllout(freqcr, parent_rate, priv->mult) /
+		pclk_div[freqcr & 7];
+
+	new_freqcr = get_best_freqcr(rate, pclk_rate, parent_rate, priv->mult);
+
+	if ((freqcr & 0x0200) = 0 && (new_freqcr & 0x0200) != 0) {
+		/* PLL on */
+		/* required stable time */
+		spin_lock_irqsave(&clklock, flags);
+		iowrite16(0x5a00, priv->freqcr + 8);
+		iowrite16(0xa503, priv->freqcr + 12);
+		iowrite16(new_freqcr, priv->freqcr);
+		spin_unlock_irqrestore(&clklock, flags);
+	} else {
+		/* PLL state no change */
+		/* not required stable time */
+		iowrite16(new_freqcr, priv->freqcr);
+	}
+	return 0;
+}
+
+static int cpg_enable(struct clk_hw *hw)
+{
+	struct cpg_clock *cpg_clock = to_cpg_clock(hw);
+	struct priv *priv = cpg_clock->priv;
+	u8 stbcr;
+
+	switch ((cpg_clock->index >> 3) & 3) {
+	case 0:
+		/* STBCR */
+		stbcr = ioread8(priv->freqcr + 4);
+		stbcr &= ~(1 << (cpg_clock->index & 7));
+		iowrite8(stbcr, priv->freqcr + 4);
+		break;
+	case 1:
+		/* STBCR2 */
+		stbcr = ioread8(priv->freqcr + 16);
+		stbcr &= ~(1 << (cpg_clock->index & 7));
+		iowrite8(stbcr, priv->freqcr + 16);
+		break;
+	case 2:
+		/* CLKSTPCLR00 */
+		iowrite32(1 << (cpg_clock->index - 16), priv->clkstp + 8);
+		break;
+	}
+	return 0;
+}
+
+static void cpg_disable(struct clk_hw *hw)
+{
+	struct cpg_clock *cpg_clock = to_cpg_clock(hw);
+	struct priv *priv = cpg_clock->priv;
+	u8 stbcr;
+
+	switch ((cpg_clock->index >> 3) & 3) {
+	case 0:
+		/* STBCR */
+		stbcr = ioread8(priv->freqcr + 4);
+		stbcr |= (1 << (cpg_clock->index & 7));
+		iowrite8(stbcr, priv->freqcr + 4);
+		break;
+	case 1:
+		/* STBCR2 */
+		stbcr = ioread8(priv->freqcr + 16);
+		stbcr |= (1 << (cpg_clock->index & 7));
+		iowrite8(stbcr, priv->freqcr + 16);
+		break;
+	case 2:
+		/* CLKSTP00 */
+		iowrite32(1 << (cpg_clock->index - 16), priv->clkstp);
+		break;
+	}
+}
+
+struct clk *sh7750_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= ARRAY_SIZE(clocknames)) {
+		pr_err("%s: invalid clock index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return priv->clks[idx];
+}
+
+static const struct clk_ops cpg_ops = {
+	.recalc_rate	= cpg_recalc_rate,
+	.round_rate	= cpg_round_rate,
+	.set_rate	= cpg_set_rate,
+	.enable		= cpg_enable,
+	.disable	= cpg_disable,
+};
+
+static struct clk *  __init sh7750_cpg_register(struct device_node *node,
+						const struct clockname *name,
+						const char *parent_name,
+						struct priv *priv)
+{
+	struct cpg_clock *cpg_clock;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	cpg_clock = kzalloc(sizeof(struct cpg_clock), GFP_KERNEL);
+	if (!cpg_clock) {
+		pr_err("%s: failed to alloc memory", name->name);
+		return NULL;
+	}
+
+	init.name = name->name;
+	init.ops = &cpg_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	cpg_clock->hw.init = &init;
+	cpg_clock->priv = priv;
+	cpg_clock->index = name->index;
+
+	clk = clk_register(NULL, &cpg_clock->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register %s pll clock (%ld)\n",
+		       __func__, name->name, PTR_ERR(clk));
+		return NULL;
+	}
+	return clk;
+}
+
+static void __init sh7750_cpg_setup(struct device_node *node)
+{
+	const char *parent_name;
+	struct priv *priv;
+	int i;
+
+	priv = kzalloc(sizeof(struct priv), GFP_KERNEL);
+	if (priv = NULL) {
+		pr_err("%s: failed to alloc memory",
+		       node->name);
+		return;
+	}
+	priv->clks = kmalloc_array(sizeof(priv->clks), ARRAY_SIZE(clocknames),
+				   GFP_KERNEL);
+	if (priv->clks = NULL) {
+		pr_err("%s: failed to alloc memory",
+		       node->name);
+		kfree(priv);
+		return;
+	}
+	for (i = 0; i < ARRAY_SIZE(clocknames); i++)
+		priv->clks[i] = ERR_PTR(-ENOENT);
+
+	priv->freqcr = of_iomap(node, 0);
+	if (priv->freqcr = NULL) {
+		pr_err("%s: failed to map frequenct control register",
+		       node->name);
+		goto free_clock;
+	}
+
+	/* Optional register */
+	priv->clkstp = of_iomap(node, 1);
+
+	of_property_read_u32_index(node, "renesas,mult", 0, &priv->mult);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	for (i = 0; i < ARRAY_SIZE(clocknames); i++) {
+		priv->clks[i] = sh7750_cpg_register(node, &clocknames[i],
+						    parent_name, priv);
+		if (priv->clks[i] = NULL)
+			goto unmap_reg;
+	}
+	of_clk_add_provider(node, sh7750_onecell_get, priv);
+	return;
+
+unmap_reg:
+	if (priv->clkstp)
+		iounmap(priv->clkstp);
+	iounmap(priv->freqcr);
+free_clock:
+	for (i = 0; i < ARRAY_SIZE(clocknames); i++)
+		if (priv->clks[i] != ERR_PTR(-ENOENT) && priv->clks[i])
+			clk_unregister(priv->clks[i]);
+	kfree(priv->clks);
+	kfree(priv);
+}
+
+CLK_OF_DECLARE(sh7750_cpg, "renesas,sh7750-cpg", sh7750_cpg_setup);
-- 
2.7.0

