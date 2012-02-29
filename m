From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:18:19 +0000
Subject: [PATCH 17/17] sh: remove clk_ops
Message-Id: <20120229131819.29154.63445.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when all clk_ops have been renamed it is 
safe to rename clk_ops to sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 include/linux/sh_clk.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- 0015/include/linux/sh_clk.h
+++ work/include/linux/sh_clk.h	2012-02-28 21:46:18.000000000 +0900
@@ -31,9 +31,8 @@ struct clk_mapping {
 	struct kref		ref;
 };
 
-#define sh_clk_ops clk_ops
 
-struct clk_ops {
+struct sh_clk_ops {
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 	void (*init)(struct clk *clk);
 #endif
@@ -52,7 +51,7 @@ struct clk {
 	unsigned short		parent_num;	/* choose between */
 	unsigned char		src_shift;	/* source clock field in the */
 	unsigned char		src_width;	/* configuration register */
-	struct clk_ops		*ops;
+	struct sh_clk_ops	*ops;
 
 	struct list_head	children;
 	struct list_head	sibling;	/* node for children */
