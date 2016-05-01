From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 04:59:16 +0000
Subject: [PATCH 06/12] clk: sh: SH7750/51 PLL and divider clock driver
Message-Id: <1462078763-27135-7-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462078763-27135-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462078763-27135-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, linux-kerel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,sh-div-clock.txt        |  24 ++
 .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 ++
 .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +-
 drivers/clk/sh/Kconfig                             |   5 +
 drivers/clk/sh/Makefile                            |   2 +
 drivers/clk/sh/clk-sh7750.c                        | 223 ++++++++++++++
 drivers/clk/sh/clk-shdiv.c                         | 338 +++++++++++++++++++++
 9 files changed, 648 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-sh7750.c
 create mode 100644 drivers/clk/sh/clk-shdiv.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
new file mode 100644
index 0000000..399e0da
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
@@ -0,0 +1,24 @@
+* Renesas H8/300 divider clock
+
+Required Properties:
+
+  - compatible: Must be "renesas,h8300-div-clock"
+
+  - clocks: Reference to the parent clocks ("extal1" and "extal2")
+
+  - #clock-cells: Must be 1
+
+  - reg: Base address and length of the divide rate selector
+
+  - renesas,width: bit width of selector
+
+Example
+-------
+
+		cclk: cclk {
+			compatible = "renesas,h8300-div-clock";
+			clocks = <&xclk>;
+			#clock-cells = <0>;
+			reg = <0xfee01b 2>;
+			renesas,width = <2>;
+		};
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
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 16f7d33..19b0cd3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -202,6 +202,7 @@ source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/samsung/Kconfig"
+source "drivers/clk/sh/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 46869d6..c75d9c8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -83,4 +83,5 @@ obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
-obj-$(CONFIG_H8300)		+= h8300/
+obj-$(CONFIG_H8300)			+= h8300/
+obj-$(CONFIG_SUPERH)			+= sh/
diff --git a/drivers/clk/sh/Kconfig b/drivers/clk/sh/Kconfig
new file mode 100644
index 0000000..729850c
--- /dev/null
+++ b/drivers/clk/sh/Kconfig
@@ -0,0 +1,5 @@
+config COMMON_CLK_SH7750
+	bool "Clcok driver for SH7750/SH7751"
+	depends on CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
+	           CPU_SUBTYPE_SH7750R || \
+	           CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
diff --git a/drivers/clk/sh/Makefile b/drivers/clk/sh/Makefile
new file mode 100644
index 0000000..7122c37
--- /dev/null
+++ b/drivers/clk/sh/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_COMMON_CLK_SH7750) += clk-sh7750.o
+obj-$(CONFIG_COMMON_CLK_SH7750) += clk-shdiv.o
diff --git a/drivers/clk/sh/clk-sh7750.c b/drivers/clk/sh/clk-sh7750.c
new file mode 100644
index 0000000..a00c421
--- /dev/null
+++ b/drivers/clk/sh/clk-sh7750.c
@@ -0,0 +1,223 @@
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
+
+struct clk *sh_div_clk_register(struct device *dev, const char *name,
+				const char *parent_name,
+				void __iomem *reg, u8 shift, u8 width,
+				const struct clk_div_table *table,
+				spinlock_t *lock);
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
+					  &clklock);
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
diff --git a/drivers/clk/sh/clk-shdiv.c b/drivers/clk/sh/clk-shdiv.c
new file mode 100644
index 0000000..ad244a8
--- /dev/null
+++ b/drivers/clk/sh/clk-shdiv.c
@@ -0,0 +1,338 @@
+/*
+ * SuperH divider clock driver
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+#define div_mask(width)	((1 << (width)) - 1)
+
+static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
+				      u8 width)
+{
+	unsigned int maxdiv = 0, mask = div_mask(width);
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div > maxdiv && clkt->val <= mask)
+			maxdiv = clkt->div;
+	return maxdiv;
+}
+
+static unsigned int _get_maxdiv(const struct clk_div_table *table, u8 width)
+{
+	if (table)
+		return _get_table_maxdiv(table, width);
+	return div_mask(width) + 1;
+}
+
+static unsigned int _get_table_div(const struct clk_div_table *table,
+				   unsigned int val)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val = val)
+			return clkt->div;
+	return 0;
+}
+
+static unsigned int _get_div(const struct clk_div_table *table,
+			     unsigned int val,  u8 width)
+{
+	if (table)
+		return _get_table_div(table, val);
+	return val + 1;
+}
+
+static unsigned int _get_table_val(const struct clk_div_table *table,
+				   unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div = div)
+			return clkt->val;
+	return 0;
+}
+
+static unsigned int _get_val(const struct clk_div_table *table,
+			     unsigned int div, u8 width)
+{
+	if (table)
+		return  _get_table_val(table, div);
+	return div - 1;
+}
+
+static unsigned long sh_divider_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate,
+					 unsigned int val,
+					 const struct clk_div_table *table)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int div;
+
+	div = _get_div(table, val, divider->width);
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static unsigned long sh_clk_divider_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int val;
+
+	val = __raw_readw(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+
+	return sh_divider_recalc_rate(hw, parent_rate, val, divider->table);
+}
+
+static bool _is_valid_table_div(const struct clk_div_table *table,
+				unsigned int div)
+{
+	const struct clk_div_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->div = div)
+			return true;
+	return false;
+}
+
+static bool _is_valid_div(const struct clk_div_table *table, unsigned int div)
+{
+	if (table)
+		return _is_valid_table_div(table, div);
+	return true;
+}
+
+static int _round_up_table(const struct clk_div_table *table, int div)
+{
+	const struct clk_div_table *clkt;
+	int up = INT_MAX;
+
+	for (clkt = table; clkt->div; clkt++) {
+		if (clkt->div = div)
+			return clkt->div;
+		else if (clkt->div < div)
+			continue;
+
+		if ((clkt->div - div) < (up - div))
+			up = clkt->div;
+	}
+
+	return up;
+}
+
+static int _div_round_up(const struct clk_div_table *table,
+			 unsigned long parent_rate, unsigned long rate)
+{
+	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+
+	if (table)
+		div = _round_up_table(table, div);
+
+	return div;
+}
+
+static int _div_round(const struct clk_div_table *table,
+		      unsigned long parent_rate, unsigned long rate)
+{
+	return _div_round_up(table, parent_rate, rate);
+}
+
+static bool _is_best_div(unsigned long rate, unsigned long now,
+			 unsigned long best)
+{
+	return now <= rate && now > best;
+}
+
+static int _next_div(const struct clk_div_table *table, int div)
+{
+	div++;
+
+	if (table)
+		return _round_up_table(table, div);
+
+	return div;
+}
+
+static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *best_parent_rate,
+			       const struct clk_div_table *table, u8 width)
+{
+	int i, bestdiv = 0;
+	unsigned long parent_rate, best = 0, now, maxdiv;
+	unsigned long parent_rate_saved = *best_parent_rate;
+
+	if (!rate)
+		rate = 1;
+
+	maxdiv = _get_maxdiv(table, width);
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestdiv = _div_round(table, parent_rate, rate);
+		bestdiv = bestdiv = 0 ? 1 : bestdiv;
+		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
+		return bestdiv;
+	}
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * i below
+	 */
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (i = _next_div(table, 0); i <= maxdiv;
+	     i = _next_div(table, i)) {
+		if (rate * i = parent_rate_saved) {
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without needing to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return i;
+		}
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+					       rate * i);
+		now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
+		if (_is_best_div(rate, now, best)) {
+			bestdiv = i;
+			best = now;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestdiv) {
+		bestdiv = _get_maxdiv(table, width);
+		*best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
+	}
+
+	return bestdiv;
+}
+
+static long sh_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate, const struct clk_div_table *table,
+			u8 width)
+{
+	int div;
+
+	div = clk_divider_bestdiv(hw, rate, prate, table, width);
+
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
+}
+
+static long sh_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+
+	return sh_divider_round_rate(hw, rate, prate, divider->table,
+				     divider->width);
+}
+
+static int sh_divider_get_val(unsigned long rate, unsigned long parent_rate,
+			   const struct clk_div_table *table, u8 width)
+{
+	unsigned int div, value;
+
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+
+	if (!_is_valid_div(table, div))
+		return -EINVAL;
+
+	value = _get_val(table, div, width);
+
+	return min_t(unsigned int, value, div_mask(width));
+}
+
+static int sh_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int value;
+	unsigned long flags = 0;
+	u16 val;
+
+	value = sh_divider_get_val(rate, parent_rate, divider->table,
+				   divider->width);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	val = __raw_readw(divider->reg);
+	val &= ~(div_mask(divider->width) << divider->shift);
+	val |= value << divider->shift;
+	__raw_writew(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static const struct clk_ops sh_clk_divider_ops = {
+	.recalc_rate = sh_clk_divider_recalc_rate,
+	.round_rate = sh_clk_divider_round_rate,
+	.set_rate = sh_clk_divider_set_rate,
+};
+
+static struct clk *_register_divider(struct device *dev, const char *name,
+		const char *parent_name,
+		void __iomem *reg, u8 shift, u8 width,
+		const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	struct clk_divider *div;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &sh_clk_divider_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_divider assignments */
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	clk = clk_register(dev, &div->hw);
+
+	if (IS_ERR(clk))
+		kfree(div);
+
+	return clk;
+}
+
+struct clk *sh_div_clk_register(struct device *dev, const char *name,
+				const char *parent_name,
+				void __iomem *reg, u8 shift, u8 width,
+				const struct clk_div_table *table,
+				spinlock_t *lock)
+{
+	return _register_divider(dev, name, parent_name, reg, shift,
+				 width, table, lock);
+}
+EXPORT_SYMBOL_GPL(sh_div_clk_register);
-- 
2.7.0

