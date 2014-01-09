From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 09 Jan 2014 15:23:20 +0000
Subject: [PATCH V2 1/4] ARM: shmobile: r8a7791: Add ZS clock
Message-Id: <1389281003-10253-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds fixed ratio zs_clk to R8A7791 clocks.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 1074ba4..52d7d13 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -113,6 +113,7 @@ SH_FIXED_RATIO_CLK_SET(rclk_clk,		pll1_clk,	1, (48 * 1024));
 SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
 SH_FIXED_RATIO_CLK_SET(zg_clk,			pll1_clk,	1, 3);
 SH_FIXED_RATIO_CLK_SET(zx_clk,			pll1_clk,	1, 3);
+SH_FIXED_RATIO_CLK_SET(zs_clk,			pll1_clk,	1, 6);
 
 static struct clk *main_clks[] = {
 	&extal_clk,
@@ -128,6 +129,7 @@ static struct clk *main_clks[] = {
 	&cp_clk,
 	&zg_clk,
 	&zx_clk,
+	&zs_clk,
 };
 
 /* MSTP */
@@ -187,6 +189,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pll1_div2",	&pll1_div2_clk),
 	CLKDEV_CON_ID("pll3",		&pll3_clk),
 	CLKDEV_CON_ID("zg",		&zg_clk),
+	CLKDEV_CON_ID("zs",		&zs_clk),
 	CLKDEV_CON_ID("hp",		&hp_clk),
 	CLKDEV_CON_ID("p",		&p_clk),
 	CLKDEV_CON_ID("rclk",		&rclk_clk),
-- 
1.8.3.1

