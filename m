From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 07:37:59 +0000
Subject: [PATCH] sh: sh7722 clock framework rewrite
Message-Id: <20090604073759.32257.98080.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch rewrites the sh7722 clock framework code.
The new code makes use of the recently merged div4,
div6 and mstp32 helper code. Both extal and dll are
supported as input clocks to the pll.

While at it, now when all SuperH Mobile processors
are converted, fix CONFIG_SH_CLK_CPG_LEGACY to depend
on CONFIG_ARCH_SHMOBILE.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |  830 +++++---------------------------
 2 files changed, 155 insertions(+), 677 deletions(-)

--- 0015/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-06-04 13:32:10.000000000 +0900
@@ -516,7 +516,7 @@ config SH_CLK_CPG
 
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
-	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724 && !CPU_SUBTYPE_SH7343 && !CPU_SUBTYPE_SH7366
+	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0015/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-06-04 13:35:58.000000000 +0900
@@ -1,719 +1,197 @@
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
- * SH7722 support for the clock framework
+ * SH7722 clock framework support
  *
- * Copyright (c) 2006-2007 Nomad Global Solutions Inc
- * Based on code for sh7343 by Paul Mundt
+ * Copyright (C) 2009 Magnus Damm
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
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
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/errno.h>
-#include <linux/stringify.h>
 #include <asm/clock.h>
-#include <asm/freq.h>
 
