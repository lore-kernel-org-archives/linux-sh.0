From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:32 +0000
Subject: [PATCH 10/15] sh: switch sh7763 to clkdev
Message-Id: <20100511093632.28210.43133.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7763 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7763.c	2010-05-11 17:30:53.000000000 +0900
@@ -12,6 +12,8 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
@@ -77,7 +79,6 @@ static struct clk_ops sh7763_shyway_clk_
 };
 
 static struct clk sh7763_shyway_clk = {
-	.name		= "shyway_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh7763_shyway_clk_ops,
 };
@@ -90,6 +91,13 @@ static struct clk *sh7763_onchip_clocks[
 	&sh7763_shyway_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("shyway_clk", &sh7763_shyway_clk),
+};
+
 int __init arch_clk_init(void)
 {
 	struct clk *clk;
@@ -107,5 +115,7 @@ int __init arch_clk_init(void)
 
 	clk_put(clk);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return ret;
 }
