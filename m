From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:13 +0000
Subject: [PATCH 01/17] sh: introduce sh_clk_ops in parallel with clk_ops
Message-Id: <20120229131613.29154.26316.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Introduce sh_clk_ops in parallel with clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 include/linux/sh_clk.h |    2 ++
 1 file changed, 2 insertions(+)

--- 0014/include/linux/sh_clk.h
+++ work/include/linux/sh_clk.h	2012-02-28 21:38:55.000000000 +0900
@@ -31,6 +31,8 @@ struct clk_mapping {
 	struct kref		ref;
 };
 
+#define sh_clk_ops clk_ops
+
 struct clk_ops {
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 	void (*init)(struct clk *clk);
