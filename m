From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:36 +0000
Subject: [PATCH 09/09] sh: get rid of mstp32 clock name and id
Message-Id: <20100511050047.26302.35898.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove the name and the id from SH_CLK_MSTP32().
Now when lookups are handled by clkdev they are
not needed anymore.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   15 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   93 +++++++++++++++-----------------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   82 ++++++++++++++--------------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   42 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |   58 +++++++++----------
 5 files changed, 143 insertions(+), 147 deletions(-)

--- 0008/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-05-11 13:31:38.000000000 +0900
@@ -116,15 +116,12 @@ int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate);
 
-#define SH_CLK_MSTP32(_name, _id, _parent, _enable_reg,	\
-	    _enable_bit, _flags)			\
-{							\
-	.name		= _name,			\
-	.id		= _id,				\
-	.parent		= _parent,			\
-	.enable_reg	= (void __iomem *)_enable_reg,	\
-	.enable_bit	= _enable_bit,			\
-	.flags		= _flags,			\
+#define SH_CLK_MSTP32(_parent, _enable_reg, _enable_bit, _flags)	\
+{									\
+	.parent		= _parent,					\
+	.enable_reg	= (void __iomem *)_enable_reg,			\
+	.enable_bit	= _enable_bit,					\
+	.flags		= _flags,					\
 }
 
 int sh_clk_mstp32_register(struct clk *clks, int nr);
--- 0010/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-05-11 13:40:57.000000000 +0900
@@ -142,8 +142,8 @@ struct clk div6_clks[DIV6_NR] = {
 	[DIV6_V] = SH_CLK_DIV6(&pll_clk, VCLKCR, 0),
 };
 
-#define MSTP(_str, _parent, _reg, _bit, _flags) \
-  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+#define MSTP(_parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
 
 enum { MSTP031, MSTP030, MSTP029, MSTP028, MSTP026,
        MSTP023, MSTP022, MSTP021, MSTP020, MSTP019, MSTP018, MSTP017, MSTP016,
@@ -156,50 +156,50 @@ enum { MSTP031, MSTP030, MSTP029, MSTP02
        MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP031] = MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
-	[MSTP030] = MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
-	[MSTP029] = MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
-	[MSTP028] = MSTP("uram0", &div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
-	[MSTP026] = MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
-	[MSTP023] = MSTP("intc3", &div4_clks[DIV4_P], MSTPCR0, 23, 0),
-	[MSTP022] = MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 0),
-	[MSTP021] = MSTP("dmac0", &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	[MSTP020] = MSTP("sh0", &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	[MSTP019] = MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0),
-	[MSTP017] = MSTP("ubc0", &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	[MSTP015] = MSTP("tmu_fck", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
-	[MSTP014] = MSTP("cmt_fck", &r_clk, MSTPCR0, 14, 0),
-	[MSTP013] = MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
-	[MSTP011] = MSTP("mfi0", &div4_clks[DIV4_P], MSTPCR0, 11, 0),
-	[MSTP010] = MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
-	[MSTP007] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 7, 0),
-	[MSTP006] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 6, 0),
-	[MSTP005] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
-	[MSTP004] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
-	[MSTP003] = MSTP("sio0", &div4_clks[DIV4_P], MSTPCR0, 3, 0),
-	[MSTP002] = MSTP("siof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
-	[MSTP001] = MSTP("siof1", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
-
-	[MSTP109] = MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
-	[MSTP108] = MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0),
-
-	[MSTP225] = MSTP("tpu0", &div4_clks[DIV4_P], MSTPCR2, 25, 0),
-	[MSTP224] = MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
-	[MSTP218] = MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
-	[MSTP217] = MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
-	[MSTP216] = MSTP("sim0", &div4_clks[DIV4_P], MSTPCR2, 16, 0),
-	[MSTP214] = MSTP("keysc0", &r_clk, MSTPCR2, 14, 0),
-	[MSTP213] = MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 13, 0),
-	[MSTP212] = MSTP("s3d40", &div4_clks[DIV4_P], MSTPCR2, 12, 0),
-	[MSTP211] = MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
-	[MSTP208] = MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 8, 0),
-	[MSTP206] = MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
-	[MSTP205] = MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
-	[MSTP204] = MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
-	[MSTP203] = MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
-	[MSTP202] = MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
-	[MSTP201] = MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
-	[MSTP200] = MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
+	[MSTP031] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	[MSTP030] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	[MSTP029] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	[MSTP028] = MSTP(&div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	[MSTP026] = MSTP(&div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	[MSTP023] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP019] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 19, 0),
+	[MSTP017] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP015] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = MSTP(&r_clk, MSTPCR0, 14, 0),
+	[MSTP013] = MSTP(&r_clk, MSTPCR0, 13, 0),
+	[MSTP011] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP007] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	[MSTP006] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	[MSTP005] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	[MSTP004] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	[MSTP003] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	[MSTP002] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP001] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	[MSTP109] = MSTP(&div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	[MSTP108] = MSTP(&div4_clks[DIV4_P], MSTPCR1, 8, 0),
+
+	[MSTP225] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 25, 0),
+	[MSTP224] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	[MSTP218] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	[MSTP217] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	[MSTP216] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 16, 0),
+	[MSTP214] = MSTP(&r_clk, MSTPCR2, 14, 0),
+	[MSTP213] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 13, 0),
+	[MSTP212] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 12, 0),
+	[MSTP211] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	[MSTP208] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 8, 0),
+	[MSTP206] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
+	[MSTP205] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	[MSTP204] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	[MSTP203] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	[MSTP202] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	[MSTP201] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	[MSTP200] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -216,7 +216,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("xymem0", &mstp_clks[MSTP026]),
 	CLKDEV_CON_ID("intc3", &mstp_clks[MSTP023]),
 	CLKDEV_CON_ID("intc0", &mstp_clks[MSTP022]),
