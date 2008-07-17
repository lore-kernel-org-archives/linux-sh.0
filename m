From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 09:52:19 +0000
Subject: [PATCH] sh: Use arch_flags to simplify sh7722 siu clock code
Message-Id: <20080717095219.19560.81772.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make use of arch_flags to simplify the SIU clock code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   47 ++++++--------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-06-13 15:51:14.000000000 +0900
@@ -411,40 +411,16 @@ static struct clk_ops sh7722_frqcr_clk_o
  * clock ops methods for SIU A/B and IrDA clock
  *
  */
-static int sh7722_siu_which(struct clk *clk)
-{
-	if (!strcmp(clk->name, "siu_a_clk"))
-		return 0;
-	if (!strcmp(clk->name, "siu_b_clk"))
-		return 1;
-#if defined(CONFIG_CPU_SUBTYPE_SH7722)
-	if (!strcmp(clk->name, "irda_clk"))
-		return 2;
-#endif
-	return -EINVAL;
-}
-
-static unsigned long sh7722_siu_regs[] = {
-	[0] = SCLKACR,
-	[1] = SCLKBCR,
-#if defined(CONFIG_CPU_SUBTYPE_SH7722)
-	[2] = IrDACLKCR,
-#endif
-};
 
 static int sh7722_siu_start_stop(struct clk *clk, int enable)
 {
-	int siu = sh7722_siu_which(clk);
 	unsigned long r;
 
-	if (siu < 0)
-		return siu;
-	BUG_ON(siu > 2);
-	r = ctrl_inl(sh7722_siu_regs[siu]);
+	r = ctrl_inl(clk->arch_flags);
 	if (enable)
-		ctrl_outl(r & ~(1 << 8), sh7722_siu_regs[siu]);
+		ctrl_outl(r & ~(1 << 8), clk->arch_flags);
 	else
-		ctrl_outl(r | (1 << 8), sh7722_siu_regs[siu]);
+		ctrl_outl(r | (1 << 8), clk->arch_flags);
 	return 0;
 }
 
@@ -496,31 +472,23 @@ static void sh7722_video_recalc(struct c
 
 static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
 {
-	int siu = sh7722_siu_which(clk);
 	unsigned long r;
 	int div;
 
-	if (siu < 0)
-		return siu;
-	BUG_ON(siu > 2);
-	r = ctrl_inl(sh7722_siu_regs[siu]);
+	r = ctrl_inl(clk->arch_flags);
 	div = sh7722_find_divisors(clk->parent->rate, rate);
 	if (div < 0)
 		return div;
 	r = (r & ~0xF) | div;
-	ctrl_outl(r, sh7722_siu_regs[siu]);
+	ctrl_outl(r, clk->arch_flags);
 	return 0;
 }
 
 static void sh7722_siu_recalc(struct clk *clk)
 {
-	int siu = sh7722_siu_which(clk);
 	unsigned long r;
 
-	if (siu < 0)
-		return /* siu */ ;
-	BUG_ON(siu > 2);
-	r = ctrl_inl(sh7722_siu_regs[siu]);
+	r = ctrl_inl(clk->arch_flags);
 	clk->rate = clk->parent->rate * 2 / divisors2[r & 0xF];
 }
 
@@ -567,17 +535,20 @@ static struct clk sh7722_sdram_clock = {
  */
 static struct clk sh7722_siu_a_clock = {
 	.name = "siu_a_clk",
+	.arch_flags = SCLKACR,
 	.ops = &sh7722_siu_clk_ops,
 };
 
 static struct clk sh7722_siu_b_clock = {
 	.name = "siu_b_clk",
+	.arch_flags = SCLKBCR,
 	.ops = &sh7722_siu_clk_ops,
 };
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
 static struct clk sh7722_irda_clock = {
 	.name = "irda_clk",
+	.arch_flags = IrDACLKCR,
 	.ops = &sh7722_siu_clk_ops,
 };
 #endif
