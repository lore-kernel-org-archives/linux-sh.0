From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:00 +0000
Subject: [PATCH 07/17] ARM: mach-shmobile: r8a7740 sh_clk_ops rename
Message-Id: <20120229131700.29154.67438.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7740 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7740.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7740.c
+++ work/arch/arm/mach-shmobile/clock-r8a7740.c	2012-02-28 22:14:45.000000000 +0900
@@ -93,7 +93,7 @@ static unsigned long div_recalc(struct c
 	return clk->parent->rate / (int)(clk->priv);
 }
 
-static struct clk_ops div_clk_ops = {
+static struct sh_clk_ops div_clk_ops = {
 	.recalc	= div_recalc,
 };
 
@@ -125,7 +125,7 @@ static struct clk extal2_div2_clk = {
 	.parent	= &extal2_clk,
 };
 
-static struct clk_ops followparent_clk_ops = {
+static struct sh_clk_ops followparent_clk_ops = {
 	.recalc	= followparent_recalc,
 };
 
@@ -156,7 +156,7 @@ static unsigned long pllc01_recalc(struc
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc01_clk_ops = {
+static struct sh_clk_ops pllc01_clk_ops = {
 	.recalc		= pllc01_recalc,
 };
 
