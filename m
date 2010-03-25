From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Mar 2010 07:08:32 +0000
Subject: [PATCH 06/06] ARM: mach-shmobile: initial sh7372 clock framework
Message-Id: <20100325070832.24148.17407.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add initial sh7372 clock framework support to
SH-Mobile ARM. The implementation is far from
complete but is enough to dynamically deal with
module stop bits for CMT1, SDHI and KEYSC.

The peripheral clock is kept as a static dummy
clock to satisfy the code in sh-sci.c.

Clock parent selection, z_clk and support for
99% of the module stop bits are still on the TODO.

Also, move the clock framework init time to later
to deal with the fact that the new clock framework
code is using kmalloc().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    2 
 arch/arm/mach-shmobile/Makefile              |    2 
 arch/arm/mach-shmobile/board-ap4evb.c        |   16 +
 arch/arm/mach-shmobile/clock-sh7372.c        |  297 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/setup-sh7372.c        |    2 
 6 files changed, 314 insertions(+), 6 deletions(-)

--- 0007/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-03-25 13:48:11.000000000 +0900
@@ -22,7 +22,7 @@ config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select SH_CLK_CPG
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
--- 0007/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-03-25 13:48:11.000000000 +0900
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= setup-sh737
 # Clock framework
 clk-$(CONFIG_ARCH_SH7367)	+ clk-$(CONFIG_ARCH_SH7377)	+-clk-$(CONFIG_ARCH_SH7372)	++clk-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
 obj-$(CONFIG_SH_CLK_CPG)	+= $(clk-y) clock.o
 
 obj-$(CONFIG_COMMON_CLKDEV)	+= clock-sh7367.o
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-03-25 15:04:45.000000000 +0900
@@ -36,6 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 /*
  * Address	Interface		BusWidth	note
@@ -250,9 +251,8 @@ static void __init ap4evb_map_io(void)
 {
 	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
 
-	/* setup early devices, clocks and console here as well */
+	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
-	sh7367_clock_init(); /* use g3 clocks for now */
 	shmobile_setup_console();
 }
 
