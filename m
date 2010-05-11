From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:58 +0000
Subject: [PATCH 03/09] sh: sh7366 mstp32 index rework
Message-Id: <20100511045958.26302.23975.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7366 MSTP enums for mstp_clks[] index.
The MSTP bit for the SIU is removed as well since it is
not included in the documentation. Most likely an old
copy paste error from sh7722.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   92 +++++++++++++++++---------------
 1 file changed, 50 insertions(+), 42 deletions(-)

--- 0008/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-11 12:31:39.000000000 +0900
@@ -148,48 +148,56 @@ struct clk div6_clks[DIV6_NR] = {
 #define MSTP(_str, _parent, _reg, _bit, _flags) \
   SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
 
-static struct clk mstp_clks[] = {
+enum { MSTP031, MSTP030, MSTP029, MSTP028, MSTP026,
+       MSTP023, MSTP022, MSTP021, MSTP020, MSTP019, MSTP018, MSTP017, MSTP016,
+       MSTP015, MSTP014, MSTP013, MSTP012, MSTP011, MSTP010,
+       MSTP007, MSTP006, MSTP005, MSTP002, MSTP001,
+       MSTP109, MSTP100,
+       MSTP227, MSTP226, MSTP224, MSTP223, MSTP222, MSTP218, MSTP217,
+       MSTP211, MSTP207, MSTP205, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+       MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
 	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
-	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
-	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
-	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
-	MSTP("rsmem0", &div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
-	MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
-	MSTP("intc3", &div4_clks[DIV4_P], MSTPCR0, 23, 0),
-	MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 0),
-	MSTP("dmac0", &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	MSTP("sh0", &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0),
-	MSTP("ubc0", &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	MSTP("tmu_fck", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
-	MSTP("cmt_fck", &r_clk, MSTPCR0, 14, 0),
-	MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
-	MSTP("mfi0", &div4_clks[DIV4_P], MSTPCR0, 11, 0),
-	MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
-	SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 7, 0),
-	SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 6, 0),
-	SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
-	MSTP("msiof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
-	MSTP("sbr0", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
-
-	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
-
-	MSTP("icb0", &div4_clks[DIV4_P], MSTPCR2, 27, 0),
-	MSTP("meram0", &div4_clks[DIV4_P], MSTPCR2, 26, 0),
-	MSTP("dacy1", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
-	MSTP("dacy0", &div4_clks[DIV4_P], MSTPCR2, 23, 0),
-	MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 22, 0),
-	MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
-	MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
-	MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
-	MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 9, 0),
-	MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 7, CLK_ENABLE_ON_INIT),
-	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
-	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
-	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
-	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
-	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
-	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
+	[MSTP031] = MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	[MSTP030] = MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	[MSTP029] = MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	[MSTP028] = MSTP("rsmem0", &div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	[MSTP026] = MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	[MSTP023] = MSTP("intc3", &div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = MSTP("dmac0", &div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = MSTP("sh0", &div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP019] = MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0),
+	[MSTP017] = MSTP("ubc0", &div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP015] = MSTP("tmu_fck", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = MSTP("cmt_fck", &r_clk, MSTPCR0, 14, 0),
+	[MSTP013] = MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
+	[MSTP011] = MSTP("mfi0", &div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP007] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	[MSTP006] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	[MSTP005] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	[MSTP002] = MSTP("msiof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP001] = MSTP("sbr0", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	[MSTP109] = MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
+
+	[MSTP227] = MSTP("icb0", &div4_clks[DIV4_P], MSTPCR2, 27, 0),
+	[MSTP226] = MSTP("meram0", &div4_clks[DIV4_P], MSTPCR2, 26, 0),
+	[MSTP224] = MSTP("dacy1", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	[MSTP223] = MSTP("dacy0", &div4_clks[DIV4_P], MSTPCR2, 23, 0),
+	[MSTP222] = MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 22, 0),
+	[MSTP218] = MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	[MSTP217] = MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	[MSTP211] = MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	[MSTP207] = MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 7, CLK_ENABLE_ON_INIT),
+	[MSTP205] = MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	[MSTP204] = MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	[MSTP203] = MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	[MSTP202] = MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	[MSTP201] = MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	[MSTP200] = MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -221,7 +229,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
