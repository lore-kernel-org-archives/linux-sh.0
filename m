From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 13 May 2009 06:08:34 +0000
Subject: [PATCH] sh: clkfw: Moved the .init callback in the clk_register function [v3]
Message-Id: <1242194914-13983-1-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch moves the .init callback in the clk_register function.
Moreover not the .init callback return a value:
 - zero means the initialization is ok and the clock can be registered.
 - any value not zero means there is a problem in the initialization and
   the clkfw rejects the clock registration

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h            |    3 +--
 arch/sh/kernel/cpu/clock.c             |   28 ++++++----------------------
 arch/sh/kernel/cpu/sh2/clock-sh7619.c  |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh3.c     |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7706.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  |    6 ++++--
 arch/sh/kernel/cpu/sh3/clock-sh7710.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7712.c  |    3 ++-
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    6 +++++-
 arch/sh/kernel/cpu/sh4/clock-sh4.c     |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    3 ++-
 arch/sh/kernel/cpu/sh5/clock-sh5.c     |    3 ++-
 arch/sh/kernel/timers/timer-tmu.c      |    3 ++-
 23 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index b1f2919..f8d253b 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -9,7 +9,7 @@
 struct clk;
 
 struct clk_ops {
-	void (*init)(struct clk *clk);
+	int (*init)(struct clk *clk);
 	void (*enable)(struct clk *clk);
 	void (*disable)(struct clk *clk);
 	void (*recalc)(struct clk *clk);
@@ -36,7 +36,6 @@ struct clk {
 
 #define CLK_ALWAYS_ENABLED	(1 << 0)
 #define CLK_RATE_PROPAGATES	(1 << 1)
-#define CLK_NEEDS_INIT		(1 << 2)
 
 /* Should be defined by processor-specific code */
 void arch_init_clk_ops(struct clk_ops **, int type);
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 133dbe4..c95b603 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -89,24 +89,6 @@ static void propagate_rate(struct clk *clk)
 	}
 }
 
-static void __clk_init(struct clk *clk)
-{
-	/*
-	 * See if this is the first time we're enabling the clock, some
-	 * clocks that are always enabled still require "special"
-	 * initialization. This is especially true if the clock mode
-	 * changes and the clock needs to hunt for the proper set of
-	 * divisors to use before it can effectively recalc.
-	 */
-
-	if (clk->flags & CLK_NEEDS_INIT) {
-		if (clk->ops && clk->ops->init)
-			clk->ops->init(clk);
-
-		clk->flags &= ~CLK_NEEDS_INIT;
-	}
-}
-
 static int __clk_enable(struct clk *clk)
 {
 	if (!clk)
@@ -119,8 +101,6 @@ static int __clk_enable(struct clk *clk)
 		return 0;
 
 	if (clk->usecount = 1) {
-		__clk_init(clk);
-
 		__clk_enable(clk->parent);
 
 		if (clk->ops && clk->ops->enable)
@@ -175,16 +155,20 @@ EXPORT_SYMBOL_GPL(clk_disable);
 
 int clk_register(struct clk *clk)
 {
+	int ret = 0;
+	if (clk->ops && clk->ops->init) {
+		ret = clk->ops->init(clk);
+		if (ret < 0)
+			return ret;
+	}
 	mutex_lock(&clock_list_sem);
 
 	list_add(&clk->node, &clock_list);
 	clk->usecount = 0;
-	clk->flags |= CLK_NEEDS_INIT;
 
 	mutex_unlock(&clock_list_sem);
 
 	if (clk->flags & CLK_ALWAYS_ENABLED) {
-		__clk_init(clk);
 		pr_debug( "Clock '%s' is ALWAYS_ENABLED\n", clk->name);
 		if (clk->ops && clk->ops->enable)
 			clk->ops->enable(clk);
diff --git a/arch/sh/kernel/cpu/sh2/clock-sh7619.c b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
index d2c1579..5549534 100644
--- a/arch/sh/kernel/cpu/sh2/clock-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
@@ -29,9 +29,10 @@ static const int pfc_divisors[] = {1,2,0,4};
 #error "Illigal Clock Mode!"
 #endif
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= PLL2 * pll1rate[(ctrl_inw(FREQCR) >> 8) & 7];
+	return 0;
 }
 
 static struct clk_ops sh7619_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
index 4a5e597..90a183a 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
@@ -32,9 +32,10 @@ static const int pfc_divisors[]={1,2,3,4,6,8,12};
 #error "Illegal Clock Mode!"
 #endif
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate = 10000000 * PLL2 * pll1rate[(ctrl_inw(FREQCR) >> 8) & 0x0007];
+	return 0;
 }
 
 static struct clk_ops sh7201_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
index fb78132..2efd225 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
@@ -37,9 +37,10 @@ static const int pfc_divisors[]={1,2,3,4,6,8,12};
 #error "Illegal Clock Mode!"
 #endif
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pll1rate[(ctrl_inw(FREQCR) >> 8) & 0x0003] * PLL2 ;
+	return 0;
 }
 
 static struct clk_ops sh7203_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
index 82d7f99..f374c7e 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
@@ -32,9 +32,10 @@ static const int pfc_divisors[]={1,2,3,4,6,8,12};
 #error "Illigal Clock Mode!"
 #endif
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= PLL2 * pll1rate[(ctrl_inw(FREQCR) >> 8) & 0x0007];
+	return 0;
 }
 
 static struct clk_ops sh7206_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh3.c b/arch/sh/kernel/cpu/sh3/clock-sh3.c
