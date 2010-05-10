From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:12 +0000
Subject: [PATCH 07/13] sh: Use clkdev for sh7724 div6 clocks
Message-Id: <20100510112412.14587.95013.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7724 clkdev lookups for the div6 clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- 0007/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 19:16:09.000000000 +0900
@@ -164,12 +164,17 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &div3_clk, VCLKCR, 0),
-	SH_CLK_DIV6("fsia_clk", &div3_clk, FCLKACR, 0),
-	SH_CLK_DIV6("fsib_clk", &div3_clk, FCLKBCR, 0),
-	SH_CLK_DIV6("irda_clk", &div3_clk, IRDACLKCR, 0),
-	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
+enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
+
+#define DIV6(_str, _reg, _flags) \
+  SH_CLK_DIV6(_str, &div3_clk, _reg, _flags)
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = DIV6("video_clk", VCLKCR, 0),
+	[DIV6_FA] = DIV6("fsia_clk", FCLKACR, 0),
+	[DIV6_FB] = DIV6("fsib_clk", FCLKBCR, 0),
+	[DIV6_I] = DIV6("irda_clk", IRDACLKCR, 0),
+	[DIV6_S] = DIV6("spu_clk", SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
 #define R_CLK (&r_clk)
@@ -242,6 +247,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 }
 
 static struct clk_lookup lookups[] = {
+	CLKDEV_NO_DEV("video_clk", &div6_clks[DIV6_V]),
+	CLKDEV_NO_DEV("fsia_clk", &div6_clks[DIV6_FA]),
+	CLKDEV_NO_DEV("fsib_clk", &div6_clks[DIV6_FB]),
+	CLKDEV_NO_DEV("irda_clk", &div6_clks[DIV6_I]),
+	CLKDEV_NO_DEV("spu_clk", &div6_clks[DIV6_S]),
+
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -347,6 +358,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_NO_DEV("veu0", &mstp_clks[HWBLK_VEU0]),
 	CLKDEV_NO_DEV("vpu0", &mstp_clks[HWBLK_VPU]),
 	CLKDEV_NO_DEV("lcdc0", &mstp_clks[HWBLK_LCDC]),
+
 };
 
 int __init arch_clk_init(void)
