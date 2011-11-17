From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Nov 2011 13:55:52 +0000
Subject: [PATCH 2/3 v2] sh: sh7722: use runtime PM implementation, common
Message-Id: <Pine.LNX.4.64.1111171453110.2650@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Switch sh7722 to a runtime PM implementation, common with ARM-based
sh-mobile platforms.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: remove the MSTP() wrapper

 arch/sh/include/asm/hwblk.h            |    2 +-
 arch/sh/kernel/cpu/Makefile            |    2 +-
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   77 ++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c |  106 --------------------------------
 arch/sh/kernel/cpu/shmobile/Makefile   |    2 +-
 drivers/sh/Makefile                    |    1 +
 7 files changed, 45 insertions(+), 147 deletions(-)
 delete mode 100644 arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c

diff --git a/arch/sh/include/asm/hwblk.h b/arch/sh/include/asm/hwblk.h
index 567c9aa..d6b7dea 100644
--- a/arch/sh/include/asm/hwblk.h
+++ b/arch/sh/include/asm/hwblk.h
@@ -44,7 +44,7 @@ struct hwblk_info {
 	int nr_hwblks;
 };
 
-#if !defined(CONFIG_CPU_SUBTYPE_SH7724)
+#if !defined(CONFIG_CPU_SUBTYPE_SH7724) && !defined(CONFIG_CPU_SUBTYPE_SH7722)
 /* Should be defined by processor-specific code */
 int arch_hwblk_init(void);
 int arch_hwblk_sleep_mode(void);
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index b937f1a..b1f515c 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -19,6 +19,6 @@ obj-$(CONFIG_SH_ADC)		+= adc.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
 obj-y	+= irq/ init.o clock.o fpu.o proc.o
-ifneq ($(CONFIG_CPU_SUBTYPE_SH7724),y)
+ifneq ($(CONFIG_CPU_SUBTYPE_SH7724)$(CONFIG_CPU_SUBTYPE_SH7722),y)
 obj-y	+= hwblk.o
 endif
diff --git a/arch/sh/kernel/cpu/sh4a/Makefile b/arch/sh/kernel/cpu/sh4a/Makefile
index cb93287..9f28773 100644
--- a/arch/sh/kernel/cpu/sh4a/Makefile
+++ b/arch/sh/kernel/cpu/sh4a/Makefile
@@ -27,7 +27,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7780)	:= clock-sh7780.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= clock-sh7785.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= clock-sh7786.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o hwblk-sh7722.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o hwblk-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7366.o
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index c9a4808..212c72e 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -22,8 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/sh_clk.h>
 #include <asm/clock.h>
-#include <asm/hwblk.h>
 #include <cpu/sh7722.h>
 
 /* SH7722 registers */
@@ -33,6 +33,9 @@
 #define SCLKBCR		0xa415000c
 #define IRDACLKCR	0xa4150018
 #define PLLCR		0xa4150024
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
 #define DLLFRQ		0xa4150050
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
@@ -148,31 +151,31 @@ struct clk div6_clks[DIV6_NR] = {
 };
 
 static struct clk mstp_clks[HWBLK_NR] = {
-	SH_HWBLK_CLK(HWBLK_URAM, &div4_clks[DIV4_U], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_XYMEM, &div4_clks[DIV4_B], CLK_ENABLE_ON_INIT),
-	SH_HWBLK_CLK(HWBLK_TMU, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_CMT, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_RWDT, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_FLCTL, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF0, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF1, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_SCIF2, &div4_clks[DIV4_P], 0),
-
-	SH_HWBLK_CLK(HWBLK_IIC, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_RTC, &r_clk, 0),
-
-	SH_HWBLK_CLK(HWBLK_SDHI, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_KEYSC, &r_clk, 0),
-	SH_HWBLK_CLK(HWBLK_USBF, &div4_clks[DIV4_P], 0),
-	SH_HWBLK_CLK(HWBLK_2DG, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_SIU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VOU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_JPU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_BEU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_CEU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VEU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_VPU, &div4_clks[DIV4_B], 0),
-	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_P], 0),
+	[HWBLK_URAM]  = SH_CLK_MSTP32(&div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	[HWBLK_XYMEM] = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	[HWBLK_TMU]   = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[HWBLK_CMT]   = SH_CLK_MSTP32(&r_clk,		  MSTPCR0, 14, 0),
+	[HWBLK_RWDT]  = SH_CLK_MSTP32(&r_clk,		  MSTPCR0, 13, 0),
+	[HWBLK_FLCTL] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[HWBLK_SCIF0] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	[HWBLK_SCIF1] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	[HWBLK_SCIF2] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 5, 0),
+
+	[HWBLK_IIC]   = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	[HWBLK_RTC]   = SH_CLK_MSTP32(&r_clk,		  MSTPCR1, 8, 0),
+
+	[HWBLK_SDHI]  = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	[HWBLK_KEYSC] = SH_CLK_MSTP32(&r_clk,		  MSTPCR2, 14, 0),
+	[HWBLK_USBF]  = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	[HWBLK_2DG]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 9, 0),
+	[HWBLK_SIU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 8, 0),
+	[HWBLK_JPU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 6, 0),
+	[HWBLK_VOU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	[HWBLK_BEU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	[HWBLK_CEU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	[HWBLK_VEU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 2, 0),
+	[HWBLK_VPU]   = SH_CLK_MSTP32(&div4_clks[DIV4_B], MSTPCR2, 1, 0),
+	[HWBLK_LCDC]  = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR2, 0, 0),
 };
 
 static struct clk_lookup lookups[] = {
@@ -205,27 +208,27 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[HWBLK_TMU]),
 
 	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
-	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_DEV_ID("sh-wdt.0", &mstp_clks[HWBLK_RWDT]),
 	CLKDEV_CON_ID("flctl0", &mstp_clks[HWBLK_FLCTL]),
 
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
 
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
-	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI]),
-	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI]),
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[HWBLK_KEYSC]),
 	CLKDEV_CON_ID("usbf0", &mstp_clks[HWBLK_USBF]),
 	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
