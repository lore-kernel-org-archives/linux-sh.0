From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 14:21:34 +0000
Subject: [PATCH 02/02] ARM: mach-shmobile: sh7372 clock framework support V2
Message-Id: <20100512142134.28459.80358.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch is V2 of clock framework tables/code for sh7372.
MSTP are included for KEYSC, SCIF, IIC, USB, SDHI and UIO.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    1 
 arch/arm/mach-shmobile/Makefile              |    2 
 arch/arm/mach-shmobile/board-ap4evb.c        |   16 -
 arch/arm/mach-shmobile/clock-sh7372.c        |  387 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/setup-sh7372.c        |    8 
 6 files changed, 404 insertions(+), 11 deletions(-)

--- 0012/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-05-12 22:41:28.000000000 +0900
@@ -23,6 +23,7 @@ config ARCH_SH7372
 	select CPU_V7
 	select HAVE_CLK
 	select COMMON_CLKDEV
+	select SH_CLK_CPG
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
--- 0012/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-05-12 22:41:28.000000000 +0900
@@ -8,7 +8,7 @@ obj-y				:= timer.o console.o memory.o c
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
 obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7367.o intc-sh7377.o
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7367.o intc-sh7372.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 
 # Pinmux setup
 pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-05-12 22:41:28.000000000 +0900
@@ -39,6 +39,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 /*
  * Address	Interface		BusWidth	note
@@ -328,9 +329,8 @@ static void __init ap4evb_map_io(void)
 {
 	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
 
-	/* setup early devices, clocks and console here as well */
+	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
-	sh7367_clock_init(); /* use g3 clocks for now */
 	shmobile_setup_console();
 }
 
@@ -419,11 +419,21 @@ static void __init ap4evb_init(void)
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 }
 
+static void __init ap4evb_timer_init(void)
+{
+	sh7372_clock_init();
+	shmobile_timer.init();
+}
+
+static struct sys_timer ap4evb_timer = {
+	.init		= ap4evb_timer_init,
+};
+
 MACHINE_START(AP4EVB, "ap4evb")
 	.phys_io	= 0xe6000000,
 	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= ap4evb_map_io,
 	.init_irq	= sh7372_init_irq,
 	.init_machine	= ap4evb_init,
-	.timer		= &shmobile_timer,
+	.timer		= &ap4evb_timer,
 MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-05-12 23:01:52.000000000 +0900
