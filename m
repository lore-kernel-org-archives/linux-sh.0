From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:15:07 +0000
Subject: [PATCH] sh: new sh_mobile mstpcr clocks base code
Message-Id: <20081031111507.2967.56963.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add base code to handle new mstpcr clocks. Make sure clock rates propagate.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   45 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)


--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-31 17:20:13.000000000 +0900
@@ -516,16 +516,19 @@ static struct clk_ops sh7722_video_clk_o
 static struct clk sh7722_umem_clock = {
 	.name = "umem_clk",
 	.ops = &sh7722_frqcr_clk_ops,
+	.flags = CLK_RATE_PROPAGATES,
 };
 
 static struct clk sh7722_sh_clock = {
 	.name = "sh_clk",
 	.ops = &sh7722_frqcr_clk_ops,
+	.flags = CLK_RATE_PROPAGATES,
 };
 
 static struct clk sh7722_peripheral_clock = {
 	.name = "peripheral_clk",
 	.ops = &sh7722_frqcr_clk_ops,
+	.flags = CLK_RATE_PROPAGATES,
 };
 
 static struct clk sh7722_sdram_clock = {
@@ -533,6 +536,11 @@ static struct clk sh7722_sdram_clock = {
 	.ops = &sh7722_frqcr_clk_ops,
 };
 
+static struct clk sh7722_r_clock = {
+	.name = "r_clk",
+	.rate = 32768,
+	.flags = CLK_RATE_PROPAGATES,
+};
 
 #ifndef CONFIG_CPU_SUBTYPE_SH7343
 
@@ -612,9 +620,16 @@ static void sh7722_mstpcr_disable(struct
 	sh7722_mstpcr_start_stop(clk, 0);
 }
 
+static void sh7722_mstpcr_recalc(struct clk *clk)
+{
+	if (clk->parent)
+		clk->rate = clk->parent->rate;
+}
+
 static struct clk_ops sh7722_mstpcr_clk_ops = {
 	.enable = sh7722_mstpcr_enable,
 	.disable = sh7722_mstpcr_disable,
+	.recalc = sh7722_mstpcr_recalc,
 };
 
 #define DECLARE_MSTPCRN(regnr, bitnr, bitstr)		\
@@ -664,6 +679,16 @@ static struct clk sh7722_mstpcr[] = {
 	DECLARE_MSTPCR(2),
 };
 
+#define MSTPCR(_name, _parent, regnr, bitnr) \
+{						\
+	.name = _name,				\
+	.arch_flags = MSTPCR_ARCH_FLAGS(regnr, bitnr),	\
+	.ops = (void *)_parent,		\
+}
+
+static struct clk sh7722_mstpcr_clocks[] = {
+};
+
 static struct clk *sh7722_clocks[] = {
 	&sh7722_umem_clock,
 	&sh7722_sh_clock,
@@ -698,16 +723,28 @@ arch_init_clk_ops(struct clk_ops **ops, 
 
 int __init arch_clk_init(void)
 {
-	struct clk *master;
+	struct clk *clk;
 	int i;
 
-	master = clk_get(NULL, "master_clk");
+	clk = clk_get(NULL, "master_clk");
 	for (i = 0; i < ARRAY_SIZE(sh7722_clocks); i++) {
 		pr_debug( "Registering clock '%s'\n", sh7722_clocks[i]->name);
-		sh7722_clocks[i]->parent = master;
+		sh7722_clocks[i]->parent = clk;
 		clk_register(sh7722_clocks[i]);
 	}
-	clk_put(master);
+	clk_put(clk);
+
+	clk_register(&sh7722_r_clock);
+
+	for (i = 0; i < ARRAY_SIZE(sh7722_mstpcr_clocks); i++) {
+		pr_debug( "Registering mstpcr clock '%s'\n",
+			  sh7722_mstpcr_clocks[i].name);
+		clk = clk_get(NULL, (void *) sh7722_mstpcr_clocks[i].ops);
+		sh7722_mstpcr_clocks[i].parent = clk;
+		sh7722_mstpcr_clocks[i].ops = &sh7722_mstpcr_clk_ops;
+		clk_register(&sh7722_mstpcr_clocks[i]);
+		clk_put(clk);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(sh7722_mstpcr); i++) {
 		pr_debug( "Registering mstpcr '%s'\n", sh7722_mstpcr[i].name);
