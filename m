From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 31 Mar 2010 13:59:37 +0000
Subject: [PATCH] ARM: mach-shmobile: initial sh7367 clock framework
Message-Id: <20100331135937.3082.22328.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100331135618.3072.17807.sendpatchset@t400s>
In-Reply-To: <20100331135618.3072.17807.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add initial sh7367 clock framework support to
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

As this is the last processor that depends on
the clkdev code, also remove the clkdev.h header.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of the earlier clock framework patches.

 arch/arm/mach-shmobile/Kconfig               |    2 
 arch/arm/mach-shmobile/Makefile              |    4 
 arch/arm/mach-shmobile/board-g3evm.c         |   19 +
 arch/arm/mach-shmobile/clock-sh7367.c        |  274 ++++++++++++++++++++------
 arch/arm/mach-shmobile/include/mach/clkdev.h |    7 
 5 files changed, 235 insertions(+), 71 deletions(-)

--- 0009/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-03-31 22:09:25.000000000 +0900
@@ -6,7 +6,7 @@ config ARCH_SH7367
 	bool "SH-Mobile G3 (SH7367)"
 	select CPU_V6
 	select HAVE_CLK
-	select COMMON_CLKDEV
+	select SH_CLK_CPG
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 
--- 0009/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-03-31 22:09:46.000000000 +0900
@@ -11,13 +11,11 @@ obj-$(CONFIG_ARCH_SH7377)	+= setup-sh737
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
 
 # Clock framework
-clk-$(CONFIG_ARCH_SH7367)	++clk-$(CONFIG_ARCH_SH7367)	+= clock-sh7367.o
 clk-$(CONFIG_ARCH_SH7377)	+= clock-sh7377.o
 clk-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
 obj-$(CONFIG_SH_CLK_CPG)	+= $(clk-y) clock.o
 
-obj-$(CONFIG_COMMON_CLKDEV)	+= clock-sh7367.o
-
 # Pinmux setup
 pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
 pfc-$(CONFIG_ARCH_SH7377)	:= pfc-sh7377.o
--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-03-31 22:42:39.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -232,9 +233,8 @@ static void __init g3evm_map_io(void)
 {
 	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
 
-	/* setup early devices, clocks and console here as well */
+	/* setup early devices and console here as well */
 	sh7367_add_early_devices();
-	sh7367_clock_init();
 	shmobile_setup_console();
 }
 
@@ -271,9 +271,6 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_EXTLP, NULL);
 	gpio_request(GPIO_FN_IDIN, NULL);
 
-	/* enable clock in SYMSTPCR2 */
-	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 22), 0xe6158048);
-
 	/* setup USB phy */
 	__raw_writew(0x0300, 0xe605810a);	/* USBCR1 */
 	__raw_writew(0x00e0, 0xe60581c0);	/* CPFCH */
@@ -323,11 +320,21 @@ static void __init g3evm_init(void)
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
 }
 
+static void __init g3evm_timer_init(void)
+{
+	sh7367_clock_init();
+	shmobile_timer.init();
+}
+
+static struct sys_timer g3evm_timer = {
+	.init		= g3evm_timer_init,
+};
+
 MACHINE_START(G3EVM, "g3evm")
 	.phys_io	= 0xe6000000,
 	.io_pg_offst	= ((0xe6000000) >> 18) & 0xfffc,
 	.map_io		= g3evm_map_io,
 	.init_irq	= sh7367_init_irq,
 	.init_machine	= g3evm_init,
-	.timer		= &shmobile_timer,
+	.timer		= &g3evm_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-03-31 22:48:40.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- * Preliminary clock framework support for sh7367
+ * SH7367 clock framework support
  *
  * Copyright (C) 2010  Magnus Damm
  *
@@ -17,46 +17,140 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/sh_clk.h>
 
