From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:40 +0000
Subject: [PATCH 12/17] sh: sh3 sh_clk_ops rename
Message-Id: <20120229131740.29154.874.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh3 SoCs to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh3/clock-sh3.c    |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7705.c |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7706.c |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7709.c |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7710.c |   12 ++++++------
 arch/sh/kernel/cpu/sh3/clock-sh7712.c |   10 +++++-----
 6 files changed, 35 insertions(+), 35 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh3/clock-sh3.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh3.c	2012-02-29 20:36:21.000000000 +0900
@@ -34,7 +34,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[idx];
 }
 
-static struct clk_ops sh3_master_clk_ops = {
+static struct sh_clk_ops sh3_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -46,7 +46,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh3_module_clk_ops = {
+static struct sh_clk_ops sh3_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -58,7 +58,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / stc_multipliers[idx];
 }
 
-static struct clk_ops sh3_bus_clk_ops = {
+static struct sh_clk_ops sh3_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -70,18 +70,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh3_cpu_clk_ops = {
+static struct sh_clk_ops sh3_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh3_clk_ops[] = {
+static struct sh_clk_ops *sh3_clk_ops[] = {
 	&sh3_master_clk_ops,
 	&sh3_module_clk_ops,
 	&sh3_bus_clk_ops,
 	&sh3_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh3_clk_ops))
 		*ops = sh3_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh3/clock-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh7705.c	2012-02-29 20:39:15.000000000 +0900
@@ -35,7 +35,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[__raw_readw(FRQCR) & 0x0003];
 }
 
-static struct clk_ops sh7705_master_clk_ops = {
+static struct sh_clk_ops sh7705_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -45,7 +45,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7705_module_clk_ops = {
+static struct sh_clk_ops sh7705_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -55,7 +55,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / stc_multipliers[idx];
 }
 
-static struct clk_ops sh7705_bus_clk_ops = {
+static struct sh_clk_ops sh7705_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -65,18 +65,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7705_cpu_clk_ops = {
+static struct sh_clk_ops sh7705_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7705_clk_ops[] = {
+static struct sh_clk_ops *sh7705_clk_ops[] = {
 	&sh7705_master_clk_ops,
 	&sh7705_module_clk_ops,
 	&sh7705_bus_clk_ops,
 	&sh7705_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7705_clk_ops))
 		*ops = sh7705_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh3/clock-sh7706.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh7706.c	2012-02-29 20:40:26.000000000 +0900
@@ -30,7 +30,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[idx];
 }
 
-static struct clk_ops sh7706_master_clk_ops = {
+static struct sh_clk_ops sh7706_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -42,7 +42,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7706_module_clk_ops = {
+static struct sh_clk_ops sh7706_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -54,7 +54,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / stc_multipliers[idx];
 }
 
-static struct clk_ops sh7706_bus_clk_ops = {
+static struct sh_clk_ops sh7706_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -66,18 +66,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7706_cpu_clk_ops = {
+static struct sh_clk_ops sh7706_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7706_clk_ops[] = {
+static struct sh_clk_ops *sh7706_clk_ops[] = {
 	&sh7706_master_clk_ops,
 	&sh7706_module_clk_ops,
 	&sh7706_bus_clk_ops,
 	&sh7706_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7706_clk_ops))
 		*ops = sh7706_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh7709.c	2012-02-29 20:40:48.000000000 +0900
@@ -30,7 +30,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[idx];
 }
 
-static struct clk_ops sh7709_master_clk_ops = {
+static struct sh_clk_ops sh7709_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -42,7 +42,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7709_module_clk_ops = {
+static struct sh_clk_ops sh7709_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -55,7 +55,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate * stc_multipliers[idx];
 }
 
-static struct clk_ops sh7709_bus_clk_ops = {
+static struct sh_clk_ops sh7709_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -67,18 +67,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7709_cpu_clk_ops = {
+static struct sh_clk_ops sh7709_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7709_clk_ops[] = {
+static struct sh_clk_ops *sh7709_clk_ops[] = {
 	&sh7709_master_clk_ops,
 	&sh7709_module_clk_ops,
 	&sh7709_bus_clk_ops,
 	&sh7709_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7709_clk_ops))
 		*ops = sh7709_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh3/clock-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh7710.c	2012-02-29 20:42:17.000000000 +0900
@@ -29,7 +29,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= md_table[__raw_readw(FRQCR) & 0x0007];
 }
 
-static struct clk_ops sh7710_master_clk_ops = {
+static struct sh_clk_ops sh7710_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -39,7 +39,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / md_table[idx];
 }
 
-static struct clk_ops sh7710_module_clk_ops = {
+static struct sh_clk_ops sh7710_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -49,7 +49,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / md_table[idx];
 }
 
-static struct clk_ops sh7710_bus_clk_ops = {
+static struct sh_clk_ops sh7710_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -59,18 +59,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / md_table[idx];
 }
 
-static struct clk_ops sh7710_cpu_clk_ops = {
+static struct sh_clk_ops sh7710_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7710_clk_ops[] = {
+static struct sh_clk_ops *sh7710_clk_ops[] = {
 	&sh7710_master_clk_ops,
 	&sh7710_module_clk_ops,
 	&sh7710_bus_clk_ops,
 	&sh7710_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7710_clk_ops))
 		*ops = sh7710_clk_ops[idx];
--- 0001/arch/sh/kernel/cpu/sh3/clock-sh7712.c
+++ work/arch/sh/kernel/cpu/sh3/clock-sh7712.c	2012-02-29 20:43:32.000000000 +0900
@@ -29,7 +29,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= multipliers[idx];
 }
 
-static struct clk_ops sh7712_master_clk_ops = {
+static struct sh_clk_ops sh7712_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -41,7 +41,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / divisors[idx];
 }
 
-static struct clk_ops sh7712_module_clk_ops = {
+static struct sh_clk_ops sh7712_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -53,17 +53,17 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / divisors[idx];
 }
 
-static struct clk_ops sh7712_cpu_clk_ops = {
+static struct sh_clk_ops sh7712_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7712_clk_ops[] = {
+static struct sh_clk_ops *sh7712_clk_ops[] = {
 	&sh7712_master_clk_ops,
 	&sh7712_module_clk_ops,
 	&sh7712_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh7712_clk_ops))
 		*ops = sh7712_clk_ops[idx];
