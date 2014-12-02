From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:36:44 +0000
Subject: [PATCH v3 1/6] clk: shmobile: r8a73a4 common clock framework implementation
Message-Id: <1417509409-31638-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Driver for the R8A73A4's clocks that are too specific to be supported by a
generic driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |  33 +++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a73a4.c                 | 244 +++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a73a4.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
new file mode 100644
index 0000000..ece9239
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
@@ -0,0 +1,33 @@
+* Renesas R8A73A4 Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the R8A73A4 SoC. It includes five PLLs
+and several fixed ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be "renesas,r8a73a4-cpg-clocks"
+
+  - reg: Base address and length of the memory resource used by the CPG
+
+  - clocks: Reference to the parent clocks ("extal1" and "extal2")
+
+  - #clock-cells: Must be 1
+
+  - clock-output-names: The names of the clocks. Supported clocks are "main",
+    "pll0", "pll1", "pll2", "pll2s", "pll2h", "z", "z2", "i", "m3", "b",
+    "m1", "m2", "zx", "zs", and "hp".
+
+
+Example
+-------
+
+        cpg_clocks: cpg_clocks@e6150000 {
+                compatible = "renesas,r8a73a4-cpg-clocks";
+                reg = <0 0xe6150000 0 0x10000>;
+                clocks = <&extal1_clk>, <&extal2_clk>;
+                #clock-cells = <1>;
+                clock-output-names = "main", "pll0", "pll1", "pll2",
+                                     "pll2s", "pll2h", "z", "z2",
+                                     "i", "m3", "b", "m1", "m2",
+                                     "zx", "zs", "hp";
+        };
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 960bf22..f48c144 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
+obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
diff --git a/drivers/clk/shmobile/clk-r8a73a4.c b/drivers/clk/shmobile/clk-r8a73a4.c
new file mode 100644
index 0000000..2c9d760
--- /dev/null
+++ b/drivers/clk/shmobile/clk-r8a73a4.c
@@ -0,0 +1,244 @@
+/*
+ * r8a73a4 Core CPG Clocks
+ *
+ * Copyright (C) 2014  Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/shmobile.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+
+struct r8a73a4_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+};
+
+#define CPG_CKSCR	0xc0
+#define CPG_FRQCRA	0x00
+#define CPG_FRQCRB	0x04
+#define CPG_FRQCRC	0xe0
+#define CPG_PLL0CR	0xd8
+#define CPG_PLL1CR	0x28
+#define CPG_PLL2CR	0x2c
+#define CPG_PLL2HCR	0xe4
+#define CPG_PLL2SCR	0xf4
+
+#define CLK_ENABLE_ON_INIT BIT(0)
+
+struct div4_clk {
+	const char *name;
+	unsigned int reg;
+	unsigned int shift;
+	unsigned int mask;
+	int flags;
+};
+
+static struct div4_clk div4_clks[] = {
+	{ "i",	CPG_FRQCRA, 20, 0x0dff, CLK_ENABLE_ON_INIT },
+	{ "m3", CPG_FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT },
+	{ "b",	CPG_FRQCRA,  8, 0x0dff, CLK_ENABLE_ON_INIT },
+	{ "m1", CPG_FRQCRA,  4, 0x1dff, CLK_ENABLE_ON_INIT },
+	{ "m2", CPG_FRQCRA,  0, 0x1dff, 0 },
+	{ "zx", CPG_FRQCRB, 12, 0x0dff, 0 },
+	{ "zs", CPG_FRQCRB,  8, 0x0dff, 0 },
+	{ "hp", CPG_FRQCRB,  4, 0x0dff, 0 },
+	{ NULL, 0, 0, 0 },
+};
+
+static const struct clk_div_table div4_div_table[] = {
+	{ 0, 2 }, { 1, 3 }, { 2, 4 }, { 3, 6 }, { 4, 8 }, { 5, 12 },
+	{ 6, 16 }, { 7, 18 }, { 8, 24 }, { 10, 36 }, { 11, 48 },
+	{ 12, 10 }, { 0, 0 }
+};
+
+static struct clk * __init
+r8a73a4_cpg_register_clock(struct device_node *np, struct r8a73a4_cpg *cpg,
+			     const char *name)
+{
+	const struct clk_div_table *table = NULL;
+	const char *parent_name;
+	unsigned int shift, reg;
+	unsigned int mult = 1;
+	unsigned int div = 1;
+
+
+	if (!strcmp(name, "main")) {
+		u32 ckscr = clk_readl(cpg->reg + CPG_CKSCR);
+
+		switch ((ckscr >> 28) & 3) {
+		case 0:	/* extal1 */
+			parent_name = of_clk_get_parent_name(np, 0);
+			break;
+		case 1:	/* extal1 / 2 */
+			parent_name = of_clk_get_parent_name(np, 0);
+			div = 2;
+			break;
+		case 2: /* extal2 */
+			parent_name = of_clk_get_parent_name(np, 1);
+			break;
+		case 3: /* extal2 / 2 */
+			parent_name = of_clk_get_parent_name(np, 1);
+			div = 2;
+			break;
+		}
+	} else if (!strcmp(name, "pll0")) {
+		/* PLL0/1 are configurable multiplier clocks. Register them as
+		 * fixed factor clocks for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		u32 value = clk_readl(cpg->reg + CPG_PLL0CR);
+
+		parent_name = "main";
+		mult = ((value >> 24) & 0x7f) + 1;
+		if (value & BIT(20))
+			div = 2;
+	} else if (!strcmp(name, "pll1")) {
+		u32 value = clk_readl(cpg->reg + CPG_PLL1CR);
+
+		parent_name = "main";
+		/* XXX: enable bit? */
+		mult = ((value >> 24) & 0x7f) + 1;
+		if (value & BIT(7))
+			div = 2;
+	} else if (!strncmp(name, "pll2", 4)) {
+		u32 value, cr;
+
+		switch (name[4]) {
+		case 0:
+			cr = CPG_PLL2CR;
+			break;
+		case 's':
+			cr = CPG_PLL2SCR;
+			break;
+		case 'h':
+			cr = CPG_PLL2HCR;
+			break;
+		default:
+			return ERR_PTR(-EINVAL);
+		}
+		value = clk_readl(cpg->reg + cr);
+		switch ((value >> 5) & 7) {
+		case 0:
+			parent_name = "main";
+			div = 2;
+			break;
+		case 1:
+			parent_name = "extal2";
+			div = 2;
+			break;
+		case 3:
+			parent_name = "extal2";
+			div = 4;
+			break;
+		case 4:
+			parent_name = "main";
+			break;
+		case 5:
+			parent_name = "extal2";
+			break;
+		default:
+			pr_warn("%s: unexpected parent of %s\n", __func__,
+				name);
+			return ERR_PTR(-EINVAL);
+		}
+		/* XXX: enable bit? */
+		mult = ((value >> 24) & 0x7f) + 1;
+	} else if (!strcmp(name, "z") || !strcmp(name, "z2")) {
+		u32 shift = 8;
+
+		parent_name = "pll0";
+		if (name[1] = '2') {
+			div = 2;
+			shift = 0;
+		}
+		div *= 32;
+		mult = 0x20 - ((clk_readl(cpg->reg + CPG_FRQCRC) >> shift)
+		       & 0x1f);
+	} else {
+		struct div4_clk *c;
+
+		for (c = div4_clks; c->name; c++) {
+			if (!strcmp(name, c->name)) {
+				break;
+			}
+		}
+		if (!c->name)
+			return ERR_PTR(-EINVAL);
+
+		parent_name = "pll1";
+		table = div4_div_table;
+		reg = c->reg;
+		shift = c->shift;
+	}
+
+	if (!table) {
+		return clk_register_fixed_factor(NULL, name, parent_name, 0,
+						 mult, div);
+	} else {
+		return clk_register_divider_table(NULL, name, parent_name, 0,
+						  cpg->reg + reg, shift, 4, 0,
+						  table, &cpg->lock);
+	}
+}
+
+static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
+{
+	struct r8a73a4_cpg *cpg;
+	struct clk **clks;
+	unsigned int i;
+	int num_clks;
+
+	num_clks = of_property_count_strings(np, "clock-output-names");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks\n", __func__);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	clks = kcalloc(num_clks, sizeof(*clks), GFP_KERNEL);
+	if (cpg = NULL || clks = NULL) {
+		/* We're leaking memory on purpose, there's no point in cleaning
+		 * up as the system won't boot anyway.
+		 */
+		return;
+	}
+
+	spin_lock_init(&cpg->lock);
+
+	cpg->data.clks = clks;
+	cpg->data.clk_num = num_clks;
+
+	cpg->reg = of_iomap(np, 0);
+	if (WARN_ON(cpg->reg = NULL))
+		return;
+
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i,
+					      &name);
+
+		clk = r8a73a4_cpg_register_clock(np, cpg, name);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
+	       r8a73a4_cpg_clocks_init);
-- 
1.8.4.5

