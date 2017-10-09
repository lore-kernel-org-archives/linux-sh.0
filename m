From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 09 Oct 2017 12:27:45 +0000
Subject: [PATCH] sh: clkfwk: use '"%s:", __func__' instead of function name.
Message-Id: <6394b165cf42e5f226db8f47589a7e0aff15fee2.1507551115.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The script "checkpatch.pl" pointed information out like the following.
WARNING: Prefer using '"%s...", __func__' to using 'sh_clk_init_parent',
this function's name, in a string.

pr_err() strings should end with newlines. Add '\n' to fix this.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/sh/clk/cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 7442bc1..4b5b2f6 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -217,7 +217,7 @@ static int __init sh_clk_init_parent(struct clk *clk)
 		return 0;
 
 	if (!clk->src_width) {
-		pr_err("sh_clk_init_parent: cannot select parent clock\n");
+		pr_err("%s: cannot select parent clock\n", __func__);
 		return -EINVAL;
 	}
 
@@ -225,13 +225,13 @@ static int __init sh_clk_init_parent(struct clk *clk)
 	val &= (1 << clk->src_width) - 1;
 
 	if (val >= clk->parent_num) {
-		pr_err("sh_clk_init_parent: parent table size failed\n");
+		pr_err("%s: parent table size failed\n", __func__);
 		return -EINVAL;
 	}
 
 	clk_reparent(clk, clk->parent_table[val]);
 	if (!clk->parent) {
-		pr_err("sh_clk_init_parent: unable to set parent");
+		pr_err("%s: unable to set parent\n", __func__);
 		return -EINVAL;
 	}
 
-- 
1.9.1

