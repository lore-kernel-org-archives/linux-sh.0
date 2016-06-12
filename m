From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:28 +0000
Subject: [PATCH v2 10/17] sh: convert generic drivers framework
Message-Id: <1465714475-24111-11-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Use common PCI host framework and Common Clock Freamework.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/Kconfig      |   1 +
 arch/sh/drivers/Makefile    |   2 +
 arch/sh/kernel/cpu/Makefile |   8 +-
 arch/sh/kernel/cpu/clock.c  |   6 +-
 drivers/clk/Kconfig         |   1 +
 drivers/clk/Makefile        |   3 +-
 drivers/clk/sh/Kconfig      |   2 +
 drivers/clk/sh/Makefile     |   2 +
 drivers/clk/sh/clk-shdiv.c  | 344 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sh/clk-shdiv.h  |  16 +++
 10 files changed, 381 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/sh/Kconfig
 create mode 100644 drivers/clk/sh/Makefile
 create mode 100644 drivers/clk/sh/clk-shdiv.c
 create mode 100644 drivers/clk/sh/clk-shdiv.h

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
diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index e13f06b..382e86f 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -4,7 +4,9 @@
 
 obj-y		+= dma/
 
+ifndef CONFIG_SH_DEVICE_TREE
 obj-$(CONFIG_PCI)		+= pci/
+endif
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
 obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
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
index 0000000..89e28d8
--- /dev/null
+++ b/drivers/clk/sh/Kconfig
@@ -0,0 +1,2 @@
+config COMMON_CLK_SH7750
+	bool "Clcok driver for SH7750/SH7751"
diff --git a/drivers/clk/sh/Makefile b/drivers/clk/sh/Makefile
new file mode 100644
index 0000000..468eb9d
--- /dev/null
+++ b/drivers/clk/sh/Makefile
@@ -0,0 +1,2 @@
+obj-y += clk-shdiv.o
+obj-$(CONFIG_COMMON_CLK_SH7750) += clk-sh7750.o
\ No newline at end of file
diff --git a/drivers/clk/sh/clk-shdiv.c b/drivers/clk/sh/clk-shdiv.c
new file mode 100644
index 0000000..be19ffa
--- /dev/null
+++ b/drivers/clk/sh/clk-shdiv.c
@@ -0,0 +1,344 @@
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
+#include "clk-shdiv.h"
+
+#define div_mask(width) ((1 << (width)) - 1)
+#define to_sh_clk_div(_divider)					\
+	container_of(_divider, struct sh_clk_div, divider)
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
+	struct sh_clk_div *sh_div = to_sh_clk_div(divider);
+	unsigned int val;
+
+	val = sh_div->read(divider);
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
+	struct sh_clk_div *sh_div = to_sh_clk_div(divider);
+	unsigned int value;
+	unsigned long flags = 0;
+
+	value = sh_divider_get_val(rate, parent_rate, divider->table,
+				   divider->width);
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	sh_div->write(divider, value);
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
+		     const char *parent_name,
+		     void __iomem *reg, u8 shift, u8 width,
+		     const struct clk_div_table *table,
+		     spinlock_t *lock,
+		     u16 (*read)(struct clk_divider *hw),
+		     void (*write)(struct clk_divider *hw, u16 val))
+{
+	struct sh_clk_div *div;
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
+	div->divider.reg = reg;
+	div->divider.shift = shift;
+	div->divider.width = width;
+	div->divider.lock = lock;
+	div->divider.hw.init = &init;
+	div->divider.table = table;
+	div->read = read;
+	div->write = write;
+
+	/* register the clock */
+	clk = clk_register(dev, &div->divider.hw);
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
+				spinlock_t *lock,
+				u16 (*read)(struct clk_divider *hw),
+				void (*write)(struct clk_divider *hw, u16 val))
+{
+	return _register_divider(dev, name, parent_name, reg, shift,
+				 width, table, lock, read, write);
+}
+EXPORT_SYMBOL_GPL(sh_div_clk_register);
diff --git a/drivers/clk/sh/clk-shdiv.h b/drivers/clk/sh/clk-shdiv.h
new file mode 100644
index 0000000..ebd27df
--- /dev/null
+++ b/drivers/clk/sh/clk-shdiv.h
@@ -0,0 +1,16 @@
+/* SuperH common clock divider */
+
+struct sh_clk_div {
+	struct clk_divider divider;
+	u16 (*read)(struct clk_divider *divider);
+	void (*write)(struct clk_divider *divider, u16 val);
+};
+
+struct clk *sh_div_clk_register(struct device *dev, const char *name,
+				const char *parent_name,
+				void __iomem *reg, u8 shift, u8 width,
+				const struct clk_div_table *table,
+				spinlock_t *lock,
+				u16 (*read)(struct clk_divider *hw),
+				void (*write)(struct clk_divider *hw, u16 val));
+
-- 
2.7.0

