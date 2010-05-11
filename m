From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:48 +0000
Subject: [PATCH 12/15] sh: switch shx3 to clkdev
Message-Id: <20100511093648.28210.33129.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining shx3 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-shx3.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-shx3.c	2010-05-11 17:42:01.000000000 +0900
@@ -13,9 +13,10 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
-#include <asm/io.h>
 
 static int ifc_divisors[] = { 1, 2, 4 ,6 };
 static int bfc_divisors[] = { 1, 1, 1, 1, 1, 12, 16, 18, 24, 32, 36, 48 };
@@ -94,7 +95,6 @@ static struct clk_ops shx3_shyway_clk_op
 };
 
 static struct clk shx3_shyway_clk = {
-	.name		= "shyway_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &shx3_shyway_clk_ops,
 };
@@ -107,6 +107,13 @@ static struct clk *shx3_onchip_clocks[] 
 	&shx3_shyway_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("shyway_clk", &shx3_shyway_clk),
+};
+
 int __init arch_clk_init(void)
 {
 	struct clk *clk;
@@ -124,5 +131,7 @@ int __init arch_clk_init(void)
 
 	clk_put(clk);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return ret;
 }
