From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 06:57:36 +0000
Subject: [PATCH] sh: hwblk support for sh7724
Message-Id: <20090731065736.28041.61685.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds hwblk support for the sh7724 processor.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on kfr2r09.

 arch/sh/include/cpu-sh4/cpu/sh7724.h   |   17 ++++
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  119 ++++++++++++++++---------------
 arch/sh/kernel/cpu/sh4a/hwblk-sh7724.c |  121 ++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 58 deletions(-)

--- 0001/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7724.h	2009-07-31 15:00:08.000000000 +0900
@@ -266,4 +266,21 @@ enum {
 	GPIO_FN_INTC_IRQ1, GPIO_FN_INTC_IRQ0,
 };
 
+enum {
+	HWBLK_UNKNOWN = 0,
+	HWBLK_TLB, HWBLK_IC, HWBLK_OC, HWBLK_RSMEM, HWBLK_ILMEM, HWBLK_L2C,
+	HWBLK_FPU, HWBLK_INTC, HWBLK_DMAC0, HWBLK_SHYWAY,
+	HWBLK_HUDI, HWBLK_DBG, HWBLK_UBC,
+	HWBLK_TMU0, HWBLK_CMT, HWBLK_RWDT, HWBLK_DMAC1, HWBLK_TMU1,
+	HWBLK_SCIF0, HWBLK_SCIF1, HWBLK_SCIF2, HWBLK_SCIF3,
+	HWBLK_SCIF4, HWBLK_SCIF5, HWBLK_MSIOF0, HWBLK_MSIOF1,
+	HWBLK_KEYSC, HWBLK_RTC, HWBLK_IIC0, HWBLK_IIC1,
+	HWBLK_MMC, HWBLK_ETHER, HWBLK_ATAPI, HWBLK_TPU, HWBLK_IRDA,
+	HWBLK_TSIF, HWBLK_USB1, HWBLK_USB0, HWBLK_2DG,
+	HWBLK_SDHI0, HWBLK_SDHI1, HWBLK_VEU1, HWBLK_CEU1, HWBLK_BEU1,
+	HWBLK_2DDMAC, HWBLK_SPU, HWBLK_JPU, HWBLK_VOU,
+	HWBLK_BEU0, HWBLK_CEU0,	HWBLK_VEU0, HWBLK_VPU, HWBLK_LCDC,
+	HWBLK_NR,
+};
+
 #endif /* __ASM_SH7724_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-07-31 15:00:08.000000000 +0900
@@ -27,7 +27,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o hwblk-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o hwblk-sh7723.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o hwblk-sh7724.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7366.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
 
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2009-07-31 15:00:55.000000000 +0900
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <asm/clock.h>
+#include <asm/hwblk.h>
+#include <cpu/sh7724.h>
 
 /* SH7724 registers */
 #define FRQCRA		0xa4150000
@@ -156,64 +158,67 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, 0),
 };
 
