From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 Nov 2011 12:35:51 +0000
Subject: [PATCH 3/3] sh: sh7723: use runtime PM implementation, common with
Message-Id: <Pine.LNX.4.64.1111161317140.1100@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Switch sh7723 to a runtime PM implementation, common with ARM-based
sh-mobile platforms.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/include/asm/hwblk.h            |    4 +-
 arch/sh/kernel/cpu/Makefile            |    2 +-
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |  171 ++++++++++++++------------------
 arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c |  117 ----------------------
 arch/sh/kernel/cpu/shmobile/Makefile   |    2 +-
 drivers/sh/Makefile                    |    3 +-
 7 files changed, 84 insertions(+), 217 deletions(-)
 delete mode 100644 arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c

diff --git a/arch/sh/include/asm/hwblk.h b/arch/sh/include/asm/hwblk.h
index d6b7dea..e29461b 100644
--- a/arch/sh/include/asm/hwblk.h
+++ b/arch/sh/include/asm/hwblk.h
@@ -44,7 +44,9 @@ struct hwblk_info {
 	int nr_hwblks;
 };
 
-#if !defined(CONFIG_CPU_SUBTYPE_SH7724) && !defined(CONFIG_CPU_SUBTYPE_SH7722)
+#if !defined(CONFIG_CPU_SUBTYPE_SH7722) && \
+    !defined(CONFIG_CPU_SUBTYPE_SH7723) && \
+    !defined(CONFIG_CPU_SUBTYPE_SH7724)
 /* Should be defined by processor-specific code */
 int arch_hwblk_init(void);
 int arch_hwblk_sleep_mode(void);
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index b1f515c..5366fdf 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -19,6 +19,6 @@ obj-$(CONFIG_SH_ADC)		+= adc.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
 obj-y	+= irq/ init.o clock.o fpu.o proc.o
-ifneq ($(CONFIG_CPU_SUBTYPE_SH7724)$(CONFIG_CPU_SUBTYPE_SH7722),y)
+ifneq ($(CONFIG_CPU_SUBTYPE_SH7722)$(CONFIG_CPU_SUBTYPE_SH7723)$(CONFIG_CPU_SUBTYPE_SH7724),y)
 obj-y	+= hwblk.o
 endif
diff --git a/arch/sh/kernel/cpu/sh4a/Makefile b/arch/sh/kernel/cpu/sh4a/Makefile
index 9f28773..0b22d10 100644
--- a/arch/sh/kernel/cpu/sh4a/Makefile
+++ b/arch/sh/kernel/cpu/sh4a/Makefile
@@ -28,7 +28,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= clock-sh7785.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= clock-sh7786.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o hwblk-sh7723.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7366.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index 3cc3827..358c7cc 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -23,8 +23,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/sh_clk.h>
 #include <asm/clock.h>
-#include <asm/hwblk.h>
 #include <cpu/sh7723.h>
 
 /* SH7723 registers */
@@ -34,6 +34,9 @@
 #define SCLKBCR		0xa415000c
 #define IRDACLKCR	0xa4150018
 #define PLLCR		0xa4150024
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
 #define DLLFRQ		0xa4150050
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
@@ -147,57 +150,60 @@ struct clk div6_clks[DIV6_NR] = {
 	[DIV6_V] = SH_CLK_DIV6(&pll_clk, VCLKCR, 0),
 };
 
