From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 May 2009 10:31:39 +0000
Subject: [PATCH] sh: call clock framework init() callback once
Message-Id: <20090507103139.31790.67489.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make sure that clk->ops->init() only gets called once in
the case of CLK_ALWAYS_ENABLED. Without this patch the
init() callback may be called multiple times.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/clock.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-05-07 15:00:52.000000000 +0900
@@ -99,15 +99,18 @@ static int __clk_enable(struct clk *clk)
 	 * changes and the clock needs to hunt for the proper set of
 	 * divisors to use before it can effectively recalc.
 	 */
+
+	if (clk->flags & CLK_ALWAYS_ENABLED) {
+		kref_get(&clk->kref);
+		return 0;
+	}
+
 	if (unlikely(atomic_read(&clk->kref.refcount) = 1))
 		if (clk->ops && clk->ops->init)
 			clk->ops->init(clk);
 
 	kref_get(&clk->kref);
 
-	if (clk->flags & CLK_ALWAYS_ENABLED)
-		return 0;
-
 	if (likely(clk->ops && clk->ops->enable))
 		clk->ops->enable(clk);
 
