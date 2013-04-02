From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 11:06:41 +0000
Subject: [PATCH 3/6] ARM: shmobile: r8a73a4: add pll clocks
Message-Id: <877gkl5gzm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PLL clocks are basis clock for other clock.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |  107 ++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 42942b4..09fe317 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -33,6 +33,15 @@
 #define SMSTPCR5 0xe6150144
 
 #define CKSCR		0xE61500C0
+#define PLLECR		0xE61500D0
+#define PLL1CR		0xE6150028
+#define PLL2CR		0xE615002C
+#define PLL3CR		0xE61500DC
+#define PLL2SCR		0xE61501F4
+#define PLL2HCR		0xE61501E4
+
+
+#define CPG_MAP(o) ((o - CPG_BASE) + cpg_mapping.base)
 
 static struct clk_mapping cpg_mapping = {
 	.phys   = CPG_BASE,
@@ -82,6 +91,93 @@ static struct clk *main_clks[] = {
 	&main_div2_clk,
 };
 
+/*
+ *		PLL clocks
+ */
+static struct clk *pll_parent_main[] = {
+	[0] = &main_clk,
+	[1] = &main_div2_clk
+};
+
+static struct clk *pll_parent_main_extal[8] = {
+	[0] = &main_div2_clk,
+	[1] = &extal2_div2_clk,
+	[3] = &extal2_div4_clk,
+	[4] = &main_clk,
+	[5] = &extal2_clk,
+};
+
+static unsigned long pll_recalc(struct clk *clk)
+{
+	unsigned long mult = 1;
+
+	if (ioread32(CPG_MAP(PLLECR)) & (1 << clk->enable_bit))
+		mult = (((ioread32(clk->mapped_reg) >> 24) & 0x7f) + 1);
+
+	return clk->parent->rate * mult;
+}
+
+static int pll_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 val;
+	int i, ret;
+
+	if (!clk->parent_table || !clk->parent_num)
+		return -EINVAL;
+
+	/* Search the parent */
+	for (i = 0; i < clk->parent_num; i++)
+		if (clk->parent_table[i] = parent)
+			break;
+
+	if (i = clk->parent_num)
+		return -ENODEV;
+
+	ret = clk_reparent(clk, parent);
+	if (ret < 0)
+		return ret;
+
+	val = ioread32(clk->mapped_reg) &
+		~(((1 << clk->src_width) - 1) << clk->src_shift);
+
+	iowrite32(val | i << clk->src_shift, clk->mapped_reg);
+
+	return 0;
+}
+
+static struct sh_clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
+	.set_parent	= pll_set_parent,
+};
+
+#define PLL_CLOCK(name, parent, w, s, reg, e)		\
+	static struct clk name = {			\
+		.ops		= &pll_clk_ops,		\
+		.flags		= CLK_ENABLE_ON_INIT,	\
+		.parent_table	= parent,		\
+		.parent_num	= ARRAY_SIZE(parent),	\
+		.src_width	= w,			\
+		.src_shift	= s,			\
+		.enable_reg	= (void __iomem *)reg,	\
+		.enable_bit	= e,			\
+		.mapping	= &cpg_mapping,		\
+	}
+
+PLL_CLOCK(pll1_clk,  pll_parent_main,       1, 7, PLL1CR,  1);
+PLL_CLOCK(pll2_clk,  pll_parent_main_extal, 3, 5, PLL2CR,  2);
+PLL_CLOCK(pll2s_clk, pll_parent_main_extal, 3, 5, PLL2SCR, 4);
+PLL_CLOCK(pll2h_clk, pll_parent_main_extal, 3, 5, PLL2HCR, 5);
+
+SH_FIXED_RATIO_CLK(pll1_div2_clk,	pll1_clk,	div2);
+
+static struct clk *pll_clks[] = {
+	&pll1_clk,
+	&pll1_div2_clk,
+	&pll2_clk,
+	&pll2s_clk,
+	&pll2h_clk,
+};
+
 enum {
 	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
 	MSTP522,
@@ -106,6 +202,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("extal2_div2",		&extal2_div2_clk),
 	CLKDEV_CON_ID("extal2_div4",		&extal2_div4_clk),
 
+	/* pll clock */
+	CLKDEV_CON_ID("pll1",			&pll1_clk),
+	CLKDEV_CON_ID("pll1_div2",		&pll1_div2_clk),
+	CLKDEV_CON_ID("pll2",			&pll2_clk),
+	CLKDEV_CON_ID("pll2s",			&pll2s_clk),
+	CLKDEV_CON_ID("pll2h",			&pll2h_clk),
+
+	/* MSTP */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
@@ -156,6 +260,9 @@ void __init r8a73a4_clock_init(void)
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
+	for (k = 0; !ret && (k < ARRAY_SIZE(pll_clks)); k++)
+		ret = sh_clk_reparent_register(pll_clks[k]);
+
 	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
-- 
1.7.9.5