+#define MSTP(_parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
 static struct clk mstp_clks[] = {
 	/* See page 60 of Datasheet V1.0: Overview -> Block Diagram */
-	SH_HWBLK_CLK(HWBLK_TLB, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_IC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_OC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_L2C, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_ILMEM, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_FPU, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_INTC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_DMAC0, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SHYWAY, &div4_clks[DIV4_SH], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_HUDI, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_UBC, &div4_clks[DIV4_I], 0),
-	SH_HWBLK_CLK(HWBLK_TMU0, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_CMT, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_RWDT, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_DMAC1, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_TMU1, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_FLCTL, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF0, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF1, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF2, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF3, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF4, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF5, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_MSIOF0, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_MSIOF1, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_MERAM, &div4_clks[DIV4_SH], 0),
-
-	SH_HWBLK_CLK(HWBLK_IIC, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_RTC, &r_clk, 0),
-
-	SH_HWBLK_CLK(HWBLK_ATAPI, &div4_clks[DIV4_SH], 0),
-	SH_HWBLK_CLK(HWBLK_ADC, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_TPU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_IRDA, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_TSIF, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_ICB, &div4_clks[DIV4_B], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_SDHI0, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SDHI1, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_KEYSC, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_USB, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_2DG, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SIU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VEU2H1, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VOU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_BEU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_CEU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VEU2H0, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VPU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_B], 0),
+	[HWBLK_TLB]    = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	[HWBLK_IC]     = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	[HWBLK_OC]     = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	[HWBLK_L2C]    = MSTP(&div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	[HWBLK_ILMEM]  = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 27, CLK_ENABLE_ON_INIT),
+	[HWBLK_FPU]    = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 24, CLK_ENABLE_ON_INIT),
+	[HWBLK_INTC]   = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 22, CLK_ENABLE_ON_INIT),
+	[HWBLK_DMAC0]  = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 21, 0),
+	[HWBLK_SHYWAY] = MSTP(&div4_clks[DIV4_SH], MSTPCR0, 20, CLK_ENABLE_ON_INIT),
+	[HWBLK_HUDI]   = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 19, 0),
+	[HWBLK_UBC]    = MSTP(&div4_clks[DIV4_I],  MSTPCR0, 17, 0),
+	[HWBLK_TMU0]   = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 15, 0),
+	[HWBLK_CMT]    = MSTP(&r_clk,		   MSTPCR0, 14, 0),
+	[HWBLK_RWDT]   = MSTP(&r_clk,		   MSTPCR0, 13, 0),
+	[HWBLK_DMAC1]  = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 12, 0),
+	[HWBLK_TMU1]   = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 11, 0),
+	[HWBLK_FLCTL]  = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 10, 0),
+	[HWBLK_SCIF0]  = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 9, 0),
+	[HWBLK_SCIF1]  = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 8, 0),
+	[HWBLK_SCIF2]  = MSTP(&div4_clks[DIV4_P],  MSTPCR0, 7, 0),
+	[HWBLK_SCIF3]  = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 6, 0),
+	[HWBLK_SCIF4]  = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 5, 0),
+	[HWBLK_SCIF5]  = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 4, 0),
+	[HWBLK_MSIOF0] = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 2, 0),
+	[HWBLK_MSIOF1] = MSTP(&div4_clks[DIV4_B],  MSTPCR0, 1, 0),
+	[HWBLK_MERAM]  = MSTP(&div4_clks[DIV4_SH], MSTPCR0, 0, 0),
+
+	[HWBLK_IIC]    = MSTP(&div4_clks[DIV4_P],  MSTPCR1, 9, 0),
+	[HWBLK_RTC]    = MSTP(&r_clk,		   MSTPCR1, 8, 0),
+
+	[HWBLK_ATAPI]  = MSTP(&div4_clks[DIV4_SH], MSTPCR2, 28, 0),
+	[HWBLK_ADC]    = MSTP(&div4_clks[DIV4_P],  MSTPCR2, 27, 0),
+	[HWBLK_TPU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 25, 0),
+	[HWBLK_IRDA]   = MSTP(&div4_clks[DIV4_P],  MSTPCR2, 24, 0),
+	[HWBLK_TSIF]   = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 22, 0),
+	[HWBLK_ICB]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 21, CLK_ENABLE_ON_INIT),
+	[HWBLK_SDHI0]  = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 18, 0),
+	[HWBLK_SDHI1]  = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 17, 0),
+	[HWBLK_KEYSC]  = MSTP(&r_clk,		   MSTPCR2, 14, 0),
+	[HWBLK_USB]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 11, 0),
+	[HWBLK_2DG]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 10, 0),
+	[HWBLK_SIU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 8, 0),
+	[HWBLK_VEU2H1] = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 6, 0),
+	[HWBLK_VOU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 5, 0),
+	[HWBLK_BEU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 4, 0),
+	[HWBLK_CEU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 3, 0),
+	[HWBLK_VEU2H0] = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 2, 0),
+	[HWBLK_VPU]    = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 1, 0),
+	[HWBLK_LCDC]   = MSTP(&div4_clks[DIV4_B],  MSTPCR2, 0, 0),
 };
 
 static struct clk_lookup lookups[] = {
@@ -229,7 +235,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ilmem0", &mstp_clks[HWBLK_ILMEM]),
 	CLKDEV_CON_ID("fpu0", &mstp_clks[HWBLK_FPU]),
 	CLKDEV_CON_ID("intc0", &mstp_clks[HWBLK_INTC]),
-	CLKDEV_CON_ID("dmac0", &mstp_clks[HWBLK_DMAC0]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[HWBLK_DMAC0]),
 	CLKDEV_CON_ID("sh0", &mstp_clks[HWBLK_SHYWAY]),
 	CLKDEV_CON_ID("hudi0", &mstp_clks[HWBLK_HUDI]),
 	CLKDEV_CON_ID("ubc0", &mstp_clks[HWBLK_UBC]),
@@ -250,8 +256,8 @@ static struct clk_lookup lookups[] = {
 		.clk		= &mstp_clks[HWBLK_TMU0],
 	},
 	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
-	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
-	CLKDEV_CON_ID("dmac1", &mstp_clks[HWBLK_DMAC1]),
+	CLKDEV_DEV_ID("sh-wdt.0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[HWBLK_DMAC1]),
 	{
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
@@ -269,40 +275,15 @@ static struct clk_lookup lookups[] = {
 		.clk		= &mstp_clks[HWBLK_TMU1],
 	},
 	CLKDEV_CON_ID("flctl0", &mstp_clks[HWBLK_FLCTL]),
-	{
-		/* SCIF0 */
-		.dev_id		= "sh-sci.0",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF0],
-	}, {
-		/* SCIF1 */
-		.dev_id		= "sh-sci.1",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF1],
-	}, {
-		/* SCIF2 */
-		.dev_id		= "sh-sci.2",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF2],
-	}, {
-		/* SCIF3 */
-		.dev_id		= "sh-sci.3",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF3],
-	}, {
-		/* SCIF4 */
-		.dev_id		= "sh-sci.4",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF4],
-	}, {
-		/* SCIF5 */
-		.dev_id		= "sh-sci.5",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF5],
-	},
-	CLKDEV_CON_ID("msiof0", &mstp_clks[HWBLK_MSIOF0]),
-	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
-	CLKDEV_CON_ID("meram0", &mstp_clks[HWBLK_MERAM]),
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[HWBLK_SCIF3]),
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[HWBLK_SCIF4]),
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[HWBLK_SCIF5]),
+	CLKDEV_DEV_ID("spi_sh_msiof.0", &mstp_clks[HWBLK_MSIOF0]),
+	CLKDEV_DEV_ID("spi_sh_msiof.1", &mstp_clks[HWBLK_MSIOF1]),
+	CLKDEV_DEV_ID("sh_mobile_meram.0", &mstp_clks[HWBLK_MERAM]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
 	CLKDEV_CON_ID("atapi0", &mstp_clks[HWBLK_ATAPI]),
@@ -311,19 +292,19 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("irda0", &mstp_clks[HWBLK_IRDA]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
 	CLKDEV_CON_ID("icb0", &mstp_clks[HWBLK_ICB]),
-	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI0]),
-	CLKDEV_CON_ID("sdhi1", &mstp_clks[HWBLK_SDHI1]),
-	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI0]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[HWBLK_SDHI1]),
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[HWBLK_KEYSC]),
 	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB]),
 	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
