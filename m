From: Dan Carpenter <error27@gmail.com>
Date: Sun, 20 Mar 2011 11:12:49 +0000
Subject: [patch] sh: clkfwk: potential null deref in debug code
Message-Id: <20110320111249.GH2008@bicker>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This function is designed to accept a NULL for "best_freq" but the
debug code dereferences it unconditionally.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Btw.  Smatch complains that "best" could NULL as well, but I don't
know if actually that's possible so I left it as is.

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index 5f63c3b..dee971c 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -616,7 +616,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 
 		pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
 			 freq->frequency, div, freq_high, div + 1, freq_low,
-			 *best_freq, best->frequency);
+			 best_freq ? *best_freq : -1, best->frequency);
 
 		if (!error)
 			break;
