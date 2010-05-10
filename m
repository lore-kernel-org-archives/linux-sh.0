From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 14:01:44 +0000
Subject: [PATCH 05/07] sh: get rid of hwblk clock names
Message-Id: <20100510140144.32745.10297.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove the clock name from sh7722/sh7723/sh7724
hwblk clocks. Lookup is handled by clkdev.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/hwblk.h            |   12 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   55 +++++++--------
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |  105 +++++++++++++----------------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  114 +++++++++++++++-----------------
 4 files changed, 133 insertions(+), 153 deletions(-)

--- 0002/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2010-05-10 21:39:02.000000000 +0900
@@ -58,13 +58,11 @@ void hwblk_cnt_inc(struct hwblk_info *in
 void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int cnt);
 
 /* allow clocks to enable and disable hardware blocks */
-#define SH_HWBLK_CLK(_name, _id, _parent, _hwblk, _flags)	\
-[_hwblk] = {							\
-	.name		= _name,			\
-	.id		= _id,				\
-	.parent		= _parent,			\
-	.arch_flags	= _hwblk,			\
-	.flags		= _flags,			\
+#define SH_HWBLK_CLK(_hwblk, _parent, _flags)	\
+[_hwblk] = {					\
+	.parent		= _parent,		\
+	.arch_flags	= _hwblk,		\
+	.flags		= _flags,		\
 }
 
 int sh_hwblk_clk_register(struct clk *clks, int nr);
--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-10 22:00:30.000000000 +0900
@@ -153,37 +153,32 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
-#define R_CLK &r_clk
-#define P_CLK &div4_clks[DIV4_P]
-#define B_CLK &div4_clks[DIV4_B]
-#define U_CLK &div4_clks[DIV4_U]
-
 static struct clk mstp_clks[HWBLK_NR] = {
-	SH_HWBLK_CLK("uram0", -1, U_CLK, HWBLK_URAM, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("xymem0", -1, B_CLK, HWBLK_XYMEM, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("tmu_fck", -1, P_CLK, HWBLK_TMU, 0),
-	SH_HWBLK_CLK("cmt_fck", -1, R_CLK, HWBLK_CMT, 0),
-	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
-	SH_HWBLK_CLK("flctl0", -1, P_CLK, HWBLK_FLCTL, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
-
-	SH_HWBLK_CLK("i2c0", -1, P_CLK, HWBLK_IIC, 0),
-	SH_HWBLK_CLK("rtc0", -1, R_CLK, HWBLK_RTC, 0),
-
-	SH_HWBLK_CLK("sdhi0", -1, P_CLK, HWBLK_SDHI, 0),
-	SH_HWBLK_CLK("keysc0", -1, R_CLK, HWBLK_KEYSC, 0),
-	SH_HWBLK_CLK("usbf0", -1, P_CLK, HWBLK_USBF, 0),
-	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
-	SH_HWBLK_CLK("siu0", -1, B_CLK, HWBLK_SIU, 0),
-	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
-	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, 0),
-	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU, 0),
-	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU, 0),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
-	SH_HWBLK_CLK("lcdc0", -1, P_CLK, HWBLK_LCDC, 0),
+	SH_HWBLK_CLK(HWBLK_URAM, &div4_clks[DIV4_U], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_XYMEM, &div4_clks[DIV4_B], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_TMU, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_CMT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_RWDT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_FLCTL, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF1, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF2, &div4_clks[DIV4_P], 0),
+
+	SH_HWBLK_CLK(HWBLK_IIC, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_RTC, &r_clk, 0),
+
+	SH_HWBLK_CLK(HWBLK_SDHI, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_KEYSC, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_USBF, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_2DG, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SIU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VOU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_JPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_BEU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_CEU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VEU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_P], 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-10 21:55:36.000000000 +0900
@@ -153,64 +153,57 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
-#define R_CLK (&r_clk)
-#define P_CLK (&div4_clks[DIV4_P])
-#define B_CLK (&div4_clks[DIV4_B])
-#define U_CLK (&div4_clks[DIV4_U])
-#define I_CLK (&div4_clks[DIV4_I])
-#define SH_CLK (&div4_clks[DIV4_SH])
-
 static struct clk mstp_clks[] = {
 	/* See page 60 of Datasheet V1.0: Overview -> Block Diagram */
-	SH_HWBLK_CLK("tlb0", -1, I_CLK, HWBLK_TLB, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("ic0", -1, I_CLK, HWBLK_IC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("oc0", -1, I_CLK, HWBLK_OC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("l2c0", -1, SH_CLK, HWBLK_L2C, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("ilmem0", -1, I_CLK, HWBLK_ILMEM, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("fpu0", -1, I_CLK, HWBLK_FPU, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("intc0", -1, I_CLK, HWBLK_INTC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("dmac0", -1, B_CLK, HWBLK_DMAC0, 0),
-	SH_HWBLK_CLK("sh0", -1, SH_CLK, HWBLK_SHYWAY, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("hudi0", -1, P_CLK, HWBLK_HUDI, 0),
-	SH_HWBLK_CLK("ubc0", -1, I_CLK, HWBLK_UBC, 0),
-	SH_HWBLK_CLK("tmu012_fck", -1, P_CLK, HWBLK_TMU0, 0),
-	SH_HWBLK_CLK("cmt_fck", -1, R_CLK, HWBLK_CMT, 0),
-	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
-	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
-	SH_HWBLK_CLK("tmu345_fck", -1, P_CLK, HWBLK_TMU1, 0),
-	SH_HWBLK_CLK("flctl0", -1, P_CLK, HWBLK_FLCTL, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF3, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF4, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF5, 0),
-	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
-	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
-	SH_HWBLK_CLK("meram0", -1, SH_CLK, HWBLK_MERAM, 0),
-
-	SH_HWBLK_CLK("i2c0", -1, P_CLK, HWBLK_IIC, 0),
-	SH_HWBLK_CLK("rtc0", -1, R_CLK, HWBLK_RTC, 0),
-
-	SH_HWBLK_CLK("atapi0", -1, SH_CLK, HWBLK_ATAPI, 0),
-	SH_HWBLK_CLK("adc0", -1, P_CLK, HWBLK_ADC, 0),
-	SH_HWBLK_CLK("tpu0", -1, B_CLK, HWBLK_TPU, 0),
-	SH_HWBLK_CLK("irda0", -1, P_CLK, HWBLK_IRDA, 0),
-	SH_HWBLK_CLK("tsif0", -1, B_CLK, HWBLK_TSIF, 0),
-	SH_HWBLK_CLK("icb0", -1, B_CLK, HWBLK_ICB, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("sdhi0", -1, B_CLK, HWBLK_SDHI0, 0),
-	SH_HWBLK_CLK("sdhi1", -1, B_CLK, HWBLK_SDHI1, 0),
-	SH_HWBLK_CLK("keysc0", -1, R_CLK, HWBLK_KEYSC, 0),
-	SH_HWBLK_CLK("usb0", -1, B_CLK, HWBLK_USB, 0),
-	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
-	SH_HWBLK_CLK("siu0", -1, B_CLK, HWBLK_SIU, 0),
-	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU2H1, 0),
-	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
-	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU, 0),
-	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU2H0, 0),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
-	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
+	SH_HWBLK_CLK(HWBLK_TLB, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_IC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_OC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_L2C, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_ILMEM, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_FPU, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_INTC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_DMAC0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SHYWAY, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_HUDI, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_UBC, &div4_clks[DIV4_I], 0),
+	SH_HWBLK_CLK(HWBLK_TMU0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_CMT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_RWDT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_DMAC1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_TMU1, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_FLCTL, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF1, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF2, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF3, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF4, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF5, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_MSIOF0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_MSIOF1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_MERAM, &div4_clks[DIV4_SH], 0),
+
+	SH_HWBLK_CLK(HWBLK_IIC, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_RTC, &r_clk, 0),
+
+	SH_HWBLK_CLK(HWBLK_ATAPI, &div4_clks[DIV4_SH], 0),
+	SH_HWBLK_CLK(HWBLK_ADC, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_TPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_IRDA, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_TSIF, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_ICB, &div4_clks[DIV4_B], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_SDHI0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SDHI1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_KEYSC, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_USB, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_2DG, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SIU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VEU2H1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VOU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_BEU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_CEU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VEU2H0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_B], 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 21:44:29.000000000 +0900
@@ -172,67 +172,61 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
-#define R_CLK (&r_clk)
-#define P_CLK (&div4_clks[DIV4_P])
-#define B_CLK (&div4_clks[DIV4_B])
-#define I_CLK (&div4_clks[DIV4_I])
-#define SH_CLK (&div4_clks[DIV4_SH])
-
 static struct clk mstp_clks[HWBLK_NR] = {
-	SH_HWBLK_CLK("tlb0", -1, I_CLK, HWBLK_TLB, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("ic0", -1, I_CLK, HWBLK_IC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("oc0", -1, I_CLK, HWBLK_OC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("rs0", -1, B_CLK, HWBLK_RSMEM, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("ilmem0", -1, I_CLK, HWBLK_ILMEM, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("l2c0", -1, SH_CLK, HWBLK_L2C, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("fpu0", -1, I_CLK, HWBLK_FPU, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("intc0", -1, P_CLK, HWBLK_INTC, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("dmac0", -1, B_CLK, HWBLK_DMAC0, 0),
-	SH_HWBLK_CLK("sh0", -1, SH_CLK, HWBLK_SHYWAY, CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK("hudi0", -1, P_CLK, HWBLK_HUDI, 0),
-	SH_HWBLK_CLK("ubc0", -1, I_CLK, HWBLK_UBC, 0),
-	SH_HWBLK_CLK("tmu012_fck", -1, P_CLK, HWBLK_TMU0, 0),
-	SH_HWBLK_CLK("cmt_fck", -1, R_CLK, HWBLK_CMT, 0),
-	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
-	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
-	SH_HWBLK_CLK("tmu345_fck", -1, P_CLK, HWBLK_TMU1, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF3, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF4, 0),
-	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF5, 0),
-	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
-	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
-
-	SH_HWBLK_CLK("keysc0", -1, R_CLK, HWBLK_KEYSC, 0),
-	SH_HWBLK_CLK("rtc0", -1, R_CLK, HWBLK_RTC, 0),
-	SH_HWBLK_CLK("i2c0", -1, P_CLK, HWBLK_IIC0, 0),
-	SH_HWBLK_CLK("i2c1", -1, P_CLK, HWBLK_IIC1, 0),
-
-	SH_HWBLK_CLK("mmc0", -1, B_CLK, HWBLK_MMC, 0),
-	SH_HWBLK_CLK("eth0", -1, B_CLK, HWBLK_ETHER, 0),
-	SH_HWBLK_CLK("atapi0", -1, B_CLK, HWBLK_ATAPI, 0),
-	SH_HWBLK_CLK("tpu0", -1, B_CLK, HWBLK_TPU, 0),
-	SH_HWBLK_CLK("irda0", -1, P_CLK, HWBLK_IRDA, 0),
-	SH_HWBLK_CLK("tsif0", -1, B_CLK, HWBLK_TSIF, 0),
-	SH_HWBLK_CLK("usb1", -1, B_CLK, HWBLK_USB1, 0),
-	SH_HWBLK_CLK("usb0", -1, B_CLK, HWBLK_USB0, 0),
-	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
-	SH_HWBLK_CLK("sdhi0", -1, B_CLK, HWBLK_SDHI0, 0),
-	SH_HWBLK_CLK("sdhi1", -1, B_CLK, HWBLK_SDHI1, 0),
-	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU1, 0),
-	SH_HWBLK_CLK("ceu1", -1, B_CLK, HWBLK_CEU1, 0),
-	SH_HWBLK_CLK("beu1", -1, B_CLK, HWBLK_BEU1, 0),
-	SH_HWBLK_CLK("2ddmac0", -1, SH_CLK, HWBLK_2DDMAC, 0),
-	SH_HWBLK_CLK("spu0", -1, B_CLK, HWBLK_SPU, 0),
-	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, 0),
-	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
-	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU0, 0),
-	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU0, 0),
-	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU0, 0),
-	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, 0),
-	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
+	SH_HWBLK_CLK(HWBLK_TLB, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_IC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_OC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_RSMEM, &div4_clks[DIV4_B], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_ILMEM, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_L2C, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_FPU, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_INTC, &div4_clks[DIV4_P], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_DMAC0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SHYWAY, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(HWBLK_HUDI, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_UBC, &div4_clks[DIV4_I], 0),
+	SH_HWBLK_CLK(HWBLK_TMU0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_CMT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_RWDT, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_DMAC1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_TMU1, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF1, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF2, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF3, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF4, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SCIF5, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_MSIOF0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_MSIOF1, &div4_clks[DIV4_B], 0),
+
+	SH_HWBLK_CLK(HWBLK_KEYSC, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_RTC, &r_clk, 0),
+	SH_HWBLK_CLK(HWBLK_IIC0, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_IIC1, &div4_clks[DIV4_P], 0),
+
+	SH_HWBLK_CLK(HWBLK_MMC, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_ETHER, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_ATAPI, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_TPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_IRDA, &div4_clks[DIV4_P], 0),
+	SH_HWBLK_CLK(HWBLK_TSIF, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_USB1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_USB0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_2DG, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SDHI0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_SDHI1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VEU1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_CEU1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_BEU1, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_2DDMAC, &div4_clks[DIV4_SH], 0),
+	SH_HWBLK_CLK(HWBLK_SPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_JPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VOU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_BEU0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_CEU0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VEU0, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_VPU, &div4_clks[DIV4_B], 0),
+	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_B], 0),
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
