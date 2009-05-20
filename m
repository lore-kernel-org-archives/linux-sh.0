From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 14:18:00 +0000
Subject: [PATCH] sh: shared clock framework code for SuperH Mobile
Message-Id: <20090520141800.8158.23015.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds new and improved clock framework code for
SuperH Mobile processors. Only shared code is included in
this patch, processor specific patches are required on top
of this to make use of the new features.

With this rewrite the clock framework becomes aware of
which CPG divisors combinations that are valid. The cpu
specific code flags which divisor bits that are supported
and a callback is used to validate divisor combinations.
Maximum per divisor clock ratings are also supported.

The divisors are kept in groups. One group is a bunch of
divisors that have complex dependencies. The shared code
will make sure that all divisors are kept valid and
informs the cpu specific code to update the divisors in
the group atomically.

PLL modification is not supported. Only divisor modification
with sh_mobile_div_optimize() is supported for now. The PLL
should be read out during boot and will be kept constant during
run-time.

Setting rates from the clock framework needs a bit more work,
but should be fairly easy to add on top of this.

Hint: state_dump() gives you all valid divisor combinations.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Apply on top of the clkfwk topic branch.

 arch/sh/include/cpu-common/cpu/clock-sh_mobile.h |   89 +++
 arch/sh/kernel/cpu/shmobile/Makefile             |    2 
 arch/sh/kernel/cpu/shmobile/clock.c              |  569 ++++++++++++++++++++++
 3 files changed, 659 insertions(+), 1 deletion(-)

--- /dev/null
+++ work/arch/sh/include/cpu-common/cpu/clock-sh_mobile.h	2009-05-20 22:08:58.000000000 +0900
@@ -0,0 +1,89 @@
+#ifndef __CLOCK_SH_MOBILE_H__
+#define __CLOCK_SH_MOBILE_H__
+
+#define SH_MOBILE_DIVISOR_NR 0 /* override with cpu specific value */
+#define SH_MOBILE_MSTP_NR 0 /* override with cpu specific value */
+#define SH_MOBILE_ALLOWED_NR 16 /* 4-bit fields is enough for now */
+
+/* system clock modes */
+#define CLK_MODE_N_1 0
+#define CLK_MODE_3_2 1
+#define CLK_MODE_5_2 2
+#define CLK_MODE_1_N 3
+#define CLK_MODE_4_3 4
+#define CLK_MODE_5_4 5
+#define CLK_MODE_1_1 6
+#define CLK_MODE_2_1 7
+#define CLK_MODE_3_1 8
+#define CLK_MODE_4_1 9
+
+/* per-divisor run time state */
+struct sh_mobile_div_state {
+	int mode;
+	int selected;
+	int cnt;
+	int forced_min;
+	int forced_max;
+	int best;
+};
+
+/* run time state */
+struct sh_mobile_cpg_state {
+	int cnt;
+	struct sh_mobile_div_state div_state[SH_MOBILE_DIVISOR_NR];
+};
+
+/* per-divisor hardware configuration (write-once) */
+struct sh_mobile_div_hw_cfg {
+	char *name;
+	int div;
+	int grp;
+	unsigned long max_mhz;
+	DECLARE_BITMAP(allowed, SH_MOBILE_ALLOWED_NR);
+};
+
+/* per-mstp hardware configuration (write-once) */
+struct sh_mobile_mstp_hw_cfg {
+	char *name;
+	int parent;
+	unsigned long reg;
+	unsigned char bitnr, enable_on_init, use_cpg, use_ram;
+};
+
+/* hardware configuration (write-once) */
+struct sh_mobile_cpg_hw_cfg {
+	int pll_mult; /* fixed PLL multiplier for now */
+	int (*check_div)(struct sh_mobile_cpg_hw_cfg *h, int div, int bit,
+			 struct sh_mobile_cpg_state *cs);
+	int (*set_div)(struct sh_mobile_cpg_hw_cfg *h, int grp,
+		       struct sh_mobile_cpg_state *cs);
+	int (*get_div)(struct sh_mobile_cpg_hw_cfg *h, int div);
+	void (*enable_disable)(struct sh_mobile_cpg_hw_cfg *h, int div, int on);
+	struct sh_mobile_div_hw_cfg div[SH_MOBILE_DIVISOR_NR];
+	int *multipliers;
+	int *divisors;
+	struct sh_mobile_mstp_hw_cfg mstp[SH_MOBILE_MSTP_NR];
+};
+
+int sh_mobile_div_check(struct sh_mobile_cpg_hw_cfg *h, int prev_div,
+			int mode, int this,
+			struct sh_mobile_cpg_state *cs);
+
+struct sh_mobile_div_hw_cfg *sh_mobile_div(struct sh_mobile_cpg_hw_cfg *h,
+					   int nr, char *name, int clk,
+					   int grp, unsigned long max_mhz);
+
+void sh_mobile_div_ok(struct sh_mobile_div_hw_cfg *d, int bit);
+void sh_mobile_div_ng(struct sh_mobile_div_hw_cfg *d, int bit);
+
+int sh_mobile_div_optimize(struct sh_mobile_cpg_hw_cfg *fhcp, char *div_str);
+
+int sh_mobile_mstp(struct sh_mobile_cpg_hw_cfg *h,
+		   int nr, char *name, int parent,
+		   unsigned long reg, int bitnr,
+		   int enable_on_init, int use_cpg, int use_ram);
+
+
+int __init sh_mobile_clk_register(struct sh_mobile_cpg_hw_cfg *h);
+
+#endif /* __CLOCK_SH_MOBILE_H__ */
--- 0001/arch/sh/kernel/cpu/shmobile/Makefile
+++ work/arch/sh/kernel/cpu/shmobile/Makefile	2009-05-20 22:03:57.000000000 +0900
@@ -3,4 +3,4 @@
 #
 
 # Power Management & Sleep mode
