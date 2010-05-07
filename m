From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 09:20:40 +0000
Subject: [PATCH] sh: fix clock framework on SH7757
Message-Id: <4BE3DB68.1040503@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

 - fix the recalc function's prototype
 - This CPU don't have FRQCR

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 86aae60..b24dae6 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -3,7 +3,7 @@
  *
  * SH7757 support for the clock framework
  *
- *  Copyright (C) 2009  Renesas Solutions Corp.
+ *  Copyright (C) 2009-2010  Renesas Solutions Corp.
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -15,38 +15,28 @@
 #include <asm/clock.h>
 #include <asm/freq.h>

-static int ifc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int sfc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int bfc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int p1fc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			       16, 1, 1, 32, 1, 1, 1, 1 };
-
 static void master_clk_init(struct clk *clk)
 {
-	clk->rate = CONFIG_SH_PCLK_FREQ * 16;
+	clk->rate = CONFIG_SH_PCLK_FREQ * 12;
 }

 static struct clk_ops sh7757_master_clk_ops = {
 	.init		= master_clk_init,
 };

-static void module_clk_recalc(struct clk *clk)
+static unsigned long module_clk_recalc(struct clk *clk)
 {
-	int idx = __raw_readl(FRQCR) & 0x0000000f;
-	clk->rate = clk->parent->rate / p1fc_divisors[idx];
+	return clk->parent->rate / 12;
 }

 static struct clk_ops sh7757_module_clk_ops = {
 	.recalc		= module_clk_recalc,
 };

-static void bus_clk_recalc(struct clk *clk)
+static unsigned long bus_clk_recalc(struct clk *clk)
 {
-	int idx = (__raw_readl(FRQCR) >> 8) & 0x0000000f;
-	clk->rate = clk->parent->rate / bfc_divisors[idx];
+	/* Bus clock = P clock */
+	return clk->parent->rate / 12;
 }

 static struct clk_ops sh7757_bus_clk_ops = {
@@ -55,8 +45,7 @@ static struct clk_ops sh7757_bus_clk_ops = {

 static void cpu_clk_recalc(struct clk *clk)
 {
-	int idx = (__raw_readl(FRQCR) >> 20) & 0x0000000f;
-	clk->rate = clk->parent->rate / ifc_divisors[idx];
+	return clk->parent->rate;
 }

 static struct clk_ops sh7757_cpu_clk_ops = {
@@ -78,8 +67,7 @@ void __init arch_init_clk_ops(struct clk_ops **ops, int idx)

 static void shyway_clk_recalc(struct clk *clk)
 {
-	int idx = (__raw_readl(FRQCR) >> 12) & 0x0000000f;
-	clk->rate = clk->parent->rate / sfc_divisors[idx];
+	return clk->parent->rate / 3;
 }

 static struct clk_ops sh7757_shyway_clk_ops = {
-- 
1.5.5
