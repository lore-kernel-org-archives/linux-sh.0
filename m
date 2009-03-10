From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 10 Mar 2009 13:17:27 +0000
Subject: [PATCH] sh_clk: added clk_set_parent/clk_get_parent support
Message-Id: <49B66867.2010406@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020205080306070107070206"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------020205080306070107070206
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

I would add the following functions in the clock framework
 - clk_set_parent
 - clk_get_parent

and the utility function
 - clk_for_each

Regards
 Francesco

--------------020205080306070107070206
Content-Type: text/x-patch;
 name="0002-Clk-set_parent-get_parent.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Clk-set_parent-get_parent.patch"

From 8b12a8d0c9d8adb86c70debbd2318ae7ef57784b Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Tue, 10 Mar 2009 08:46:11 +0100
Subject: [PATCH] Clk set_parent/get_parent

This patch:
 - adds set_parent/get_parent support
 - adds clk_for_each utility function
 - changes the callback function to return a value

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h |    9 ++++--
 arch/sh/kernel/cpu/clock.c  |   61 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index f9c8858..133f270 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -10,11 +10,12 @@
 struct clk;
 
 struct clk_ops {
-	void (*init)(struct clk *clk);
-	void (*enable)(struct clk *clk);
-	void (*disable)(struct clk *clk);
+	int (*init)(struct clk *clk);
+	int (*enable)(struct clk *clk);
+	int (*disable)(struct clk *clk);
 	void (*recalc)(struct clk *clk);
 	int (*set_rate)(struct clk *clk, unsigned long rate, int algo_id);
+	int (*set_parent)(struct clk *clk, struct clk *parent);
 	long (*round_rate)(struct clk *clk, unsigned long rate);
 };
 
@@ -49,6 +50,8 @@ void clk_recalc_rate(struct clk *);
 int clk_register(struct clk *);
 void clk_unregister(struct clk *);
 
+int clk_for_each(int (*fn)(struct clk *clk, void *data), void *data);
+
 static inline int clk_always_enable(const char *id)
 {
 	struct clk *clk;
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 7b17137..dc53def 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -135,28 +135,34 @@ static void clk_kref_release(struct kref *kref)
 	/* Nothing to do */
 }
 
-static void __clk_disable(struct clk *clk)
+static int __clk_disable(struct clk *clk)
 {
 	int count = kref_put(&clk->kref, clk_kref_release);
+	int ret = -EINVAL;
 
 	if (clk->flags & CLK_ALWAYS_ENABLED)
-		return;
+		return ret;
 
 	if (!count) {	/* count reaches zero, disable the clock */
 		if (likely(clk->ops && clk->ops->disable))
-			clk->ops->disable(clk);
+			if (!clk->ops->disable(clk)) {
+				clk->rate = 0;
+				ret = 0;
+			}
 	}
+	return ret;
 }
 
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+	int ret;
 
 	if (!clk)
 		return;
 
 	spin_lock_irqsave(&clock_lock, flags);
-	__clk_disable(clk);
+	ret = __clk_disable(clk);
 	spin_unlock_irqrestore(&clock_lock, flags);
 
 	clk_disable(clk->parent);
@@ -239,6 +245,35 @@ void clk_recalc_rate(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_recalc_rate);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret = -EINVAL;
+	struct clk *old;
+
+	if (!parent || !clk)
+		return ret;
+
+	old = clk->parent;
+	if (likely(clk->ops && clk->ops->set_parent)) {
+		unsigned long flags;
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_parent(clk, parent);
+		spin_unlock_irqrestore(&clock_lock, flags);
+		clk->parent = (ret ? old : parent);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+		propagate_rate(clk);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
+
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	if (likely(clk->ops && clk->ops->round_rate)) {
@@ -255,6 +290,24 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+int clk_for_each(int (*fn)(struct clk *clk, void *data), void *data)
+{
+	struct clk *clkp;
+	int ret = 0;
+
+	if (!fn)
+		return -EINVAL;
+
+	mutex_lock(&clock_list_sem);
+
+	list_for_each_entry(clkp, &clock_list, node)
+		ret |= fn(clkp, data);
+
+	mutex_unlock(&clock_list_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_for_each);
+
 /*
  * Returns a clock. Note that we first try to use device id on the bus
  * and clock name. If this fails, we try to use clock name only.
-- 
1.5.6.6


--------------020205080306070107070206--
