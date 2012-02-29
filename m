From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:24 +0000
Subject: [PATCH 10/17] sh: sh2 sh_clk_ops rename
Message-Id: <20120229131724.29154.22859.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh2 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh2/clock-sh7619.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2/clock-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/clock-sh7619.c	2012-02-29 20:47:02.000000000 +0900
@@ -28,7 +28,7 @@ static void master_clk_init(struct clk *
 	clk->rate *= pll2_mult * pll1rate[(__raw_readw(FREQCR) >> 8) & 7];
 }
 
-static struct clk_ops sh7619_master_clk_ops = {
+static struct sh_clk_ops sh7619_master_clk_ops = {
 	.init		= master_clk_init,
 };
 
@@ -38,7 +38,7 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / pfc_divisors[idx];
 }
 
-static struct clk_ops sh7619_module_clk_ops = {
+static struct sh_clk_ops sh7619_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };
 
@@ -47,22 +47,22 @@ static unsigned long bus_clk_recalc(stru
 	return clk->parent->rate / pll1rate[(__raw_readw(FREQCR) >> 8) & 7];
 }
 
-static struct clk_ops sh7619_bus_clk_ops = {
+static struct sh_clk_ops sh7619_bus_clk_ops = {
 	.recalc		= bus_clk_recalc,
 };
 
-static struct clk_ops sh7619_cpu_clk_ops = {
+static struct sh_clk_ops sh7619_cpu_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
-static struct clk_ops *sh7619_clk_ops[] = {
+static struct sh_clk_ops *sh7619_clk_ops[] = {
 	&sh7619_master_clk_ops,
 	&sh7619_module_clk_ops,
 	&sh7619_bus_clk_ops,
 	&sh7619_cpu_clk_ops,
 };
 
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 	if (test_mode_pin(MODE_PIN2 | MODE_PIN0) ||
 	    test_mode_pin(MODE_PIN2 | MODE_PIN1))
