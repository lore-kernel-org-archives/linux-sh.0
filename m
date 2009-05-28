From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 12:52:29 +0000
Subject: [PATCH] sh: shared mstp32 clock code
Message-Id: <20090528125229.6462.23713.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add shared 32-bit module stop bit clock support.

Processor specific code can use SH_CLK_MSTP32()
to initialize module stop bit clocks, and then
use sh_clk_mstp32() for registration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h    |   13 +++++++++++++
 arch/sh/kernel/cpu/clock-cpg.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-28 16:56:09.000000000 +0900
@@ -117,4 +117,17 @@ long clk_rate_table_round(struct clk *cl
 			  struct cpufreq_frequency_table *freq_table,
 			  unsigned long rate);
 
+#define SH_CLK_MSTP32(_name, _id, _parent, _enable_reg,	\
+	    _enable_bit, _flags)			\
+{							\
+	.name		= _name,			\
+	.id		= _id,				\
+	.parent		= _parent,			\
+	.enable_reg	= (void __iomem *)_enable_reg,	\
+	.enable_bit	= _enable_bit,			\
+	.flags		= _flags,			\
+}
+
+int sh_clk_mstp32_register(struct clk *clks, int nr);
+
 #endif /* __ASM_SH_CLOCK_H */
--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2009-05-28 20:37:03.000000000 +0900
@@ -1,7 +1,42 @@
 #include <linux/clk.h>
 #include <linux/compiler.h>
+#include <linux/io.h>
 #include <asm/clock.h>
 
+static int sh_clk_mstp32_enable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
+		     clk->enable_reg);
+	return 0;
+}
+
+static void sh_clk_mstp32_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->enable_reg) | (1 << clk->enable_bit),
+		     clk->enable_reg);
+}
+
+static struct clk_ops sh_clk_mstp32_clk_ops = {
+	.enable		= sh_clk_mstp32_enable,
+	.disable	= sh_clk_mstp32_disable,
+	.recalc		= followparent_recalc,
+};
+
+int __init sh_clk_mstp32_register(struct clk *clks, int nr)
+{
+	struct clk *clkp;
+	int ret = 0;
+	int k;
+
+	for (k = 0; !ret && (k < nr); k++) {
+		clkp = clks + k;
+		clkp->ops = &sh_clk_mstp32_clk_ops;
+		ret = clk_register(clkp);
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_SH_CLK_CPG_LEGACY
 static struct clk master_clk = {
 	.name		= "master_clk",