-#define N  (-1)
-#define NM (-2)
-#define ROUND_NEAREST 0
-#define ROUND_DOWN -1
-#define ROUND_UP   +1
-
-static int adjust_algos[][3] = {
-	{},	/* NO_CHANGE */
-	{ NM, N, 1 },   /* N:1, N:1 */
-	{ 3, 2, 2 },	/* 3:2:2 */
-	{ 5, 2, 2 },    /* 5:2:2 */
-	{ N, 1, 1 },	/* N:1:1 */
-
-	{ N, 1 },	/* N:1 */
-
-	{ N, 1 },	/* N:1 */
-	{ 3, 2 },
-	{ 4, 3 },
-	{ 5, 4 },
-
-	{ N, 1 }
+/* SH7722 registers */
+#define FRQCR		0xa4150000
+#define VCLKCR		0xa4150004
+#define SCLKACR		0xa4150008
+#define SCLKBCR		0xa415000c
+#define IRDACLKCR	0xa4150018
+#define PLLCR		0xa4150024
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
+#define DLLFRQ		0xa4150050
+
+/* Fixed 32 KHz root clock for RTC and Power Management purposes */
+static struct clk r_clk = {
+	.name           = "rclk",
+	.id             = -1,
+	.rate           = 32768,
 };
 
-static unsigned long adjust_pair_of_clocks(unsigned long r1, unsigned long r2,
-			int m1, int m2, int round_flag)
-{
-	unsigned long rem, div;
-	int the_one = 0;
-
-	pr_debug( "Actual values: r1 = %ld\n", r1);
-	pr_debug( "...............r2 = %ld\n", r2);
-
-	if (m1 = m2) {
-		r2 = r1;
-		pr_debug( "setting equal rates: r2 now %ld\n", r2);
-	} else if ((m2 = N  && m1 = 1) ||
-		   (m2 = NM && m1 = N)) { /* N:1 or NM:N */
-		pr_debug( "Setting rates as 1:N (N:N*M)\n");
-		rem = r2 % r1;
-		pr_debug( "...remainder = %ld\n", rem);
-		if (rem) {
-			div = r2 / r1;
-			pr_debug( "...div = %ld\n", div);
-			switch (round_flag) {
-			case ROUND_NEAREST:
-				the_one = rem >= r1/2 ? 1 : 0; break;
-			case ROUND_UP:
-				the_one = 1; break;
-			case ROUND_DOWN:
-				the_one = 0; break;
-			}
-
-			r2 = r1 * (div + the_one);
-			pr_debug( "...setting r2 to %ld\n", r2);
-		}
-	} else if ((m2 = 1  && m1 = N) ||
-		   (m2 = N && m1 = NM)) { /* 1:N or N:NM */
-		pr_debug( "Setting rates as N:1 (N*M:N)\n");
-		rem = r1 % r2;
-		pr_debug( "...remainder = %ld\n", rem);
-		if (rem) {
-			div = r1 / r2;
-			pr_debug( "...div = %ld\n", div);
-			switch (round_flag) {
-			case ROUND_NEAREST:
-				the_one = rem > r2/2 ? 1 : 0; break;
-			case ROUND_UP:
-				the_one = 0; break;
-			case ROUND_DOWN:
-				the_one = 1; break;
-			}
-
-			r2 = r1 / (div + the_one);
-			pr_debug( "...setting r2 to %ld\n", r2);
-		}
-	} else { /* value:value */
-		pr_debug( "Setting rates as %d:%d\n", m1, m2);
-		div = r1 / m1;
-		r2 = div * m2;
-		pr_debug( "...div = %ld\n", div);
-		pr_debug( "...setting r2 to %ld\n", r2);
-	}
-
-	return r2;
-}
-
-static void adjust_clocks(int originate, int *l, unsigned long v[],
-			  int n_in_line)
-{
-	int x;
-
-	pr_debug( "Go down from %d...\n", originate);
-	/* go up recalculation clocks */
-	for (x = originate; x>0; x -- )
-		v[x-1] = adjust_pair_of_clocks(v[x], v[x-1],
-					l[x], l[x-1],
-					ROUND_UP);
-
-	pr_debug( "Go up from %d...\n", originate);
-	/* go down recalculation clocks */
-	for (x = originate; x<n_in_line - 1; x ++ )
-		v[x+1] = adjust_pair_of_clocks(v[x], v[x+1],
-					l[x], l[x+1],
-					ROUND_UP);
-}
-
-
 /*
- * SH7722 uses a common set of multipliers and divisors, so this
- * is quite simple..
- */
-
-#define STCPLL(frqcr) (((frqcr >> 24) & 0x1f) + 1)
-
-/*
- * Instead of having two separate multipliers/divisors set, like this:
- *
- * static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
- * static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
- *
- * I created the divisors2 array, which is used to calculate rate like
- *   rate = parent * 2 / divisors2[ divisor ];
-*/
-static int divisors2[] = { 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 24, 32, 40 };
-
-static unsigned long master_clk_recalc(struct clk *clk)
-{
-	unsigned frqcr = ctrl_inl(FRQCR);
-
-	return CONFIG_SH_PCLK_FREQ * STCPLL(frqcr);
-}
-
-static void master_clk_init(struct clk *clk)
-{
-	clk->parent = NULL;
-	clk->rate = master_clk_recalc(clk);
-}
-
-static unsigned long module_clk_recalc(struct clk *clk)
-{
-	unsigned long frqcr = ctrl_inl(FRQCR);
-
-	return clk->parent->rate / STCPLL(frqcr);
-}
-
-#define MASTERDIVS	{ 2, 3, 4, 6, 8, 16 }
-#define STCMASK		0x1f
-#define DIVCALC(div)	(div-1)
-#define FRQCRKICK	0x00000000
-
-static int master_clk_setrate(struct clk *clk, unsigned long rate, int id)
-{
-	int div = rate / clk->rate;
-	int master_divs[] = MASTERDIVS;
-	int index;
-	unsigned long frqcr;
-
-	for (index = 1; index < ARRAY_SIZE(master_divs); index++)
-		if (div >= master_divs[index - 1] && div < master_divs[index])
-			break;
-
-	if (index >= ARRAY_SIZE(master_divs))
-		index = ARRAY_SIZE(master_divs);
-	div = master_divs[index - 1];
-
-	frqcr = ctrl_inl(FRQCR);
-	frqcr &= ~(STCMASK << 24);
-	frqcr |= (DIVCALC(div) << 24);
-	frqcr |= FRQCRKICK;
-	ctrl_outl(frqcr, FRQCR);
-
-	return 0;
-}
-
-static struct clk_ops sh7722_master_clk_ops = {
-	.init = master_clk_init,
-	.recalc = master_clk_recalc,
-	.set_rate = master_clk_setrate,
-};
-
-static struct clk_ops sh7722_module_clk_ops = {
-       .recalc = module_clk_recalc,
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+struct clk extal_clk = {
+	.name		= "extal",
+	.id		= -1,
+	.rate		= 33333333,
 };
 
-struct frqcr_context {
-	unsigned mask;
-	unsigned shift;
-};
-
-struct frqcr_context sh7722_get_clk_context(const char *name)
-{
-	struct frqcr_context ctx = { 0, };
-
-	if (!strcmp(name, "peripheral_clk")) {
-		ctx.shift = 0;
-		ctx.mask = 0xF;
-	} else if (!strcmp(name, "sdram_clk")) {
-		ctx.shift = 4;
-		ctx.mask = 0xF;
-	} else if (!strcmp(name, "bus_clk")) {
-		ctx.shift = 8;
-		ctx.mask = 0xF;
-	} else if (!strcmp(name, "sh_clk")) {
-		ctx.shift = 12;
-		ctx.mask = 0xF;
-	} else if (!strcmp(name, "umem_clk")) {
-		ctx.shift = 16;
-		ctx.mask = 0xF;
-	} else if (!strcmp(name, "cpu_clk")) {
-		ctx.shift = 20;
-		ctx.mask = 7;
-	}
-	return ctx;
-}
-
-/**
- * sh7722_find_div_index - find divisor for setting rate
- *
- * All sh7722 clocks use the same set of multipliers/divisors. This function
- * chooses correct divisor to set the rate of clock with parent clock that
- * generates frequency of 'parent_rate'
- *
- * @parent_rate: rate of parent clock
- * @rate: requested rate to be set
- */
-static int sh7722_find_div_index(unsigned long parent_rate, unsigned rate)
-{
-	unsigned div2 = parent_rate * 2 / rate;
-	int index;
-
-	if (rate > parent_rate)
-		return -EINVAL;
-
-	for (index = 1; index < ARRAY_SIZE(divisors2); index++) {
-		if (div2 > divisors2[index - 1] && div2 <= divisors2[index])
-			break;
-	}
-	if (index >= ARRAY_SIZE(divisors2))
-		index = ARRAY_SIZE(divisors2) - 1;
-	return index;
-}
-
-static unsigned long sh7722_frqcr_recalc(struct clk *clk)
-{
-	struct frqcr_context ctx = sh7722_get_clk_context(clk->name);
-	unsigned long frqcr = ctrl_inl(FRQCR);
-	int index;
-
-	index = (frqcr >> ctx.shift) & ctx.mask;
-	return clk->parent->rate * 2 / divisors2[index];
-}
-
-static int sh7722_frqcr_set_rate(struct clk *clk, unsigned long rate,
-				 int algo_id)
-{
-	struct frqcr_context ctx = sh7722_get_clk_context(clk->name);
-	unsigned long parent_rate = clk->parent->rate;
-	int div;
-	unsigned long frqcr;
-	int err = 0;
-
-	/* pretty invalid */
-	if (parent_rate < rate)
-		return -EINVAL;
-
-	/* look for multiplier/divisor pair */
-	div = sh7722_find_div_index(parent_rate, rate);
-	if (div<0)
-		return div;
-
-	/* calculate new value of clock rate */
-	clk->rate = parent_rate * 2 / divisors2[div];
-	frqcr = ctrl_inl(FRQCR);
-
-	/* FIXME: adjust as algo_id specifies */
-	if (algo_id != NO_CHANGE) {
-		int originator;
-		char *algo_group_1[] = { "cpu_clk", "umem_clk", "sh_clk" };
-		char *algo_group_2[] = { "sh_clk", "bus_clk" };
-		char *algo_group_3[] = { "sh_clk", "sdram_clk" };
-		char *algo_group_4[] = { "bus_clk", "peripheral_clk" };
-		char *algo_group_5[] = { "cpu_clk", "peripheral_clk" };
-		char **algo_current = NULL;
-		/* 3 is the maximum number of clocks in relation */
-		struct clk *ck[3];
-		unsigned long values[3]; /* the same comment as above */
-		int part_length = -1;
-		int i;
-
-		/*
-		 * all the steps below only required if adjustion was
-		 * requested
-		 */
-		if (algo_id = IUS_N1_N1 ||
-		    algo_id = IUS_322 ||
-		    algo_id = IUS_522 ||
-		    algo_id = IUS_N11) {
-			algo_current = algo_group_1;
-			part_length = 3;
-		}
-		if (algo_id = SB_N1) {
-			algo_current = algo_group_2;
-			part_length = 2;
-		}
-		if (algo_id = SB3_N1 ||
-		    algo_id = SB3_32 ||
-		    algo_id = SB3_43 ||
-		    algo_id = SB3_54) {
-			algo_current = algo_group_3;
-			part_length = 2;
-		}
-		if (algo_id = BP_N1) {
-			algo_current = algo_group_4;
-			part_length = 2;
-		}
-		if (algo_id = IP_N1) {
-			algo_current = algo_group_5;
-			part_length = 2;
-		}
-		if (!algo_current)
-			goto incorrect_algo_id;
-
-		originator = -1;
-		for (i = 0; i < part_length; i ++ ) {
-			if (originator >= 0 && !strcmp(clk->name,
-						       algo_current[i]))
-				originator = i;
-			ck[i] = clk_get(NULL, algo_current[i]);
-			values[i] = clk_get_rate(ck[i]);
-		}
-
-		if (originator >= 0)
-			adjust_clocks(originator, adjust_algos[algo_id],
-				      values, part_length);
-
-		for (i = 0; i < part_length; i ++ ) {
-			struct frqcr_context part_ctx;
-			int part_div;
-
-			if (likely(!err)) {
-				part_div = sh7722_find_div_index(parent_rate,
-								rate);
-				if (part_div > 0) {
-					part_ctx = sh7722_get_clk_context(
-								ck[i]->name);
-					frqcr &= ~(part_ctx.mask <<
-						   part_ctx.shift);
-					frqcr |= part_div << part_ctx.shift;
-				} else
-					err = part_div;
-			}
-
-			ck[i]->ops->recalc(ck[i]);
-			clk_put(ck[i]);
-		}
-	}
-
-	/* was there any error during recalculation ? If so, bail out.. */
-	if (unlikely(err!=0))
-		goto out_err;
-
-	/* clear FRQCR bits */
-	frqcr &= ~(ctx.mask << ctx.shift);
-	frqcr |= div << ctx.shift;
-	frqcr |= FRQCRKICK;
-
-	/* ...and perform actual change */
-	ctrl_outl(frqcr, FRQCR);
-	return 0;
-
-incorrect_algo_id:
-	return -EINVAL;
-out_err:
-	return err;
-}
-
-static long sh7722_frqcr_round_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent_rate = clk->parent->rate;
-	int div;
-
-	/* look for multiplier/divisor pair */
-	div = sh7722_find_div_index(parent_rate, rate);
-	if (div < 0)
-		return clk->rate;
-
-	/* calculate new value of clock rate */
-	return parent_rate * 2 / divisors2[div];
-}
-
-static struct clk_ops sh7722_frqcr_clk_ops = {
-	.recalc = sh7722_frqcr_recalc,
-	.set_rate = sh7722_frqcr_set_rate,
-	.round_rate = sh7722_frqcr_round_rate,
-};
-
-/*
- * clock ops methods for SIU A/B and IrDA clock
- */
-static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
-{
-	unsigned long r;
-	int div;
-
-	r = ctrl_inl(clk->arch_flags);
-	div = sh7722_find_div_index(clk->parent->rate, rate);
-	if (div < 0)
-		return div;
-	r = (r & ~0xF) | div;
-	ctrl_outl(r, clk->arch_flags);
-	return 0;
-}
-
-static unsigned long sh7722_siu_recalc(struct clk *clk)
+/* The dll block multiplies the 32khz r_clk, may be used instead of extal */
+static unsigned long dll_recalc(struct clk *clk)
 {
-	unsigned long r;
+	unsigned long mult;
 
-	r = ctrl_inl(clk->arch_flags);
-	return clk->parent->rate * 2 / divisors2[r & 0xF];
-}
-
-static int sh7722_siu_start_stop(struct clk *clk, int enable)
-{
-	unsigned long r;
-
-	r = ctrl_inl(clk->arch_flags);
-	if (enable)
-		ctrl_outl(r & ~(1 << 8), clk->arch_flags);
+	if (__raw_readl(PLLCR) & 0x1000)
+		mult = __raw_readl(DLLFRQ);
 	else
-		ctrl_outl(r | (1 << 8), clk->arch_flags);
-	return 0;
-}
+		mult = 0;
 
-static int sh7722_siu_enable(struct clk *clk)
-{
-	return sh7722_siu_start_stop(clk, 1);
+	return clk->parent->rate * mult;
 }
 
-static void sh7722_siu_disable(struct clk *clk)
-{
-	sh7722_siu_start_stop(clk, 0);
-}
-
-static struct clk_ops sh7722_siu_clk_ops = {
-	.recalc = sh7722_siu_recalc,
-	.set_rate = sh7722_siu_set_rate,
-	.enable = sh7722_siu_enable,
-	.disable = sh7722_siu_disable,
-};
-
-static int sh7722_video_enable(struct clk *clk)
-{
-	unsigned long r;
-
-	r = ctrl_inl(VCLKCR);
-	ctrl_outl( r & ~(1<<8), VCLKCR);
-	return 0;
-}
-
-static void sh7722_video_disable(struct clk *clk)
-{
-	unsigned long r;
-
-	r = ctrl_inl(VCLKCR);
-	ctrl_outl( r | (1<<8), VCLKCR);
-}
-
-static int sh7722_video_set_rate(struct clk *clk, unsigned long rate,
-				 int algo_id)
-{
-	unsigned long r;
-
-	r = ctrl_inl(VCLKCR);
-	r &= ~0x3F;
-	r |= ((clk->parent->rate / rate - 1) & 0x3F);
-	ctrl_outl(r, VCLKCR);
-	return 0;
-}
-
-static unsigned long sh7722_video_recalc(struct clk *clk)
-{
-	unsigned long r;
-
-	r = ctrl_inl(VCLKCR);
-	return clk->parent->rate / ((r & 0x3F) + 1);
-}
-
-static struct clk_ops sh7722_video_clk_ops = {
-	.recalc = sh7722_video_recalc,
-	.set_rate = sh7722_video_set_rate,
-	.enable = sh7722_video_enable,
-	.disable = sh7722_video_disable,
-};
-/*
- * and at last, clock definitions themselves
- */
-static struct clk sh7722_umem_clock = {
-	.name = "umem_clk",
-	.ops = &sh7722_frqcr_clk_ops,
-};
-
-static struct clk sh7722_sh_clock = {
-	.name = "sh_clk",
-	.ops = &sh7722_frqcr_clk_ops,
-};
-
-static struct clk sh7722_peripheral_clock = {
-	.name = "peripheral_clk",
-	.ops = &sh7722_frqcr_clk_ops,
-};
-
-static struct clk sh7722_sdram_clock = {
-	.name = "sdram_clk",
-	.ops = &sh7722_frqcr_clk_ops,
-};
-
-static struct clk sh7722_r_clock = {
-	.name = "r_clk",
-	.rate = 32768,
-};
-
-/*
- * these three clocks - SIU A, SIU B, IrDA - share the same clk_ops
- * methods of clk_ops determine which register they should access by
- * examining clk->name field
- */
-static struct clk sh7722_siu_a_clock = {
-	.name = "siu_a_clk",
-	.arch_flags = SCLKACR,
-	.ops = &sh7722_siu_clk_ops,
+static struct clk_ops dll_clk_ops = {
+	.recalc		= dll_recalc,
 };
 
-static struct clk sh7722_siu_b_clock = {
-	.name = "siu_b_clk",
-	.arch_flags = SCLKBCR,
-	.ops = &sh7722_siu_clk_ops,
+static struct clk dll_clk = {
+	.name           = "dll_clk",
+	.id             = -1,
+	.ops		= &dll_clk_ops,
+	.parent		= &r_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
 };
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7722)
-static struct clk sh7722_irda_clock = {
-	.name = "irda_clk",
-	.arch_flags = IrDACLKCR,
-	.ops = &sh7722_siu_clk_ops,
-};
-#endif
-
-static struct clk sh7722_video_clock = {
-	.name = "video_clk",
-	.ops = &sh7722_video_clk_ops,
-};
-
-#define MSTPCR_ARCH_FLAGS(reg, bit) (((reg) << 8) | (bit))
-#define MSTPCR_ARCH_FLAGS_REG(value) ((value) >> 8)
-#define MSTPCR_ARCH_FLAGS_BIT(value) ((value) & 0xff)
-
-static int sh7722_mstpcr_start_stop(struct clk *clk, int enable)
+static unsigned long pll_recalc(struct clk *clk)
 {
-	unsigned long bit = MSTPCR_ARCH_FLAGS_BIT(clk->arch_flags);
-	unsigned long reg;
-	unsigned long r;
-
-	switch(MSTPCR_ARCH_FLAGS_REG(clk->arch_flags)) {
-	case 0:
-		reg = MSTPCR0;
-		break;
-	case 1:
-		reg = MSTPCR1;
-		break;
-	case 2:
-		reg = MSTPCR2;
-		break;
-	default:
-		return -EINVAL;
-	}
+	unsigned long mult = 1;
+	unsigned long div = 1;
 
-	r = ctrl_inl(reg);
-
-	if (enable)
-		r &= ~(1 << bit);
+	if (__raw_readl(PLLCR) & 0x4000)
+		mult = (((__raw_readl(FRQCR) >> 24) & 0x1f) + 1);
 	else
-		r |= (1 << bit);
+		div = 2;
 
-	ctrl_outl(r, reg);
-	return 0;
+	return (clk->parent->rate * mult) / div;
 }
 
-static int sh7722_mstpcr_enable(struct clk *clk)
-{
-	return sh7722_mstpcr_start_stop(clk, 1);
-}
-
-static void sh7722_mstpcr_disable(struct clk *clk)
-{
-	sh7722_mstpcr_start_stop(clk, 0);
-}
-
-static struct clk_ops sh7722_mstpcr_clk_ops = {
-	.enable = sh7722_mstpcr_enable,
-	.disable = sh7722_mstpcr_disable,
-	.recalc = followparent_recalc,
+static struct clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
 };
 
-#define MSTPCR(_name, _parent, regnr, bitnr, _flags) \
-{						\
-	.name = _name,				\
-	.flags = _flags,			\
-	.arch_flags = MSTPCR_ARCH_FLAGS(regnr, bitnr),	\
-	.ops = (void *)_parent,		\
-}
-
-static struct clk sh7722_mstpcr_clocks[] = {
-#if defined(CONFIG_CPU_SUBTYPE_SH7722)
-	MSTPCR("uram0", "umem_clk", 0, 28, CLK_ENABLE_ON_INIT),
-	MSTPCR("xymem0", "bus_clk", 0, 26, CLK_ENABLE_ON_INIT),
-	MSTPCR("tmu0", "peripheral_clk", 0, 15, 0),
-	MSTPCR("cmt0", "r_clk", 0, 14, 0),
-	MSTPCR("rwdt0", "r_clk", 0, 13, 0),
-	MSTPCR("flctl0", "peripheral_clk", 0, 10, 0),
-	MSTPCR("scif0", "peripheral_clk", 0, 7, 0),
-	MSTPCR("scif1", "peripheral_clk", 0, 6, 0),
-	MSTPCR("scif2", "peripheral_clk", 0, 5, 0),
-	MSTPCR("i2c0", "peripheral_clk", 1, 9, 0),
-	MSTPCR("rtc0", "r_clk", 1, 8, 0),
-	MSTPCR("sdhi0", "peripheral_clk", 2, 18, 0),
-	MSTPCR("keysc0", "r_clk", 2, 14, 0),
-	MSTPCR("usbf0", "peripheral_clk", 2, 11, 0),
-	MSTPCR("2dg0", "bus_clk", 2, 9, 0),
-	MSTPCR("siu0", "bus_clk", 2, 8, 0),
-	MSTPCR("vou0", "bus_clk", 2, 5, 0),
-	MSTPCR("jpu0", "bus_clk", 2, 6, CLK_ENABLE_ON_INIT),
-	MSTPCR("beu0", "bus_clk", 2, 4, 0),
-	MSTPCR("ceu0", "bus_clk", 2, 3, 0),
-	MSTPCR("veu0", "bus_clk", 2, 2, CLK_ENABLE_ON_INIT),
-	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
-	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
-#endif
-};
-
-static struct clk *sh7722_clocks[] = {
-	&sh7722_umem_clock,
-	&sh7722_sh_clock,
-	&sh7722_peripheral_clock,
-	&sh7722_sdram_clock,
-	&sh7722_siu_a_clock,
-	&sh7722_siu_b_clock,
-#if defined(CONFIG_CPU_SUBTYPE_SH7722)
-	&sh7722_irda_clock,
-#endif
-	&sh7722_video_clock,
+static struct clk pll_clk = {
+	.name		= "pll_clk",
+	.id		= -1,
+	.ops		= &pll_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+struct clk *main_clks[] = {
+	&r_clk,
+	&extal_clk,
+	&dll_clk,
+	&pll_clk,
+};
+
+static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
+static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
+
+static struct clk_div_mult_table div4_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+	.multipliers = multipliers,
+	.nr_multipliers = ARRAY_SIZE(multipliers),
+};
+
+enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
+       DIV4_SIUA, DIV4_SIUB, DIV4_IRDA, DIV4_NR };
+
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
+	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
+	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
+	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x1fff, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+};
+
+#define MSTP(_str, _parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[] = {
+	MSTP("uram0", &div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	MSTP("tmu0", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	MSTP("cmt0", &r_clk, MSTPCR0, 14, 0),
+	MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
+	MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	MSTP("scif0", &div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	MSTP("scif1", &div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	MSTP("scif2", &div4_clks[DIV4_P], MSTPCR0, 5, 0),
+
+	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	MSTP("rtc0", &r_clk, MSTPCR1, 8, 0),
+
+	MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	MSTP("keysc0", &r_clk, MSTPCR2, 14, 0),
+	MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	MSTP("2dg0", &div4_clks[DIV4_B], MSTPCR2, 9, 0),
+	MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 8, 0),
+	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
+	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
-/*
- * init in order: master, module, bus, cpu
- */
-struct clk_ops *onchip_ops[] = {
-	&sh7722_master_clk_ops,
-	&sh7722_module_clk_ops,
-	&sh7722_frqcr_clk_ops,
-	&sh7722_frqcr_clk_ops,
-};
-
-void __init
-arch_init_clk_ops(struct clk_ops **ops, int type)
-{
-	BUG_ON(type < 0 || type >= ARRAY_SIZE(onchip_ops));
-	*ops = onchip_ops[type];
-}
-
 int __init arch_clk_init(void)
 {
-	struct clk *clk;
-	int i;
+	int k, ret = 0;
+
+	/* autodetect extal or dll configuration */
+	if (__raw_readl(PLLCR) & 0x1000)
+		pll_clk.parent = &dll_clk;
+	else
+		pll_clk.parent = &extal_clk;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
 
-	cpg_clk_init();
+	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
-	clk = clk_get(NULL, "master_clk");
-	for (i = 0; i < ARRAY_SIZE(sh7722_clocks); i++) {
-		pr_debug( "Registering clock '%s'\n", sh7722_clocks[i]->name);
-		sh7722_clocks[i]->parent = clk;
-		clk_register(sh7722_clocks[i]);
-	}
-	clk_put(clk);
-
-	clk_register(&sh7722_r_clock);
-
-	for (i = 0; i < ARRAY_SIZE(sh7722_mstpcr_clocks); i++) {
-		pr_debug( "Registering mstpcr clock '%s'\n",
-			  sh7722_mstpcr_clocks[i].name);
-		clk = clk_get(NULL, (void *) sh7722_mstpcr_clocks[i].ops);
-		sh7722_mstpcr_clocks[i].parent = clk;
-		sh7722_mstpcr_clocks[i].ops = &sh7722_mstpcr_clk_ops;
-		clk_register(&sh7722_mstpcr_clocks[i]);
-		clk_put(clk);
-	}
+	if (!ret)
+		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
-	propagate_rate(&sh7722_r_clock); /* make sure rate gets propagated */
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
 
-	return 0;
+	return ret;
 }