-	CLKDEV_CON_ID("siu0", &mstp_clks[HWBLK_SIU]),
-	CLKDEV_CON_ID("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_DEV_ID("siu-pcm-audio", &mstp_clks[HWBLK_SIU]),
+	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU]),
-	CLKDEV_CON_ID("ceu0", &mstp_clks[HWBLK_CEU]),
+	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[HWBLK_CEU]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU]),
 	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
-	CLKDEV_CON_ID("lcdc0", &mstp_clks[HWBLK_LCDC]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
@@ -258,7 +261,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
+		ret = sh_clk_mstp32_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c b/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c
deleted file mode 100644
index a288b5d..0000000
--- a/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c
- *
- * SH7722 hardware block support
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
-#include <cpu/sh7722.h>
-
-/* SH7722 registers */
-#define MSTPCR0		0xa4150030
-#define MSTPCR1		0xa4150034
-#define MSTPCR2		0xa4150038
-
-/* SH7722 Power Domains */
-enum { CORE_AREA, SUB_AREA, CORE_AREA_BM };
-static struct hwblk_area sh7722_hwblk_area[] = {
-	[CORE_AREA] = HWBLK_AREA(0, 0),
-	[CORE_AREA_BM] = HWBLK_AREA(HWBLK_AREA_FLAG_PARENT, CORE_AREA),
-	[SUB_AREA] = HWBLK_AREA(0, 0),
-};
-
-/* Table mapping HWBLK to Module Stop Bit and Power Domain */
-static struct hwblk sh7722_hwblk[HWBLK_NR] = {
-	[HWBLK_TLB] = HWBLK(MSTPCR0, 31, CORE_AREA),
-	[HWBLK_IC] = HWBLK(MSTPCR0, 30, CORE_AREA),
-	[HWBLK_OC] = HWBLK(MSTPCR0, 29, CORE_AREA),
-	[HWBLK_URAM] = HWBLK(MSTPCR0, 28, CORE_AREA),
-	[HWBLK_XYMEM] = HWBLK(MSTPCR0, 26, CORE_AREA),
-	[HWBLK_INTC] = HWBLK(MSTPCR0, 22, CORE_AREA),
-	[HWBLK_DMAC] = HWBLK(MSTPCR0, 21, CORE_AREA_BM),
-	[HWBLK_SHYWAY] = HWBLK(MSTPCR0, 20, CORE_AREA),
-	[HWBLK_HUDI] = HWBLK(MSTPCR0, 19, CORE_AREA),
-	[HWBLK_UBC] = HWBLK(MSTPCR0, 17, CORE_AREA),
-	[HWBLK_TMU] = HWBLK(MSTPCR0, 15, CORE_AREA),
-	[HWBLK_CMT] = HWBLK(MSTPCR0, 14, SUB_AREA),
-	[HWBLK_RWDT] = HWBLK(MSTPCR0, 13, SUB_AREA),
-	[HWBLK_FLCTL] = HWBLK(MSTPCR0, 10, CORE_AREA),
-	[HWBLK_SCIF0] = HWBLK(MSTPCR0, 7, CORE_AREA),
-	[HWBLK_SCIF1] = HWBLK(MSTPCR0, 6, CORE_AREA),
-	[HWBLK_SCIF2] = HWBLK(MSTPCR0, 5, CORE_AREA),
-	[HWBLK_SIO] = HWBLK(MSTPCR0, 3, CORE_AREA),
-	[HWBLK_SIOF0] = HWBLK(MSTPCR0, 2, CORE_AREA),
-	[HWBLK_SIOF1] = HWBLK(MSTPCR0, 1, CORE_AREA),
-
-	[HWBLK_IIC] = HWBLK(MSTPCR1, 9, CORE_AREA),
-	[HWBLK_RTC] = HWBLK(MSTPCR1, 8, SUB_AREA),
-
-	[HWBLK_TPU] = HWBLK(MSTPCR2, 25, CORE_AREA),
-	[HWBLK_IRDA] = HWBLK(MSTPCR2, 24, CORE_AREA),
-	[HWBLK_SDHI] = HWBLK(MSTPCR2, 18, CORE_AREA),
-	[HWBLK_SIM] = HWBLK(MSTPCR2, 16, CORE_AREA),
-	[HWBLK_KEYSC] = HWBLK(MSTPCR2, 14, SUB_AREA),
-	[HWBLK_TSIF] = HWBLK(MSTPCR2, 13, SUB_AREA),
-	[HWBLK_USBF] = HWBLK(MSTPCR2, 11, CORE_AREA),
-	[HWBLK_2DG] = HWBLK(MSTPCR2, 9, CORE_AREA_BM),
-	[HWBLK_SIU] = HWBLK(MSTPCR2, 8, CORE_AREA),
-	[HWBLK_JPU] = HWBLK(MSTPCR2, 6, CORE_AREA_BM),
-	[HWBLK_VOU] = HWBLK(MSTPCR2, 5, CORE_AREA_BM),
-	[HWBLK_BEU] = HWBLK(MSTPCR2, 4, CORE_AREA_BM),
-	[HWBLK_CEU] = HWBLK(MSTPCR2, 3, CORE_AREA_BM),
-	[HWBLK_VEU] = HWBLK(MSTPCR2, 2, CORE_AREA_BM),
-	[HWBLK_VPU] = HWBLK(MSTPCR2, 1, CORE_AREA_BM),
-	[HWBLK_LCDC] = HWBLK(MSTPCR2, 0, CORE_AREA_BM),
-};
-
-static struct hwblk_info sh7722_hwblk_info = {
-	.areas = sh7722_hwblk_area,
-	.nr_areas = ARRAY_SIZE(sh7722_hwblk_area),
-	.hwblks = sh7722_hwblk,
-	.nr_hwblks = ARRAY_SIZE(sh7722_hwblk),
-};
-
-int arch_hwblk_sleep_mode(void)
-{
-	if (!sh7722_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE])
-		return SUSP_SH_STANDBY | SUSP_SH_SF;
-
-	if (!sh7722_hwblk_area[CORE_AREA_BM].cnt[HWBLK_CNT_USAGE])
-		return SUSP_SH_SLEEP | SUSP_SH_SF;
-
-	return SUSP_SH_SLEEP;
-}
-
-int __init arch_hwblk_init(void)
-{
-	return hwblk_register(&sh7722_hwblk_info);
-}
diff --git a/arch/sh/kernel/cpu/shmobile/Makefile b/arch/sh/kernel/cpu/shmobile/Makefile
index 2f32a03..e83c9d5 100644
--- a/arch/sh/kernel/cpu/shmobile/Makefile
+++ b/arch/sh/kernel/cpu/shmobile/Makefile
@@ -5,6 +5,6 @@
 # Power Management & Sleep mode
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
-ifneq ($(CONFIG_CPU_SUBTYPE_SH7724),y)
+ifneq ($(CONFIG_CPU_SUBTYPE_SH7724)$(CONFIG_CPU_SUBTYPE_SH7722),y)
 obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
 endif
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index 30c2594..ffca2b4 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
 #
 obj-$(CONFIG_SUPERH)$(CONFIG_ARCH_SHMOBILE)	+= pm_runtime.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7724)		+= pm_runtime.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7722)		+= pm_runtime.o
-- 
1.7.2.5