@@ -323,11 +323,21 @@ static void __init ap4evb_init(void)
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
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-03-25 15:12:24.000000000 +0900
@@ -0,0 +1,297 @@
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
+#include <linux/io.h>
+#include <linux/sh_clk.h>
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
+	.name           = "r_clk",
+	.id             = -1,
+	.rate           = 32768,
+};
+
+/*
+ * 26MHz default rate for the EXTAL1 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extal1_clk = {
+	.name		= "extal1",
+	.id		= -1,
+	.rate		= 26666666,
+};
+
+/*
+ * 48MHz default rate for the EXTAL2 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extal2_clk = {
+	.name		= "extal2",
+	.id		= -1,
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
+	.name		= "extal1_div2_clk",
+	.id		= -1,
+	.ops		= &div2_clk_ops,
+	.parent		= &extal1_clk,
+};
+
+/* Divide extal2 by two */
+static struct clk extal2_div2_clk = {
+	.name		= "extal2_div2_clk",
+	.id		= -1,
+	.ops		= &div2_clk_ops,
+	.parent		= &extal2_clk,
+};
+
+/* Divide extal2 by four */
+static struct clk extal2_div4_clk = {
+	.name		= "extal2_div4_clk",
+	.id		= -1,
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
+	.name		= "pllc0_clk",
+	.id		= -1,
+	.ops		= &pllc01_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+	.enable_reg	= (void __iomem *)FRQCRC,
+};
+
+static struct clk pllc1_clk = {
+	.name		= "pllc1_clk",
+	.id		= -1,
+	.ops		= &pllc01_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+	.enable_reg	= (void __iomem *)FRQCRA,
+};
+
+/* Divide PLLC1 by two */
+static struct clk pllc1_div2_clk = {
+	.name		= "pllc1_div2_clk",
+	.id		= -1,
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
+	.name		= "pllc2_clk",
+	.id		= -1,
+	.ops		= &pllc2_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extal1_div2_clk,
+};
+
+/* a static peripheral clock for now - enough to get sh-sci working */
+static struct clk peripheral_clk = {
+	.name	    = "peripheral_clk",
+	.rate	    = 48000000,
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
+	&peripheral_clk,
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
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pllc1_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("i_clk", FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG] = DIV4("zg_clk", FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("b_clk", FRQCRA, 8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1] = DIV4("m1_clk", FRQCRA, 4, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_CSIR] = DIV4("csir_clk", FRQCRA, 0, 0x6fff, 0),
+	[DIV4_ZTR] = DIV4("ztr_clk", FRQCRB, 20, 0x6fff, 0),
+	[DIV4_ZT] = DIV4("zt_clk", FRQCRB, 16, 0x6fff, 0),
+	[DIV4_ZX] = DIV4("zx_clk", FRQCRB, 12, 0x6fff, 0),
+	[DIV4_HP] = DIV4("hp_clk", FRQCRB, 4, 0x6fff, 0),
+	[DIV4_ISPB] = DIV4("ispb_clk", FRQCRC, 20, 0x6fff, 0),
+	[DIV4_S] = DIV4("s_clk", FRQCRC, 12, 0x6fff, 0),
+	[DIV4_ZB] = DIV4("zb_clk", FRQCRC, 8, 0x6fff, 0),
+	[DIV4_ZB3] = DIV4("zb3_clk", FRQCRC, 4, 0x6fff, 0),
+	[DIV4_CP] = DIV4("cp_clk", FRQCRC, 0, 0x6fff, 0),
+	[DIV4_DDRP] = DIV4("ddrp_clk", FRQCRD, 0, 0x677c, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("vck1_clk", &pllc1_div2_clk, VCLKCR1, 0),
+	SH_CLK_DIV6("vck2_clk", &pllc1_div2_clk, VCLKCR2, 0),
+	SH_CLK_DIV6("vck3_clk", &pllc1_div2_clk, VCLKCR3, 0),
+	SH_CLK_DIV6("fmsi_clk", &pllc1_div2_clk, FMSICKCR, 0),
+	SH_CLK_DIV6("fmso_clk", &pllc1_div2_clk, FMSOCKCR, 0),
+	SH_CLK_DIV6("fsia_clk", &pllc1_div2_clk, FSIACKCR, 0),
+	SH_CLK_DIV6("fsib_clk", &pllc1_div2_clk, FSIBCKCR, 0),
+	SH_CLK_DIV6("sub_clk", &pllc1_div2_clk, SUBCKCR, 0),
+	SH_CLK_DIV6("spu_clk", &pllc1_div2_clk, SPUCKCR, 0),
+	SH_CLK_DIV6("vou_clk", &pllc1_div2_clk, VOUCKCR, 0),
+	SH_CLK_DIV6("hdmi_clk", &pllc1_div2_clk, HDMICKCR, 0),
+	SH_CLK_DIV6("dsit_clk", &pllc1_div2_clk, DSITCKCR, 0),
+	SH_CLK_DIV6("dsi0p_clk", &pllc1_div2_clk, DSI0PCKCR, 0),
+	SH_CLK_DIV6("dsi1p_clk", &pllc1_div2_clk, DSI1PCKCR, 0),
+};
+
+#define MSTP(_str, _parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+
+#define R_CLK (&r_clk)
+#define HP_CLK (&div4_clks[DIV4_HP])
+
+static struct clk mstp_clks[] = {
+	MSTP("sdhi0", HP_CLK, SMSTPCR3, 14, 0),
+	MSTP("sdhi1", HP_CLK, SMSTPCR3, 13, 0),
+	MSTP("keysc0", R_CLK, SMSTPCR4, 3, 0),
+	MSTP("sdhi2", HP_CLK, SMSTPCR4, 15, 0),
+	MSTP("cmt1", R_CLK, SMSTPCR3, 29, 0),
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
+		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup sh7372 clocks\n");
+
+}
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-03-25 13:48:11.000000000 +0900
@@ -18,6 +18,7 @@ extern void sh7377_pinmux_init(void);
 extern void sh7372_init_irq(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
+extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 
 #endif /* __ARCH_MACH_COMMON_H */
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-03-25 14:37:16.000000000 +0900
@@ -141,7 +141,7 @@ static struct sh_timer_config cmt10_plat
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clk = "r_clk",
+	.clk = "cmt1",
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