-#define MSTP(_str, _parent, _reg, _bit, _force_on, _need_cpg, _need_ram) \
-  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _force_on * CLK_ENABLE_ON_INIT)
+#define R_CLK (&r_clk)
+#define P_CLK (&div4_clks[DIV4_P])
+#define B_CLK (&div4_clks[DIV4_B])
+#define I_CLK (&div4_clks[DIV4_I])
+#define SH_CLK (&div4_clks[DIV4_SH])
 
 static struct clk mstp_clks[] = {
-	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, 1, 1, 0),
-	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, 1, 1, 0),
-	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, 1, 1, 0),
-	MSTP("rs0", &div4_clks[DIV4_B], MSTPCR0, 28, 1, 1, 0),
-	MSTP("ilmem0", &div4_clks[DIV4_I], MSTPCR0, 27, 1, 1, 0),
-	MSTP("l2c0", &div4_clks[DIV4_SH], MSTPCR0, 26, 1, 1, 0),
-	MSTP("fpu0", &div4_clks[DIV4_I], MSTPCR0, 24, 1, 1, 0),
-	MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 1, 1, 0),
-	MSTP("dmac0", &div4_clks[DIV4_B], MSTPCR0, 21, 0, 1, 1),
-	MSTP("sh0", &div4_clks[DIV4_SH], MSTPCR0, 20, 0, 1, 0),
-	MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0, 1, 0),
-	MSTP("ubc0", &div4_clks[DIV4_I], MSTPCR0, 17, 0, 1, 0),
-	MSTP("tmu0", &div4_clks[DIV4_P], MSTPCR0, 15, 0, 1, 0),
-	MSTP("cmt0", &r_clk, MSTPCR0, 14, 0, 0, 0),
-	MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0, 0, 0),
-	MSTP("dmac1", &div4_clks[DIV4_B], MSTPCR0, 12, 0, 1, 1),
-	MSTP("tmu1", &div4_clks[DIV4_P], MSTPCR0, 10, 0, 1, 0),
-	MSTP("scif0", &div4_clks[DIV4_P], MSTPCR0, 9, 0, 1, 0),
-	MSTP("scif1", &div4_clks[DIV4_P], MSTPCR0, 8, 0, 1, 0),
-	MSTP("scif2", &div4_clks[DIV4_P], MSTPCR0, 7, 0, 1, 0),
-	MSTP("scif3", &div4_clks[DIV4_B], MSTPCR0, 6, 0, 1, 0),
-	MSTP("scif4", &div4_clks[DIV4_B], MSTPCR0, 5, 0, 1, 0),
-	MSTP("scif5", &div4_clks[DIV4_B], MSTPCR0, 4, 0, 1, 0),
-	MSTP("msiof0", &div4_clks[DIV4_B], MSTPCR0, 2, 0, 1, 0),
-	MSTP("msiof1", &div4_clks[DIV4_B], MSTPCR0, 1, 0, 1, 0),
-
-	MSTP("keysc0", &r_clk, MSTPCR1, 12, 0, 0, 0),
-	MSTP("rtc0", &r_clk, MSTPCR1, 11, 0, 0, 0),
-	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0, 1, 0),
-	MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0, 1, 0),
-
-	MSTP("mmc0", &div4_clks[DIV4_B], MSTPCR2, 29, 0, 1, 0),
-	MSTP("eth0", &div4_clks[DIV4_B], MSTPCR2, 28, 0, 1, 0),
-	MSTP("atapi0", &div4_clks[DIV4_B], MSTPCR2, 26, 0, 1, 0),
-	MSTP("tpu0", &div4_clks[DIV4_B], MSTPCR2, 25, 0, 1, 0),
-	MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0, 1, 0),
-	MSTP("tsif0", &div4_clks[DIV4_B], MSTPCR2, 22, 0, 1, 0),
-	MSTP("usb1", &div4_clks[DIV4_B], MSTPCR2, 21, 0, 1, 1),
-	MSTP("usb0", &div4_clks[DIV4_B], MSTPCR2, 20, 0, 1, 1),
-	MSTP("2dg0", &div4_clks[DIV4_B], MSTPCR2, 19, 0, 1, 1),
-	MSTP("sdhi0", &div4_clks[DIV4_B], MSTPCR2, 18, 0, 1, 0),
-	MSTP("sdhi1", &div4_clks[DIV4_B], MSTPCR2, 17, 0, 1, 0),
-	MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 15, 1, 1, 1),
-	MSTP("ceu1", &div4_clks[DIV4_B], MSTPCR2, 13, 0, 1, 1),
-	MSTP("beu1", &div4_clks[DIV4_B], MSTPCR2, 12, 0, 1, 1),
-	MSTP("2ddmac0", &div4_clks[DIV4_SH], MSTPCR2, 10, 0, 1, 1),
-	MSTP("spu0", &div4_clks[DIV4_B], MSTPCR2, 9, 0, 1, 0),
-	MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, 1, 1, 1),
-	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0, 1, 1),
-	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0, 1, 1),
-	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0, 1, 1),
-	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, 1, 1, 1),
-	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, 1, 1, 1),
-	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0, 1, 1),
+	SH_HWBLK_CLK("tlb0", -1, I_CLK, HWBLK_TLB, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("ic0", -1, I_CLK, HWBLK_IC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("oc0", -1, I_CLK, HWBLK_OC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("rs0", -1, B_CLK, HWBLK_RSMEM, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("ilmem0", -1, I_CLK, HWBLK_ILMEM, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("l2c0", -1, SH_CLK, HWBLK_L2C, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("fpu0", -1, I_CLK, HWBLK_FPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("intc0", -1, P_CLK, HWBLK_INTC, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("dmac0", -1, B_CLK, HWBLK_DMAC0, 0),
+	SH_HWBLK_CLK("sh0", -1, SH_CLK, HWBLK_SHYWAY, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("hudi0", -1, P_CLK, HWBLK_HUDI, 0),
+	SH_HWBLK_CLK("ubc0", -1, I_CLK, HWBLK_UBC, 0),
+	SH_HWBLK_CLK("tmu0", -1, P_CLK, HWBLK_TMU0, 0),
+	SH_HWBLK_CLK("cmt0", -1, R_CLK, HWBLK_CMT, 0),
+	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
+	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
+	SH_HWBLK_CLK("tmu1", -1, P_CLK, HWBLK_TMU1, 0),
+	SH_HWBLK_CLK("scif0", -1, P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK("scif1", -1, P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK("scif2", -1, P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK("scif3", -1, B_CLK, HWBLK_SCIF3, 0),
+	SH_HWBLK_CLK("scif4", -1, B_CLK, HWBLK_SCIF4, 0),
+	SH_HWBLK_CLK("scif5", -1, B_CLK, HWBLK_SCIF5, 0),
+	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
+	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
+
+	SH_HWBLK_CLK("keysc0", -1, R_CLK, HWBLK_KEYSC, 0),
+	SH_HWBLK_CLK("rtc0", -1, R_CLK, HWBLK_RTC, 0),
+	SH_HWBLK_CLK("i2c0", -1, P_CLK, HWBLK_IIC0, 0),
+	SH_HWBLK_CLK("i2c1", -1, P_CLK, HWBLK_IIC1, 0),
+
+	SH_HWBLK_CLK("mmc0", -1, B_CLK, HWBLK_MMC, 0),
+	SH_HWBLK_CLK("eth0", -1, B_CLK, HWBLK_ETHER, 0),
+	SH_HWBLK_CLK("atapi0", -1, B_CLK, HWBLK_ATAPI, 0),
+	SH_HWBLK_CLK("tpu0", -1, B_CLK, HWBLK_TPU, 0),
+	SH_HWBLK_CLK("irda0", -1, P_CLK, HWBLK_IRDA, 0),
+	SH_HWBLK_CLK("tsif0", -1, B_CLK, HWBLK_TSIF, 0),
+	SH_HWBLK_CLK("usb1", -1, B_CLK, HWBLK_USB1, 0),
+	SH_HWBLK_CLK("usb0", -1, B_CLK, HWBLK_USB0, 0),
+	SH_HWBLK_CLK("2dg0", -1, B_CLK, HWBLK_2DG, 0),
+	SH_HWBLK_CLK("sdhi0", -1, B_CLK, HWBLK_SDHI0, 0),
+	SH_HWBLK_CLK("sdhi1", -1, B_CLK, HWBLK_SDHI1, 0),
+	SH_HWBLK_CLK("veu1", -1, B_CLK, HWBLK_VEU1, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("ceu1", -1, B_CLK, HWBLK_CEU1, 0),
+	SH_HWBLK_CLK("beu1", -1, B_CLK, HWBLK_BEU1, 0),
+	SH_HWBLK_CLK("2ddmac0", -1, SH_CLK, HWBLK_2DDMAC, 0),
+	SH_HWBLK_CLK("spu0", -1, B_CLK, HWBLK_SPU, 0),
+	SH_HWBLK_CLK("jpu0", -1, B_CLK, HWBLK_JPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("vou0", -1, B_CLK, HWBLK_VOU, 0),
+	SH_HWBLK_CLK("beu0", -1, B_CLK, HWBLK_BEU0, 0),
+	SH_HWBLK_CLK("ceu0", -1, B_CLK, HWBLK_CEU0, 0),
+	SH_HWBLK_CLK("veu0", -1, B_CLK, HWBLK_VEU0, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("vpu0", -1, B_CLK, HWBLK_VPU, CLK_ENABLE_ON_INIT),
+	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
 int __init arch_clk_init(void)
@@ -236,7 +241,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_hwblk_clk_register(mstp_clks, ARRAY_SIZE(mstp_clks));
 
 	return ret;
 }
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/hwblk-sh7724.c	2009-07-31 15:00:08.000000000 +0900
@@ -0,0 +1,121 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/hwblk-sh7724.c
+ *
+ * SH7724 hardware block support
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/suspend.h>
+#include <asm/hwblk.h>
+#include <cpu/sh7724.h>
+
+/* SH7724 registers */
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
+
+/* SH7724 Power Domains */
+enum { CORE_AREA, SUB_AREA, CORE_AREA_BM };
+static struct hwblk_area sh7724_hwblk_area[] = {
+	[CORE_AREA] = HWBLK_AREA(0, 0),
+	[CORE_AREA_BM] = HWBLK_AREA(HWBLK_AREA_FLAG_PARENT, CORE_AREA),
+	[SUB_AREA] = HWBLK_AREA(0, 0),
+};
+
+/* Table mapping HWBLK to Module Stop Bit and Power Domain */
+static struct hwblk sh7724_hwblk[HWBLK_NR] = {
+	[HWBLK_TLB] = HWBLK(MSTPCR0, 31, CORE_AREA),
+	[HWBLK_IC] = HWBLK(MSTPCR0, 30, CORE_AREA),
+	[HWBLK_OC] = HWBLK(MSTPCR0, 29, CORE_AREA),
+	[HWBLK_RSMEM] = HWBLK(MSTPCR0, 28, CORE_AREA),
+	[HWBLK_ILMEM] = HWBLK(MSTPCR0, 27, CORE_AREA),
+	[HWBLK_L2C] = HWBLK(MSTPCR0, 26, CORE_AREA),
+	[HWBLK_FPU] = HWBLK(MSTPCR0, 24, CORE_AREA),
+	[HWBLK_INTC] = HWBLK(MSTPCR0, 22, CORE_AREA),
+	[HWBLK_DMAC0] = HWBLK(MSTPCR0, 21, CORE_AREA_BM),
+	[HWBLK_SHYWAY] = HWBLK(MSTPCR0, 20, CORE_AREA),
+	[HWBLK_HUDI] = HWBLK(MSTPCR0, 19, CORE_AREA),
+	[HWBLK_DBG] = HWBLK(MSTPCR0, 18, CORE_AREA),
+	[HWBLK_UBC] = HWBLK(MSTPCR0, 17, CORE_AREA),
+	[HWBLK_TMU0] = HWBLK(MSTPCR0, 15, CORE_AREA),
+	[HWBLK_CMT] = HWBLK(MSTPCR0, 14, SUB_AREA),
+	[HWBLK_RWDT] = HWBLK(MSTPCR0, 13, SUB_AREA),
+	[HWBLK_DMAC1] = HWBLK(MSTPCR0, 12, CORE_AREA_BM),
+	[HWBLK_TMU1] = HWBLK(MSTPCR0, 10, CORE_AREA),
+	[HWBLK_SCIF0] = HWBLK(MSTPCR0, 9, CORE_AREA),
+	[HWBLK_SCIF1] = HWBLK(MSTPCR0, 8, CORE_AREA),
+	[HWBLK_SCIF2] = HWBLK(MSTPCR0, 7, CORE_AREA),
+	[HWBLK_SCIF3] = HWBLK(MSTPCR0, 6, CORE_AREA),
+	[HWBLK_SCIF4] = HWBLK(MSTPCR0, 5, CORE_AREA),
+	[HWBLK_SCIF5] = HWBLK(MSTPCR0, 4, CORE_AREA),
+	[HWBLK_MSIOF0] = HWBLK(MSTPCR0, 2, CORE_AREA),
+	[HWBLK_MSIOF1] = HWBLK(MSTPCR0, 1, CORE_AREA),
+
+	[HWBLK_KEYSC] = HWBLK(MSTPCR1, 12, SUB_AREA),
+	[HWBLK_RTC] = HWBLK(MSTPCR1, 11, SUB_AREA),
+	[HWBLK_IIC0] = HWBLK(MSTPCR1, 9, CORE_AREA),
+	[HWBLK_IIC1] = HWBLK(MSTPCR1, 8, CORE_AREA),
+
+	[HWBLK_MMC] = HWBLK(MSTPCR2, 29, CORE_AREA),
+	[HWBLK_ETHER] = HWBLK(MSTPCR2, 28, CORE_AREA_BM),
+	[HWBLK_ATAPI] = HWBLK(MSTPCR2, 26, CORE_AREA_BM),
+	[HWBLK_TPU] = HWBLK(MSTPCR2, 25, CORE_AREA),
+	[HWBLK_IRDA] = HWBLK(MSTPCR2, 24, CORE_AREA),
+	[HWBLK_TSIF] = HWBLK(MSTPCR2, 22, CORE_AREA),
+	[HWBLK_USB1] = HWBLK(MSTPCR2, 21, CORE_AREA),
+	[HWBLK_USB0] = HWBLK(MSTPCR2, 20, CORE_AREA),
+	[HWBLK_2DG] = HWBLK(MSTPCR2, 19, CORE_AREA_BM),
+	[HWBLK_SDHI0] = HWBLK(MSTPCR2, 18, CORE_AREA),
+	[HWBLK_SDHI1] = HWBLK(MSTPCR2, 17, CORE_AREA),
+	[HWBLK_VEU1] = HWBLK(MSTPCR2, 15, CORE_AREA_BM),
+	[HWBLK_CEU1] = HWBLK(MSTPCR2, 13, CORE_AREA_BM),
+	[HWBLK_BEU1] = HWBLK(MSTPCR2, 12, CORE_AREA_BM),
+	[HWBLK_2DDMAC] = HWBLK(MSTPCR2, 10, CORE_AREA_BM),
+	[HWBLK_SPU] = HWBLK(MSTPCR2, 9, CORE_AREA_BM),
+	[HWBLK_JPU] = HWBLK(MSTPCR2, 6, CORE_AREA_BM),
+	[HWBLK_VOU] = HWBLK(MSTPCR2, 5, CORE_AREA_BM),
+	[HWBLK_BEU0] = HWBLK(MSTPCR2, 4, CORE_AREA_BM),
+	[HWBLK_CEU0] = HWBLK(MSTPCR2, 3, CORE_AREA_BM),
+	[HWBLK_VEU0] = HWBLK(MSTPCR2, 2, CORE_AREA_BM),
+	[HWBLK_VPU] = HWBLK(MSTPCR2, 1, CORE_AREA_BM),
+	[HWBLK_LCDC] = HWBLK(MSTPCR2, 0, CORE_AREA_BM),
+};
+
+static struct hwblk_info sh7724_hwblk_info = {
+	.areas = sh7724_hwblk_area,
+	.nr_areas = ARRAY_SIZE(sh7724_hwblk_area),
+	.hwblks = sh7724_hwblk,
+	.nr_hwblks = ARRAY_SIZE(sh7724_hwblk),
+};
+
+int arch_hwblk_sleep_mode(void)
+{
+	if (!sh7724_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE])
+		return SUSP_SH_STANDBY | SUSP_SH_SF;
+
+	if (!sh7724_hwblk_area[CORE_AREA_BM].cnt[HWBLK_CNT_USAGE])
+		return SUSP_SH_SLEEP | SUSP_SH_SF;
+
+	return SUSP_SH_SLEEP;
+}
+
+int __init arch_hwblk_init(void)
+{
+	return hwblk_register(&sh7724_hwblk_info);
+}
