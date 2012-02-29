From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:32 +0000
Subject: [PATCH 11/17] sh: sh2a sh_clk_ops rename
Message-Id: <20120229131732.29154.85086.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh2a SoCs to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |   12 ++++++------
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c |   12 ++++++------
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c |   12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+++ work/arch/sh/kernel/cpu/sh2a/clock-sh7201.c	2012-02-29 20:49:02.000000000 +0900
@@ -30,7 +30,7 @@ static void master_clk_init(struct clk *
 	       pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0007];
 }
 
-static struct clk_ops sh7201_master_clk_ops = {
+static struct sh_clk_ops sh7201_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -40,7 +40,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7201_module_clk_ops = {
+static struct sh_clk_ops sh7201_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -50,7 +50,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7201_bus_clk_ops = {
+static struct sh_clk_ops sh7201_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -60,18 +60,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7201_cpu_clk_ops = {
+static struct sh_clk_ops sh7201_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7201_clk_ops[] = {
+static struct sh_clk_ops *sh7201_clk_ops[] = {
 	&sh7201_master_clk_ops,
 	&sh7201_module_clk_ops,
 	&sh7201_bus_clk_ops,
 	&sh7201_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (test_mode_pin(MODE_PIN1 | MODE_PIN0))
 		pll2_mult = 1;
--- 0001/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/clock-sh7203.c	2012-02-29 20:50:04.000000000 +0900
@@ -32,7 +32,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0003] * pll2_mult;
 }
 
-static struct clk_ops sh7203_master_clk_ops = {
+static struct sh_clk_ops sh7203_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -42,7 +42,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7203_module_clk_ops = {
+static struct sh_clk_ops sh7203_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -52,22 +52,22 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / pfc_divisors[idx-2];
 }
 
-static struct clk_ops sh7203_bus_clk_ops = {
+static struct sh_clk_ops sh7203_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
-static struct clk_ops sh7203_cpu_clk_ops = {
+static struct sh_clk_ops sh7203_cpu_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
-static struct clk_ops *sh7203_clk_ops[] = {
+static struct sh_clk_ops *sh7203_clk_ops[] = {
 	&sh7203_master_clk_ops,
 	&sh7203_module_clk_ops,
 	&sh7203_bus_clk_ops,
 	&sh7203_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (test_mode_pin(MODE_PIN1))
 		pll2_mult = 4;
--- 0001/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/clock-sh7206.c	2012-02-29 20:50:37.000000000 +0900
@@ -29,7 +29,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pll2_mult * pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0007];
 }
 
-static struct clk_ops sh7206_master_clk_ops = {
+static struct sh_clk_ops sh7206_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -39,7 +39,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7206_module_clk_ops = {
+static struct sh_clk_ops sh7206_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -48,7 +48,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0007];
 }
 
-static struct clk_ops sh7206_bus_clk_ops = {
+static struct sh_clk_ops sh7206_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -58,18 +58,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh7206_cpu_clk_ops = {
+static struct sh_clk_ops sh7206_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh7206_clk_ops[] = {
+static struct sh_clk_ops *sh7206_clk_ops[] = {
 	&sh7206_master_clk_ops,
 	&sh7206_module_clk_ops,
 	&sh7206_bus_clk_ops,
 	&sh7206_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (test_mode_pin(MODE_PIN2 | MODE_PIN1 | MODE_PIN0))
 		pll2_mult = 1;
