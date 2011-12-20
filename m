From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Dec 2011 08:53:52 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: clock-r8a7779: clkz/clkzs support
Message-Id: <87zken62ub.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 29c3306..b4b0e8c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -102,9 +102,35 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0), /* TMU2 */
 };
 
+static unsigned long mul4_recalc(struct clk *clk)
+{
+	return clk->parent->rate * 4;
+}
+
+static struct clk_ops mul4_clk_ops = {
+	.recalc		= mul4_recalc,
+};
+
+struct clk clkz_clk = {
+	.ops		= &mul4_clk_ops,
+	.parent		= &div4_clks[DIV4_S],
+};
+
+struct clk clkzs_clk = {
+	/* clks x 4 / 4 = clks */
+	.parent		= &div4_clks[DIV4_S],
+};
+
+static struct clk *late_main_clks[] = {
+	&clkz_clk,
+	&clkzs_clk,
+};
+
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("plla_clk", &plla_clk),
+	CLKDEV_CON_ID("clkz_clk", &clkz_clk),
+	CLKDEV_CON_ID("clkzs_clk", &clkzs_clk),
 
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("shyway_clk",	&div4_clks[DIV4_S]),
@@ -138,6 +164,9 @@ void __init r8a7779_clock_init(void)
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
+	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
+		ret = clk_register(late_main_clks[k]);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	if (!ret)
-- 
1.7.5.4

