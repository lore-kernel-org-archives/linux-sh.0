From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:18:03 +0000
Subject: [PATCH 15/17] sh: sh5 sh_clk_ops rename
Message-Id: <20120229131803.29154.48513.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh5 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh5/clock-sh5.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh5/clock-sh5.c
+++ work/arch/sh/kernel/cpu/sh5/clock-sh5.c	2012-02-29 20:51:40.000000000 +0900
@@ -28,7 +28,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= ifc_table[idx];
 }
 
-static struct clk_ops sh5_master_clk_ops = {
+static struct sh_clk_ops sh5_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -38,7 +38,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / ifc_table[idx];
 }
 
-static struct clk_ops sh5_module_clk_ops = {
+static struct sh_clk_ops sh5_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -48,7 +48,7 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / ifc_table[idx];
 }
 
-static struct clk_ops sh5_bus_clk_ops = {
+static struct sh_clk_ops sh5_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
@@ -58,18 +58,18 @@ static unsigned long cpu_clk_recalc(stru
 	return clk->parent->rate / ifc_table[idx];
 }
 
-static struct clk_ops sh5_cpu_clk_ops = {
+static struct sh_clk_ops sh5_cpu_clk_ops = {
 	.recalc		= cpu_clk_recalc,
 };
 
-static struct clk_ops *sh5_clk_ops[] = {
+static struct sh_clk_ops *sh5_clk_ops[] = {
 	&sh5_master_clk_ops,
 	&sh5_module_clk_ops,
 	&sh5_bus_clk_ops,
 	&sh5_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	cprc_base = (unsigned long)ioremap_nocache(CPRC_BASE, 1024);
 	BUG_ON(!cprc_base);
