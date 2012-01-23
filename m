From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jan 2012 05:10:02 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh73a0: add DSIxPHY clock support
Message-Id: <871uqrhumx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   16 ++++-
 arch/arm/mach-shmobile/clock-sh73a0.c |  113 +++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..9952f0a 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -321,12 +321,11 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
-#define DSI0PHYCR	0xe615006c
 static int sh_mipi_set_dot_clock(struct platform_device *pdev,
 				 void __iomem *base,
 				 int enable)
 {
-	struct clk *pck;
+	struct clk *pck, *phy;
 	int ret;
 
 	pck = clk_get(&pdev->dev, "dsip_clk");
@@ -335,18 +334,27 @@ static int sh_mipi_set_dot_clock(struct platform_device *pdev,
 		goto sh_mipi_set_dot_clock_pck_err;
 	}
 
+	phy = clk_get(&pdev->dev, "dsiphy_clk");
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		goto sh_mipi_set_dot_clock_phy_err;
+	}
+
 	if (enable) {
 		clk_set_rate(pck, clk_round_rate(pck,  24000000));
-		__raw_writel(0x2a809010, DSI0PHYCR);
+		clk_set_rate(phy, clk_round_rate(pck, 510000000));
 		clk_enable(pck);
+		clk_enable(phy);
 	} else {
 		clk_disable(pck);
+		clk_disable(phy);
 	}
 
 	ret = 0;
 
+	clk_put(phy);
+sh_mipi_set_dot_clock_phy_err:
 	clk_put(pck);
-
 sh_mipi_set_dot_clock_pck_err:
 	return ret;
 }
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index afbead6..7727cca 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -365,6 +365,114 @@ static struct clk div6_clks[DIV6_NR] = {
 			dsi_parent, ARRAY_SIZE(dsi_parent), 12, 3),
 };
 
+/* DSI DIV */
+static unsigned long dsiphy_recalc(struct clk *clk)
+{
+	u32 value;
+
+	value = __raw_readl(clk->mapping->base);
+
+	/* FIXME */
+	if (!(value & 0x000B8000))
+		return clk->parent->rate;
+
+	value &= 0x3f;
+	value += 1;
+
+	if ((value < 12) ||
+	    (value > 33)) {
+		pr_err("DSIPHY has wrong value (%d)", value);
+		return 0;
+	}
+
+	return clk->parent->rate / value;
+}
+
+static long dsiphy_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_rate_mult_range_round(clk, 12, 33, rate);
+}
+
+static void dsiphy_disable(struct clk *clk)
+{
+	u32 value;
+
+	value = __raw_readl(clk->mapping->base);
+	value &= ~0x000B8000;
+
+	__raw_writel(value , clk->mapping->base);
+}
+
+static int dsiphy_enable(struct clk *clk)
+{
+	u32 value;
+	int multi;
+
+	value = __raw_readl(clk->mapping->base);
+	multi = (value & 0x3f) + 1;
+
+	if ((multi < 12) || (multi > 33))
+		return -EIO;
+
+	__raw_writel(value | 0x000B8000, clk->mapping->base);
+
+	return 0;
+}
+
+static int dsiphy_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 value;
+	int idx;
+
+	idx = rate / clk->parent->rate;
+	if ((idx < 12) || (idx > 33))
+		return -EINVAL;
+
+	idx += -1;
+
+	value = __raw_readl(clk->mapping->base);
+	value = (value & ~0x3f) + idx;
+
+	__raw_writel(value, clk->mapping->base);
+
+	return 0;
+}
+
+static struct clk_ops dsiphy_clk_ops = {
+	.recalc		= dsiphy_recalc,
+	.round_rate	= dsiphy_round_rate,
+	.set_rate	= dsiphy_set_rate,
+	.enable		= dsiphy_enable,
+	.disable	= dsiphy_disable,
+};
+
+static struct clk_mapping dsi0phy_clk_mapping = {
+	.phys	= DSI0PHYCR,
+	.len	= 4,
+};
+
+static struct clk_mapping dsi1phy_clk_mapping = {
+	.phys	= DSI1PHYCR,
+	.len	= 4,
+};
+
+static struct clk dsi0phy_clk = {
+	.ops		= &dsiphy_clk_ops,
+	.parent		= &div6_clks[DIV6_DSI0P], /* late install */
+	.mapping	= &dsi0phy_clk_mapping,
+};
+
+static struct clk dsi1phy_clk = {
+	.ops		= &dsiphy_clk_ops,
+	.parent		= &div6_clks[DIV6_DSI1P], /* late install */
+	.mapping	= &dsi1phy_clk_mapping,
+};
+
+static struct clk *late_main_clks[] = {
+	&dsi0phy_clk,
+	&dsi1phy_clk,
+};
+
 enum { MSTP001,
 	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
@@ -429,6 +537,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
 	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
+	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
+	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
@@ -504,6 +614,9 @@ void __init sh73a0_clock_init(void)
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
+	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
+		ret = clk_register(late_main_clks[k]);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	if (!ret)
-- 
1.7.5.4