-struct clk {
-	const char *name;
-	unsigned long rate;
+/* SH7367 registers */
+#define RTFRQCR    0xe6150000
+#define SYFRQCR    0xe6150004
+#define CMFRQCR    0xe61500E0
+#define VCLKCR1    0xe6150008
+#define VCLKCR2    0xe615000C
+#define VCLKCR3    0xe615001C
+#define SCLKACR    0xe6150010
+#define SCLKBCR    0xe6150014
+#define SUBUSBCKCR 0xe6158080
+#define SPUCKCR    0xe6150084
+#define MSUCKCR    0xe6150088
+#define MVI3CKCR   0xe6150090
+#define VOUCKCR    0xe6150094
+#define MFCK1CR    0xe6150098
+#define MFCK2CR    0xe615009C
+#define PLLC1CR    0xe6150028
+#define PLLC2CR    0xe615002C
+#define RTMSTPCR0  0xe6158030
+#define RTMSTPCR2  0xe6158038
+#define SYMSTPCR0  0xe6158040
+#define SYMSTPCR2  0xe6158048
+#define CMMSTPCR0  0xe615804c
+
+/* Fixed 32 KHz root clock from EXTALR pin */
+static struct clk r_clk = {
+	.name           = "r_clk",
+	.id             = -1,
+	.rate           = 32768,
 };
 
-#include <asm/clkdev.h>
+/*
+ * 26MHz default rate for the EXTALB1 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extalb1_clk = {
+	.name		= "extalb1",
+	.id		= -1,
+	.rate		= 26666666,
+};
 
-int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-EXPORT_SYMBOL(__clk_get);
+/*
+ * 48MHz default rate for the EXTAL2 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk extal2_clk = {
+	.name		= "extal2",
+	.id		= -1,
+	.rate		= 48000000,
+};
 
-void __clk_put(struct clk *clk)
+/* A fixed divide-by-2 block */
+static unsigned long div2_recalc(struct clk *clk)
 {
+	return clk->parent->rate / 2;
 }
-EXPORT_SYMBOL(__clk_put);
 
+static struct clk_ops div2_clk_ops = {
+	.recalc		= div2_recalc,
+};
 
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
+/* Divide extalb1 by two */
+static struct clk extalb1_div2_clk = {
+	.name		= "extalb1_div2_clk",
+	.id		= -1,
+	.ops		= &div2_clk_ops,
+	.parent		= &extalb1_clk,
+};
+
+/* Divide extal2 by two */
+static struct clk extal2_div2_clk = {
+	.name		= "extal2_div2_clk",
+	.id		= -1,
+	.ops		= &div2_clk_ops,
+	.parent		= &extal2_clk,
+};
 
-void clk_disable(struct clk *clk)
+/* PLLC1 */
+static unsigned long pllc1_recalc(struct clk *clk)
 {
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLC1CR) & (1 << 14))
+		mult = (((__raw_readl(RTFRQCR) >> 24) & 0x3f) + 1) * 2;
+
+	return clk->parent->rate * mult;
 }
-EXPORT_SYMBOL(clk_disable);
 
-unsigned long clk_get_rate(struct clk *clk)
+static struct clk_ops pllc1_clk_ops = {
+	.recalc		= pllc1_recalc,
+};
+
+static struct clk pllc1_clk = {
+	.name		= "pllc1_clk",
+	.id		= -1,
+	.ops		= &pllc1_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extalb1_div2_clk,
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
 {
-	return clk ? clk->rate : 0;
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLC2CR) & (1 << 31))
+		mult = (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
+
+	return clk->parent->rate * mult;
 }
