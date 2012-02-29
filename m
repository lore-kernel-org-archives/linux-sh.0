From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:52 +0000
Subject: [PATCH 06/17] ARM: mach-shmobile: sh73a0 sh_clk_ops rename
Message-Id: <20120229131652.29154.26200.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh73a0 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2012-02-28 21:41:05.000000000 +0900
@@ -88,7 +88,7 @@ static unsigned long div2_recalc(struct
 	return clk->parent->rate / 2;
 }
 
-static struct clk_ops div2_clk_ops = {
+static struct sh_clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
@@ -97,7 +97,7 @@ static unsigned long div7_recalc(struct
 	return clk->parent->rate / 7;
 }
 
-static struct clk_ops div7_clk_ops = {
+static struct sh_clk_ops div7_clk_ops = {
 	.recalc		= div7_recalc,
 };
 
@@ -106,7 +106,7 @@ static unsigned long div13_recalc(struct
 	return clk->parent->rate / 13;
 }
 
-static struct clk_ops div13_clk_ops = {
+static struct sh_clk_ops div13_clk_ops = {
 	.recalc		= div13_recalc,
 };
 
@@ -122,7 +122,7 @@ static struct clk extal2_div2_clk = {
 	.parent		= &sh73a0_extal2_clk,
 };
 
-static struct clk_ops main_clk_ops = {
+static struct sh_clk_ops main_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
@@ -156,7 +156,7 @@ static unsigned long pll_recalc(struct c
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pll_clk_ops = {
+static struct sh_clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
@@ -438,7 +438,7 @@ static int dsiphy_set_rate(struct clk *c
 	return 0;
 }
 
-static struct clk_ops dsiphy_clk_ops = {
+static struct sh_clk_ops dsiphy_clk_ops = {
 	.recalc		= dsiphy_recalc,
 	.round_rate	= dsiphy_round_rate,
 	.set_rate	= dsiphy_set_rate,
