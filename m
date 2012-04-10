From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 10 Apr 2012 13:00:50 +0000
Subject: [PATCH 1/4] sh: Add support for 8-bit module stop registers
Message-Id: <1334062853-23045-2-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh2a uses the same mechanism for module stop, but uses 8-bit regs
containing the module stops bits, rather than 32-bit regs.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/sh/clk/cpg.c   |   34 ++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 91b6d52..10e2b94 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -13,6 +13,25 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 
+static int sh_clk_mstp8_enable(struct clk *clk)
+{
+	__raw_writeb(__raw_readb(clk->enable_reg) & ~(1 << clk->enable_bit),
+		     clk->enable_reg);
+	return 0;
+}
+
+static void sh_clk_mstp8_disable(struct clk *clk)
+{
+	__raw_writeb(__raw_readb(clk->enable_reg) | (1 << clk->enable_bit),
+		     clk->enable_reg);
+}
+
+static struct sh_clk_ops sh_clk_mstp8_clk_ops = {
+	.enable		= sh_clk_mstp8_enable,
+	.disable	= sh_clk_mstp8_disable,
+	.recalc		= followparent_recalc,
+};
+
 static int sh_clk_mstp32_enable(struct clk *clk)
 {
 	iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
@@ -32,6 +51,21 @@ static struct sh_clk_ops sh_clk_mstp32_clk_ops = {
 	.recalc		= followparent_recalc,
 };
 
+int __init sh_clk_mstp8_register(struct clk *clks, int nr)
+{
+	struct clk *clkp;
+	int ret = 0;
+	int k;
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+		clkp->ops = &sh_clk_mstp8_clk_ops;
+		ret |= clk_register(clkp);
+	}
+
+	return ret;
+}
+
 int __init sh_clk_mstp32_register(struct clk *clks, int nr)
 {
 	struct clk *clkp;
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 0a9d8f2..211d173 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -110,6 +110,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 	.flags		= _flags,					\
 }
 
+int sh_clk_mstp8_register(struct clk *clks, int nr);
 int sh_clk_mstp32_register(struct clk *clks, int nr);
 
 #define SH_CLK_DIV4(_parent, _reg, _shift, _div_bitmap, _flags)	\
-- 
1.7.0.4