-	CLKDEV_CON_ID("siu0", &mstp_clks[HWBLK_SIU]),
+	CLKDEV_DEV_ID("siu-pcm-audio", &mstp_clks[HWBLK_SIU]),
 	CLKDEV_CON_ID("veu1", &mstp_clks[HWBLK_VEU2H1]),
-	CLKDEV_CON_ID("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU]),
-	CLKDEV_CON_ID("ceu0", &mstp_clks[HWBLK_CEU]),
+	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[HWBLK_CEU]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU2H0]),
 	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
-	CLKDEV_CON_ID("lcdc0", &mstp_clks[HWBLK_LCDC]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
@@ -356,7 +337,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
+		ret = sh_clk_mstp32_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c b/arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c
deleted file mode 100644
index a7f4684..0000000
--- a/arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * arch/sh/kernel/cpu/sh4a/hwblk-sh7723.c
- *
- * SH7723 hardware block support
- *
- * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <asm/suspend.h>
-#include <asm/hwblk.h>
-#include <cpu/sh7723.h>
-
-/* SH7723 registers */
-#define MSTPCR0		0xa4150030
-#define MSTPCR1		0xa4150034
-#define MSTPCR2		0xa4150038
-
-/* SH7723 Power Domains */
-enum { CORE_AREA, SUB_AREA, CORE_AREA_BM };
-static struct hwblk_area sh7723_hwblk_area[] = {
-	[CORE_AREA] = HWBLK_AREA(0, 0),
-	[CORE_AREA_BM] = HWBLK_AREA(HWBLK_AREA_FLAG_PARENT, CORE_AREA),
-	[SUB_AREA] = HWBLK_AREA(0, 0),
-};
-
-/* Table mapping HWBLK to Module Stop Bit and Power Domain */
-static struct hwblk sh7723_hwblk[HWBLK_NR] = {
-	[HWBLK_TLB] = HWBLK(MSTPCR0, 31, CORE_AREA),
-	[HWBLK_IC] = HWBLK(MSTPCR0, 30, CORE_AREA),
-	[HWBLK_OC] = HWBLK(MSTPCR0, 29, CORE_AREA),
-	[HWBLK_L2C] = HWBLK(MSTPCR0, 28, CORE_AREA),
-	[HWBLK_ILMEM] = HWBLK(MSTPCR0, 27, CORE_AREA),
-	[HWBLK_FPU] = HWBLK(MSTPCR0, 24, CORE_AREA),
-	[HWBLK_INTC] = HWBLK(MSTPCR0, 22, CORE_AREA),
-	[HWBLK_DMAC0] = HWBLK(MSTPCR0, 21, CORE_AREA_BM),
-	[HWBLK_SHYWAY] = HWBLK(MSTPCR0, 20, CORE_AREA),
-	[HWBLK_HUDI] = HWBLK(MSTPCR0, 19, CORE_AREA),
-	[HWBLK_DBG] = HWBLK(MSTPCR0, 18, CORE_AREA),
-	[HWBLK_UBC] = HWBLK(MSTPCR0, 17, CORE_AREA),
-	[HWBLK_SUBC] = HWBLK(MSTPCR0, 16, CORE_AREA),
-	[HWBLK_TMU0] = HWBLK(MSTPCR0, 15, CORE_AREA),
-	[HWBLK_CMT] = HWBLK(MSTPCR0, 14, SUB_AREA),
-	[HWBLK_RWDT] = HWBLK(MSTPCR0, 13, SUB_AREA),
-	[HWBLK_DMAC1] = HWBLK(MSTPCR0, 12, CORE_AREA_BM),
-	[HWBLK_TMU1] = HWBLK(MSTPCR0, 11, CORE_AREA),
-	[HWBLK_FLCTL] = HWBLK(MSTPCR0, 10, CORE_AREA),
-	[HWBLK_SCIF0] = HWBLK(MSTPCR0, 9, CORE_AREA),
-	[HWBLK_SCIF1] = HWBLK(MSTPCR0, 8, CORE_AREA),
-	[HWBLK_SCIF2] = HWBLK(MSTPCR0, 7, CORE_AREA),
-	[HWBLK_SCIF3] = HWBLK(MSTPCR0, 6, CORE_AREA),
-	[HWBLK_SCIF4] = HWBLK(MSTPCR0, 5, CORE_AREA),
-	[HWBLK_SCIF5] = HWBLK(MSTPCR0, 4, CORE_AREA),
-	[HWBLK_MSIOF0] = HWBLK(MSTPCR0, 2, CORE_AREA),
-	[HWBLK_MSIOF1] = HWBLK(MSTPCR0, 1, CORE_AREA),
-	[HWBLK_MERAM] = HWBLK(MSTPCR0, 0, CORE_AREA),
-
-	[HWBLK_IIC] = HWBLK(MSTPCR1, 9, CORE_AREA),
-	[HWBLK_RTC] = HWBLK(MSTPCR1, 8, SUB_AREA),
-
-	[HWBLK_ATAPI] = HWBLK(MSTPCR2, 28, CORE_AREA_BM),
-	[HWBLK_ADC] = HWBLK(MSTPCR2, 27, CORE_AREA),
-	[HWBLK_TPU] = HWBLK(MSTPCR2, 25, CORE_AREA),
-	[HWBLK_IRDA] = HWBLK(MSTPCR2, 24, CORE_AREA),
-	[HWBLK_TSIF] = HWBLK(MSTPCR2, 22, CORE_AREA),
-	[HWBLK_ICB] = HWBLK(MSTPCR2, 21, CORE_AREA_BM),
-	[HWBLK_SDHI0] = HWBLK(MSTPCR2, 18, CORE_AREA),
-	[HWBLK_SDHI1] = HWBLK(MSTPCR2, 17, CORE_AREA),
-	[HWBLK_KEYSC] = HWBLK(MSTPCR2, 14, SUB_AREA),
-	[HWBLK_USB] = HWBLK(MSTPCR2, 11, CORE_AREA),
-	[HWBLK_2DG] = HWBLK(MSTPCR2, 10, CORE_AREA_BM),
-	[HWBLK_SIU] = HWBLK(MSTPCR2, 8, CORE_AREA),
-	[HWBLK_VEU2H1] = HWBLK(MSTPCR2, 6, CORE_AREA_BM),
-	[HWBLK_VOU] = HWBLK(MSTPCR2, 5, CORE_AREA_BM),
-	[HWBLK_BEU] = HWBLK(MSTPCR2, 4, CORE_AREA_BM),
-	[HWBLK_CEU] = HWBLK(MSTPCR2, 3, CORE_AREA_BM),
-	[HWBLK_VEU2H0] = HWBLK(MSTPCR2, 2, CORE_AREA_BM),
-	[HWBLK_VPU] = HWBLK(MSTPCR2, 1, CORE_AREA_BM),
-	[HWBLK_LCDC] = HWBLK(MSTPCR2, 0, CORE_AREA_BM),
-};
-
-static struct hwblk_info sh7723_hwblk_info = {
-	.areas = sh7723_hwblk_area,
-	.nr_areas = ARRAY_SIZE(sh7723_hwblk_area),
-	.hwblks = sh7723_hwblk,
-	.nr_hwblks = ARRAY_SIZE(sh7723_hwblk),
-};
-
-int arch_hwblk_sleep_mode(void)
-{
-	if (!sh7723_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE])
-		return SUSP_SH_STANDBY | SUSP_SH_SF;
-
-	if (!sh7723_hwblk_area[CORE_AREA_BM].cnt[HWBLK_CNT_USAGE])
-		return SUSP_SH_SLEEP | SUSP_SH_SF;
-
-	return SUSP_SH_SLEEP;
-}
-
-int __init arch_hwblk_init(void)
-{
-	return hwblk_register(&sh7723_hwblk_info);
-}
diff --git a/arch/sh/kernel/cpu/shmobile/Makefile b/arch/sh/kernel/cpu/shmobile/Makefile
index e83c9d5..7eb4502 100644
--- a/arch/sh/kernel/cpu/shmobile/Makefile
+++ b/arch/sh/kernel/cpu/shmobile/Makefile
@@ -5,6 +5,6 @@
 # Power Management & Sleep mode
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
-ifneq ($(CONFIG_CPU_SUBTYPE_SH7724)$(CONFIG_CPU_SUBTYPE_SH7722),y)
+ifneq ($(CONFIG_CPU_SUBTYPE_SH7722)$(CONFIG_CPU_SUBTYPE_SH7723)$(CONFIG_CPU_SUBTYPE_SH7724),y)
 obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
 endif
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index ffca2b4..51f171b 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
 # special casing can go away.
 #
 obj-$(CONFIG_SUPERH)$(CONFIG_ARCH_SHMOBILE)	+= pm_runtime.o
-obj-$(CONFIG_CPU_SUBTYPE_SH7724)		+= pm_runtime.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7722)		+= pm_runtime.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7723)		+= pm_runtime.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7724)		+= pm_runtime.o
-- 
1.7.2.5

