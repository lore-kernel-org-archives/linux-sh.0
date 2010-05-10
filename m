From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:52 +0000
Subject: [PATCH 12/13] sh: Get rid of sh7724 main clock names
Message-Id: <20100510112452.14587.53366.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Get rid of name and id from sh7724 main clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   10 ----------
 1 file changed, 10 deletions(-)

--- 0012/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 19:32:46.000000000 +0900
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
