From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 27 Jun 2012 00:59:01 +0000
Subject: [PATCH 3/3] sh: clkfwk: Remove sh_clk_mstp32_register function
Message-Id: <1340758741-565-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_clk_mstp32_register is deprecated.
There is not the code using this function. Therefore, this delete it.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 include/linux/sh_clk.h |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index c513b73..207581b 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -129,17 +129,6 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 
 int sh_clk_mstp_register(struct clk *clks, int nr);
 
-/*
- * MSTP registration never really cared about access size, despite the
- * original enable/disable pairs assuming a 32-bit access. Clocks are
- * responsible for defining their access sizes either directly or via the
- * clock definition wrappers.
- */
-static inline int __deprecated sh_clk_mstp32_register(struct clk *clks, int nr)
-{
-	return sh_clk_mstp_register(clks, nr);
-}
-
 #define SH_CLK_DIV4(_parent, _reg, _shift, _div_bitmap, _flags)	\
 {								\
 	.parent = _parent,					\
-- 
1.7.10

