From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:32:06 +0000
Subject: [PATCH 1/2] drivers: sh: clk: Avoid crashes when passing NULL clocks
Message-Id: <1447957927-32738-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-clk@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Several clock API functions handle NULL clocks when the Common Clock
Framework is used, while their legacy SH counterparts don't, and would
just crash when a NULL clock is passed.

Add NULL checks to clk_get_rate(), clk_set_rate(), clk_get_parent(), and
clk_round_rate(), to avoid different behavior in drivers shared between
legacy and CCF-based platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that there are still differences in return values (e.g. zero vs. an
error code). These are not changed, as callers in legacy code may depend
on specific values.
---
 drivers/sh/clk/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index be56b22ca941..c9afc5681474 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -469,6 +469,9 @@ void clk_enable_init_clocks(void)
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return clk->rate;
 }
 EXPORT_SYMBOL_GPL(clk_get_rate);
@@ -478,6 +481,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	int ret = -EOPNOTSUPP;
 	unsigned long flags;
 
+	if (!clk)
+		return 0;
+
 	spin_lock_irqsave(&clock_lock, flags);
 
 	if (likely(clk->ops && clk->ops->set_rate)) {
@@ -535,12 +541,18 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
 
 struct clk *clk_get_parent(struct clk *clk)
 {
+	if (!clk)
+		return NULL;
+
 	return clk->parent;
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
+	if (!clk)
+		return 0;
+
 	if (likely(clk->ops && clk->ops->round_rate)) {
 		unsigned long flags, rounded;
 
-- 
1.9.1

