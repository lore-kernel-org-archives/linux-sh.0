From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 May 2010 14:49:28 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367 clock framework V2
Message-Id: <20100520144928.27662.44645.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch is V2 of clock framework tables/code for sh7367.
MSTP support is included for the following hardware blocks:
KEYSC, SCIF, IIC, IRDA, FLCTL, VOU, SIU, USB, SDHI and UIO.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    1 
 arch/arm/mach-shmobile/board-g3evm.c         |   19 -
 arch/arm/mach-shmobile/clock-sh7367.c        |  353 +++++++++++++++++++++++---
 arch/arm/mach-shmobile/include/mach/common.h |    2 
 4 files changed, 337 insertions(+), 38 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-05-20 23:19:59.000000000 +0900
@@ -7,6 +7,7 @@ config ARCH_SH7367
 	select CPU_V6
 	select HAVE_CLK
 	select COMMON_CLKDEV
+	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
 
 config ARCH_SH7377
--- 0002/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-05-20 23:19:59.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 
 /*
  * IrDA
@@ -259,9 +260,8 @@ static void __init g3evm_map_io(void)
 {
 	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
 
-	/* setup early devices, clocks and console here as well */
+	/* setup early devices and console here as well */
 	sh7367_add_early_devices();
-	sh7367_clock_init();
 	shmobile_setup_console();
 }
 
@@ -298,9 +298,6 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_EXTLP, NULL);
 	gpio_request(GPIO_FN_IDIN, NULL);
 
-	/* enable clock in SYMSTPCR2 */
-	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 22), 0xe6158048);
-
 	/* setup USB phy */
 	__raw_writew(0x0300, 0xe605810a);	/* USBCR1 */
 	__raw_writew(0x00e0, 0xe60581c0);	/* CPFCH */
@@ -356,11 +353,21 @@ static void __init g3evm_init(void)
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
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-05-20 23:19:59.000000000 +0900
@@ -1,5 +1,5 @@
 /*
- * Preliminary clock framework support for sh7367
+ * SH7367 clock framework support
  *
  * Copyright (C) 2010  Magnus Damm
  *
@@ -17,53 +17,342 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/sh_clk.h>
+#include <mach/common.h>
 #include <asm/clkdev.h>
 
-/* a static peripheral clock for now - enough to get sh-sci working */
-static struct clk peripheral_clk = {
-	.name	    = "peripheral_clk",
-	.rate	    = 48000000,
-};
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
 
-/* a static rclk for now - enough to get sh_cmt working */
+/* Fixed 32 KHz root clock from EXTALR pin */
 static struct clk r_clk = {
-	.name	    = "r_clk",
-	.rate	    = 32768,
+	.rate           = 32768,
 };
 
