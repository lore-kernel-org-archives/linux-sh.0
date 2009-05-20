From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 14:23:16 +0000
Subject: [PATCH] sh: shared clock framework code for sh7723
Message-Id: <20090520142316.8221.69424.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090520141800.8158.23015.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090520141800.8158.23015.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch hooks up the sh7723 processor to make use of
the new and improved clock framework code for SuperH Mobile.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on ap325.  Apply on top of the clkfwk topic branch.

 arch/sh/Kconfig                                  |    1 
 arch/sh/include/cpu-common/cpu/clock-sh_mobile.h |    6 
 arch/sh/kernel/cpu/sh4a/Makefile                 |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c           |   57 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c           |  361 ++++++++++++++++++++++
 5 files changed, 370 insertions(+), 57 deletions(-)

--- 0003/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-20 22:19:34.000000000 +0900
@@ -365,6 +365,7 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
+	select SH_CLK_DISABLE_LEGACY
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
--- 0004/arch/sh/include/cpu-common/cpu/clock-sh_mobile.h
+++ work/arch/sh/include/cpu-common/cpu/clock-sh_mobile.h	2009-05-20 22:19:34.000000000 +0900
@@ -1,8 +1,14 @@
 #ifndef __CLOCK_SH_MOBILE_H__
 #define __CLOCK_SH_MOBILE_H__
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7723
+#define SH_MOBILE_DIVISOR_NR 9
+#define SH_MOBILE_MSTP_NR 48
+#else
 #define SH_MOBILE_DIVISOR_NR 0 /* override with cpu specific value */
 #define SH_MOBILE_MSTP_NR 0 /* override with cpu specific value */
+#endif
+
 #define SH_MOBILE_ALLOWED_NR 16 /* 4-bit fields is enough for now */
 
 /* system clock modes */
--- 0001/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-05-20 22:19:34.000000000 +0900
@@ -26,7 +26,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= clock-sh7786.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7722.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-05-20 22:22:15.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
- * SH7343, SH7722, SH7723 & SH7366 support for the clock framework
+ * SH7343, SH7722 & SH7366 support for the clock framework
  *
  * Copyright (c) 2006-2007 Nomad Global Solutions Inc
  * Based on code for sh7343 by Paul Mundt
