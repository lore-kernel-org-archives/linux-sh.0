From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:40 +0000
Subject: [PATCH 11/15] sh: switch sh7757 to clkdev
Message-Id: <20100511093640.28210.69602.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7757 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7757.c	2010-05-11 17:36:46.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
 
@@ -87,7 +88,6 @@ static struct clk_ops sh7757_shyway_clk_
 };
 
 static struct clk sh7757_shyway_clk = {
-	.name		= "shyway_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.ops		= &sh7757_shyway_clk_ops,
 };
@@ -100,6 +100,13 @@ static struct clk *sh7757_onchip_clocks[
 	&sh7757_shyway_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("shyway_clk", &sh7757_shyway_clk),
+};
+
 static int __init sh7757_clk_init(void)
 {
 	struct clk *clk = clk_get(NULL, "master_clk");
@@ -123,6 +130,8 @@ static int __init sh7757_clk_init(void)
 
 	clk_put(clk);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return 0;
 }
 