-/* a static usb0 for now - enough to get r8a66597 working */
-static struct clk usb0_clk = {
-	.name	    = "usb0",
+/*
+ * 26MHz default rate for the EXTALB1 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk sh7367_extalb1_clk = {
+	.rate		= 26666666,
 };
 
-/* a static keysc0 clk for now - enough to get sh_keysc working */
-static struct clk keysc0_clk = {
-	.name	    = "keysc0",
+/*
+ * 48MHz default rate for the EXTAL2 root input clock.
+ * If needed, reset this with clk_set_rate() from the platform code.
+ */
+struct clk sh7367_extal2_clk = {
+	.rate		= 48000000,
 };
 
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
+/* Divide extalb1 by two */
+static struct clk extalb1_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &sh7367_extalb1_clk,
+};
+
+/* Divide extal2 by two */
+static struct clk extal2_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &sh7367_extal2_clk,
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
+	.ops		= &pllc1_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.parent		= &extalb1_div2_clk,
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
+	.parent		= &extalb1_div2_clk,
+};
+
+static struct clk *main_clks[] = {
+	&r_clk,
+	&sh7367_extalb1_clk,
+	&sh7367_extal2_clk,
+	&extalb1_div2_clk,
+	&extal2_div2_clk,
+	&pllc1_clk,
+	&pllc1_div2_clk,
+	&pllc2_clk,
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
+};
+
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+	.kick = div4_kick,
+};
+
+enum { DIV4_I, DIV4_G, DIV4_S, DIV4_B,
+       DIV4_ZX, DIV4_ZT, DIV4_Z, DIV4_ZD, DIV4_HP,
+       DIV4_ZS, DIV4_ZB, DIV4_ZB3, DIV4_CP, DIV4_NR };
+
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pllc1_clk, _reg, _bit, _mask, _flags)
+
+static struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4(RTFRQCR, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_G] = DIV4(RTFRQCR, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_S] = DIV4(RTFRQCR, 12, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(RTFRQCR, 8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZX] = DIV4(SYFRQCR, 20, 0x6fff, 0),
+	[DIV4_ZT] = DIV4(SYFRQCR, 16, 0x6fff, 0),
+	[DIV4_Z] = DIV4(SYFRQCR, 12, 0x6fff, 0),
+	[DIV4_ZD] = DIV4(SYFRQCR, 8, 0x6fff, 0),
+	[DIV4_HP] = DIV4(SYFRQCR, 4, 0x6fff, 0),
+	[DIV4_ZS] = DIV4(CMFRQCR, 12, 0x6fff, 0),
+	[DIV4_ZB] = DIV4(CMFRQCR, 8, 0x6fff, 0),
+	[DIV4_ZB3] = DIV4(CMFRQCR, 4, 0x6fff, 0),
+	[DIV4_CP] = DIV4(CMFRQCR, 0, 0x6fff, 0),
+};
+
+enum { DIV6_SUB, DIV6_SIUA, DIV6_SIUB, DIV6_MSU, DIV6_SPU,
+       DIV6_MVI3, DIV6_MF1, DIV6_MF2,
+       DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_VOU,
+       DIV6_NR };
+
+static struct clk div6_clks[DIV6_NR] = {
+	[DIV6_SUB] = SH_CLK_DIV6(&sh7367_extal2_clk, SUBUSBCKCR, 0),
+	[DIV6_SIUA] = SH_CLK_DIV6(&pllc1_div2_clk, SCLKACR, 0),
+	[DIV6_SIUB] = SH_CLK_DIV6(&pllc1_div2_clk, SCLKBCR, 0),
+	[DIV6_MSU] = SH_CLK_DIV6(&pllc1_div2_clk, MSUCKCR, 0),
+	[DIV6_SPU] = SH_CLK_DIV6(&pllc1_div2_clk, SPUCKCR, 0),
+	[DIV6_MVI3] = SH_CLK_DIV6(&pllc1_div2_clk, MVI3CKCR, 0),
+	[DIV6_MF1] = SH_CLK_DIV6(&pllc1_div2_clk, MFCK1CR, 0),
+	[DIV6_MF2] = SH_CLK_DIV6(&pllc1_div2_clk, MFCK2CR, 0),
+	[DIV6_VCK1] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR1, 0),
+	[DIV6_VCK2] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR2, 0),
+	[DIV6_VCK3] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR3, 0),
+	[DIV6_VOU] = SH_CLK_DIV6(&pllc1_div2_clk, VOUCKCR, 0),
+};
+
+enum { RTMSTP001,
+       RTMSTP231, RTMSTP230, RTMSTP229, RTMSTP228, RTMSTP226,
+       RTMSTP216, RTMSTP206, RTMSTP205, RTMSTP201,
+       SYMSTP023, SYMSTP007, SYMSTP006, SYMSTP004,
+       SYMSTP003, SYMSTP002, SYMSTP001, SYMSTP000,
+       SYMSTP231, SYMSTP229, SYMSTP225, SYMSTP223, SYMSTP222,
+       SYMSTP215, SYMSTP214, SYMSTP213, SYMSTP211,
+       CMMSTP003,
+       MSTP_NR };
+
+#define MSTP(_parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[RTMSTP001] = MSTP(&div6_clks[DIV6_SUB], RTMSTPCR0, 1, 0), /* IIC2 */
+	[RTMSTP231] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 31, 0), /* VEU3 */
+	[RTMSTP230] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 30, 0), /* VEU2 */
+	[RTMSTP229] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 29, 0), /* VEU1 */
+	[RTMSTP228] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 28, 0), /* VEU0 */
+	[RTMSTP226] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 26, 0), /* VEU2H */
+	[RTMSTP216] = MSTP(&div6_clks[DIV6_SUB], RTMSTPCR2, 16, 0), /* IIC0 */
+	[RTMSTP206] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 6, 0), /* JPU */
+	[RTMSTP205] = MSTP(&div6_clks[DIV6_VOU], RTMSTPCR2, 5, 0), /* VOU */
+	[RTMSTP201] = MSTP(&div4_clks[DIV4_B], RTMSTPCR2, 1, 0), /* VPU */
+	[SYMSTP023] = MSTP(&div6_clks[DIV6_SPU], SYMSTPCR0, 23, 0), /* SPU1 */
+	[SYMSTP007] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 7, 0), /* SCIFA5 */
+	[SYMSTP006] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 6, 0), /* SCIFB */
+	[SYMSTP004] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 4, 0), /* SCIFA0 */
+	[SYMSTP003] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 3, 0), /* SCIFA1 */
+	[SYMSTP002] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 2, 0), /* SCIFA2 */
+	[SYMSTP001] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 1, 0), /* SCIFA3 */
+	[SYMSTP000] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR0, 0, 0), /* SCIFA4 */
+	[SYMSTP231] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR2, 31, 0), /* SIU */
+	[SYMSTP229] = MSTP(&r_clk, SYMSTPCR2, 29, 0), /* CMT10 */
+	[SYMSTP225] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR2, 25, 0), /* IRDA */
+	[SYMSTP223] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR2, 23, 0), /* IIC1 */
+	[SYMSTP222] = MSTP(&div6_clks[DIV6_SUB], SYMSTPCR2, 22, 0), /* USBHS */
+	[SYMSTP215] = MSTP(&div4_clks[DIV4_HP], SYMSTPCR2, 15, 0), /* FLCTL */
+	[SYMSTP214] = MSTP(&div4_clks[DIV4_HP], SYMSTPCR2, 14, 0), /* SDHI0 */
+	[SYMSTP213] = MSTP(&div4_clks[DIV4_HP], SYMSTPCR2, 13, 0), /* SDHI1 */
+	[SYMSTP211] = MSTP(&div4_clks[DIV4_HP], SYMSTPCR2, 11, 0), /* SDHI2 */
+	[CMMSTP003] = MSTP(&r_clk, CMMSTPCR0, 3, 0), /* KEYSC */
+};
+
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+
 static struct clk_lookup lookups[] = {
-	{
-		.clk = &peripheral_clk,
-	}, {
-		.clk = &r_clk,
-	}, {
-		.clk = &usb0_clk,
-	}, {
-		.clk = &keysc0_clk,
-	}
+	/* main clocks */
+	CLKDEV_CON_ID("r_clk", &r_clk),
+	CLKDEV_CON_ID("extalb1", &sh7367_extalb1_clk),
+	CLKDEV_CON_ID("extal2", &sh7367_extal2_clk),
+	CLKDEV_CON_ID("extalb1_div2_clk", &extalb1_div2_clk),
+	CLKDEV_CON_ID("extal2_div2_clk", &extal2_div2_clk),
+	CLKDEV_CON_ID("pllc1_clk", &pllc1_clk),
+	CLKDEV_CON_ID("pllc1_div2_clk", &pllc1_div2_clk),
+	CLKDEV_CON_ID("pllc2_clk", &pllc2_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("i_clk", &div4_clks[DIV4_I]),
+	CLKDEV_CON_ID("g_clk", &div4_clks[DIV4_G]),
+	CLKDEV_CON_ID("b_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("zx_clk", &div4_clks[DIV4_ZX]),
+	CLKDEV_CON_ID("zt_clk", &div4_clks[DIV4_ZT]),
+	CLKDEV_CON_ID("z_clk", &div4_clks[DIV4_Z]),
+	CLKDEV_CON_ID("zd_clk", &div4_clks[DIV4_ZD]),
+	CLKDEV_CON_ID("hp_clk", &div4_clks[DIV4_HP]),
+	CLKDEV_CON_ID("zs_clk", &div4_clks[DIV4_ZS]),
+	CLKDEV_CON_ID("zb_clk", &div4_clks[DIV4_ZB]),
+	CLKDEV_CON_ID("zb3_clk", &div4_clks[DIV4_ZB3]),
+	CLKDEV_CON_ID("cp_clk", &div4_clks[DIV4_CP]),
+
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
+	CLKDEV_CON_ID("siua_clk", &div6_clks[DIV6_SIUA]),
+	CLKDEV_CON_ID("siub_clk", &div6_clks[DIV6_SIUB]),
+	CLKDEV_CON_ID("msu_clk", &div6_clks[DIV6_MSU]),
+	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
+	CLKDEV_CON_ID("mvi3_clk", &div6_clks[DIV6_MVI3]),
+	CLKDEV_CON_ID("mf1_clk", &div6_clks[DIV6_MF1]),
+	CLKDEV_CON_ID("mf2_clk", &div6_clks[DIV6_MF2]),
+	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
+	CLKDEV_CON_ID("vck2_clk", &div6_clks[DIV6_VCK2]),
+	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
+	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
+
+	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[RTMSTP001]), /* IIC2 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.4", &mstp_clks[RTMSTP231]), /* VEU3 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[RTMSTP230]), /* VEU2 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[RTMSTP229]), /* VEU1 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[RTMSTP228]), /* VEU0 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[RTMSTP226]), /* VEU2H */
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[RTMSTP216]), /* IIC0 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.6", &mstp_clks[RTMSTP206]), /* JPU */
+	CLKDEV_DEV_ID("sh-vou", &mstp_clks[RTMSTP205]), /* VOU */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[RTMSTP201]), /* VPU */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.7", &mstp_clks[SYMSTP023]), /* SPU1 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[SYMSTP007]), /* SCIFA5 */
+	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[SYMSTP006]), /* SCIFB */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[SYMSTP004]), /* SCIFA0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[SYMSTP003]), /* SCIFA1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[SYMSTP002]), /* SCIFA2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[SYMSTP001]), /* SCIFA3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[SYMSTP000]), /* SCIFA4 */
+	CLKDEV_DEV_ID("sh_siu", &mstp_clks[SYMSTP231]), /* SIU */
+	CLKDEV_CON_ID("cmt1", &mstp_clks[SYMSTP229]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_irda", &mstp_clks[SYMSTP225]), /* IRDA */
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[SYMSTP223]), /* IIC1 */
+	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[SYMSTP222]), /* USBHS */
+	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[SYMSTP222]), /* USBHS */
+	CLKDEV_DEV_ID("sh_flctl", &mstp_clks[SYMSTP215]), /* FLCTL */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[SYMSTP214]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[SYMSTP213]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[SYMSTP211]), /* SDHI2 */
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[CMMSTP003]), /* KEYSC */
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
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
-		lookups[i].con_id = lookups[i].clk->name;
-		clkdev_add(&lookups[i]);
-	}
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup sh7367 clocks\n");
 }
--- 0005/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-05-20 23:19:59.000000000 +0900
@@ -11,6 +11,8 @@ extern void sh7367_add_early_devices(voi
 extern void sh7367_add_standard_devices(void);
 extern void sh7367_clock_init(void);
 extern void sh7367_pinmux_init(void);
+extern struct clk sh7367_extalb1_clk;
+extern struct clk sh7367_extal2_clk;
 
 extern void sh7377_init_irq(void);
 extern void sh7377_add_early_devices(void);
