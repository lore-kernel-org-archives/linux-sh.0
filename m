From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:24 +0000
Subject: [PATCH 09/15] sh: switch sh7780 to clkdev
Message-Id: <20100511093624.28210.14137.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7780 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7780.c	2010-05-11 17:14:17.000000000 +0900
@@ -11,6 +11,8 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
@@ -83,7 +85,6 @@ static struct clk_ops sh7780_shyway_clk_
 };
 
 static struct clk sh7780_shyway_clk = {
-	.name		= "shyway_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh7780_shyway_clk_ops,
 };
@@ -96,6 +97,13 @@ static struct clk *sh7780_onchip_clocks[
 	&sh7780_shyway_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("shyway_clk", &sh7780_shyway_clk),
+};
+
 int __init arch_clk_init(void)
 {
 	struct clk *clk;
@@ -113,5 +121,7 @@ int __init arch_clk_init(void)
 
 	clk_put(clk);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return ret;
 }
