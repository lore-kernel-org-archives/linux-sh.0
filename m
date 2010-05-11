From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:35:11 +0000
Subject: [PATCH 01/15] sh: switch legacy clocks to clkdev
Message-Id: <20100511093511.28210.25802.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the legacy clocks to register
using clkdev. Also the clock name is removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/clock-cpg.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- 0011/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-05-11 17:53:38.000000000 +0900
@@ -2,6 +2,7 @@
 #include <linux/compiler.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 
 static int sh_clk_mstp32_enable(struct clk *clk)
@@ -299,25 +300,21 @@ int __init sh_clk_div4_reparent_register
 
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 static struct clk master_clk = {
-	.name		= "master_clk",
 	.flags		= CLK_ENABLE_ON_INIT,
 	.rate		= CONFIG_SH_PCLK_FREQ,
 };
 
 static struct clk peripheral_clk = {
-	.name		= "peripheral_clk",
 	.parent		= &master_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 };
 
 static struct clk bus_clk = {
-	.name		= "bus_clk",
 	.parent		= &master_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 };
 
 static struct clk cpu_clk = {
-	.name		= "cpu_clk",
 	.parent		= &master_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
 };
@@ -332,6 +329,16 @@ static struct clk *onchip_clocks[] = {
 	&cpu_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("master_clk", &master_clk),
+	CLKDEV_CON_ID("peripheral_clk", &peripheral_clk),
+	CLKDEV_CON_ID("bus_clk", &bus_clk),
+	CLKDEV_CON_ID("cpu_clk", &cpu_clk),
+};
+
 int __init __deprecated cpg_clk_init(void)
 {
 	int i, ret = 0;
@@ -343,6 +350,8 @@ int __init __deprecated cpg_clk_init(voi
 			ret |= clk_register(clk);
 	}
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	clk_add_alias("tmu_fck", NULL, "peripheral_clk", NULL);
 	clk_add_alias("mtu2_fck", NULL, "peripheral_clk", NULL);
 	clk_add_alias("cmt_fck", NULL, "peripheral_clk", NULL);
