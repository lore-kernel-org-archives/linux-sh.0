From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:36:16 +0000
Subject: [PATCH 08/15] sh: switch sh7786 to clkdev
Message-Id: <20100511093616.28210.87336.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining sh7786 clocks
to use clkdev for lookup. The now unused name
and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0019/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 17:05:22.000000000 +0900
@@ -23,8 +23,6 @@
  * from the platform code.
  */
 static struct clk extal_clk = {
-	.name		= "extal",
-	.id		= -1,
 	.rate		= 33333333,
 };
 
@@ -46,8 +44,6 @@ static struct clk_ops pll_clk_ops = {
 };
 
 static struct clk pll_clk = {
-	.name		= "pll_clk",
-	.id		= -1,
 	.ops		= &pll_clk_ops,
 	.parent		= &extal_clk,
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -133,6 +129,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
 	CLKDEV_CON_ID("du_clk", &div4_clks[DIV4_DU]),
