From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:04 +0000
Subject: [PATCH 06/13] sh: Get rid of sh7724 hwblk clock names
Message-Id: <20100510112404.14587.85275.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Get rid of name and id from sh7724 hwblk clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/hwblk.h            |    4 -
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  108 ++++++++++++++++----------------
 2 files changed, 55 insertions(+), 57 deletions(-)

--- 0003/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2010-05-10 18:55:52.000000000 +0900
@@ -58,10 +58,8 @@ void hwblk_cnt_inc(struct hwblk_info *in
 void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int cnt);
 
 /* allow clocks to enable and disable hardware blocks */
-#define SH_HWBLK_CLK(_name, _id, _parent, _hwblk, _flags)	\
+#define SH_HWBLK_CLK(_parent, _hwblk, _flags)	\
 [_hwblk] = {							\
-	.name		= _name,			\
-	.id		= _id,				\
 	.parent		= _parent,			\
 	.arch_flags	= _hwblk,			\
 	.flags		= _flags,			\
--- 0005/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 18:57:47.000000000 +0900
@@ -179,60 +179,60 @@ struct clk div6_clks[] = {
 #define SH_CLK (&div4_clks[DIV4_SH])
 
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
+	SH_HWBLK_CLK(I_CLK, HWBLK_TLB, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(I_CLK, HWBLK_IC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(I_CLK, HWBLK_OC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(B_CLK, HWBLK_RSMEM, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(I_CLK, HWBLK_ILMEM, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(SH_CLK, HWBLK_L2C, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(I_CLK, HWBLK_FPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(P_CLK, HWBLK_INTC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(B_CLK, HWBLK_DMAC0, 0),
+	SH_HWBLK_CLK(SH_CLK, HWBLK_SHYWAY, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK(P_CLK, HWBLK_HUDI, 0),
+	SH_HWBLK_CLK(I_CLK, HWBLK_UBC, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_TMU0, 0),
+	SH_HWBLK_CLK(R_CLK, HWBLK_CMT, 0),
+	SH_HWBLK_CLK(R_CLK, HWBLK_RWDT, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_DMAC1, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_TMU1, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SCIF3, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SCIF4, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SCIF5, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_MSIOF0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_MSIOF1, 0),
+
+	SH_HWBLK_CLK(R_CLK, HWBLK_KEYSC, 0),
+	SH_HWBLK_CLK(R_CLK, HWBLK_RTC, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_IIC0, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_IIC1, 0),
+
+	SH_HWBLK_CLK(B_CLK, HWBLK_MMC, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_ETHER, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_ATAPI, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_TPU, 0),
+	SH_HWBLK_CLK(P_CLK, HWBLK_IRDA, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_TSIF, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_USB1, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_USB0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_2DG, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SDHI0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SDHI1, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_VEU1, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_CEU1, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_BEU1, 0),
+	SH_HWBLK_CLK(SH_CLK, HWBLK_2DDMAC, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_SPU, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_JPU, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_VOU, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_BEU0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_CEU0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_VEU0, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_VPU, 0),
+	SH_HWBLK_CLK(B_CLK, HWBLK_LCDC, 0),
 };
 
 #define CLKDEV_NO_DEV(_name, _clk)		\
