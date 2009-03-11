From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 07:40:54 +0000
Subject: [PATCH] sh_clk: added clk_set_parent/clk_get_parent v2
Message-Id: <49B76B06.50602@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050600020602060606080704"
List-Id: <linux-sh.vger.kernel.org>
References: <49B66867.2010406@st.com>
In-Reply-To: <49B66867.2010406@st.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------050600020602060606080704
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit



--------------050600020602060606080704
Content-Type: text/x-patch;
 name="0002-sh_clk-Add-clk_set_parent-clk_get_parent-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-sh_clk-Add-clk_set_parent-clk_get_parent-support.patch"

From 96d7aa00af83ecb4a3660ace507221b959aa12f1 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 08:09:16 +0100
Subject: [PATCH] sh_clk: Add clk_set_parent/clk_get_parent support

This patch adds the clk_set_parent/clk_get_parent in the sh clock framework

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h |    1 +
 arch/sh/kernel/cpu/clock.c  |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index f9c8858..2f6c962 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -15,6 +15,7 @@ struct clk_ops {
 	void (*disable)(struct clk *clk);
 	void (*recalc)(struct clk *clk);
 	int (*set_rate)(struct clk *clk, unsigned long rate, int algo_id);
+	int (*set_parent)(struct clk *clk, struct clk *parent);
 	long (*round_rate)(struct clk *clk, unsigned long rate);
 };
 
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 7b17137..332a179 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -239,6 +239,35 @@ void clk_recalc_rate(struct clk *clk)
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
-- 
1.5.6.6


--------------050600020602060606080704--
