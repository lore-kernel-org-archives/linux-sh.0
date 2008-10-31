From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:13:32 +0000
Subject: [PATCH] sh: enable and disable clocks recursively
Message-Id: <20081031111332.2962.27525.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Recurse and make sure parent clocks get enabled/disabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/clock.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2008-10-31 17:28:18.000000000 +0900
@@ -117,6 +117,11 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret;
 
+	if (!clk)
+		return -EINVAL;
+
+	clk_enable(clk->parent);
+
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);
 	spin_unlock_irqrestore(&clock_lock, flags);
@@ -147,9 +152,14 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
+	if (!clk)
+		return -EINVAL;
+
 	spin_lock_irqsave(&clock_lock, flags);
 	__clk_disable(clk);
 	spin_unlock_irqrestore(&clock_lock, flags);
+
+	clk_disable(clk->parent);
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
