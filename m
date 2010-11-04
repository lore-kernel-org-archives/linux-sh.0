From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 14:14:29 +0000
Subject: [PATCH] sh: make some needlessly global sh7724 clocks static
Message-Id: <Pine.LNX.4.64.1011041511320.13123@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These clocks are currently only used inside one .c file and are not 
declared in any headers, therefore having them global is useless.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

other CPU-type clocks could use a similar clean-up.

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 2d9700c..0fe2e93 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -48,7 +48,7 @@ static struct clk r_clk = {
  * Default rate for the root input clock, reset this with clk_set_rate()
  * from the platform code.
  */
-struct clk extal_clk = {
+static struct clk extal_clk = {
 	.rate		= 33333333,
 };
 
@@ -111,7 +111,7 @@ static struct clk div3_clk = {
 	.parent		= &pll_clk,
 };
 
-struct clk *main_clks[] = {
+static struct clk *main_clks[] = {
 	&r_clk,
 	&extal_clk,
 	&fll_clk,
@@ -156,7 +156,7 @@ struct clk div4_clks[DIV4_NR] = {
 
 enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
 
-struct clk div6_clks[DIV6_NR] = {
+static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_V] = SH_CLK_DIV6(&div3_clk, VCLKCR, 0),
 	[DIV6_FA] = SH_CLK_DIV6(&div3_clk, FCLKACR, 0),
 	[DIV6_FB] = SH_CLK_DIV6(&div3_clk, FCLKBCR, 0),
-- 
1.7.2.3

