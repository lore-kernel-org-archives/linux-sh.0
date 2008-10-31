From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:14:03 +0000
Subject: [PATCH] sh: sh_mobile clock divider index fix
Message-Id: <20081031111403.2963.58047.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use divider index value instead of divider value.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-30 19:08:21.000000000 +0900
@@ -229,7 +229,7 @@ struct frqcr_context sh7722_get_clk_cont
 }
 
 /**
- * sh7722_find_divisors - find divisor for setting rate
+ * sh7722_find_div_index - find divisor for setting rate
  *
  * All sh7722 clocks use the same set of multipliers/divisors. This function
  * chooses correct divisor to set the rate of clock with parent clock that
@@ -238,7 +238,7 @@ struct frqcr_context sh7722_get_clk_cont
  * @parent_rate: rate of parent clock
  * @rate: requested rate to be set
  */
-static int sh7722_find_divisors(unsigned long parent_rate, unsigned rate)
+static int sh7722_find_div_index(unsigned long parent_rate, unsigned rate)
 {
 	unsigned div2 = parent_rate * 2 / rate;
 	int index;
@@ -247,12 +247,12 @@ static int sh7722_find_divisors(unsigned
 		return -EINVAL;
 
 	for (index = 1; index < ARRAY_SIZE(divisors2); index++) {
-		if (div2 > divisors2[index] && div2 <= divisors2[index])
+		if (div2 > divisors2[index - 1] && div2 <= divisors2[index])
 			break;
 	}
 	if (index >= ARRAY_SIZE(divisors2))
 		index = ARRAY_SIZE(divisors2) - 1;
-	return divisors2[index];
+	return index;
 }
 
 static void sh7722_frqcr_recalc(struct clk *clk)
@@ -279,12 +279,12 @@ static int sh7722_frqcr_set_rate(struct 
 		return -EINVAL;
 
 	/* look for multiplier/divisor pair */
-	div = sh7722_find_divisors(parent_rate, rate);
+	div = sh7722_find_div_index(parent_rate, rate);
 	if (div<0)
 		return div;
 
 	/* calculate new value of clock rate */
-	clk->rate = parent_rate * 2 / div;
+	clk->rate = parent_rate * 2 / divisors2[div];
 	frqcr = ctrl_inl(FRQCR);
 
 	/* FIXME: adjust as algo_id specifies */
@@ -353,7 +353,7 @@ static int sh7722_frqcr_set_rate(struct 
 			int part_div;
 
 			if (likely(!err)) {
-				part_div = sh7722_find_divisors(parent_rate,
+				part_div = sh7722_find_div_index(parent_rate,
 								rate);
 				if (part_div > 0) {
 					part_ctx = sh7722_get_clk_context(
@@ -394,12 +394,12 @@ static long sh7722_frqcr_round_rate(stru
 	int div;
 
 	/* look for multiplier/divisor pair */
-	div = sh7722_find_divisors(parent_rate, rate);
+	div = sh7722_find_div_index(parent_rate, rate);
 	if (div < 0)
 		return clk->rate;
 
 	/* calculate new value of clock rate */
-	return parent_rate * 2 / div;
+	return parent_rate * 2 / divisors2[div];
 }
 
 static struct clk_ops sh7722_frqcr_clk_ops = {
@@ -421,7 +421,7 @@ static int sh7722_siu_set_rate(struct cl
 	int div;
 
 	r = ctrl_inl(clk->arch_flags);
-	div = sh7722_find_divisors(clk->parent->rate, rate);
+	div = sh7722_find_div_index(clk->parent->rate, rate);
 	if (div < 0)
 		return div;
 	r = (r & ~0xF) | div;