index c3c9459..47f3591 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh3.c
@@ -26,12 +26,13 @@ static int stc_multipliers[] = { 1, 2, 3, 4, 6, 1, 1, 1 };
 static int ifc_divisors[]    = { 1, 2, 3, 4, 1, 1, 1, 1 };
 static int pfc_divisors[]    = { 1, 2, 3, 4, 6, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	int frqcr = ctrl_inw(FRQCR);
 	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
 
 	clk->rate *= pfc_divisors[idx];
+	return 0;
 }
 
 static struct clk_ops sh3_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7705.c b/arch/sh/kernel/cpu/sh3/clock-sh7705.c
index dfdbf32..2943c46 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7705.c
@@ -30,9 +30,10 @@ static int stc_multipliers[] = { 1, 2, 3, 4, 6, 1, 1, 1 };
 static int ifc_divisors[]    = { 1, 2, 3, 4, 1, 1, 1, 1 };
 static int pfc_divisors[]    = { 1, 2, 3, 4, 6, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[ctrl_inw(FRQCR) & 0x0003];
+	return 0;
 }
 
 static struct clk_ops sh7705_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7706.c b/arch/sh/kernel/cpu/sh3/clock-sh7706.c
index 0cf96f9..6397122 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7706.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7706.c
@@ -22,12 +22,13 @@ static int stc_multipliers[] = { 1, 2, 4, 1, 3, 6, 1, 1 };
 static int ifc_divisors[]    = { 1, 2, 4, 1, 3, 1, 1, 1 };
 static int pfc_divisors[]    = { 1, 2, 4, 1, 3, 6, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	int frqcr = ctrl_inw(FRQCR);
 	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
 
 	clk->rate *= pfc_divisors[idx];
+	return 0;
 }
 
 static struct clk_ops sh7706_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
index b791a29..d24dc08 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -22,19 +22,21 @@ static int stc_multipliers[] = { 1, 2, 4, 8, 3, 6, 1, 1 };
 static int ifc_divisors[]    = { 1, 2, 4, 1, 3, 1, 1, 1 };
 static int pfc_divisors[]    = { 1, 2, 4, 1, 3, 6, 1, 1 };
 
-static void set_bus_parent(struct clk *clk)
+static int set_bus_parent(struct clk *clk)
 {
 	struct clk *bus_clk = clk_get(NULL, "bus_clk");
 	clk->parent = bus_clk;
 	clk_put(bus_clk);
+	return 0;
 }
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	int frqcr = ctrl_inw(FRQCR);
 	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
 
 	clk->rate *= pfc_divisors[idx];
+	return 0;
 }
 
 static struct clk_ops sh7709_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7710.c b/arch/sh/kernel/cpu/sh3/clock-sh7710.c
index 4744c50..fa23605 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7710.c
@@ -24,9 +24,10 @@
 
 static int md_table[] = { 1, 2, 3, 4, 6, 8, 12 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= md_table[ctrl_inw(FRQCR) & 0x0007];
+	return 0;
 }
 
 static struct clk_ops sh7710_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7712.c b/arch/sh/kernel/cpu/sh3/clock-sh7712.c
index 54f54df..50c8033 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7712.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7712.c
@@ -21,12 +21,13 @@
 static int multipliers[] = { 1, 2, 3 };
 static int divisors[]    = { 1, 2, 3, 4, 6 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	int frqcr = ctrl_inw(FRQCR);
 	int idx = (frqcr & 0x0300) >> 8;
 
 	clk->rate *= multipliers[idx];
+	return 0;
 }
 
 static struct clk_ops sh7712_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
index a334294..3128925 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -15,6 +15,7 @@
 #include <asm/clock.h>
 #include <asm/freq.h>
 #include <asm/io.h>
+#include <asm-generic/errno-base.h>
 
 #define CPG2_FRQCR3	0xfe0a0018
 
@@ -66,7 +67,7 @@ static struct clk sh4202_femi_clk = {
 	.ops		= &sh4202_femi_clk_ops,
 };
 
-static void shoc_clk_init(struct clk *clk)
+static int shoc_clk_init(struct clk *clk)
 {
 	int i;
 
@@ -88,6 +89,9 @@ static void shoc_clk_init(struct clk *clk)
 	}
 
 	WARN_ON(i = ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
+	if (i = ARRAY_SIZE(frqcr3_divisors))
+		return -EPERM;
+	return 0;
 }
 
 static void shoc_clk_recalc(struct clk *clk)
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4.c b/arch/sh/kernel/cpu/sh4/clock-sh4.c
index dca9f87..70794ac 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4.c
@@ -26,9 +26,10 @@ static int ifc_divisors[] = { 1, 2, 3, 4, 6, 8, 1, 1 };
 #define bfc_divisors ifc_divisors	/* Same */
 static int pfc_divisors[] = { 2, 3, 4, 6, 8, 2, 2, 2 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[ctrl_inw(FRQCR) & 0x0007];
+	return 0;
 }
 
 static struct clk_ops sh4_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 1ccdfc5..003c6af 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -158,12 +158,13 @@ static void master_clk_recalc(struct clk *clk)
 	clk->rate = CONFIG_SH_PCLK_FREQ * STCPLL(frqcr);
 }
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->parent = NULL;
 	clk->flags |= CLK_RATE_PROPAGATES;
 	clk->rate = CONFIG_SH_PCLK_FREQ;
 	master_clk_recalc(clk);