@@ -0,0 +1,387 @@
+/*
+ * SH7372 clock framework support
+ *
+ * Copyright (C) 2010 Magnus Damm
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
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/sh_clk.h>
+#include <mach/common.h>
+#include <asm/clkdev.h>
+
+/* SH7372 registers */
+#define FRQCRA		0xe6150000
+#define FRQCRB		0xe6150004
+#define FRQCRC		0xe61500e0
+#define FRQCRD		0xe61500e4
+#define VCLKCR1		0xe6150008
+#define VCLKCR2		0xe615000c
+#define VCLKCR3		0xe615001c
+#define FMSICKCR	0xe6150010
+#define FMSOCKCR	0xe6150014
+#define FSIACKCR	0xe6150018
+#define FSIBCKCR	0xe6150090
+#define SUBCKCR		0xe6150080
+#define SPUCKCR		0xe6150084
+#define VOUCKCR		0xe6150088
+#define HDMICKCR	0xe6150094
+#define DSITCKCR	0xe6150060
+#define DSI0PCKCR	0xe6150064
+#define DSI1PCKCR	0xe6150098
+#define PLLC01CR	0xe6150028
+#define PLLC2CR		0xe615002c
+#define SMSTPCR0	0xe6150130
+#define SMSTPCR1	0xe6150134
+#define SMSTPCR2	0xe6150138
+#define SMSTPCR3	0xe615013c
+#define SMSTPCR4	0xe6150140
+
+/* Fixed 32 KHz root clock from EXTALR pin */
+static struct clk r_clk = {
+	.rate           = 32768,
+};
+
+/*
+ * 26MHz default rate for the EXTAL1 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extal1_clk = {
+	.rate		= 26666666,
+};
+
+/*
+ * 48MHz default rate for the EXTAL2 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extal2_clk = {
+	.rate		= 48000000,
+};
+
+/* A fixed divide-by-2 block */
+static unsigned long div2_recalc(struct clk *clk)
+{
+	return clk->parent->rate / 2;
+}
+
+static struct clk_ops div2_clk_ops = {
+	.recalc		= div2_recalc,
+};
+
+/* Divide extal1 by two */
+static struct clk extal1_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &extal1_clk,
+};
+
+/* Divide extal2 by two */
+static struct clk extal2_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &extal2_clk,
+};
+
+/* Divide extal2 by four */
+static struct clk extal2_div4_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &extal2_div2_clk,
+};
+
+/* PLLC0 and PLLC1 */
+static unsigned long pllc01_recalc(struct clk *clk)
+{
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLC01CR) & (1 << 14))
+		mult = (((__raw_readl(clk->enable_reg) >> 24) & 0x3f) + 1) * 2;
+
+	return clk->parent->rate * mult;
+}
+
+static struct clk_ops pllc01_clk_ops = {
+	.recalc		= pllc01_recalc,
+};
+
+static struct clk pllc0_clk = {
+	.ops		= &pllc01_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+	.enable_reg	= (void __iomem *)FRQCRC,
+};
+
+static struct clk pllc1_clk = {
+	.ops		= &pllc01_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+	.enable_reg	= (void __iomem *)FRQCRA,
+};
+
+/* Divide PLLC1 by two */
+static struct clk pllc1_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &pllc1_clk,
+};
+
+/* PLLC2 */
+static unsigned long pllc2_recalc(struct clk *clk)
+{
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLC2CR) & (1 << 31))
+		mult = (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
+
+	return clk->parent->rate * mult;
+}
+
+static struct clk_ops pllc2_clk_ops = {
+	.recalc		= pllc2_recalc,
+};
+
+static struct clk pllc2_clk = {
+	.ops		= &pllc2_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+};
+
+struct clk *main_clks[] = {
+	&r_clk,
+	&extal1_clk,
+	&extal2_clk,
+	&extal1_div2_clk,
+	&extal2_div2_clk,
+	&extal2_div4_clk,
+	&pllc0_clk,
+	&pllc1_clk,
+	&pllc1_div2_clk,
+	&pllc2_clk,
+};
+
+static void div4_kick(struct clk *clk)
+{
+	unsigned long value;
+
+	/* set KICK bit in FRQCRB to update hardware setting */
+	value = __raw_readl(FRQCRB);
+	value |= (1 << 31);
+	__raw_writel(value, FRQCRB);
+}
+
+static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18,
+			  24, 32, 36, 48, 0, 72, 96, 0 };
+
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+};
+
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+	.kick = div4_kick,
+};
+
+enum { DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_CSIR,
+       DIV4_ZTR, DIV4_ZT, DIV4_ZX, DIV4_HP,
+       DIV4_ISPB, DIV4_S, DIV4_ZB, DIV4_ZB3, DIV4_CP,
+       DIV4_DDRP, DIV4_NR };
+
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pllc1_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4(FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG] = DIV4(FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCRA, 8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1] = DIV4(FRQCRA, 4, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_CSIR] = DIV4(FRQCRA, 0, 0x6fff, 0),
+	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0x6fff, 0),
+	[DIV4_ZT] = DIV4(FRQCRB, 16, 0x6fff, 0),
+	[DIV4_ZX] = DIV4(FRQCRB, 12, 0x6fff, 0),
+	[DIV4_HP] = DIV4(FRQCRB, 4, 0x6fff, 0),
+	[DIV4_ISPB] = DIV4(FRQCRC, 20, 0x6fff, 0),
+	[DIV4_S] = DIV4(FRQCRC, 12, 0x6fff, 0),
+	[DIV4_ZB] = DIV4(FRQCRC, 8, 0x6fff, 0),
+	[DIV4_ZB3] = DIV4(FRQCRC, 4, 0x6fff, 0),
+	[DIV4_CP] = DIV4(FRQCRC, 0, 0x6fff, 0),
+	[DIV4_DDRP] = DIV4(FRQCRD, 0, 0x677c, 0),
+};
+
+enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_FMSI, DIV6_FMSO,
+       DIV6_FSIA, DIV6_FSIB, DIV6_SUB, DIV6_SPU,
+       DIV6_VOU, DIV6_HDMI, DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
+       DIV6_NR };
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_VCK1] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR1, 0),
+	[DIV6_VCK2] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR2, 0),
+	[DIV6_VCK3] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR3, 0),
+	[DIV6_FMSI] = SH_CLK_DIV6(&pllc1_div2_clk, FMSICKCR, 0),
+	[DIV6_FMSO] = SH_CLK_DIV6(&pllc1_div2_clk, FMSOCKCR, 0),
+	[DIV6_FSIA] = SH_CLK_DIV6(&pllc1_div2_clk, FSIACKCR, 0),
+	[DIV6_FSIB] = SH_CLK_DIV6(&pllc1_div2_clk, FSIBCKCR, 0),
+	[DIV6_SUB] = SH_CLK_DIV6(&extal2_clk, SUBCKCR, 0),
+	[DIV6_SPU] = SH_CLK_DIV6(&pllc1_div2_clk, SPUCKCR, 0),
+	[DIV6_VOU] = SH_CLK_DIV6(&pllc1_div2_clk, VOUCKCR, 0),
+	[DIV6_HDMI] = SH_CLK_DIV6(&pllc1_div2_clk, HDMICKCR, 0),
+	[DIV6_DSIT] = SH_CLK_DIV6(&pllc1_div2_clk, DSITCKCR, 0),
+	[DIV6_DSI0P] = SH_CLK_DIV6(&pllc1_div2_clk, DSI0PCKCR, 0),
+	[DIV6_DSI1P] = SH_CLK_DIV6(&pllc1_div2_clk, DSI1PCKCR, 0),
+};
+
+enum { MSTP001,
+       MSTP131, MSTP130, MSTP129, MSTP128, MSTP116, MSTP106, MSTP101,
+       MSTP223,
+       MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+       MSTP329, MSTP323, MSTP322, MSTP314, MSTP313,
+       MSTP415, MSTP410, MSTP411, MSTP406, MSTP403,
+       MSTP_NR };
+
+#define MSTP(_parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP001] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR0, 1, 0), /* IIC2 */
+	[MSTP131] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 31, 0), /* VEU3 */
+	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
+	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
+	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
+	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, 0), /* JPU */
+	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
+	[MSTP223] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR2, 23, 0), /* SPU2 */
+	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
+	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
+	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
+	[MSTP203] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 3, 0), /* SCIFA1 */
+	[MSTP202] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
+	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
+	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
+	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
+	[MSTP313] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 13, 0), /* SDHI1 */
+	[MSTP415] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 15, 0), /* SDHI2 */
+	[MSTP411] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0), /* IIC3 */
+	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
+	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
+	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
+};
+
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("r_clk", &r_clk),
+	CLKDEV_CON_ID("extal1", &extal1_clk),
+	CLKDEV_CON_ID("extal2", &extal2_clk),
+	CLKDEV_CON_ID("extal1_div2_clk", &extal1_div2_clk),
+	CLKDEV_CON_ID("extal2_div2_clk", &extal2_div2_clk),
+	CLKDEV_CON_ID("extal2_div4_clk", &extal2_div4_clk),
+	CLKDEV_CON_ID("pllc0_clk", &pllc0_clk),
+	CLKDEV_CON_ID("pllc1_clk", &pllc1_clk),
+	CLKDEV_CON_ID("pllc1_div2_clk", &pllc1_div2_clk),
+	CLKDEV_CON_ID("pllc2_clk", &pllc2_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("i_clk", &div4_clks[DIV4_I]),
+	CLKDEV_CON_ID("zg_clk", &div4_clks[DIV4_ZG]),
+	CLKDEV_CON_ID("b_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("m1_clk", &div4_clks[DIV4_M1]),
+	CLKDEV_CON_ID("csir_clk", &div4_clks[DIV4_CSIR]),
+	CLKDEV_CON_ID("ztr_clk", &div4_clks[DIV4_ZTR]),
+	CLKDEV_CON_ID("zt_clk", &div4_clks[DIV4_ZT]),
+	CLKDEV_CON_ID("zx_clk", &div4_clks[DIV4_ZX]),
+	CLKDEV_CON_ID("hp_clk", &div4_clks[DIV4_HP]),
+	CLKDEV_CON_ID("ispb_clk", &div4_clks[DIV4_ISPB]),
+	CLKDEV_CON_ID("s_clk", &div4_clks[DIV4_S]),
+	CLKDEV_CON_ID("zb_clk", &div4_clks[DIV4_ZB]),
+	CLKDEV_CON_ID("zb3_clk", &div4_clks[DIV4_ZB3]),
+	CLKDEV_CON_ID("cp_clk", &div4_clks[DIV4_CP]),
+	CLKDEV_CON_ID("ddrp_clk", &div4_clks[DIV4_DDRP]),
+
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
+	CLKDEV_CON_ID("vck2_clk", &div6_clks[DIV6_VCK2]),
+	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
+	CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
+	CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
+	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FSIA]),
+	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FSIB]),
+	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
+	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
+	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
+	CLKDEV_CON_ID("hdmi_clk", &div6_clks[DIV6_HDMI]),
+	CLKDEV_CON_ID("dsit_clk", &div6_clks[DIV6_DSIT]),
+	CLKDEV_CON_ID("dsi0p_clk", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_CON_ID("dsi1p_clk", &div6_clks[DIV6_DSI1P]),
+
+	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP131]), /* VEU3 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP130]), /* VEU2 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP129]), /* VEU1 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP128]), /* VEU0 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP101]), /* VPU */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.6", &mstp_clks[MSTP223]), /* SPU2DSP0 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.7", &mstp_clks[MSTP223]), /* SPU2DSP1 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
+	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
+	CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
+	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
+	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP415]), /* SDHI2 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
+	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
+	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
+};
+
+void __init sh7372_clock_init(void)
+{
+	int k, ret = 0;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
+
+	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup sh7372 clocks\n");
+
+}
--- 0012/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-05-12 22:41:28.000000000 +0900
@@ -24,6 +24,7 @@ extern void sh7377_pinmux_init(void);
 extern void sh7372_init_irq(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
+extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 
 #endif /* __ARCH_MACH_COMMON_H */
--- 0007/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-05-12 22:41:28.000000000 +0900
@@ -145,7 +145,7 @@ static struct sh_timer_config cmt10_plat
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clk = "r_clk",
+	.clk = "cmt1",
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
@@ -490,14 +490,8 @@ void __init sh7372_add_standard_devices(
 			    ARRAY_SIZE(sh7372_devices));
 }
 
-#define SMSTPCR3 0xe615013c
-#define SMSTPCR3_CMT1 (1 << 29)
-
 void __init sh7372_add_early_devices(void)
 {
-	/* enable clock to CMT1 */
-	__raw_writel(__raw_readl(SMSTPCR3) & ~SMSTPCR3_CMT1, SMSTPCR3);
-
 	early_platform_add_devices(sh7372_early_devices,
 				   ARRAY_SIZE(sh7372_early_devices));
 }
