From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:47 +0000
Subject: [PATCH 13/17] sh: sh4 sh_clk_ops rename
Message-Id: <20120229131747.29154.42782.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh4 SoCs to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    6 +++---
 arch/sh/kernel/cpu/sh4/clock-sh4.c     |   12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/clock-sh4-202.c	2012-02-29 20:32:42.000000000 +0900
@@ -41,7 +41,7 @@ static inline int frqcr3_lookup(struct c
 	return 5;
 }
 
-static struct clk_ops sh4202_emi_clk_ops = {
+static struct sh_clk_ops sh4202_emi_clk_ops = {
 	.recalc		= emi_clk_recalc,
 };
 
@@ -56,7 +56,7 @@ static unsigned long femi_clk_recalc(str
 	return clk->parent->rate / frqcr3_divisors[idx];
 }
 
-static struct clk_ops sh4202_femi_clk_ops = {
+static struct sh_clk_ops sh4202_femi_clk_ops = {
 	.recalc		= femi_clk_recalc,
 };
 
@@ -130,7 +130,7 @@ static int shoc_clk_set_rate(struct clk
 	return 0;
 }
 
-static struct clk_ops sh4202_shoc_clk_ops = {
+static struct sh_clk_ops sh4202_shoc_clk_ops = {
 	.init		= shoc_clk_init,
 	.recalc		= shoc_clk_recalc,
 	.set_rate	= shoc_clk_set_rate,
--- 0001/arch/sh/kernel/cpu/sh4/clock-sh4.c
+++ work/arch/sh/kernel/cpu/sh4/clock-sh4.c	2012-02-29 20:31:56.000000000 +0900
@@ -31,7 +31,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pfc_divisors[__raw_readw(FRQCR) & 0x0007];
 }
 
-static struct clk_ops sh4_master_clk_ops = {
+static struct sh_clk_ops sh4_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -41,7 +41,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh4_module_clk_ops = {
+static struct sh_clk_ops sh4_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -51,7 +51,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / bfc_divisors[idx];
 }
 
-static struct clk_ops sh4_bus_clk_ops = {
+static struct sh_clk_ops sh4_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -61,18 +61,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_divisors[idx];
 }
 
-static struct clk_ops sh4_cpu_clk_ops = {
+static struct sh_clk_ops sh4_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh4_clk_ops[] = {
+static struct sh_clk_ops *sh4_clk_ops[] = {
 	&sh4_master_clk_ops,
 	&sh4_module_clk_ops,
 	&sh4_bus_clk_ops,
 	&sh4_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (idx < ARRAY_SIZE(sh4_clk_ops))
 		*ops = sh4_clk_ops[idx];
