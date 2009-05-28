From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 12:06:17 +0000
Subject: [PATCH] sh: sh7785 pll configuration from mode pin
Message-Id: <20090528120617.5901.52374.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the sh7785 clock code to use the MODE4
value to switch between 72x and 36x PLL multiplication.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-28 16:42:18.000000000 +0900
@@ -16,6 +16,7 @@
 #include <linux/cpufreq.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
+#include <cpu/sh7785.h>
 
 static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
 			       24, 32, 36, 48 };
@@ -80,12 +81,11 @@ static struct clk_ops frqmr_clk_ops = {
 
 static unsigned long pll_recalc(struct clk *clk)
 {
-	/*
-	 * XXX: PLL1 multiplier is locked for the default clock mode,
-	 * when mode pin detection and configuration support is added,
-	 * select the multiplier dynamically.
-	 */
-	return clk->parent->rate * 36;
+	int multiplier;
+
+	multiplier = test_mode_pin(MODE_PIN_MODE4) ? 36 : 72;
+
+	return clk->parent->rate * multiplier;
 }
 
 static struct clk_ops pll_clk_ops = {
