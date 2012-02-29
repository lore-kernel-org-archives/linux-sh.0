From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:55 +0000
Subject: [PATCH 14/17] sh: sh4a sh_clk_ops rename
Message-Id: <20120229131755.29154.56752.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh4a SoCs to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    2 +-
 12 files changed, 35 insertions(+), 35 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2012-02-29 20:12:51.000000000 +0900
@@ -61,7 +61,7 @@ static unsigned long dll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops dll_clk_ops = {
+static struct sh_clk_ops dll_clk_ops = {
 	.recalc		= dll_recalc,
 };
 
@@ -81,7 +81,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2012-02-29 20:17:49.000000000 +0900
@@ -61,7 +61,7 @@ static unsigned long dll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops dll_clk_ops = {
+static struct sh_clk_ops dll_clk_ops = {
 	.recalc		= dll_recalc,
 };
 
@@ -84,7 +84,7 @@ static unsigned long pll_recalc(struct c
 	return (clk->parent->rate * mult) / div;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2012-02-29 20:17:14.000000000 +0900
@@ -64,7 +64,7 @@ static unsigned long dll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops dll_clk_ops = {
+static struct sh_clk_ops dll_clk_ops = {
 	.recalc		= dll_recalc,
 };
 
@@ -87,7 +87,7 @@ static unsigned long pll_recalc(struct c
 	return (clk->parent->rate * mult) / div;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2012-02-29 20:14:24.000000000 +0900
@@ -65,7 +65,7 @@ static unsigned long dll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops dll_clk_ops = {
+static struct sh_clk_ops dll_clk_ops = {
 	.recalc		= dll_recalc,
 };
 
@@ -88,7 +88,7 @@ static unsigned long pll_recalc(struct c
 	return (clk->parent->rate * mult) / div;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2012-02-29 20:10:48.000000000 +0900
@@ -70,7 +70,7 @@ static unsigned long fll_recalc(struct c
 	return (clk->parent->rate * mult) / div;
 }
 
-static struct clk_ops fll_clk_ops = {
+static struct sh_clk_ops fll_clk_ops = {
 	.recalc		= fll_recalc,
 };
 
@@ -90,7 +90,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
@@ -105,7 +105,7 @@ static unsigned long div3_recalc(struct
 	return clk->parent->rate / 3;
 }
 
-static struct clk_ops div3_clk_ops = {
+static struct sh_clk_ops div3_clk_ops = {
 	.recalc		= div3_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7757.c	2012-02-29 20:18:07.000000000 +0900
@@ -33,7 +33,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * multiplier;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7763.c	2012-02-29 20:23:19.000000000 +0900
@@ -27,7 +27,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= p0fc_divisors[(__raw_readl(FRQCR) >> 4) & 0x07];
 }
 
-static struct clk_ops sh7763_master_clk_ops = {
+static struct sh_clk_ops sh7763_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -37,7 +37,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / p0fc_divisors[idx];
 }
 
-static struct clk_ops sh7763_module_clk_ops = {
+static struct sh_clk_ops sh7763_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -47,22 +47,22 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / bfc_divisors[idx];
 }
 
-static struct clk_ops sh7763_bus_clk_ops = {
+static struct sh_clk_ops sh7763_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
-static struct clk_ops sh7763_cpu_clk_ops = {
+static struct sh_clk_ops sh7763_cpu_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
-static struct clk_ops *sh7763_clk_ops[] = {
+static struct sh_clk_ops *sh7763_clk_ops[] = {
 	&sh7763_master_clk_ops,
 	&sh7763_module_clk_ops,
 	&sh7763_bus_clk_ops,
 	&sh7763_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7763_clk_ops))
 		*ops = sh7763_clk_ops[idx];
@@ -74,7 +74,7 @@ static unsigned long shyway_clk_recalc(s
 	return clk->parent->rate / cfc_divisors[idx];
 }
 
-static struct clk_ops sh7763_shyway_clk_ops = {
+static struct sh_clk_ops sh7763_shyway_clk_ops = {
 	.recalc		= shyway_clk_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7770.c	2012-02-29 20:23:50.000000000 +0900
@@ -24,7 +24,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[(__raw_readl(FRQCR) >> 28) & 0x000f];
 }
 
-static struct clk_ops sh7770_master_clk_ops = {
+static struct sh_clk_ops sh7770_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -34,7 +34,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7770_module_clk_ops = {
+static struct sh_clk_ops sh7770_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -44,7 +44,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / bfc_divisors[idx];
 }
 
-static struct clk_ops sh7770_bus_clk_ops = {
+static struct sh_clk_ops sh7770_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -54,18 +54,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7770_cpu_clk_ops = {
+static struct sh_clk_ops sh7770_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7770_clk_ops[] = {
+static struct sh_clk_ops *sh7770_clk_ops[] = {
 	&sh7770_master_clk_ops,
 	&sh7770_module_clk_ops,
 	&sh7770_bus_clk_ops,
 	&sh7770_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7770_clk_ops))
 		*ops = sh7770_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7780.c	2012-02-29 20:24:36.000000000 +0900
@@ -27,7 +27,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[__raw_readl(FRQCR) & 0x0003];
 }
 
-static struct clk_ops sh7780_master_clk_ops = {
+static struct sh_clk_ops sh7780_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -37,7 +37,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7780_module_clk_ops = {
+static struct sh_clk_ops sh7780_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -47,7 +47,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / bfc_divisors[idx];
 }
 
-static struct clk_ops sh7780_bus_clk_ops = {
+static struct sh_clk_ops sh7780_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -57,18 +57,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7780_cpu_clk_ops = {
+static struct sh_clk_ops sh7780_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7780_clk_ops[] = {
+static struct sh_clk_ops *sh7780_clk_ops[] = {
 	&sh7780_master_clk_ops,
 	&sh7780_module_clk_ops,
 	&sh7780_bus_clk_ops,
 	&sh7780_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7780_clk_ops))
 		*ops = sh7780_clk_ops[idx];
@@ -80,7 +80,7 @@ static unsigned long shyway_clk_recalc(s
 	return clk->parent->rate / cfc_divisors[idx];
 }
 
-static struct clk_ops sh7780_shyway_clk_ops = {
+static struct sh_clk_ops sh7780_shyway_clk_ops = {
 	.recalc		= shyway_clk_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2012-02-29 20:26:08.000000000 +0900
@@ -36,7 +36,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * multiplier;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2012-02-29 20:27:05.000000000 +0900
@@ -38,7 +38,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * multiplier;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-shx3.c	2012-02-29 20:27:48.000000000 +0900
@@ -32,7 +32,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * 72;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
