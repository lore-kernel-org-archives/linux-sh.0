From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 22 Aug 2016 08:38:52 +0000
Subject: [PATCH] sh: clkfwk: remove unnecessary for failing to alloc mem
Message-Id: <1471855132-15448-1-git-send-email-shawn.lin@rock-chips.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

kzalloc will print err there, so we don't need this extra one.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/sh/clk/cpg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 7442bc1..7b98937 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -250,10 +250,8 @@ static int __init sh_clk_div_register_ops(struct clk *clks, int nr,
 
 	freq_table_size *= (nr_divs + 1);
 	freq_table = kzalloc(freq_table_size * nr, GFP_KERNEL);
-	if (!freq_table) {
-		pr_err("%s: unable to alloc memory\n", __func__);
+	if (!freq_table)
 		return -ENOMEM;
-	}
 
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
-- 
2.3.7


