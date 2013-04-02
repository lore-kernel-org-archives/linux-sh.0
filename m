From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 11:06:50 +0000
Subject: [PATCH 4/6] ARM: shmobile: r8a73a4: add div4 clocks
Message-Id: <8762055gzd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DIV4 clocks control each core clocks.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |   48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 09fe317..0149bbf 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -32,6 +32,8 @@
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR5 0xe6150144
 
+#define FRQCRA		0xE6150000
+#define FRQCRB		0xE6150004
 #define CKSCR		0xE61500C0
 #define PLLECR		0xE61500D0
 #define PLL1CR		0xE6150028
@@ -178,6 +180,49 @@ static struct clk *pll_clks[] = {
 	&pll2h_clk,
 };
 
+/* DIV4 */
+static void div4_kick(struct clk *clk)
+{
+	unsigned long value;
+
+	/* set KICK bit in FRQCRB to update hardware setting */
+	value = ioread32(CPG_MAP(FRQCRB));
+	value |= (1 << 31);
+	iowrite32(value, CPG_MAP(FRQCRB));
+}
+
+static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18, 24, 0, 36, 48, 10};
+
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors	= divisors,
+	.nr_divisors	= ARRAY_SIZE(divisors),
+};
+
+static struct clk_div4_table div4_table = {
+	.div_mult_table	= &div4_div_mult_table,
+	.kick		= div4_kick,
+};
+
+enum {
+	DIV4_I, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
+	DIV4_ZTR, DIV4_ZT, DIV4_ZX, DIV4_ZS, DIV4_HP,
+	DIV4_NR };
+
+static struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I]	= SH_CLK_DIV4(&pll1_clk, FRQCRA, 20, 0x0dff, CLK_ENABLE_ON_INIT),
+	[DIV4_M3]	= SH_CLK_DIV4(&pll1_clk, FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT),
+	[DIV4_B]	= SH_CLK_DIV4(&pll1_clk, FRQCRA,  8, 0x0dff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1]	= SH_CLK_DIV4(&pll1_clk, FRQCRA,  4, 0x1dff, 0),
+	[DIV4_M2]	= SH_CLK_DIV4(&pll1_clk, FRQCRA,  0, 0x1dff, 0),
+	/* ignore ZGFC */
+	[DIV4_ZTR]	= SH_CLK_DIV4(&pll1_clk, FRQCRB, 20, 0x0dff, 0),
+	[DIV4_ZT]	= SH_CLK_DIV4(&pll1_clk, FRQCRB, 16, 0x0dff, 0),
+	[DIV4_ZX]	= SH_CLK_DIV4(&pll1_clk, FRQCRB, 12, 0x0dff, 0),
+	[DIV4_ZS]	= SH_CLK_DIV4(&pll1_clk, FRQCRB,  8, 0x0dff, 0),
+	[DIV4_HP]	= SH_CLK_DIV4(&pll1_clk, FRQCRB,  4, 0x0dff, 0),
+};
+
+/* MSTP */
 enum {
 	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
 	MSTP522,
@@ -264,6 +309,9 @@ void __init r8a73a4_clock_init(void)
 		ret = sh_clk_reparent_register(pll_clks[k]);
 
 	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.9.5