@@ -176,11 +176,6 @@ static unsigned long module_clk_recalc(s
 #define STCMASK		0x3f
 #define DIVCALC(div)	(div/2-1)
 #define FRQCRKICK	0x80000000
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-#define MASTERDIVS	{ 6, 8, 12, 16 }
-#define STCMASK		0x1f
-#define DIVCALC(div)	(div-1)
-#define FRQCRKICK	0x00000000
 #else
 #define MASTERDIVS	{ 2, 3, 4, 6, 8, 16 }
 #define STCMASK		0x1f
@@ -681,56 +676,6 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
 	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
 #endif
-#if defined(CONFIG_CPU_SUBTYPE_SH7723)
-	/* See page 60 of Datasheet V1.0: Overview -> Block Diagram */
-	MSTPCR("tlb0", "cpu_clk", 0, 31, 0),
-	MSTPCR("ic0", "cpu_clk", 0, 30, 0),
-	MSTPCR("oc0", "cpu_clk", 0, 29, 0),
-	MSTPCR("l2c0", "sh_clk", 0, 28, 0),
-	MSTPCR("ilmem0", "cpu_clk", 0, 27, 0),
-	MSTPCR("fpu0", "cpu_clk", 0, 24, 0),
-	MSTPCR("intc0", "cpu_clk", 0, 22, 0),
-	MSTPCR("dmac0", "bus_clk", 0, 21, 0),
-	MSTPCR("sh0", "sh_clk", 0, 20, 0),
-	MSTPCR("hudi0", "peripheral_clk", 0, 19, 0),
-	MSTPCR("ubc0", "cpu_clk", 0, 17, 0),
-	MSTPCR("tmu0", "peripheral_clk", 0, 15, 0),
-	MSTPCR("cmt0", "r_clk", 0, 14, 0),
-	MSTPCR("rwdt0", "r_clk", 0, 13, 0),
-	MSTPCR("dmac1", "bus_clk", 0, 12, 0),
-	MSTPCR("tmu1", "peripheral_clk", 0, 11, 0),
-	MSTPCR("flctl0", "peripheral_clk", 0, 10, 0),
-	MSTPCR("scif0", "peripheral_clk", 0, 9, 0),
-	MSTPCR("scif1", "peripheral_clk", 0, 8, 0),
-	MSTPCR("scif2", "peripheral_clk", 0, 7, 0),
-	MSTPCR("scif3", "bus_clk", 0, 6, 0),
-	MSTPCR("scif4", "bus_clk", 0, 5, 0),
-	MSTPCR("scif5", "bus_clk", 0, 4, 0),
-	MSTPCR("msiof0", "bus_clk", 0, 2, 0),
-	MSTPCR("msiof1", "bus_clk", 0, 1, 0),
-	MSTPCR("meram0", "sh_clk", 0, 0, CLK_ENABLE_ON_INIT),
-	MSTPCR("i2c0", "peripheral_clk", 1, 9, 0),
-	MSTPCR("rtc0", "r_clk", 1, 8, 0),
-	MSTPCR("atapi0", "sh_clk", 2, 28, 0),
-	MSTPCR("adc0", "peripheral_clk", 2, 28, 0),
-	MSTPCR("tpu0", "bus_clk", 2, 25, 0),
-	MSTPCR("irda0", "peripheral_clk", 2, 24, 0),
-	MSTPCR("tsif0", "bus_clk", 2, 22, 0),
-	MSTPCR("icb0", "bus_clk", 2, 21, 0),
-	MSTPCR("sdhi0", "bus_clk", 2, 18, 0),
-	MSTPCR("sdhi1", "bus_clk", 2, 17, 0),
-	MSTPCR("keysc0", "r_clk", 2, 14, 0),
-	MSTPCR("usb0", "bus_clk", 2, 11, 0),
-	MSTPCR("2dg0", "bus_clk", 2, 10, 0),
-	MSTPCR("siu0", "bus_clk", 2, 8, 0),
-	MSTPCR("veu1", "bus_clk", 2, 6, CLK_ENABLE_ON_INIT),
-	MSTPCR("vou0", "bus_clk", 2, 5, 0),
-	MSTPCR("beu0", "bus_clk", 2, 4, 0),
-	MSTPCR("ceu0", "bus_clk", 2, 3, 0),
-	MSTPCR("veu0", "bus_clk", 2, 2, CLK_ENABLE_ON_INIT),
-	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
-	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
-#endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7724)
 	/* See Datasheet : Overview -> Block Diagram */
 	MSTPCR("tlb0", "cpu_clk", 0, 31, 0),
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2009-05-20 22:21:02.000000000 +0900
@@ -0,0 +1,361 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+ *
+ * SH77723 clock framework support
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
+#include <linux/errno.h>
+#include <linux/stringify.h>
+#include <cpu/clock-sh_mobile.h>
+#include <asm/clock.h>
+
+/* divisor bitnr in bitmaps and as index in multipliers[] / divisors[] */
+#define BIT_1_1  0
+#define BIT_2_3  1
+#define BIT_1_2  2
+#define BIT_2_5  3
+#define BIT_1_3  4
+#define BIT_1_4  5
+#define BIT_1_5  6
+#define BIT_1_6  7
+#define BIT_1_8  8
+#define BIT_1_10 9
+#define BIT_1_12 10
+#define BIT_1_16 11 /* keep below SH_MOBILE_ALLOWED_NR */
+
+/* system divisor nr */
+#define DIV_I  0
+#define DIV_U  1
+#define DIV_SH 2
+#define DIV_B3 3
+#define DIV_B  4
+#define DIV_P  5
+#define DIV_SIUA 6
+#define DIV_SIUB 7
+#define DIV_IRDA 8  /* keep below SH_MOBILE_DIVISOR_NR */
+
+/* system clock groups */
+#define GRP_UNUSED 0 /* zero must be unused */
+#define GRP_FRQCR 1
+#define GRP_SIUA 2
+#define GRP_SIUB 3
+#define GRP_IRDA 4
+
+/* SH7723 registers */
+#define FRQCR		        0xa4150000
+#define VCLKCR			0xa4150004
+#define SCLKACR			0xa4150008
+#define SCLKBCR			0xa415000c
+#define IrDACLKCR		0xa4150010
+#define MSTPCR0			0xa4150030
+#define MSTPCR1			0xa4150034
+#define MSTPCR2			0xa4150038
+
+/* common divisor combinations, index must match with BIT_ values above */
+static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1,  1,  1  };
+static int divisors[] =    { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16 };
+
+static int sh7723_div_check(struct sh_mobile_cpg_hw_cfg *f, int div, int bit,
+			    struct sh_mobile_cpg_state *cs)
+{
+	int ret = -1;
+
+	switch (div) {
+	case DIV_SH:
+		ret = sh_mobile_div_check(f, DIV_I, CLK_MODE_N_1, bit, cs);
+		if (ret >= 0)
+			break;
+		ret = sh_mobile_div_check(f, DIV_I, CLK_MODE_3_2, bit, cs);
+		break;
+	case DIV_U:
+		ret = sh_mobile_div_check(f, DIV_SH, CLK_MODE_1_1, bit, cs);
+		break;
+	case DIV_B:
+		ret = sh_mobile_div_check(f, DIV_SH, CLK_MODE_N_1, bit, cs);
+		break;
+	case DIV_B3:
+		ret = sh_mobile_div_check(f, DIV_SH, CLK_MODE_N_1, bit, cs);
+		break;
+	case DIV_P: /* both combinations must be met */
+		ret = sh_mobile_div_check(f, DIV_I, CLK_MODE_N_1, bit, cs);
+		if (ret < 0)
+			break;
+		ret = sh_mobile_div_check(f, DIV_B, CLK_MODE_N_1, bit, cs);
+		break;
+	case DIV_I:
+	case DIV_SIUA:
+	case DIV_SIUB:
+	case DIV_IRDA:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int sh7723_div_set(struct sh_mobile_cpg_hw_cfg *f, int grp,
+			  struct sh_mobile_cpg_state *cs)
+{
+	unsigned long value;
+
+	switch (grp) {
+	case GRP_FRQCR:
+		value = __raw_readl(FRQCR) & 0xff000000;
+		value |= cs->div_state[DIV_I].selected << 20; /* IFC */
+		value |= cs->div_state[DIV_U].selected << 16; /* UFC */
+		value |= cs->div_state[DIV_SH].selected << 12; /* SFC */
+		value |= cs->div_state[DIV_B].selected << 8; /* BFC */
+		value |= cs->div_state[DIV_B3].selected << 4; /* B3FC */
+		value |= cs->div_state[DIV_P].selected; /* P1FC */
+		__raw_writel(value, FRQCR);
+		break;
+
+	case GRP_SIUA:
+		value = __raw_readl(SCLKACR) & ~0xf;
+		value |=  cs->div_state[DIV_SIUA].selected;
+		__raw_writel(value, SCLKACR);
+		break;
+
+	case GRP_SIUB:
+		value = __raw_readl(SCLKBCR) & ~0xf;
+		value |=  cs->div_state[DIV_SIUB].selected;
+		__raw_writel(value, SCLKBCR);
+		break;
+
+	case GRP_IRDA:
+		value = __raw_readl(IrDACLKCR) & ~0xf;
+		value |=  cs->div_state[DIV_IRDA].selected;
+		__raw_writel(value, IrDACLKCR);
+		break;
+	}
+
+	return 1; /* done setting */
+}
+
+static int sh7723_div_get(struct sh_mobile_cpg_hw_cfg *f, int div)
+{
+	int shift;
+
+	switch (div) {
+	case DIV_I:
+		shift = 20; /* IFC */
+		break;
+
+	case DIV_U:
+		shift = 16; /* UFC */
+		break;
+
+	case DIV_SH:
+		shift = 12; /* SFC */
+		break;
+
+	case DIV_B:
+		shift = 8; /* BFC */
+		break;
+
+	case DIV_B3:
+		shift = 4; /* B3FC */
+		break;
+
+	case DIV_P:
+		shift = 0; /* P1FC */
+		break;
+
+	case DIV_IRDA:
+		return __raw_readl(IrDACLKCR) & 0xf;
+
+	case DIV_SIUA:
+		return __raw_readl(SCLKACR) & 0xf;
+
+	case DIV_SIUB:
+		return __raw_readl(SCLKBCR) & 0xf;
+
+	default:
+		return -1;
+	}
+
+	return (__raw_readl(FRQCR) >> shift) & 0xf;
+}
+
+static void sh7723_div_enable_disable(struct sh_mobile_cpg_hw_cfg *f,
+				      int div, int on)
+{
+	unsigned long reg;
+
+	switch (div) {
+	case DIV_IRDA:
+		reg = IrDACLKCR;
+		break;
+
+	case DIV_SIUA:
+		reg = SCLKACR;
+		break;
+
+	case DIV_SIUB:
+		reg = SCLKBCR;
+		break;
+
+	default:
+		return;
+	}
+
+	if (on)
+		__raw_writel(__raw_readl(reg) & ~0x80, reg);
+	else
+		__raw_writel(__raw_readl(reg) | 0x80, reg);
+}
+
+static void sh7723_div_all_ok(struct sh_mobile_div_hw_cfg *d)
+{
+	sh_mobile_div_ok(d, BIT_1_1);
+	sh_mobile_div_ok(d, BIT_2_3);
+	sh_mobile_div_ok(d, BIT_1_2);
+	sh_mobile_div_ok(d, BIT_2_5);
+	sh_mobile_div_ok(d, BIT_1_3);
+	sh_mobile_div_ok(d, BIT_1_4);
+	sh_mobile_div_ok(d, BIT_1_6);
+	sh_mobile_div_ok(d, BIT_1_8);
+	sh_mobile_div_ok(d, BIT_1_12);
+	sh_mobile_div_ok(d, BIT_1_16);
+}
+
+void sh7723_div_setup(struct sh_mobile_cpg_hw_cfg *p)
+{
+	struct sh_mobile_div_hw_cfg *d;
+
+	/* I Clock (CPU), max 400 MHz */
+	d = sh_mobile_div(p, 0, "cpu_clk", DIV_I, GRP_FRQCR, 400);
+	sh7723_div_all_ok(d);
+
+	/* SH Clock (SuperHyway), max 133 Mhz */
+	d = sh_mobile_div(p, 1, "shyway_clk", DIV_SH, GRP_FRQCR, 133);
+	sh7723_div_all_ok(d);
+
+	/* U Clock (URAM), max 133 MHz */
+	d = sh_mobile_div(p, 2, "uram_clk", DIV_U, GRP_FRQCR, 133);
+	sh7723_div_all_ok(d);
+
+	/* B Clock (Bus), max 66 MHz */
+	d = sh_mobile_div(p, 3, "bus_clk", DIV_B, GRP_FRQCR, 66);
+	sh7723_div_all_ok(d);
+
+	/* B3 Clock (SDRAM), max 133 MHz */
+	d = sh_mobile_div(p, 4, "b3_clk", DIV_B3, GRP_FRQCR, 133);
+	sh7723_div_all_ok(d);
+	sh_mobile_div_ng(d, BIT_1_1);
+	sh_mobile_div_ng(d, BIT_2_3);
+	sh_mobile_div_ng(d, BIT_2_5);
+
+	/* P Clock (Peripheral), max 33 MHz */
+	d = sh_mobile_div(p, 5, "peripheral_clk", DIV_P, GRP_FRQCR, 33);
+	sh7723_div_all_ok(d);
+
+	/* SIUA Clock, max 33 MHz */
+	d = sh_mobile_div(p, 6, "siua_clk", DIV_SIUA, GRP_SIUA, 33);
+	sh7723_div_all_ok(d);
+
+	/* SIUB Clock, max 33 MHz */
+	d = sh_mobile_div(p, 7, "siub_clk", DIV_SIUB, GRP_SIUB, 33);
+	sh7723_div_all_ok(d);
+
+	/* IRDA Clock, max 33 MHz */
+	d = sh_mobile_div(p, 8, "irda_clk", DIV_IRDA, GRP_IRDA, 33);
+	sh7723_div_all_ok(d);
+}
+
+void sh7723_mstp_setup(struct sh_mobile_cpg_hw_cfg *p)
+{
+	int k = 0;
+
+	/* See page 60 of Datasheet V1.0: Overview -> Block Diagram */
+	k = sh_mobile_mstp(p, k, "tlb0", DIV_I, MSTPCR0, 31, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "ic0", DIV_I, MSTPCR0, 30, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "oc0", DIV_I, MSTPCR0, 29, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "l2c0", DIV_SH, MSTPCR0, 28, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "ilmem0", DIV_I, MSTPCR0, 27, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "fpu0", DIV_I, MSTPCR0, 24, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "intc0", DIV_I, MSTPCR0, 22, 1, 1, 0);
+	k = sh_mobile_mstp(p, k, "dmac0", DIV_B, MSTPCR0, 21, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "sh0", DIV_SH, MSTPCR0, 20, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "hudi0", DIV_P, MSTPCR0, 19, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "ubc0", DIV_I, MSTPCR0, 17, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "tmu0", DIV_P, MSTPCR0, 15, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "cmt0", -1, MSTPCR0, 14, 0, 0, 0);
+	k = sh_mobile_mstp(p, k, "rwdt0", -1, MSTPCR0, 13, 0, 0, 0);
+	k = sh_mobile_mstp(p, k, "dmac1", DIV_B, MSTPCR0, 12, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "tmu1", DIV_P, MSTPCR0, 11, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "flctl0", DIV_P, MSTPCR0, 10, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif0", DIV_P, MSTPCR0, 9, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif1", DIV_P, MSTPCR0, 8, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif2", DIV_P, MSTPCR0, 7, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif3", DIV_B, MSTPCR0, 6, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif4", DIV_B, MSTPCR0, 5, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "scif5", DIV_B, MSTPCR0, 4, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "msiof0", DIV_B, MSTPCR0, 2, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "msiof1", DIV_B, MSTPCR0, 1, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "meram0", DIV_SH, MSTPCR0, 0, 1, 1, 0);
+
+	k = sh_mobile_mstp(p, k, "i2c0", DIV_P, MSTPCR1, 9, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "keysc0", -1, MSTPCR1, 8, 0, 0, 0);
+
+	k = sh_mobile_mstp(p, k, "atapi0", DIV_SH, MSTPCR2, 28, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "adc0", DIV_P, MSTPCR2, 27, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "tpu0", DIV_B, MSTPCR2, 25, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "irda0", DIV_P, MSTPCR2, 24, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "tsif0", DIV_B, MSTPCR2, 22, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "icb0", DIV_B, MSTPCR2, 21, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "sdhi0", DIV_B, MSTPCR2, 18, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "sdhi1", DIV_B, MSTPCR2, 17, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "keysc0", -1, MSTPCR2, 14, 0, 0, 0);
+	k = sh_mobile_mstp(p, k, "usb0", DIV_B, MSTPCR2, 11, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "2dg0", DIV_B, MSTPCR2, 10, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "siu0", DIV_B, MSTPCR2, 8, 0, 1, 0);
+	k = sh_mobile_mstp(p, k, "veu1", DIV_B, MSTPCR2, 6, 1, 1, 1);
+	k = sh_mobile_mstp(p, k, "vou0", DIV_B, MSTPCR2, 5, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "beu0", DIV_B, MSTPCR2, 4, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "ceu0", DIV_B, MSTPCR2, 3, 0, 1, 1);
+	k = sh_mobile_mstp(p, k, "veu0", DIV_B, MSTPCR2, 2, 1, 1, 1);
+	k = sh_mobile_mstp(p, k, "vpu0", DIV_B, MSTPCR2, 1, 1, 1, 1);
+	k = sh_mobile_mstp(p, k, "lcdc0", DIV_B, MSTPCR2, 0, 0, 1, 1);
+}
+
+static struct sh_mobile_cpg_hw_cfg sh7723_cpg_hw_config = {
+	.check_div = sh7723_div_check,
+	.set_div = sh7723_div_set,
+	.get_div = sh7723_div_get,
+	.enable_disable = sh7723_div_enable_disable,
+	.multipliers = multipliers,
+	.divisors = divisors,
+};
+
+int __init arch_clk_init(void)
+{
+	/* setup processor specific divisors & mstp bits */
+	sh7723_div_setup(&sh7723_cpg_hw_config);
+	sh7723_mstp_setup(&sh7723_cpg_hw_config);
+
+	/* detect pll setting */
+	sh7723_cpg_hw_config.pll_mult = ((__raw_readl(FRQCR) >> 24) & 0x1f) + 1;
+
+	/* register our divisors & mstp bits */
+	return sh_mobile_clk_register(&sh7723_cpg_hw_config);
+}
