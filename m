From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 22 Aug 2011 05:45:50 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM/Kota2 external Ethernet fix
Message-Id: <20110822054550.12925.52928.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Keep the ZB clock enabled on sh73a0 to allow the BSC
to access external peripherals hooked up to CS signals.

This is needed to unbreak Ethernet support on sh73a0 boards
such as AG5EVM and Kota2 together with the following patch:

 794d78f drivers: sh: late disabling of clocks V2

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-08-22 14:31:42.000000000 +0900
@@ -243,7 +243,7 @@ static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_VCK1] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR1, 0),
 	[DIV6_VCK2] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR2, 0),
 	[DIV6_VCK3] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR3, 0),
-	[DIV6_ZB1] = SH_CLK_DIV6(&pll1_div2_clk, ZBCKCR, 0),
+	[DIV6_ZB1] = SH_CLK_DIV6(&pll1_div2_clk, ZBCKCR, CLK_ENABLE_ON_INIT),
 	[DIV6_FLCTL] = SH_CLK_DIV6(&pll1_div2_clk, FLCKCR, 0),
 	[DIV6_SDHI0] = SH_CLK_DIV6(&pll1_div2_clk, SD0CKCR, 0),
 	[DIV6_SDHI1] = SH_CLK_DIV6(&pll1_div2_clk, SD1CKCR, 0),
