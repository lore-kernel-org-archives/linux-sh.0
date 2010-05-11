From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:57 +0000
Subject: [PATCH 13/15] sh: switch sh4-202 to clkdev
Message-Id: <20100511093657.28210.22731.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh4-202 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/clock-sh4-202.c	2010-05-11 17:47:17.000000000 +0900
@@ -12,9 +12,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
+#include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
-#include <asm/io.h>
 
 #define CPG2_FRQCR3	0xfe0a0018
 
@@ -45,7 +46,6 @@ static struct clk_ops sh4202_emi_clk_ops
 };
 
 static struct clk sh4202_emi_clk = {
-	.name		= "emi_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh4202_emi_clk_ops,
 };
@@ -61,7 +61,6 @@ static struct clk_ops sh4202_femi_clk_op
 };
 
 static struct clk sh4202_femi_clk = {
-	.name		= "femi_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh4202_femi_clk_ops,
 };
@@ -139,7 +138,6 @@ static struct clk_ops sh4202_shoc_clk_op
 };
 
 static struct clk sh4202_shoc_clk = {
-	.name		= "shoc_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh4202_shoc_clk_ops,
 };
@@ -150,6 +148,15 @@ static struct clk *sh4202_onchip_clocks[
 	&sh4202_shoc_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("emi_clk", &sh4202_emi_clk),
+	CLKDEV_CON_ID("femi_clk", &sh4202_femi_clk),
+	CLKDEV_CON_ID("shoc_clk", &sh4202_shoc_clk),
+};
+
 int __init arch_clk_init(void)
 {
 	struct clk *clk;
@@ -167,5 +174,7 @@ int __init arch_clk_init(void)
 
 	clk_put(clk);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return ret;
 }
