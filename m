From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Oct 2010 05:15:14 +0000
Subject: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c        |  136 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 +
 2 files changed, 138 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 4557084..1ec62f9 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -50,6 +50,9 @@
 #define SMSTPCR3	0xe615013c
 #define SMSTPCR4	0xe6150140
 
+#define FSIDIVA		0xFE1F8000
+#define FSIDIVB		0xFE1F8008
+
 /* Platforms must set frequency on their DV_CLKI pin */
 struct clk sh7372_dv_clki_clk = {
 };
@@ -417,6 +420,136 @@ static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
 				      fsibckcr_parent, ARRAY_SIZE(fsibckcr_parent), 6, 2),
 };
 
+/* FSI DIV */
+static unsigned long fsidiv_recalc(struct clk *clk)
+{
+	unsigned long value;
+
+	value = __raw_readl(clk->mapping->base);
+
+	if ((value & 0x3) != 0x3)
+		return 0;
+
+	value >>= 16;
+	if (value < 2)
+		return 0;
+
+	return clk->parent->rate / value;
+}
+
+static long fsidiv_round_rate(struct clk *clk, unsigned long rate)
+{
+	/*
+	 * FSIDIV doesn't have freq_table.
+	 * it mean fsidiv can not use clk_rate_table_round.
+	 * self calculate here
+	 */
+	unsigned long rate_error, rate_error_prev = ~0UL;
+	unsigned long rate_best_fit = rate;
+	unsigned long highest, lowest;
+	int i;
+
+	highest = lowest = 0;
+
+	for (i = 2; i <= 0xffff; i++) {
+		unsigned long freq = clk->parent->rate / i;
+
+		if (freq > highest)
+			highest = freq;
+		if (freq < lowest)
+			lowest = freq;
+
+		rate_error = abs(freq - rate);
+		if (rate_error < rate_error_prev) {
+			rate_best_fit = freq;
+			rate_error_prev = rate_error;
+		}
+
+		if (rate_error = 0)
+			break;
+	}
+
+	if (rate >= highest)
+		rate_best_fit = highest;
+	if (rate <= lowest)
+		rate_best_fit = lowest;
+
+	return rate_best_fit;
+}
+
+static void fsidiv_disable(struct clk *clk)
+{
+	__raw_writel(0, clk->mapping->base);
+}
+
+static int fsidiv_enable(struct clk *clk)
+{
+	unsigned long value;
+
+	value  = __raw_readl(clk->mapping->base) >> 16;
+	if (value < 2) {
+		fsidiv_disable(clk);
+		return -ENOENT;
+	}
+
+	__raw_writel((value << 16) | 0x3, clk->mapping->base);
+
+	return 0;
+}
+
+static int fsidiv_set_rate(struct clk *clk,
+			   unsigned long rate, int algo_id)
+{
+	int idx;
+
+	if (clk->parent->rate = rate) {
+		fsidiv_disable(clk);
+		return 0;
+	}
+
+	idx = (clk->parent->rate / rate) & 0xffff;
+	if (idx < 2)
+		return -ENOENT;
+
+	__raw_writel(idx << 16, clk->mapping->base);
+	return fsidiv_enable(clk);
+}
+
+static struct clk_ops fsidiv_clk_ops = {
+	.recalc		= fsidiv_recalc,
+	.round_rate	= fsidiv_round_rate,
+	.set_rate	= fsidiv_set_rate,
+	.enable		= fsidiv_enable,
+	.disable	= fsidiv_disable,
+};
+
+static struct clk_mapping sh7372_fsidiva_clk_mapping = {
+	.phys	= FSIDIVA,
+	.len	= 8,
+};
+
+struct clk sh7372_fsidiva_clk = {
+	.ops		= &fsidiv_clk_ops,
+	.parent		= &div6_reparent_clks[DIV6_FSIA], /* late install */
+	.mapping	= &sh7372_fsidiva_clk_mapping,
+};
+
+static struct clk_mapping sh7372_fsidivb_clk_mapping = {
+	.phys	= FSIDIVB,
+	.len	= 8,
+};
+
+struct clk sh7372_fsidivb_clk = {
+	.ops		= &fsidiv_clk_ops,
+	.parent		= &div6_reparent_clks[DIV6_FSIB],  /* late install */
+	.mapping	= &sh7372_fsidivb_clk_mapping,
+};
+
+static struct clk *late_main_clks[] = {
+	&sh7372_fsidiva_clk,
+	&sh7372_fsidivb_clk,
+};
+
 enum { MSTP001,
        MSTP131, MSTP130,
        MSTP129, MSTP128, MSTP127, MSTP126,
@@ -582,6 +715,9 @@ void __init sh7372_clock_init(void)
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
+	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
+		ret = clk_register(late_main_clks[k]);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	if (!ret)
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 147775a..e4f9004 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -464,5 +464,7 @@ extern struct clk sh7372_dv_clki_div2_clk;
 extern struct clk sh7372_pllc2_clk;
 extern struct clk sh7372_fsiack_clk;
 extern struct clk sh7372_fsibck_clk;
+extern struct clk sh7372_fsidiva_clk;
+extern struct clk sh7372_fsidivb_clk;
 
 #endif /* __ASM_SH7372_H__ */
-- 
1.7.0.4

