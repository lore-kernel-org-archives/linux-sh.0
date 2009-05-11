From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 11 May 2009 16:20:12 +0000
Subject: [PATCH] sh: clkfw: Added the .set_rate_ex callback in the clock operation
Message-Id: <1242058812-18864-1-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the .set_rate_ex callback to manage clearly the
clk_set_rate() operation and the operation under clk_set_rate_ex().

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h            |    3 ++-
 arch/sh/kernel/cpu/clock.c             |   19 ++++++++++++++++---
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    5 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    9 ++++-----
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index b1f2919..ba9114b 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -13,7 +13,8 @@ struct clk_ops {
 	void (*enable)(struct clk *clk);
 	void (*disable)(struct clk *clk);
 	void (*recalc)(struct clk *clk);
-	int (*set_rate)(struct clk *clk, unsigned long rate, int algo_id);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+	int (*set_rate_ex)(struct clk *clk, unsigned long rate, int algo_id);
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 	long (*round_rate)(struct clk *clk, unsigned long rate);
 };
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 133dbe4..f97a0c6 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -211,7 +211,20 @@ EXPORT_SYMBOL_GPL(clk_get_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	return clk_set_rate_ex(clk, rate, 0);
+	int ret = -EOPNOTSUPP;
+
+	if (likely(clk->ops && clk->ops->set_rate)) 
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_rate_ex(clk, rate);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES)){
+		propagate_rate(clk);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_rate);
 
@@ -219,11 +232,11 @@ int clk_set_rate_ex(struct clk *clk, unsigned long rate, int algo_id)
 {
 	int ret = -EOPNOTSUPP;
 
-	if (likely(clk->ops && clk->ops->set_rate)) {
+	if (likely(clk->ops && clk->ops->set_rate_ex)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&clock_lock, flags);
-		ret = clk->ops->set_rate(clk, rate, algo_id);
+		ret = clk->ops->set_rate_ex(clk, rate, algo_id);
 		spin_unlock_irqrestore(&clock_lock, flags);
 	}
 
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
index a334294..eb22dcc 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -82,8 +82,7 @@ static void shoc_clk_init(struct clk *clk)
 	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++) {
 		int divisor = frqcr3_divisors[i];
 
-		if (clk->ops->set_rate(clk, clk->parent->rate /
-						divisor, 0) = 0)
+		if (clk->ops->set_rate(clk, clk->parent->rate /	divisor) = 0)
 			break;
 	}
 
@@ -111,7 +110,7 @@ static int shoc_clk_verify_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static int shoc_clk_set_rate(struct clk *clk, unsigned long rate, int algo_id)
+static int shoc_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long frqcr3;
 	unsigned int tmp;
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 1ccdfc5..9546904 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -191,7 +191,7 @@ static void module_clk_recalc(struct clk *clk)
 #define FRQCRKICK	0x00000000
 #endif
 
-static int master_clk_setrate(struct clk *clk, unsigned long rate, int id)
+static int master_clk_setrate(struct clk *clk, unsigned long rate)
 {
 	int div = rate / clk->rate;
 	int master_divs[] = MASTERDIVS;
@@ -433,7 +433,7 @@ static long sh7722_frqcr_round_rate(struct clk *clk, unsigned long rate)
 
 static struct clk_ops sh7722_frqcr_clk_ops = {
 	.recalc = sh7722_frqcr_recalc,
-	.set_rate = sh7722_frqcr_set_rate,
+	.set_rate_ex = sh7722_frqcr_set_rate,
 	.round_rate = sh7722_frqcr_round_rate,
 };
 
@@ -444,7 +444,7 @@ static struct clk_ops sh7722_frqcr_clk_ops = {
 
 #ifndef CONFIG_CPU_SUBTYPE_SH7343
 
-static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
+static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long r;
 	int div;
@@ -513,8 +513,7 @@ static void sh7722_video_disable(struct clk *clk)
 	ctrl_outl( r | (1<<8), VCLKCR);
 }
 
-static int sh7722_video_set_rate(struct clk *clk, unsigned long rate,
-				 int algo_id)
+static int sh7722_video_set_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long r;
 
-- 
1.6.0.6

