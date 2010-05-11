From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:35:55 +0000
Subject: [PATCH 06/15] sh: switch sh7366 to clkdev
Message-Id: <20100511093555.28210.19747.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7366 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- 0019/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-11 16:50:43.000000000 +0900
@@ -37,8 +37,6 @@
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
 static struct clk r_clk = {
-	.name           = "rclk",
-	.id             = -1,
 	.rate           = 32768,
 };
 
@@ -47,8 +45,6 @@ static struct clk r_clk = {
  * from the platform code.
  */
 struct clk extal_clk = {
-	.name		= "extal",
-	.id		= -1,
 	.rate		= 33333333,
 };
 
@@ -70,8 +66,6 @@ static struct clk_ops dll_clk_ops = {
 };
 
 static struct clk dll_clk = {
-	.name           = "dll_clk",
-	.id             = -1,
 	.ops		= &dll_clk_ops,
 	.parent		= &r_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -95,8 +89,6 @@ static struct clk_ops pll_clk_ops = {
 };
 
 static struct clk pll_clk = {
-	.name		= "pll_clk",
-	.id		= -1,
 	.ops		= &pll_clk_ops,
 	.flags		= CLK_ENABLE_ON_INIT,
 };
@@ -203,6 +195,12 @@ static struct clk mstp_clks[MSTP_NR] = {
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("rclk", &r_clk),
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("dll_clk", &dll_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 	CLKDEV_CON_ID("umem_clk", &div4_clks[DIV4_U]),
