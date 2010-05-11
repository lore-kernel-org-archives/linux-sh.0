From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:35:19 +0000
Subject: [PATCH 02/15] sh: switch sh7724 to clkdev
Message-Id: <20100511093519.28210.46226.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7724 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- 0019/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-11 16:25:21.000000000 +0900
@@ -41,8 +41,6 @@
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
 static struct clk r_clk = {
-	.name           = "rclk",
-	.id             = -1,
 	.rate           = 32768,
 };
 
@@ -51,8 +49,6 @@ static struct clk r_clk = {
  * from the platform code.
  */
 struct clk extal_clk = {
-	.name		= "extal",
-	.id		= -1,
 	.rate		= 33333333,
 };
 
@@ -76,8 +72,6 @@ static struct clk_ops fll_clk_ops = {
 };
 
 static struct clk fll_clk = {
-	.name           = "fll_clk",
-	.id             = -1,
 	.ops		= &fll_clk_ops,
 	.parent		= &r_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -98,8 +92,6 @@ static struct clk_ops pll_clk_ops = {
 };
 
 static struct clk pll_clk = {
-	.name		= "pll_clk",
-	.id		= -1,
 	.ops		= &pll_clk_ops,
 	.flags		= CLK_ENABLE_ON_INIT,
 };
@@ -115,8 +107,6 @@ static struct clk_ops div3_clk_ops = {
 };
 
 static struct clk div3_clk = {
-	.name		= "div3_clk",
-	.id		= -1,
 	.ops		= &div3_clk_ops,
 	.parent		= &pll_clk,
 };
@@ -234,6 +224,13 @@ static struct clk mstp_clks[HWBLK_NR] = 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("rclk", &r_clk),
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("fll_clk", &fll_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+	CLKDEV_CON_ID("div3_clk", &div3_clk),
+
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
