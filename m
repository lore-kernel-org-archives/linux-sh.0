From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Mon, 14 Sep 2009 03:01:58 +0000
Subject: [PATCH] sh: remove set_bus_parent() from clock-sh7709.c file
Message-Id: <20090914030158.GA22263@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It prevents the change of the parent of sh7709_cpu_clk and
sh7709_module_clk (which does not work with that
set_bus_parent() in the current scheme).

Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
---
 arch/sh/kernel/cpu/sh3/clock-sh7709.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
index fa30b60..e874950 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -22,13 +22,6 @@ static int stc_multipliers[] = { 1, 2, 4, 8, 3, 6, 1, 1 };
 static int ifc_divisors[]    = { 1, 2, 4, 1, 3, 1, 1, 1 };
 static int pfc_divisors[]    = { 1, 2, 4, 1, 3, 6, 1, 1 };
 
-static void set_bus_parent(struct clk *clk)
-{
-	struct clk *bus_clk = clk_get(NULL, "bus_clk");
-	clk->parent = bus_clk;
-	clk_put(bus_clk);
-}
-
 static void master_clk_init(struct clk *clk)
 {
 	int frqcr = ctrl_inw(FRQCR);
@@ -50,9 +43,6 @@ static unsigned long module_clk_recalc(struct clk *clk)
 }
 
 static struct clk_ops sh7709_module_clk_ops = {
-#ifdef CLOCK_MODE_0_1_2_7
-	.init		= set_bus_parent,
-#endif
 	.recalc		= module_clk_recalc,
 };
 
@@ -78,7 +68,6 @@ static unsigned long cpu_clk_recalc(struct clk *clk)
 }
 
 static struct clk_ops sh7709_cpu_clk_ops = {
-	.init		= set_bus_parent,
 	.recalc		= cpu_clk_recalc,
 };
 
