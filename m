From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:29 +0000
Subject: [PATCH 03/17] ARM: mach-shmobile: sh7367 sh_clk_ops rename
Message-Id: <20120229131629.29154.87736.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7367 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7367.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2012-02-28 22:10:14.000000000 +0900
@@ -74,7 +74,7 @@ static unsigned long div2_recalc(struct
 	return clk->parent->rate / 2;
 }
 
-static struct clk_ops div2_clk_ops = {
+static struct sh_clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
@@ -101,7 +101,7 @@ static unsigned long pllc1_recalc(struct
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc1_clk_ops = {
+static struct sh_clk_ops pllc1_clk_ops = {
 	.recalc		= pllc1_recalc,
 };
 
@@ -128,7 +128,7 @@ static unsigned long pllc2_recalc(struct
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc2_clk_ops = {
+static struct sh_clk_ops pllc2_clk_ops = {
 	.recalc		= pllc2_recalc,
 };
 