+	return 0;
 }
 
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
index 3177d0d..934fbdd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
@@ -20,9 +20,10 @@ static int bfc_divisors[] = { 1, 1, 1, 8, 1, 1, 1, 1 };
 static int p0fc_divisors[] = { 1, 1, 1, 8, 1, 1, 1, 1 };
 static int cfc_divisors[] = { 1, 1, 4, 1, 1, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= p0fc_divisors[(ctrl_inl(FRQCR) >> 4) & 0x07];
+	return 0;
 }
 
 static struct clk_ops sh7763_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7770.c b/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
index 8e23606..2d21990 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
@@ -19,9 +19,10 @@ static int ifc_divisors[] = { 1, 1, 1, 1, 1, 1, 1, 1 };
 static int bfc_divisors[] = { 1, 1, 1, 1, 1, 8,12, 1 };
 static int pfc_divisors[] = { 1, 8, 1,10,12,16, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[(ctrl_inl(FRQCR) >> 28) & 0x000f];
+	return 0;
 }
 
 static struct clk_ops sh7770_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
index 01f3da6..fe82df4 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
@@ -20,9 +20,10 @@ static int bfc_divisors[] = { 1, 1, 1, 8, 12, 16, 24, 1 };
 static int pfc_divisors[] = { 1, 24, 24, 1 };
 static int cfc_divisors[] = { 1, 1, 4, 1, 6, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[ctrl_inl(FRQCR) & 0x0003];
+	return 0;
 }
 
 static struct clk_ops sh7780_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index 27fa81b..ca43ad1 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -24,9 +24,10 @@ static int mfc_divisors[] = { 1, 1, 4, 6 };
 static int pfc_divisors[] = { 1, 1, 1, 1, 1, 1, 1, 18,
 			      24, 32, 36, 48, 1, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
+	return 0;
 }
 
 static struct clk_ops sh7785_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index f84a9c1..2d1d3e2 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -27,9 +27,10 @@ static int mfc_divisors[] = { 1, 1, 4, 1 };
 static int pfc_divisors[] = { 1, 1, 1, 1, 1, 1, 16, 1,
 			      24, 32, 1, 48, 1, 1, 1, 1 };
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
+	return 0;
 }
 
 static struct clk_ops sh7786_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index c630b29..7b0f4b8 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -31,9 +31,10 @@ static int cfc_divisors[] = { 1, 1, 4, 6 };
 #define PFC_POS		0
 #define CFC_POS		20
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	clk->rate *= pfc_divisors[(ctrl_inl(FRQCR) >> PFC_POS) & PFC_MSK];
+	return 0;
 }
 
 static struct clk_ops shx3_master_clk_ops = {
diff --git a/arch/sh/kernel/cpu/sh5/clock-sh5.c b/arch/sh/kernel/cpu/sh5/clock-sh5.c
index 5486324..fbbef8d 100644
--- a/arch/sh/kernel/cpu/sh5/clock-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/clock-sh5.c
@@ -22,10 +22,11 @@ static int ifc_table[] = { 2, 4, 6, 8, 10, 12, 16, 24 };
 
 static unsigned long cprc_base;
 
-static void master_clk_init(struct clk *clk)
+static int master_clk_init(struct clk *clk)
 {
 	int idx = (ctrl_inl(cprc_base + 0x00) >> 6) & 0x0007;
 	clk->rate *= ifc_table[idx];
+	return 0;
 }
 
 static struct clk_ops sh5_master_clk_ops = {
diff --git a/arch/sh/kernel/timers/timer-tmu.c b/arch/sh/kernel/timers/timer-tmu.c
index fe8d893..f65987a 100644
--- a/arch/sh/kernel/timers/timer-tmu.c
+++ b/arch/sh/kernel/timers/timer-tmu.c
@@ -164,12 +164,13 @@ static struct irqaction tmu0_irq = {
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
 };
 
-static void __init tmu_clk_init(struct clk *clk)
+static int __init tmu_clk_init(struct clk *clk)
 {
 	u8 divisor  = TMU_TCR_INIT & 0x7;
 	int tmu_num = clk->name[3]-'0';
 	ctrl_outw(TMU_TCR_INIT, TMU0_TCR+(tmu_num*0xC));
 	clk->rate = clk_get_rate(clk->parent) / (4 << (divisor << 1));
+	return 0;
 }
 
 static void tmu_clk_recalc(struct clk *clk)
-- 
1.6.0.6

