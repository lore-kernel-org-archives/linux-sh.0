From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:36 +0000
Subject: [PATCH 04/17] ARM: mach-shmobile: sh7377 sh_clk_ops rename
Message-Id: <20120229131636.29154.57458.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7377 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7377.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7377.c
+++ work/arch/arm/mach-shmobile/clock-sh7377.c	2012-02-28 22:07:34.000000000 +0900
@@ -77,7 +77,7 @@ static unsigned long div2_recalc(struct
 	return clk->parent->rate / 2;
 }
 
-static struct clk_ops div2_clk_ops = {
+static struct sh_clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
@@ -110,7 +110,7 @@ static unsigned long pllc1_recalc(struct
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc1_clk_ops = {
+static struct sh_clk_ops pllc1_clk_ops = {
 	.recalc		= pllc1_recalc,
 };
 
@@ -137,7 +137,7 @@ static unsigned long pllc2_recalc(struct
 	return clk->parent->rate * mult;
 }
 
-static struct clk_ops pllc2_clk_ops = {
+static struct sh_clk_ops pllc2_clk_ops = {
 	.recalc		= pllc2_recalc,
 };
 