-obj-$(CONFIG_PM)	+= pm.o sleep.o
+obj-$(CONFIG_PM)	+= pm.o sleep.o clock.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/shmobile/clock.c	2009-05-20 22:03:57.000000000 +0900
@@ -0,0 +1,569 @@
+/*
+ * SuperH Mobile clock framework support
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/stringify.h>
+#include <cpu/clock-sh_mobile.h>
+#include <asm/clock.h>
+
+/* Fixed 32 KHz root clock for RTC and Power Management purposes */
+static struct clk r_clk = {
+	.name		= "rclk",
+	.id		= -1,
+	.rate		= 32768,
+};
+
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+struct clk extal_clk = {
+	.name		= "extal",
+	.id		= -1,
+	.rate		= 33333333,
+};
+
+static int check_n_m(struct sh_mobile_cpg_hw_cfg *fhcp,
+		     int n, int m, int prev_div, int this,
+		     struct sh_mobile_cpg_state *cs)
+{
+	int prev = cs->div_state[prev_div].selected;
+	int prev_value = (fhcp->divisors[prev] * n) / fhcp->multipliers[prev];
+	int this_value = (fhcp->divisors[this] * m) / fhcp->multipliers[this];
+	int last = SH_MOBILE_ALLOWED_NR - 1;
+
+	if (prev_value = this_value)
+		return 0;
+
+	if ((n > last) || (m > last))
+		return -2;
+
+	return -1;
+}
+
+int sh_mobile_div_check(struct sh_mobile_cpg_hw_cfg *fhcp, int prev_div,
+			int mode, int this,
+			struct sh_mobile_cpg_state *cs)
+{
+	int ret = -1;
+	int k;
+
+	switch (mode) {
+	case CLK_MODE_N_1:
+		for (k = 1; ret = -1; k++)
+			ret = check_n_m(fhcp, k, 1, prev_div, this, cs);
+		break;
+	case CLK_MODE_3_2:
+		ret = check_n_m(fhcp, 3, 2, prev_div, this, cs);
+		break;
+	case CLK_MODE_5_2:
+		ret = check_n_m(fhcp, 5, 2, prev_div, this, cs);
+		break;
+	case CLK_MODE_1_N:
+		for (k = 1; ret = -1; k++)
+			ret = check_n_m(fhcp, 1, k, prev_div, this, cs);
+		break;
+	case CLK_MODE_4_3:
+		ret = check_n_m(fhcp, 4, 3, prev_div, this, cs);
+		break;
+	case CLK_MODE_5_4:
+		ret = check_n_m(fhcp, 5, 4, prev_div, this, cs);
+		break;
+	case CLK_MODE_1_1:
+		ret = check_n_m(fhcp, 1, 1, prev_div, this, cs);
+		break;
+	case CLK_MODE_2_1:
+		ret = check_n_m(fhcp, 2, 1, prev_div, this, cs);
+		break;
+	case CLK_MODE_3_1:
+		ret = check_n_m(fhcp, 3, 1, prev_div, this, cs);
+		break;
+	case CLK_MODE_4_1:
+		ret = check_n_m(fhcp, 4, 1, prev_div, this, cs);
+		break;
+	default:
+		break;
+	}
+
+	if (ret >= 0)
+		ret = mode;
+
+	return ret;
+}
+
+struct sh_mobile_div_hw_cfg *sh_mobile_div(struct sh_mobile_cpg_hw_cfg *h,
+					   int nr, char *name, int div,
+					   int grp, unsigned long max_mhz)
+{
+	struct sh_mobile_div_hw_cfg *d;
+
+	BUG_ON(nr >= SH_MOBILE_DIVISOR_NR);
+
+	d = &h->div[nr];
+	d->name = name;
+	d->div = div;
+	d->grp = grp;
+	d->max_mhz = max_mhz;
+	return d;
+}
+
+void sh_mobile_div_ok(struct sh_mobile_div_hw_cfg *d, int bit)
+{
+	BUG_ON(bit >= SH_MOBILE_ALLOWED_NR);
+
+	__set_bit(bit, d->allowed);
+}
+
+void sh_mobile_div_ng(struct sh_mobile_div_hw_cfg *d, int bit)
+{
+	BUG_ON(bit >= SH_MOBILE_ALLOWED_NR);
+
+	__clear_bit(bit, d->allowed);
+}
+
+int sh_mobile_mstp(struct sh_mobile_cpg_hw_cfg *h,
+		   int nr, char *name, int parent,
+		   unsigned long reg, int bitnr,
+		   int enable_on_init, int use_cpg, int use_ram)
+{
+	struct sh_mobile_mstp_hw_cfg *d;
+
+	BUG_ON(nr >= SH_MOBILE_MSTP_NR);
+
+	d = &h->mstp[nr];
+	d->name = name;
+	d->parent = parent;
+	d->reg = reg;
+	d->bitnr = bitnr;
+	d->enable_on_init = enable_on_init;
+	d->use_cpg = use_cpg;
+	d->use_ram = use_ram;
+
+	return nr + 1;
+}
+
+
+static int div_str(struct sh_mobile_cpg_hw_cfg *h, int div,
+		   char *str, int n)
+{
+	return snprintf(str, n, "%d/%d",
+			h->multipliers[div],
+			h->divisors[div]);
+}
+
+#ifdef DEBUG
+
+static void printout_head_foot(struct sh_mobile_cpg_hw_cfg *fhcp,
+			       int grp, int foot,
+			       struct sh_mobile_cpg_state *cs)
+{
+	struct sh_mobile_div_hw_cfg *divp;
+	char *name;
+	char str[8];
+	int k, n;
+
+	if (foot) {
+		printk(KERN_INFO "\n%6s ", "min:");
+		for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+			divp = &fhcp->div[k];
+
+			if (divp->grp != grp)
+				continue;
+
+			n = cs->div_state[divp->div].forced_min;
+			if (n)
+				div_str(fhcp, n - 1, str, sizeof(str));
+			else
+				str[0] = '\0';
+
+			printk(KERN_INFO "%6s ", str);
+		}
+		printk(KERN_INFO "\n%6s ", "max:");
+		for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+			divp = &fhcp->div[k];
+
+			if (divp->grp != grp)
+				continue;
+
+			n = cs->div_state[divp->div].forced_max;
+			if (n)
+				div_str(fhcp, n - 1, str, sizeof(str));
+			else
+				str[0] = '\0';
+
+			printk(KERN_INFO "%6s ", str);
+		}
+		printk(KERN_INFO "\n");
+		return;
+	}
+
+	printk(KERN_INFO "%6s ", "");
+	for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+		divp = &fhcp->div[k];
+
+		if (divp->grp != grp)
+			continue;
+
+		name = divp->name ? divp->name : "?";
+
+		n = cs->div_state[divp->div].forced_min;
+		n |= cs->div_state[divp->div].forced_max;
+
+		if (n)
+			printk(KERN_INFO "%5s* ", name);
+		else
+			printk(KERN_INFO "%6s ", name);
+	}
+	printk(KERN_INFO "\n");
+
+}
+
+static int printout(struct sh_mobile_cpg_hw_cfg *fhcp, int grp,
+		    struct sh_mobile_cpg_state *cs)
+{
+	struct sh_mobile_div_hw_cfg *divp;
+	char str[8];
+	int k;
+
+	snprintf(str, sizeof(str), "%u:", cs->cnt);
+	printk(KERN_INFO "%6s ", str);
+	for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+		divp = &fhcp->div[k];
+
+		if (divp->grp != grp)
+			continue;
+
+		div_str(fhcp, cs->div_state[divp->div].selected,
+			str, sizeof(str));
+		printk(KERN_INFO "%6s ", str);
+	}
+	printk(KERN_INFO "\n");
+	cs->cnt++;
+	return 0;
+}
+
+#endif /* DEBUG */
+
+static int main(struct sh_mobile_cpg_hw_cfg *fhcp, int nr, int grp,
+		struct sh_mobile_cpg_state *cs,
+		int (*complete)(struct sh_mobile_cpg_hw_cfg *fhcp, int grp,
+				struct sh_mobile_cpg_state *cs))
+{
+	struct sh_mobile_div_hw_cfg *divp = &fhcp->div[nr];
+	struct sh_mobile_div_state *ds = &cs->div_state[divp->div];
+	unsigned long freq;
+	int ret;
+
+	if (nr = SH_MOBILE_DIVISOR_NR)
+		return complete(fhcp, grp, cs);
+
+	if (divp->grp != grp)
+		return main(fhcp, nr + 1, grp, cs, complete);
+
+	for (ds->cnt = 0; ds->cnt < SH_MOBILE_ALLOWED_NR; ds->cnt++) {
+		if (!test_bit(ds->cnt, divp->allowed))
+			continue;
+
+		if (ds->forced_min && (ds->cnt < (ds->forced_min - 1)))
+			continue;
+
+		if (ds->forced_max && (ds->cnt > (ds->forced_max - 1)))
+			continue;
+
+		ret = fhcp->check_div(fhcp, divp->div, ds->cnt, cs);
+		if (ret < 0)
+			continue;
+
+		freq = (extal_clk.rate * fhcp->pll_mult *
+			fhcp->multipliers[ds->cnt]) / fhcp->divisors[ds->cnt];
+
+		if (freq > (divp->max_mhz * 1000000))
+			continue;
+
+		ds->mode = ret;
+		ds->selected = ds->cnt;
+		ret = main(fhcp, nr + 1, grp, cs, complete);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void state_init(struct sh_mobile_cpg_state *cs)
+{
+	memset(cs, 0, sizeof(*cs));
+}
+
+static void state_fix(struct sh_mobile_cpg_state *cs, int div, int bit)
+{
+	cs->div_state[div].forced_min = bit + 1;
+	cs->div_state[div].forced_max = bit + 1;
+}
+
+static void state_dump(struct sh_mobile_cpg_hw_cfg *fhcp, int grp,
+		       struct sh_mobile_cpg_state *cs)
+{
+#ifdef DEBUG
+	cs->cnt = 0;
+	printout_head_foot(fhcp, grp, 0, cs);
+	main(fhcp, 0, grp, cs, printout);
+	printout_head_foot(fhcp, grp, 1, cs);
+#endif
+}
+
+static int note_best(struct sh_mobile_cpg_hw_cfg *fhcp, int grp,
+		     struct sh_mobile_cpg_state *cs)
+{
+	struct sh_mobile_div_hw_cfg *divp;
+	struct sh_mobile_div_state *ds;
+	int k;
+
+	for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+		divp = &fhcp->div[k];
+		ds = &cs->div_state[divp->div];
+
+		if (divp->grp != grp)
+			continue;
+
+		if (!ds->best || ((ds->selected + 1) < ds->best))
+			ds->best = ds->selected + 1;
+	}
+	cs->cnt++;
+	return 0;
+}
+
+int sh_mobile_div_optimize(struct sh_mobile_cpg_hw_cfg *fhcp, char *divisor)
+{
+	struct sh_mobile_cpg_state state;
+	char str[8];
+	int grp = 0, div = -1;
+	int k, n;
+
+	/* find divisor and group from string */
+	for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+		if (!strcmp(fhcp->div[k].name, divisor)) {
+			div = fhcp->div[k].div;
+			grp = fhcp->div[k].grp;
+		}
+	}
+
+	if (div = -1)
+		return -EINVAL;
+
+	/* locate the best divisor (highest frequency / lowest divisor) */
+	state_init(&state);
+	main(fhcp, 0, grp, &state, note_best);
+
+	n = -1;
+	for (k = 0; k < SH_MOBILE_DIVISOR_NR; k++) {
+		if (fhcp->div[k].div = div) {
+			n = state.div_state[fhcp->div[k].div].best;
+			break;
+		}
+	}
+
+	/* reinit and dump tables (if compiled-in) */
+	state_init(&state);
+	state_dump(fhcp, grp, &state);
+
+	if (!n)
+		return -ENOENT;
+
+	/* reinit and set optimized divisor to fixed */
+	state_init(&state);
+	state_fix(&state, div, n - 1);
+	div_str(fhcp, n - 1, str, sizeof(str));
+	pr_info("sh_mobile_cpg_optimize(): optimizing for %s [%s]\n",
+		fhcp->div[k].name, str);
+
+	/* generate all other divisors from this setting */
+	main(fhcp, 0, grp, &state, fhcp->set_div);
+	return 0;
+}
+
+static unsigned long sh_mobile_pll_recalc(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+
+	return clk->parent->rate * h->pll_mult;
+}
+
+static struct clk_ops sh_mobile_pll_ops = {
+	.recalc		= sh_mobile_pll_recalc,
+};
+
+static struct clk pll_clk = {
+	.name		= "pll",
+	.id		= -1,
+	.parent		= &extal_clk,
+	.ops		= &sh_mobile_pll_ops,
+};
+
+static struct clk div_clks[SH_MOBILE_DIVISOR_NR];
+static struct clk mstp_clks[SH_MOBILE_MSTP_NR];
+
+static unsigned long sh_mobile_div_recalc(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+	unsigned long value;
+	int div = clk - &div_clks[0];
+	int bit;
+
+	bit = h->get_div(h, div);
+
+	if (bit >= 0) {
+		value = (clk->parent->rate * h->multipliers[bit]);
+		value /= h->divisors[bit];
+	} else
+		value = 0;
+
+	pr_debug("%s has rate %lu (%d,%d)\n", clk->name, value, bit, div);
+
+	return value;
+}
+
+static int sh_mobile_div_enable(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+	int div = clk - &div_clks[0];
+
+	h->enable_disable(h, div, 1);
+	return 0;
+}
+
+static void sh_mobile_div_disable(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+	int div = clk - &div_clks[0];
+
+	h->enable_disable(h, div, 0);
+}
+
+static struct clk_ops sh_mobile_div_ops = {
+	.recalc		= sh_mobile_div_recalc,
+	.enable		= sh_mobile_div_enable,
+	.disable	= sh_mobile_div_disable,
+};
+
+static int sh_mobile_mstpcr_enable(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+	int mstp = clk - &mstp_clks[0];
+	unsigned long reg = h->mstp[mstp].reg;
+
+	__raw_writel(__raw_readl(reg) & ~(1 << h->mstp[mstp].bitnr), reg);
+	return 0;
+}
+
+static void sh_mobile_mstpcr_disable(struct clk *clk)
+{
+	struct sh_mobile_cpg_hw_cfg *h = clk->priv;
+	int mstp = clk - &mstp_clks[0];
+	unsigned long reg = h->mstp[mstp].reg;
+
+	__raw_writel(__raw_readl(reg) | (1 << h->mstp[mstp].bitnr), reg);
+}
+
+static struct clk_ops sh_mobile_mstp_ops = {
+	.enable		= sh_mobile_mstpcr_enable,
+	.disable	= sh_mobile_mstpcr_disable,
+	.recalc		= followparent_recalc,
+};
+
+int __init sh_mobile_clk_register(struct sh_mobile_cpg_hw_cfg *h)
+{
+	struct clk *clkp;
+	int k;
+	int ret;
+
+	ret = clk_register(&extal_clk);
+	if (ret < 0) {
+		pr_err("sh_mobile_clk_register: unable to register extal\n");
+		return ret;
+	}
+
+	pll_clk.priv = h;
+	ret = clk_register(&pll_clk);
+	if (ret < 0) {
+		pr_err("sh_mobile_clk_register: unable to register pll\n");
+		return ret;
+	}
+
+	ret = clk_register(&r_clk);
+	if (ret < 0) {
+		pr_err("sh_mobile_clk_register: unable to register rclk\n");
+		return ret;
+	}
+
+	for (k = 0; k < ARRAY_SIZE(div_clks); k++) {
+		clkp = &div_clks[k];
+
+		if (!h->div[k].name)
+			break;
+
+		clkp->name = h->div[k].name;
+		clkp->id = -1;
+		clkp->ops = &sh_mobile_div_ops;
+		clkp->parent = &pll_clk;
+		clkp->priv = h;
+
+		ret = clk_register(clkp);
+		if (ret < 0) {
+			pr_err("sh_mobile_clk_register: unable to register "
+			       "divisor clock\n");
+			return ret;
+		}
+	}
+
+	for (k = 0; k < ARRAY_SIZE(mstp_clks); k++) {
+		clkp = &mstp_clks[k];
+
+		if (!h->mstp[k].name)
+			break;
+
+		clkp->name = h->mstp[k].name;
+		clkp->id = -1;
+		clkp->ops = &sh_mobile_mstp_ops;
+
+		if (!h->mstp[k].use_cpg)
+			clkp->parent = &r_clk;
+		else
+			clkp->parent = &div_clks[h->mstp[k].parent];
+
+		if (h->mstp[k].enable_on_init)
+			clkp->flags = CLK_ENABLE_ON_INIT;
+
+		clkp->priv = h;
+
+		ret = clk_register(clkp);
+		if (ret < 0) {
+			pr_err("sh_mobile_clk_register: unable to register "
+			       "mstp clock\n");
+			return ret;
+		}
+	}
+#ifndef CONFIG_SERIAL_CORE_CONSOLE
+	if (sh_mobile_div_optimize(h, "cpu_clk"))
+		panic("sh_mobile_clk_register(): unable to setup clocks\n");
+#endif
+	return ret;
+}
