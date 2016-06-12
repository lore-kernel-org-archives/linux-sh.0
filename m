From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:29 +0000
Subject: [PATCH v2 11/17] sh: SH7750/51 clock driver
Message-Id: <1465714475-24111-12-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 +++
 .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 +++
 drivers/clk/sh/clk-sh7750.c                        | 240 +++++++++++++++++++++
 3 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
 create mode 100644 drivers/clk/sh/clk-sh7750.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
new file mode 100644
index 0000000..8c57ab5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
@@ -0,0 +1,27 @@
+* Renesas SH7750/51 divider clock
+
+Required Properties:
+
+  - compatible: Must be "renesas,sh7750-div-clock"
+
+  - clocks: Reference to the parent clocks (mostly PLL)
+
+  - #clock-cells: Must be 0
+
+  - reg: Base address and length of the divide rate selector
+
+  - renesas,offset: bit offset of selector
+
+  - clock-output-names: The names of the clocks.
+
+Example
+-------
+
+        iclk: iclk {
+                compatible = "renesas,sh7750-div-clock";
+                clocks = <&pllclk>;
+                #clock-cells = <0>;
+                reg = <0xffc00000 2>;
+		renesas,offset = <6>;
+		clock-output-names = "ick";
+        };
diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
new file mode 100644
index 0000000..06a3d31
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
@@ -0,0 +1,26 @@
+Renesas SH7750/51 PLL clock
+
+This device is Clock multiplyer
+
+Required Properties:
+
+  - compatible: Must be "renesas,sh7750-pll-clock"
+
+  - clocks: Reference to the parent clocks
+
+  - #clock-cells: Must be 0
+
+  - renesas,mult: PLL1 multiply rate
+
+  - reg: Two rate selector (FRQCR / WDT) register address
+
+Example
+-------
+
+        pllclk: pllclk {
+                compatible = "renesas,sh7750-pll-clock";
+                clocks = <&oclk>;
+                #clock-cells = <0>;
+		renesas,mult = <12>;
+                reg = <0xffc00000 2>, <0xffc00008 4>;
+        };
diff --git a/drivers/clk/sh/clk-sh7750.c b/drivers/clk/sh/clk-sh7750.c
new file mode 100644
index 0000000..259f1bb
--- /dev/null
+++ b/drivers/clk/sh/clk-sh7750.c
@@ -0,0 +1,240 @@
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
+#include "clk-shdiv.h"
+
+static DEFINE_SPINLOCK(clklock);
+
+static struct clk_div_table pdiv_table[] = {
+	{ .val = 0, .div = 2, },
+	{ .val = 1, .div = 3, },
+	{ .val = 2, .div = 4, },
+	{ .val = 3, .div = 6, },
+	{ .val = 4, .div = 8, },
+	{ .val = 0, .div = 0, },
+};
+
+static struct clk_div_table div_table[] = {
+	{ .val = 0, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 2, .div = 3, },
+	{ .val = 3, .div = 4, },
+	{ .val = 4, .div = 6, },
+	{ .val = 5, .div = 8, },
+	{ .val = 0, .div = 0, },
+};
+
+struct pll_clock {
+	struct clk_hw hw;
+	void __iomem *freqcr;
+	void __iomem *wdt;
+	int mult;
+};
+
+#define to_pll_clock(_hw) container_of(_hw, struct pll_clock, hw)
+
+static unsigned long pll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct pll_clock *pll_clock = to_pll_clock(hw);
+
+	if ((ioread16(pll_clock->freqcr) >> 9) & 1)
+		return parent_rate * pll_clock->mult;
+	else
+		return parent_rate;
+}
+
+static long pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct pll_clock *pll_clock = to_pll_clock(hw);
+	int mul;
+
+	mul = rate / *prate;
+	mul = (pll_clock->mult / 2 < mul)?pll_clock->mult:1;
+	return *prate * mul;
+}
+
+static int pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	int mult;
+	unsigned char val;
+	unsigned long flags;
+	struct pll_clock *pll_clock = to_pll_clock(hw);
+
+	mult = rate / parent_rate;
+	if (mult > 1) {
+		/* PLL enable */
+		/* required stable time */
+		spin_lock_irqsave(&clklock, flags);
+		iowrite16(0x5a00, pll_clock->wdt);
+		iowrite16(0xa503, pll_clock->wdt + 2);
+		val = ioread16(pll_clock->freqcr);
+		val |= 0x0200;
+		iowrite16(val, pll_clock->freqcr);
+		spin_unlock_irqrestore(&clklock, flags);
+	} else {
+		/* PLL disable */
+		/* not required stable time */
+		val = ioread16(pll_clock->freqcr);
+		val &= ~0x0200;
+		iowrite16(val, pll_clock->freqcr);
+	}
+	return 0;
+}
+
+static const struct clk_ops pll_ops = {
+	.recalc_rate = pll_recalc_rate,
+	.round_rate = pll_round_rate,
+	.set_rate = pll_set_rate,
+};
+
+static void __init sh7750_pll_clk_setup(struct device_node *node)
+{
+	unsigned int num_parents;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct pll_clock *pll_clock;
+	struct clk_init_data init;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found", clk_name);
+		return;
+	}
+
+	pll_clock = kzalloc(sizeof(struct pll_clock), GFP_KERNEL);
+	if (!pll_clock) {
+		pr_err("%s: failed to alloc memory", clk_name);
+		return;
+	}
+
+	pll_clock->freqcr = of_iomap(node, 0);
+	if (pll_clock->freqcr = NULL) {
+		pr_err("%s: failed to map frequenct control register",
+		       clk_name);
+		goto free_clock;
+	}
+
+	pll_clock->wdt = of_iomap(node, 1);
+	if (pll_clock->wdt = NULL) {
+		pr_err("%s: failed to map watchdog register", clk_name);
+		goto unmap_freqcr;
+	}
+
+	of_property_read_u32_index(node, "renesas,mult", 0, &pll_clock->mult);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.name = clk_name;
+	init.ops = &pll_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	pll_clock->hw.init = &init;
+
+	clk = clk_register(NULL, &pll_clock->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register %s pll clock (%ld)\n",
+		       __func__, clk_name, PTR_ERR(clk));
+		goto unmap_wdt;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+
+unmap_wdt:
+	iounmap(pll_clock->wdt);
+unmap_freqcr:
+	iounmap(pll_clock->freqcr);
+free_clock:
+	kfree(pll_clock);
+}
+
+static u16 sh7750_freqcr_read(struct clk_divider *divider)
+{
+	u16 val;
+
+	val = __raw_readw(divider->reg) >> divider->shift;
+	val &= ((1 << divider->width) - 1);
+	return val;
+}
+
+static void sh7750_freqcr_write(struct clk_divider *divider, u16 value)
+{
+	u16 val;
+
+	value <<= divider->shift;
+	val = __raw_readw(divider->reg);
+	val &= ~(((1 << divider->width) - 1) << divider->shift);
+	val |= value;
+	__raw_writew(val, divider->reg);
+}
+
+static void __init sh7750_div_clk_setup(struct device_node *node)
+{
+	unsigned int num_parents;
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	void __iomem *freqcr = NULL;
+	int i;
+	int num_clks;
+	int offset;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: no parent found", clk_name);
+		return;
+	}
+
+	num_clks = of_property_count_strings(node, "clock-output-names");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks", clk_name);
+		return;
+	}
+
+	freqcr = of_iomap(node, 0);
+	if (freqcr = NULL) {
+		pr_err("%s: failed to map divide register", clk_name);
+		goto error;
+	}
+	of_property_read_u32_index(node, "renesas,offset", 0, &offset);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	for (i = 0; i < num_clks; i++) {
+		of_property_read_string_index(node, "clock-output-names", i,
+					      &clk_name);
+		clk = sh_div_clk_register(NULL, clk_name, parent_name,
+					  freqcr,
+					  offset, 3,
+					  (offset = 0)?pdiv_table:div_table,
+					  &clklock, sh7750_freqcr_read,
+					  sh7750_freqcr_write);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s div clock (%ld)\n",
+			       __func__, clk_name, PTR_ERR(clk));
+		else
+			of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	}
+error:
+	if (freqcr)
+		iounmap(freqcr);
+}
+
+CLK_OF_DECLARE(sh7750_div_clk, "renesas,sh7750-div-clock",
+	       sh7750_div_clk_setup);
+CLK_OF_DECLARE(sh7750_pll_clk, "renesas,sh7750-pll-clock",
+	       sh7750_pll_clk_setup);
+
-- 
2.7.0

