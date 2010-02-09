From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 08:22:30 +0000
Subject: [PATCH] sh: break out enable/reparent div4 clocks on sh7723
Message-Id: <20100209082230.16804.92759.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Break out sh7723 div4 clocks for SIU and IRDA as
reparent / enable clocks. Similar to the SIU clock
patch for sh7722 by Guennadi.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-02-09 17:14:33.000000000 +0900
@@ -117,8 +117,7 @@ static struct clk_div_mult_table div4_ta
 	.nr_multipliers = ARRAY_SIZE(multipliers),
 };
 
-enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
-       DIV4_SIUA, DIV4_SIUB, DIV4_IRDA, DIV4_NR };
+enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P, DIV4_NR };
 
 #define DIV4(_str, _reg, _bit, _mask, _flags) \
   SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
@@ -130,11 +129,20 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x0dbf, CLK_ENABLE_ON_INIT),
 	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x0db4, CLK_ENABLE_ON_INIT),
 	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x0dbf, 0),
-	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x0dbf, 0),
-	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x0dbf, 0),
+};
+
+enum { DIV4_IRDA, DIV4_ENABLE_NR };
+
+struct clk div4_enable_clks[DIV4_ENABLE_NR] = {
 	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x0dbf, 0),
 };
 
+enum { DIV4_SIUA, DIV4_SIUB, DIV4_REPARENT_NR };
+
+struct clk div4_reparent_clks[DIV4_REPARENT_NR] = {
+	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x0dbf, 0),
+	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x0dbf, 0),
+};
 struct clk div6_clks[] = {
 	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
@@ -216,6 +224,14 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
+		ret = sh_clk_div4_enable_register(div4_enable_clks,
+					DIV4_ENABLE_NR, &div4_table);
+
+	if (!ret)
+		ret = sh_clk_div4_reparent_register(div4_reparent_clks,
+					DIV4_REPARENT_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
