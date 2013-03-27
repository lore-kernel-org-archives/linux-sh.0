From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 27 Mar 2013 07:55:41 +0000
Subject: [PATCH 3/8] ARM: shmobile: add struct clk_ratio and fixed ratio clock macro
Message-Id: <8738vhi8ee.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renesas chip has many clocks inside,
and some of them are using fixed ratio via parent clock.
Current shmobile clock code is using own divX_recalc function
and divX_clk_ops.
This patch can reduce these code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock.c              |   13 +++++++++
 arch/arm/mach-shmobile/include/mach/clock.h |   39 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/include/mach/clock.h

diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index e816ca9..ad7df62 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
@@ -23,6 +23,19 @@
 #include <linux/init.h>
 #include <linux/sh_clk.h>
 #include <linux/export.h>
+#include <mach/clock.h>
+#include <mach/common.h>
+
+unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk)
+{
+	struct clk_ratio *p = clk->priv;
+
+	return clk->parent->rate / p->div * p->mul;
+};
+
+struct sh_clk_ops shmobile_fixed_ratio_clk_ops = {
+	.recalc	= shmobile_fixed_ratio_clk_recalc,
+};
 
 int __init shmobile_clk_init(void)
 {
diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
new file mode 100644
index 0000000..76ac612
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -0,0 +1,39 @@
+#ifndef CLOCK_H
+#define CLOCK_H
+
+unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
+extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
+
+/* clock ratio */
+struct clk_ratio {
+	int mul;
+	int div;
+};
+
+#define SH_CLK_RATIO(name, m, d)		\
+static struct clk_ratio name ##_ratio = {	\
+	.mul = m,				\
+	.div = d,				\
+}
+
+#define SH_FIXED_RATIO_CLKg(name, p, r)	\
+struct clk name = {			\
+	.parent	= &p,				\
+	.ops	= &shmobile_fixed_ratio_clk_ops,\
+	.priv	= &r ## _ratio,			\
+}
+
+#define SH_FIXED_RATIO_CLK(name, p, r)		\
+static SH_FIXED_RATIO_CLKg(name, p, r);
+
+#define SH_FIXED_RATIO_CLK_SET(name, p, m, d)	\
+	SH_CLK_RATIO(name, m, d);		\
+	SH_FIXED_RATIO_CLK(name, p, name);
+
+#define SH_CLK_SET_RATIO(p, m, d)	\
+{			\
+	(p)->mul = m;	\
+	(p)->div = d;	\
+}
+
+#endif
-- 
1.7.9.5

