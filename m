From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Mar 2010 13:56:18 +0000
Subject: [PATCH] ARM: mach-shmobile: initial sh7377 clock framework
Message-Id: <20100331135618.3072.17807.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add initial sh7377 clock framework support to
SH-Mobile ARM. The implementation is far from
complete but is enough to dynamically deal with
module stop bits for CMT1, SDHI and KEYSC.

The peripheral clock is kept as a static dummy
clock to satisfy the code in sh-sci.c.

Clock parent selection and support for the rest
of the module stop bits are still on the TODO.

Also, move the clock framework init time to later
to deal with the fact that the new clock framework
code is using kmalloc().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of the earlier clock framework patches.

 arch/arm/mach-shmobile/Kconfig               |    2 
 arch/arm/mach-shmobile/Makefile              |    2 
 arch/arm/mach-shmobile/board-g4evm.c         |   19 +
 arch/arm/mach-shmobile/clock-sh7377.c        |  283 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 5 files changed, 299 insertions(+), 8 deletions(-)

--- 0008/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-03-31 21:56:22.000000000 +0900
@@ -14,7 +14,7 @@ config ARCH_SH7377
 	bool "SH-Mobile G4 (SH7377)"
 	select CPU_V7
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select SH_CLK_CPG
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
--- 0008/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-03-31 21:56:22.000000000 +0900
@@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= setup-sh737
 
 # Clock framework
 clk-$(CONFIG_ARCH_SH7367)	+-clk-$(CONFIG_ARCH_SH7377)	++clk-$(CONFIG_ARCH_SH7377)	+= clock-sh7377.o
 clk-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
 obj-$(CONFIG_SH_CLK_CPG)	+= $(clk-y) clock.o
 
--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2010-03-31 21:56:22.000000000 +0900
@@ -36,6 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -191,9 +192,8 @@ static void __init g4evm_map_io(void)
 {
 	iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
 
-	/* setup early devices, clocks and console here as well */
+	/* setup early devices and console here as well */
 	sh7377_add_early_devices();
-	sh7367_clock_init(); /* use g3 clocks for now */
 	shmobile_setup_console();
 }
 
@@ -229,9 +229,6 @@ static void __init g4evm_init(void)
 	gpio_request(GPIO_FN_EXTLP, NULL);
 	gpio_request(GPIO_FN_IDIN, NULL);
 
-	/* enable clock in SMSTPCR3 */
-	__raw_writel(__raw_readl(0xe615013c) & ~(1 << 22), 0xe615013c);
-
 	/* setup USB phy */
 	__raw_writew(0x0200, 0xe605810a);       /* USBCR1 */
 	__raw_writew(0x00e0, 0xe60581c0);       /* CPFCH */
@@ -258,11 +255,21 @@ static void __init g4evm_init(void)
 	platform_add_devices(g4evm_devices, ARRAY_SIZE(g4evm_devices));
 }
 
+static void __init g4evm_timer_init(void)
+{
+	sh7377_clock_init();
+	shmobile_timer.init();
+}
+
+static struct sys_timer g4evm_timer = {
+	.init		= g4evm_timer_init,
+};
+
 MACHINE_START(G4EVM, "g4evm")
 	.phys_io	= 0xe6000000,
 	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= g4evm_map_io,
 	.init_irq	= sh7377_init_irq,
 	.init_machine	= g4evm_init,
-	.timer		= &shmobile_timer,
+	.timer		= &g4evm_timer,
 MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock-sh7377.c	2010-03-31 22:51:01.000000000 +0900