-
 	CLKDEV_CON_ID("dmac0", &mstp_clks[MSTP021]),
 	CLKDEV_CON_ID("sh0", &mstp_clks[MSTP020]),
 	CLKDEV_CON_ID("hudi0", &mstp_clks[MSTP019]),
--- 0012/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-11 13:38:13.000000000 +0900
@@ -145,8 +145,8 @@ struct clk div6_clks[DIV6_NR] = {
 	[DIV6_V] = SH_CLK_DIV6(&pll_clk, VCLKCR, 0),
 };
 
-#define MSTP(_str, _parent, _reg, _bit, _flags) \
-  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+#define MSTP(_parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
 
 enum { MSTP031, MSTP030, MSTP029, MSTP028, MSTP026,
        MSTP023, MSTP022, MSTP021, MSTP020, MSTP019, MSTP018, MSTP017, MSTP016,
@@ -159,45 +159,45 @@ enum { MSTP031, MSTP030, MSTP029, MSTP02
 
 static struct clk mstp_clks[MSTP_NR] = {
 	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
-	[MSTP031] = MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
-	[MSTP030] = MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
-	[MSTP029] = MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
-	[MSTP028] = MSTP("rsmem0", &div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
-	[MSTP026] = MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
-	[MSTP023] = MSTP("intc3", &div4_clks[DIV4_P], MSTPCR0, 23, 0),
-	[MSTP022] = MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 0),
-	[MSTP021] = MSTP("dmac0", &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	[MSTP020] = MSTP("sh0", &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	[MSTP019] = MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0),
-	[MSTP017] = MSTP("ubc0", &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	[MSTP015] = MSTP("tmu_fck", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
-	[MSTP014] = MSTP("cmt_fck", &r_clk, MSTPCR0, 14, 0),
-	[MSTP013] = MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
-	[MSTP011] = MSTP("mfi0", &div4_clks[DIV4_P], MSTPCR0, 11, 0),
-	[MSTP010] = MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
-	[MSTP007] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 7, 0),
-	[MSTP006] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 6, 0),
-	[MSTP005] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
-	[MSTP002] = MSTP("msiof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
-	[MSTP001] = MSTP("sbr0", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
-
-	[MSTP109] = MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
-
-	[MSTP227] = MSTP("icb0", &div4_clks[DIV4_P], MSTPCR2, 27, 0),
-	[MSTP226] = MSTP("meram0", &div4_clks[DIV4_P], MSTPCR2, 26, 0),
-	[MSTP224] = MSTP("dacy1", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
-	[MSTP223] = MSTP("dacy0", &div4_clks[DIV4_P], MSTPCR2, 23, 0),
-	[MSTP222] = MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 22, 0),
-	[MSTP218] = MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
-	[MSTP217] = MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
-	[MSTP211] = MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
-	[MSTP207] = MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 7, CLK_ENABLE_ON_INIT),
-	[MSTP205] = MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
-	[MSTP204] = MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
-	[MSTP203] = MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
-	[MSTP202] = MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
-	[MSTP201] = MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
-	[MSTP200] = MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
+	[MSTP031] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	[MSTP030] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	[MSTP029] = MSTP(&div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	[MSTP028] = MSTP(&div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	[MSTP026] = MSTP(&div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	[MSTP023] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP019] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 19, 0),
+	[MSTP017] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP015] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = MSTP(&r_clk, MSTPCR0, 14, 0),
+	[MSTP013] = MSTP(&r_clk, MSTPCR0, 13, 0),
+	[MSTP011] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP007] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	[MSTP006] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	[MSTP005] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	[MSTP002] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP001] = MSTP(&div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	[MSTP109] = MSTP(&div4_clks[DIV4_P], MSTPCR1, 9, 0),
+
+	[MSTP227] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 27, 0),
+	[MSTP226] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 26, 0),
+	[MSTP224] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	[MSTP223] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 23, 0),
+	[MSTP222] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 22, 0),
+	[MSTP218] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	[MSTP217] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	[MSTP211] = MSTP(&div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	[MSTP207] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 7, CLK_ENABLE_ON_INIT),
+	[MSTP205] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	[MSTP204] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	[MSTP203] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	[MSTP202] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	[MSTP201] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	[MSTP200] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
--- 0014/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-05-11 13:35:23.000000000 +0900
@@ -95,29 +95,29 @@ enum { MSTP029, MSTP028, MSTP027, MSTP02
 
 static struct clk mstp_clks[MSTP_NR] = {
 	/* MSTPCR0 */
-	[MSTP029] = SH_CLK_MSTP32("sci_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
-	[MSTP028] = SH_CLK_MSTP32("sci_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
-	[MSTP027] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
-	[MSTP026] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
-	[MSTP025] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
-	[MSTP024] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
-	[MSTP021] = SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	[MSTP020] = SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	[MSTP017] = SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	[MSTP016] = SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
-	[MSTP013] = SH_CLK_MSTP32("mmcif_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 13, 0),
-	[MSTP012] = SH_CLK_MSTP32("flctl_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 12, 0),
-	[MSTP009] = SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
-	[MSTP008] = SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
-	[MSTP003] = SH_CLK_MSTP32("siof_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 3, 0),
-	[MSTP002] = SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP029] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	[MSTP028] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 28, 0),
+	[MSTP027] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 27, 0),
+	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	[MSTP021] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP017] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	[MSTP013] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 13, 0),
+	[MSTP012] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 12, 0),
+	[MSTP009] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	[MSTP008] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	[MSTP003] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	[MSTP002] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
-	[MSTP119] = SH_CLK_MSTP32("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
-	[MSTP117] = SH_CLK_MSTP32("ubc_fck", -1, NULL, MSTPCR1, 17, 0),
-	[MSTP105] = SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
-	[MSTP104] = SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
-	[MSTP100] = SH_CLK_MSTP32("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
+	[MSTP119] = SH_CLK_MSTP32(NULL, MSTPCR1, 19, 0),
+	[MSTP117] = SH_CLK_MSTP32(NULL, MSTPCR1, 17, 0),
+	[MSTP105] = SH_CLK_MSTP32(NULL, MSTPCR1, 5, 0),
+	[MSTP104] = SH_CLK_MSTP32(NULL, MSTPCR1, 4, 0),
+	[MSTP100] = SH_CLK_MSTP32(NULL, MSTPCR1, 0, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
--- 0016/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 13:33:55.000000000 +0900
@@ -97,37 +97,37 @@ enum { MSTP029, MSTP028, MSTP027, MSTP02
 
 static struct clk mstp_clks[MSTP_NR] = {
 	/* MSTPCR0 */
-	[MSTP029] = SH_CLK_MSTP32("sci_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
-	[MSTP028] = SH_CLK_MSTP32("sci_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
-	[MSTP027] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
-	[MSTP026] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
-	[MSTP025] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
-	[MSTP024] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
-	[MSTP023] = SH_CLK_MSTP32("ssi_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 23, 0),
-	[MSTP022] = SH_CLK_MSTP32("ssi_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 22, 0),
-	[MSTP021] = SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	[MSTP020] = SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	[MSTP017] = SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	[MSTP016] = SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
-	[MSTP015] = SH_CLK_MSTP32("i2c_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 15, 0),
-	[MSTP014] = SH_CLK_MSTP32("i2c_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 14, 0),
-	[MSTP011] = SH_CLK_MSTP32("tmu9_11_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 11, 0),
-	[MSTP010] = SH_CLK_MSTP32("tmu678_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 10, 0),
-	[MSTP009] = SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
-	[MSTP008] = SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
-	[MSTP005] = SH_CLK_MSTP32("sdif_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
-	[MSTP004] = SH_CLK_MSTP32("sdif_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
-	[MSTP002] = SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP029] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	[MSTP028] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 28, 0),
+	[MSTP027] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 27, 0),
+	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	[MSTP023] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP017] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	[MSTP015] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0),
+	[MSTP011] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP009] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	[MSTP008] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	[MSTP005] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	[MSTP004] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	[MSTP002] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
-	[MSTP112] = SH_CLK_MSTP32("usb_fck", -1, NULL, MSTPCR1, 12, 0),
-	[MSTP110] = SH_CLK_MSTP32("pcie_fck", 2, NULL, MSTPCR1, 10, 0),
-	[MSTP109] = SH_CLK_MSTP32("pcie_fck", 1, NULL, MSTPCR1, 9, 0),
-	[MSTP108] = SH_CLK_MSTP32("pcie_fck", 0, NULL, MSTPCR1, 8, 0),
-	[MSTP105] = SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
-	[MSTP104] = SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
-	[MSTP103] = SH_CLK_MSTP32("du_fck", -1, NULL, MSTPCR1, 3, 0),
-	[MSTP102] = SH_CLK_MSTP32("ether_fck", -1, NULL, MSTPCR1, 2, 0),
+	[MSTP112] = SH_CLK_MSTP32(NULL, MSTPCR1, 12, 0),
+	[MSTP110] = SH_CLK_MSTP32(NULL, MSTPCR1, 10, 0),
+	[MSTP109] = SH_CLK_MSTP32(NULL, MSTPCR1, 9, 0),
+	[MSTP108] = SH_CLK_MSTP32(NULL, MSTPCR1, 8, 0),
+	[MSTP105] = SH_CLK_MSTP32(NULL, MSTPCR1, 5, 0),
+	[MSTP104] = SH_CLK_MSTP32(NULL, MSTPCR1, 4, 0),
+	[MSTP103] = SH_CLK_MSTP32(NULL, MSTPCR1, 3, 0),
+	[MSTP102] = SH_CLK_MSTP32(NULL, MSTPCR1, 2, 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