-EXPORT_SYMBOL(clk_get_rate);
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
+	.parent		= &extalb1_div2_clk,
+};
 
 /* a static peripheral clock for now - enough to get sh-sci working */
 static struct clk peripheral_clk = {
@@ -64,40 +158,112 @@ static struct clk peripheral_clk = {
 	.rate	    = 48000000,
 };
 
-/* a static rclk for now - enough to get sh_cmt working */
-static struct clk r_clk = {
-	.name	    = "r_clk",
-	.rate	    = 32768,
+struct clk *main_clks[] = {
+	&r_clk,
+	&extalb1_clk,
+	&extal2_clk,
+	&extalb1_div2_clk,
+	&extal2_div2_clk,
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
+			  24, 32, 36, 48, 0, 72, 0, 0 };
+
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
 };
 
-/* a static usb0 for now - enough to get r8a66597 working */
-static struct clk usb0_clk = {
-	.name	    = "usb0",
-};
-
-/* a static keysc0 clk for now - enough to get sh_keysc working */
-static struct clk keysc0_clk = {
-	.name	    = "keysc0",
-};
-
-static struct clk_lookup lookups[] = {
-	{
-		.clk = &peripheral_clk,
-	}, {
-		.clk = &r_clk,
-	}, {
-		.clk = &usb0_clk,
-	}, {
-		.clk = &keysc0_clk,
-	}
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+	.kick = div4_kick,
+};
+
+enum { DIV4_I, DIV4_G, DIV4_S, DIV4_B,
+       DIV4_ZX, DIV4_ZT, DIV4_Z, DIV4_ZD, DIV4_HP,
+       DIV4_ZS, DIV4_ZB, DIV4_ZB3, DIV4_CP, DIV4_NR };
+
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pllc1_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("i_clk", RTFRQCR, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_G] = DIV4("g_clk", RTFRQCR, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_S] = DIV4("s_clk", RTFRQCR, 12, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("b_clk", RTFRQCR, 8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZX] = DIV4("zx_clk", SYFRQCR, 20, 0x6fff, 0),
+	[DIV4_ZT] = DIV4("zt_clk", SYFRQCR, 16, 0x6fff, 0),
+	[DIV4_Z] = DIV4("z_clk", SYFRQCR, 12, 0x6fff, 0),
+	[DIV4_ZD] = DIV4("zd_clk", SYFRQCR, 8, 0x6fff, 0),
+	[DIV4_HP] = DIV4("hp_clk", SYFRQCR, 4, 0x6fff, 0),
+	[DIV4_ZS] = DIV4("zs_clk", CMFRQCR, 12, 0x6fff, 0),
+	[DIV4_ZB] = DIV4("zb_clk", CMFRQCR, 8, 0x6fff, 0),
+	[DIV4_ZB3] = DIV4("zb3_clk", CMFRQCR, 4, 0x6fff, 0),
+	[DIV4_CP] = DIV4("cp_clk", CMFRQCR, 0, 0x6fff, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("subusb_clk", &pllc1_div2_clk, SUBUSBCKCR, 0),
+	SH_CLK_DIV6("siua_clk", &pllc1_div2_clk, SCLKACR, 0),
+	SH_CLK_DIV6("siub_clk", &pllc1_div2_clk, SCLKBCR, 0),
+	SH_CLK_DIV6("msu_clk", &pllc1_div2_clk, MSUCKCR, 0),
+	SH_CLK_DIV6("spu_clk", &pllc1_div2_clk, SPUCKCR, 0),
+	SH_CLK_DIV6("mvi3_clk", &pllc1_div2_clk, MVI3CKCR, 0),
+	SH_CLK_DIV6("mf1_clk", &pllc1_div2_clk, MFCK1CR, 0),
+	SH_CLK_DIV6("mf2_clk", &pllc1_div2_clk, MFCK2CR, 0),
+	SH_CLK_DIV6("vck1_clk", &pllc1_div2_clk, VCLKCR1, 0),
+	SH_CLK_DIV6("vck2_clk", &pllc1_div2_clk, VCLKCR2, 0),
+	SH_CLK_DIV6("vck3_clk", &pllc1_div2_clk, VCLKCR3, 0),
+	SH_CLK_DIV6("vou_clk", &pllc1_div2_clk, VOUCKCR, 0),
+};
+
+#define MSTP(_str, _parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+
+#define R_CLK (&r_clk)
+#define HP_CLK (&div4_clks[DIV4_HP])
+
+static struct clk mstp_clks[] = {
+	MSTP("sdhi0", HP_CLK, SYMSTPCR2, 14, 0),
+	MSTP("sdhi1", HP_CLK, SYMSTPCR2, 13, 0),
+	MSTP("sdhi2", HP_CLK, SYMSTPCR2, 11, 0),
+	MSTP("usb0", HP_CLK, SYMSTPCR2, 22, 0),
+	MSTP("cmt1", R_CLK, SYMSTPCR2, 29, 0),
+	MSTP("keysc0", R_CLK, CMMSTPCR0, 3, 0),
 };
 
 void __init sh7367_clock_init(void)
 {
-	int i;
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
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
-		lookups[i].con_id = lookups[i].clk->name;
-		clkdev_add(&lookups[i]);
-	}
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup sh7367 clocks\n");
 }
--- 0001/arch/arm/mach-shmobile/include/mach/clkdev.h
+++ /dev/null	2010-03-08 09:31:50.566014982 +0900
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-int __clk_get(struct clk *clk);
-void __clk_put(struct clk *clk);
-
-#endif /* __ASM_MACH_CLKDEV_H */