@@ -0,0 +1,283 @@
+/*
+ * SH7377 clock framework support
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
+/* SH7377 registers */
+#define RTFRQCR    0xe6150000
+#define SYFRQCR    0xe6150004
+#define CMFRQCR    0xe61500E0
+#define VCLKCR1    0xe6150008
+#define VCLKCR2    0xe615000C
+#define VCLKCR3    0xe615001C
+#define FMSICKCR   0xe6150010
+#define FMSOCKCR   0xe6150014
+#define FSICKCR    0xe6150018
+#define PLLC1CR    0xe6150028
+#define PLLC2CR    0xe615002C
+#define SUBUSBCKCR 0xe6150080
+#define SPUCKCR    0xe6150084
+#define MSUCKCR    0xe6150088
+#define MVI3CKCR   0xe6150090
+#define HDMICKCR   0xe6150094
+#define MFCK1CR    0xe6150098
+#define MFCK2CR    0xe615009C
+#define DSITCKCR   0xe6150060
+#define DSIPCKCR   0xe6150064
+#define SMSTPCR0   0xe6150130
+#define SMSTPCR1   0xe6150134
+#define SMSTPCR2   0xe6150138
+#define SMSTPCR3   0xe615013C
+#define SMSTPCR4   0xe6150140
+
+/* Fixed 32 KHz root clock from EXTALR pin */
+static struct clk r_clk = {
+	.name           = "r_clk",
+	.id             = -1,
+	.rate           = 32768,
+};
+
+/*
+ * 26MHz default rate for the EXTALC1 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extalc1_clk = {
+	.name		= "extalc1",
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
+/* Divide extalc1 by two */
+static struct clk extalc1_div2_clk = {
+	.name		= "extalc1_div2_clk",
+	.id		= -1,
+	.ops		= &div2_clk_ops,
+	.parent		= &extalc1_clk,
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
+/* PLLC1 */
+static unsigned long pllc1_recalc(struct clk *clk)
+{
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLC1CR) & (1 << 14))
+		mult = (((__raw_readl(RTFRQCR) >> 24) & 0x3f) + 1) * 2;
+
+	return clk->parent->rate * mult;
+}
+
+static struct clk_ops pllc1_clk_ops = {
+	.recalc		= pllc1_recalc,
+};
+
+static struct clk pllc1_clk = {
+	.name		= "pllc1_clk",
+	.id		= -1,
+	.ops		= &pllc1_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extalc1_div2_clk,
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
+	.parent		= &extalc1_div2_clk,
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
+	&extalc1_clk,
+	&extal2_clk,
+	&extalc1_div2_clk,
+	&extal2_div2_clk,
+	&extal2_div4_clk,
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
+	/* set KICK bit in SYFRQCR to update hardware setting */
+	value = __raw_readl(SYFRQCR);
+	value |= (1 << 31);
+	__raw_writel(value, SYFRQCR);
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
+       DIV4_ZTR, DIV4_ZT, DIV4_Z, DIV4_HP,
+       DIV4_ZS, DIV4_ZB, DIV4_ZB3, DIV4_CP, DIV4_NR };
+
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pllc1_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("i_clk", RTFRQCR, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG] = DIV4("zg_clk", RTFRQCR, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("b_clk", RTFRQCR, 8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1] = DIV4("m1_clk", RTFRQCR, 4, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_CSIR] = DIV4("csir_clk", RTFRQCR, 0, 0x6fff, 0),
+	[DIV4_ZTR] = DIV4("ztr_clk", SYFRQCR, 20, 0x6fff, 0),
+	[DIV4_ZT] = DIV4("zt_clk", SYFRQCR, 16, 0x6fff, 0),
+	[DIV4_Z] = DIV4("z_clk", SYFRQCR, 12, 0x6fff, 0),
+	[DIV4_HP] = DIV4("hp_clk", SYFRQCR, 4, 0x6fff, 0),
+	[DIV4_ZS] = DIV4("zs_clk", CMFRQCR, 12, 0x6fff, 0),
+	[DIV4_ZB] = DIV4("zb_clk", CMFRQCR, 8, 0x6fff, 0),
+	[DIV4_ZB3] = DIV4("zb3_clk", CMFRQCR, 4, 0x6fff, 0),
+	[DIV4_CP] = DIV4("cp_clk", CMFRQCR, 0, 0x6fff, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("sub_clk", &pllc1_div2_clk, SUBUSBCKCR, 0),
+	SH_CLK_DIV6("msu_clk", &pllc1_div2_clk, MSUCKCR, 0),
+	SH_CLK_DIV6("spu_clk", &pllc1_div2_clk, SPUCKCR, 0),
+	SH_CLK_DIV6("fsi_clk", &pllc1_div2_clk, FSICKCR, 0),
+	SH_CLK_DIV6("fmsi_clk", &pllc1_div2_clk, FMSICKCR, 0),
+	SH_CLK_DIV6("fmso_clk", &pllc1_div2_clk, FMSOCKCR, 0),
+	SH_CLK_DIV6("mvi3_clk", &pllc1_div2_clk, MVI3CKCR, 0),
+	SH_CLK_DIV6("mf1_clk", &pllc1_div2_clk, MFCK1CR, 0),
+	SH_CLK_DIV6("mf2_clk", &pllc1_div2_clk, MFCK2CR, 0),
+	SH_CLK_DIV6("dsit_clk", &pllc1_div2_clk, DSITCKCR, 0),
+	SH_CLK_DIV6("dsip_clk", &pllc1_div2_clk, DSIPCKCR, 0),
+	SH_CLK_DIV6("hdmi_clk", &pllc1_div2_clk, HDMICKCR, 0),
+	SH_CLK_DIV6("vck1_clk", &pllc1_div2_clk, VCLKCR1, 0),
+	SH_CLK_DIV6("vck2_clk", &pllc1_div2_clk, VCLKCR2, 0),
+	SH_CLK_DIV6("vck3_clk", &pllc1_div2_clk, VCLKCR3, 0),
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
+	MSTP("usb0", HP_CLK, SMSTPCR3, 22, 0),
+	MSTP("cmt1", R_CLK, SMSTPCR3, 29, 0),
+	MSTP("keysc0", R_CLK, SMSTPCR4, 3, 0),
+};
+
+void __init sh7377_clock_init(void)
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
+		panic("failed to setup sh7377 clocks\n");
+}
--- 0008/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-03-31 21:56:22.000000000 +0900
@@ -13,6 +13,7 @@ extern void sh7367_pinmux_init(void);
 extern void sh7377_init_irq(void);
 extern void sh7377_add_early_devices(void);
 extern void sh7377_add_standard_devices(void);
+extern void sh7377_clock_init(void);
 extern void sh7377_pinmux_init(void);
 
 extern void sh7372_init_irq(void);
