From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:43 +0000
Subject: [PATCH 01/09] sh: sh7343 mstp32 index rework
Message-Id: <20100511045943.26302.73670.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7343 MSTP enums for mstp_clks[] index.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |  102 +++++++++++++++++---------------
 1 file changed, 56 insertions(+), 46 deletions(-)

--- 0008/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-05-11 12:07:32.000000000 +0900
@@ -145,51 +145,61 @@ struct clk div6_clks[DIV6_NR] = {
 #define MSTP(_str, _parent, _reg, _bit, _flags) \
   SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
 
-static struct clk mstp_clks[] = {
-	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
-	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
-	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
-	MSTP("uram0", &div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
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
-	SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
-	MSTP("sio0", &div4_clks[DIV4_P], MSTPCR0, 3, 0),
-	MSTP("siof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
-	MSTP("siof1", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
-
-	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
-	MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0),
-
-	MSTP("tpu0", &div4_clks[DIV4_P], MSTPCR2, 25, 0),
-	MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
-	MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
-	MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
-	MSTP("sim0", &div4_clks[DIV4_P], MSTPCR2, 16, 0),
-	MSTP("keysc0", &r_clk, MSTPCR2, 14, 0),
-	MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 13, 0),
-	MSTP("s3d40", &div4_clks[DIV4_P], MSTPCR2, 12, 0),
-	MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
-	MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 8, 0),
-	MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
-	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
-	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
-	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
-	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
-	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
-	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
+enum { MSTP031, MSTP030, MSTP029, MSTP028, MSTP026,
+       MSTP023, MSTP022, MSTP021, MSTP020, MSTP019, MSTP018, MSTP017, MSTP016,
+       MSTP015, MSTP014, MSTP013, MSTP012, MSTP011, MSTP010,
+       MSTP007, MSTP006, MSTP005, MSTP004, MSTP003, MSTP002, MSTP001,
+       MSTP109, MSTP108, MSTP100,
+       MSTP225, MSTP224, MSTP218, MSTP217, MSTP216,
+       MSTP214, MSTP213, MSTP212, MSTP211, MSTP208,
+       MSTP206, MSTP205, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+       MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP031] = MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	[MSTP030] = MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	[MSTP029] = MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	[MSTP028] = MSTP("uram0", &div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
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
+	[MSTP004] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	[MSTP003] = MSTP("sio0", &div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	[MSTP002] = MSTP("siof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP001] = MSTP("siof1", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	[MSTP109] = MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	[MSTP108] = MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0),
+
+	[MSTP225] = MSTP("tpu0", &div4_clks[DIV4_P], MSTPCR2, 25, 0),
+	[MSTP224] = MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	[MSTP218] = MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	[MSTP217] = MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	[MSTP216] = MSTP("sim0", &div4_clks[DIV4_P], MSTPCR2, 16, 0),
+	[MSTP214] = MSTP("keysc0", &r_clk, MSTPCR2, 14, 0),
+	[MSTP213] = MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 13, 0),
+	[MSTP212] = MSTP("s3d40", &div4_clks[DIV4_P], MSTPCR2, 12, 0),
+	[MSTP211] = MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	[MSTP208] = MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 8, 0),
+	[MSTP206] = MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
+	[MSTP205] = MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	[MSTP204] = MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	[MSTP203] = MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	[MSTP202] = MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	[MSTP201] = MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	[MSTP200] = MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -221,7 +231,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
