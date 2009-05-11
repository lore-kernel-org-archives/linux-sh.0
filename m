From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 11 May 2009 09:26:13 +0000
Subject: Re: [Proposal][PATCH] sh: clkfw: Moved the .init callback in the
Message-Id: <4A07EF35.7040707@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070207020803030504090207"
List-Id: <linux-sh.vger.kernel.org>
References: <4A07EAFC.2080906@st.com>
In-Reply-To: <4A07EAFC.2080906@st.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------070207020803030504090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry... THe attached was broken.
Here the right patch,
Ciao
 Francesco
Francesco VIRLINZI ha scritto:
> Hi Magnus
> Here there is the patch to move the .init callback during the clock 
> registration.
> Currently the __clk_init returns always zero...
> in the next step if the __clk_init fails the clock registration will 
> be rejected.
>
> Let me know.
> Ciao
> Francesco


--------------070207020803030504090207
Content-Type: text/x-patch;
 name="0001-sh-clkfw-Moved-the-.init-callback-in-the-clk_regis.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sh-clkfw-Moved-the-.init-callback-in-the-clk_regis.patc";
 filename*1="h"

From 8b11a6b0fac5d0bbd85b43c1f5e51c006e32ffbb Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Mon, 11 May 2009 11:04:11 +0200
Subject: [PATCH] sh: clkfw: Moved the .init callback in the clk_register function

This patch moves the .init callback function in the clk_register

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h |    3 +--
 arch/sh/kernel/cpu/clock.c  |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

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
index 133dbe4..16b5cca 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -89,8 +89,9 @@ static void propagate_rate(struct clk *clk)
 	}
 }
 
-static void __clk_init(struct clk *clk)
+static int __clk_init(struct clk *clk)
 {
+	int ret = 0;
 	/*
 	 * See if this is the first time we're enabling the clock, some
 	 * clocks that are always enabled still require "special"
@@ -99,12 +100,11 @@ static void __clk_init(struct clk *clk)
 	 * divisors to use before it can effectively recalc.
 	 */
 
-	if (clk->flags & CLK_NEEDS_INIT) {
-		if (clk->ops && clk->ops->init)
-			clk->ops->init(clk);
+	if (clk->ops && clk->ops->init)
+		clk->ops->init(clk);	/* First step... */
+/*		ret = clk->ops->init(clk); ... Next step...*/
 
-		clk->flags &= ~CLK_NEEDS_INIT;
-	}
+	return ret;
 }
 
 static int __clk_enable(struct clk *clk)
@@ -119,8 +119,6 @@ static int __clk_enable(struct clk *clk)
 		return 0;
 
 	if (clk->usecount == 1) {
-		__clk_init(clk);
-
 		__clk_enable(clk->parent);
 
 		if (clk->ops && clk->ops->enable)
@@ -175,16 +173,18 @@ EXPORT_SYMBOL_GPL(clk_disable);
 
 int clk_register(struct clk *clk)
 {
+
+	if (__clk_init(clk))	/* it does every hardware initialization */
+		return -EPERM;	/* and checks they were ok */
+
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
-- 
1.6.0.6


--------------070207020803030504090207--
