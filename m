From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 20 Apr 2009 12:54:04 +0000
Subject: [Proposal][PATCH] sh: clkfwk: Add resume from standby support.
Message-Id: <49EC706C.4000302@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010609090104020108000307"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609090104020108000307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

As already done to resume from hibernation I would add a standard way to
 manage the resume from standby in the clock framework.

To do that each clock has to declare to the clock framework what it has 
to do with the clock it-self.

As general rule during a standby a clock can be:
 - reduced or
 - disabled

therefore in the flags field the clock has to specify what it wants.

The ratio in standby is a specified with the highest 16 bits in the 
flags fields with a rule:

#define CLK_PM_EXP_SHIFT       (24)
#define CLK_PM_RATIO_SHIFT     (16)

ratio = ((clk->flags >> CLK_PM_RATIO_SHIFT) & 0xff) << ((clk->flags >> 
CLK_PM_EXP_SHIFT) & 0xff);

While to enable/disable I'm using the convention that if the

 (clk->flags & CLK_PM_TURNOFF) == CLK_PM_TURNOFF)

than the clock has to be disabled.


In this manned in a single place (where the clock topology is designed) 
the developers
 can design also the configuration during the standby.

What do you think?
Regards
 Francesco

--------------010609090104020108000307
Content-Type: text/x-patch;
 name="0001-sh-clkfwk-Add-resume-from-standby-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sh-clkfwk-Add-resume-from-standby-support.patch"

From 5d0c1dec07c65f8de13c9f60a0465060ec2e5e24 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Mon, 20 Apr 2009 14:26:58 +0200
Subject: [PATCH] sh: clkfwk: Add resume from standby support.

Add the resume from standby support to the clock framework.
Each clock in the flags field specifies how it has to be managed
during a standby operation.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/clock.h |    5 +++
 arch/sh/kernel/cpu/clock.c  |   76 +++++++++++++++++++++++++++++++++---------
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/arch/sh/include/asm/clock.h b/arch/sh/include/asm/clock.h
index 2f6c962..f132db9 100644
--- a/arch/sh/include/asm/clock.h
+++ b/arch/sh/include/asm/clock.h
@@ -38,6 +38,11 @@ struct clk {
 #define CLK_ALWAYS_ENABLED	(1 << 0)
 #define CLK_RATE_PROPAGATES	(1 << 1)
 
+#define CLK_PM_MASK		(0xff)
+#define CLK_PM_EXP_SHIFT	(24)
+#define CLK_PM_RATIO_SHIFT	(16)
+#define CLK_PM_TURNOFF		(CLK_PM_MASK << CLK_PM_EXP_SHIFT)
+
 /* Should be defined by processor-specific code */
 void arch_init_clk_ops(struct clk_ops **, int type);
 int __init arch_clk_init(void);
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 1dc8964..72df119 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -365,30 +365,72 @@ static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
 {
 	static pm_message_t prev_state;
 	struct clk *clkp;
+	unsigned long rate, ratio;
 
 	switch (state.event) {
-	case PM_EVENT_ON:
-		/* Resumeing from hibernation */
-		if (prev_state.event == PM_EVENT_FREEZE) {
-			list_for_each_entry(clkp, &clock_list, node)
-				if (likely(clkp->ops)) {
-					unsigned long rate = clkp->rate;
-
-					if (likely(clkp->ops->set_parent))
-						clkp->ops->set_parent(clkp,
+	case PM_EVENT_ON: /* Resume from: */
+		switch (prev_state.event) {
+		case PM_EVENT_FREEZE: /* Hibernation */
+			list_for_each_entry(clkp, &clock_list, node) {
+				if (!clkp->ops)
+					continue;
+				rate = clkp->rate;
+
+				if (likely(clkp->ops->set_parent))
+					clkp->ops->set_parent(clkp,
 							clkp->parent);
-					if (likely(clkp->ops->set_rate))
-						clkp->ops->set_rate(clkp,
+				if (likely(clkp->ops->set_rate))
+					clkp->ops->set_rate(clkp,
 							rate, NO_CHANGE);
-					else if (likely(clkp->ops->recalc))
-						clkp->ops->recalc(clkp);
-					}
-		}
+				else if (likely(clkp->ops->recalc))
+					clkp->ops->recalc(clkp);
+			}
 		break;
-	case PM_EVENT_FREEZE:
+		case PM_EVENT_SUSPEND: /* Suspend/Standby */
+			list_for_each_entry(clkp, &clock_list, node) {
+				if (!likely(clkp->ops))
+					continue;
+				/* turn-on */
+				if ((clkp->flags & CLK_PM_TURNOFF) == CLK_PM_TURNOFF &&
+				     clkp->ops->enable)
+						clkp->ops->enable(clkp);
+				else
+				if (likely(clkp->ops->set_rate)) {
+					ratio = ((clkp->flags >> CLK_PM_RATIO_SHIFT) & CLK_PM_MASK)
+						<< ((clkp->flags >> CLK_PM_EXP_SHIFT) & CLK_PM_MASK);
+					if (ratio)
+						clkp->ops->set_rate(clkp,
+							clkp->rate * ratio,
+							NO_CHANGE);
+				}
+			}
 		break;
+		}
+	break;
 	case PM_EVENT_SUSPEND:
-		break;
+		/* reduces/turns-off the frequency based
+		 * on the flags directive
+		 */
+		list_for_each_entry_reverse(clkp, &clock_list, node) {
+			if (!clkp->ops)
+				continue;
+			/* turn-off */
+			if ((clkp->flags & CLK_PM_TURNOFF) == CLK_PM_TURNOFF &&
+				clkp->ops->disable)
+					clkp->ops->disable(clkp);
+			else    /* reduce */
+			if (likely(clkp->ops->set_rate)) {
+				ratio = ((clkp->flags >> CLK_PM_RATIO_SHIFT) & CLK_PM_MASK)
+					<< ((clkp->flags >> CLK_PM_EXP_SHIFT) & CLK_PM_MASK);
+				if (ratio)
+					clkp->ops->set_rate(clkp,
+						clkp->rate / ratio,
+						NO_CHANGE);
+			}
+		}
+	break;
+	case PM_EVENT_FREEZE:
+	break;
 	}
 
 	prev_state = state;
-- 
1.6.0.6


--------------010609090104020108000307--
