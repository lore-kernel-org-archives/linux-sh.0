From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:44 +0000
Subject: [PATCH 05/17] ARM: mach-shmobile: sh7372 sh_clk_ops rename
Message-Id: <20120229131644.29154.96237.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7372 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2012-02-28 22:03:50.000000000 +0900
@@ -89,7 +89,7 @@ static unsigned long div2_recalc(struct
 	return clk->parent->rate / 2;
 }
 
-static struct clk_ops div2_clk_ops = {
+static struct sh_clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
@@ -128,7 +128,7 @@ static unsigned long pllc01_recalc(struc
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc01_clk_ops = {
+static struct sh_clk_ops pllc01_clk_ops = {
 	.recalc		= pllc01_recalc,
 };
 
@@ -276,7 +276,7 @@ static int pllc2_set_parent(struct clk *
 	return 0;
 }
 
-static struct clk_ops pllc2_clk_ops = {
+static struct sh_clk_ops pllc2_clk_ops = {
 	.recalc		= pllc2_recalc,
 	.round_rate	= pllc2_round_rate,
 	.set_rate	= pllc2_set_rate,
@@ -468,7 +468,7 @@ static int fsidiv_set_rate(struct clk *c
 	return 0;
 }
 
-static struct clk_ops fsidiv_clk_ops = {
+static struct sh_clk_ops fsidiv_clk_ops = {
 	.recalc		= fsidiv_recalc,
 	.round_rate	= fsidiv_round_rate,
 	.set_rate	= fsidiv_set_rate,
