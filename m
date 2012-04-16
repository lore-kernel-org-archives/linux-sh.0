From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 04:55:58 +0000
Subject: [PATCH 1/3 v2] ARM: mach-shmobile: r8a7740: add usb clock support
Message-Id: <87y5pw5l7o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/clock-r8a7740.c |   86 +++++++++++++++++++++++++++++++-
 1 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 99c4d74..1685553 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -47,6 +47,7 @@
 #define PLLC01CR	0xe6150028
 
 #define SUBCKCR		0xe6150080
+#define USBCKCR		0xe615008c
 
 #define MSTPSR0		0xe6150030
 #define MSTPSR1		0xe6150038
@@ -181,6 +182,70 @@ static struct clk pllc1_div2_clk = {
 	.parent		= &pllc1_clk,
 };
 
+/* USB clock */
+static struct clk *usbckcr_parent[] = {
+	[0] = &system_div2_clk,
+	[1] = &system_clk,
+	[2] = &extal2_div2_clk,
+	[3] = &extal2_clk
+};
+
+static unsigned long usbckcr_recalc(struct clk *clk)
+{
+	return clk->parent->rate;
+};
+
+static int usbckcr_enable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(USBCKCR) & ~(1 << 8), USBCKCR);
+
+	return 0;
+}
+
+static void usbckcr_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(USBCKCR) | (1 << 8), USBCKCR);
+}
+
+static int usbckcr_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret, i;
+	u32 val;
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
+	val = __raw_readl(USBCKCR);
+	val &= ~(0x3 << 6);
+	val |= i << 6;
+	__raw_writel(val, USBCKCR);
+
+	return 0;
+}
+
+static struct sh_clk_ops usbckcr_clk_ops = {
+	.recalc		= usbckcr_recalc,
+	.enable		= usbckcr_enable,
+	.disable	= usbckcr_disable,
+	.set_parent	= usbckcr_set_parent,
+};
+
+static struct clk usbckcr_clk = {
+	.ops		= &usbckcr_clk_ops,
+	.parent		= &system_div2_clk,
+	.parent_table	= usbckcr_parent,
+	.parent_num	= ARRAY_SIZE(usbckcr_parent),
+};
+
 struct clk *main_clks[] = {
 	&extalr_clk,
 	&extal1_clk,
@@ -196,6 +261,7 @@ struct clk *main_clks[] = {
 	&pllc0_clk,
 	&pllc1_clk,
 	&pllc1_div2_clk,
+	&usbckcr_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -223,7 +289,7 @@ static struct clk_div4_table div4_table = {
 
 enum {
 	DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_HP,
-	DIV4_HPP, DIV4_S, DIV4_ZB, DIV4_M3, DIV4_CP,
+	DIV4_HPP, DIV4_USBP, DIV4_S, DIV4_ZB, DIV4_M3, DIV4_CP,
 	DIV4_NR
 };
 
@@ -234,6 +300,7 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_HP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRB,  4, 0x6fff, 0),
 	[DIV4_HPP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 20, 0x6fff, 0),
+	[DIV4_USBP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 16, 0x6fff, 0),
 	[DIV4_S]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 12, 0x6fff, 0),
 	[DIV4_ZB]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  8, 0x6fff, 0),
 	[DIV4_M3]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  4, 0x6fff, 0),
@@ -257,7 +324,9 @@ enum {
 	MSTP222,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
-	MSTP329, MSTP323,
+	MSTP329, MSTP323, MSTP320,
+
+	MSTP416, MSTP407, MSTP406,
 
 	MSTP_NR
 };
@@ -281,6 +350,11 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 	[MSTP329] = SH_CLK_MSTP32(&r_clk,		SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP323] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 20, 0), /* USBF */
+
+	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
+	[MSTP407] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4,  7, 0), /* USB-Func */
+	[MSTP406] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4,  6, 0), /* USB Phy */
 };
 
 static struct clk_lookup lookups[] = {
@@ -335,6 +409,14 @@ static struct clk_lookup lookups[] = {
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
+	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
+
+	/* ICK */
+	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
+	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
+	CLKDEV_ICK_ID("phy",	"renesas_usbhs",	&mstp_clks[MSTP406]),
+	CLKDEV_ICK_ID("pci",	"renesas_usbhs",	&div4_clks[DIV4_USBP]),
+	CLKDEV_ICK_ID("usb24",	"renesas_usbhs",	&usbckcr_clk),
 };
 
 void __init r8a7740_clock_init(u8 md_ck)
-- 
1.7.5.4

