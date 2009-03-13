From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 13 Mar 2009 08:10:45 +0000
Subject: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <49BA1505.7000500@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010600040006020307050706"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600040006020307050706
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

This patch changes the init field in the clk_ops structure.
Moreover it changes how the init function is used.
Now it's called during registration and if something was wrong the clock 
isn't registered.

Regards
 Francesco

--------------010600040006020307050706
Content-Type: text/x-patch;
 name="0002-sh-clkfwk-Changed-the-init-callback-from-void-to-i.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-sh-clkfwk-Changed-the-init-callback-from-void-to-i.patc";
 filename*1="h"

From 24022f871a04d09a0884fe7e8185871081cad44a Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Fri, 13 Mar 2009 09:03:04 +0100
Subject: [PATCH] sh: clkfwk: Changed the init callback from void to int

This patch changes the clk_ops.init function pointer
to return a value.
Moreover it change the clk_register function to call
always the clk_ops.init function to initilize the clock
if there is an error the clock _isn't_ registered.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h            |    2 +-
 arch/sh/kernel/cpu/clock.c             |   18 +++++-------------
 arch/sh/kernel/cpu/sh2/clock-sh7619.c  |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c |    3 ++-
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh3.c     |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7706.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  |    3 ++-
 arch/sh/kernel/cpu/sh3/clock-sh7712.c  |    3 ++-
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    3 ++-
 arch/sh/kernel/cpu/sh4/clock-sh4.c     |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    3 ++-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    3 ++-
 arch/sh/kernel/cpu/sh5/clock-sh5.c     |    3 ++-
 21 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index 2f6c962..f7a5899 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -10,7 +10,7 @@
 struct clk;
 
 struct clk_ops {
-	void (*init)(struct clk *clk);
+	int (*init)(struct clk *clk);
 	void (*enable)(struct clk *clk);
 	void (*disable)(struct clk *clk);
 	void (*recalc)(struct clk *clk);
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index e2d2451..87a54b5 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -92,17 +92,6 @@ static void propagate_rate(struct clk *clk)
 
 static int __clk_enable(struct clk *clk)
 {
-	/*
-	 * See if this is the first time we're enabling the clock, some
-	 * clocks that are always enabled still require "special"
-	 * initialization. This is especially true if the clock mode
-	 * changes and the clock needs to hunt for the proper set of
-	 * divisors to use before it can effectively recalc.
-	 */
-	if (unlikely(atomic_read(&clk->kref.refcount) == 1))
-		if (clk->ops && clk->ops->init)
-			clk->ops->init(clk);
-
 	kref_get(&clk->kref);
 
 	if (clk->flags & CLK_ALWAYS_ENABLED)
@@ -167,6 +156,11 @@ EXPORT_SYMBOL_GPL(clk_disable);
 
 int clk_register(struct clk *clk)
 {
+
+	if (clk->ops && clk->ops->init)
+		if (clk->ops->init(clk))
+			return -EINVAL;
+
 	mutex_lock(&clock_list_sem);
 
 	list_add(&clk->node, &clock_list);
@@ -176,8 +170,6 @@ int clk_register(struct clk *clk)
 
 	if (clk->flags & CLK_ALWAYS_ENABLED) {
 		pr_debug( "Clock '%s' is ALWAYS_ENABLED\n", clk->name);
-		if (clk->ops && clk->ops->init)
-			clk->ops->init(clk);
 		if (clk->ops && clk->ops->enable)
 			clk->ops->enable(clk);
 		pr_debug( "Enabled.");
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
index b791a29..4cc4006 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -29,12 +29,13 @@ static void set_bus_parent(struct clk *clk)
 	clk_put(bus_clk);
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
index a334294..2c46a51 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -66,7 +66,7 @@ static struct clk sh4202_femi_clk = {
 	.ops		= &sh4202_femi_clk_ops,
 };
 
-static void shoc_clk_init(struct clk *clk)
+static int shoc_clk_init(struct clk *clk)
 {
 	int i;
 
@@ -88,6 +88,7 @@ static void shoc_clk_init(struct clk *clk)
 	}
 
 	WARN_ON(i == ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
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
index 0e174af..bbfbd6f 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -148,12 +148,13 @@ static void master_clk_recalc(struct clk *clk)
 	clk->rate = CONFIG_SH_PCLK_FREQ * (((frqcr >> 24) & 0x1f) + 1);
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
index 52c4924..89abffe 100644
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
-- 
1.5.6.6


--------------010600040006020307050706--
