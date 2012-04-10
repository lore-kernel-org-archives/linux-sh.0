From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 10 Apr 2012 13:00:51 +0000
Subject: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is an sh2a device.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/Kconfig                        |    8 +
 arch/sh/include/asm/processor.h        |    2 +-
 arch/sh/kernel/cpu/proc.c              |    1 +
 arch/sh/kernel/cpu/sh2a/Makefile       |    1 +
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c |  184 ++++++++++
 arch/sh/kernel/cpu/sh2a/probe.c        |    3 +
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |  606 ++++++++++++++++++++++++++++++++
 7 files changed, 804 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/kernel/cpu/sh2a/clock-sh7264.c
 create mode 100644 arch/sh/kernel/cpu/sh2a/setup-sh7264.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ff9e033..3a945d1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -288,6 +288,13 @@ config CPU_SUBTYPE_SH7263
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
 
+config CPU_SUBTYPE_SH7264
+	bool "Support SH7264 processor"
+	select CPU_SH2A
+	select CPU_HAS_FPU
+	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_MTU2
+
 config CPU_SUBTYPE_MXG
 	bool "Support MX-G processor"
 	select CPU_SH2A
@@ -570,6 +577,7 @@ config SH_PCLK_FREQ
 			      CPU_SUBTYPE_SH7206 || \
 			      CPU_SUBTYPE_SH7263 || \
 			      CPU_SUBTYPE_MXG
+	default "36000000" if CPU_SUBTYPE_SH7264
 	default "60000000" if CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
 	default "66000000" if CPU_SUBTYPE_SH4_202
 	default "50000000"
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index a229c39..898db19 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -18,7 +18,7 @@ enum cpu_type {
 	CPU_SH7619,
 
 	/* SH-2A types */
-	CPU_SH7201, CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_MXG,
+	CPU_SH7201, CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_SH7264, CPU_MXG,
 
 	/* SH-3 types */
 	CPU_SH7705, CPU_SH7706, CPU_SH7707,
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index f47be87..b5a9d8b 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -7,6 +7,7 @@
 static const char *cpu_name[] = {
 	[CPU_SH7201]	= "SH7201",
 	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
+	[CPU_SH7264]	= "SH7264",
 	[CPU_SH7206]	= "SH7206",	[CPU_SH7619]	= "SH7619",
 	[CPU_SH7705]	= "SH7705",	[CPU_SH7706]	= "SH7706",
 	[CPU_SH7707]	= "SH7707",	[CPU_SH7708]	= "SH7708",
diff --git a/arch/sh/kernel/cpu/sh2a/Makefile b/arch/sh/kernel/cpu/sh2a/Makefile
index 45f85c7..617ef25 100644
--- a/arch/sh/kernel/cpu/sh2a/Makefile
+++ b/arch/sh/kernel/cpu/sh2a/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SH_FPU)	+= fpu.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7201)	+= setup-sh7201.o clock-sh7201.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7203)	+= setup-sh7203.o clock-sh7203.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7263)	+= setup-sh7203.o clock-sh7203.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7264)	+= setup-sh7264.o clock-sh7264.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7206)	+= setup-sh7206.o clock-sh7206.o
 obj-$(CONFIG_CPU_SUBTYPE_MXG)		+= setup-mxg.o clock-sh7206.o
 
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
new file mode 100644
index 0000000..dbc9449
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
@@ -0,0 +1,184 @@
+/*
+ * arch/sh/kernel/cpu/sh2/clock-sh7264.c
+ *
+ * SH7264 support for the clock framework
+ *
+ *  Copyright (C) 2012  Phil Edworthy
+ *
+ * Based on clock-sh7206.c
+ *  Copyright (C) 2006  Yoshinori Sato
+ *
+ * Based on clock-sh4.c
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+
+static const unsigned int pll1rate[] = {8, 12};
+static const unsigned int pfc_divisors[] = {1, 2, 3, 4, 6, 8, 12, 0};
+
+static unsigned int pll2_mult;
+
+/* Fixed 32 KHz root clock for RTC */
+static struct clk r_clk = {
+	.rate           = 32768,
+};
+
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+static struct clk extal_clk = {
+	.rate		= 18000000,
+};
+
+static unsigned long master_clk_recalc(struct clk *clk)
+{
+	unsigned long rate = clk->parent->rate * pll2_mult;
+	return rate * pll1rate[(__raw_readw(FREQCR) >> 8) & 1];
+}
+
+static struct sh_clk_ops master_clk_ops = {
+	.recalc		= master_clk_recalc,
+};
+
+static struct clk master_clk = {
+	.parent		= &extal_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.ops		= &master_clk_ops,
+};
+
+static unsigned long peripheral_clk_recalc(struct clk *clk)
+{
+	int idx = __raw_readw(FREQCR) & 0x0007;
+	return clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct sh_clk_ops peripheral_clk_ops = {
+	.recalc		= peripheral_clk_recalc,
+};
+
+static struct clk peripheral_clk = {
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.ops		= &peripheral_clk_ops,
+};
+
+static unsigned long bus_clk_recalc(struct clk *clk)
+{
+	int idx = __raw_readw(FREQCR) & 0x0007;
+	return clk->parent->rate / pfc_divisors[idx-2];
+}
+
+static struct sh_clk_ops bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static struct clk bus_clk = {
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.ops		= &bus_clk_ops,
+};
+
+static struct sh_clk_ops cpu_clk_ops = {
+	.recalc		= followparent_recalc,
+};
+
+static struct clk cpu_clk = {
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+	.ops		= &cpu_clk_ops,
+};
+
+static struct clk *main_clocks[] = {
+	&r_clk,
+	&extal_clk,
+	&master_clk,
+	&peripheral_clk,
+	&bus_clk,
+	&cpu_clk,
+};
+
+#define STBCR3 0xfffe0408
+#define STBCR4 0xfffe040c
+#define STBCR5 0xfffe0410
+#define STBCR6 0xfffe0414
+#define STBCR7 0xfffe0418
+#define STBCR8 0xfffe041c
+
+#define MSTP(_parent, _reg, _bit, _flags) \
+	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
+enum {	MSTP77, MSTP74, MSTP72,
+	MSTP60,
+	MSTP35, MSTP34, MSTP33, MSTP32, MSTP30,
+	MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP77] = MSTP(&peripheral_clk, STBCR7, 7, 0),	/* SCIF */
+	[MSTP74] = MSTP(&peripheral_clk, STBCR7, 4, 0),	/* VDC */
+	[MSTP72] = MSTP(&peripheral_clk, STBCR7, 2, 0),	/* CMT */
+	[MSTP60] = MSTP(&peripheral_clk, STBCR6, 0, 0),	/* USB */
+	[MSTP35] = MSTP(&peripheral_clk, STBCR3, 6, 0),	/* MTU2 */
+	[MSTP34] = MSTP(&peripheral_clk, STBCR3, 4, 0),	/* SDHI0 */
+	[MSTP33] = MSTP(&peripheral_clk, STBCR3, 3, 0),	/* SDHI1 */
+	[MSTP32] = MSTP(&peripheral_clk, STBCR3, 2, 0),	/* ADC */
+	[MSTP30] = MSTP(&r_clk, STBCR3, 0, 0),	/* RTC */
+};
+
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("rclk", &r_clk),
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("master_clk", &master_clk),
+	CLKDEV_CON_ID("peripheral_clk", &peripheral_clk),
+	CLKDEV_CON_ID("bus_clk", &bus_clk),
+	CLKDEV_CON_ID("cpu_clk", &cpu_clk),
+
+	/* other clocks */
+	CLKDEV_CON_ID("sci_ick", &mstp_clks[MSTP77]),
+	CLKDEV_CON_ID("vdc3", &mstp_clks[MSTP74]),
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[MSTP72]),
+	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP60]),
+	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP35]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP34]),
+	CLKDEV_CON_ID("sdhi1", &mstp_clks[MSTP33]),
+	CLKDEV_CON_ID("adc0", &mstp_clks[MSTP32]),
+	CLKDEV_CON_ID("rtc0", &mstp_clks[MSTP30]),
+};
+
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+{
+}
+
+int __init arch_clk_init(void)
+{
+	int k, ret = 0;
+
+	if (test_mode_pin(MODE_PIN0)) {
+		if (test_mode_pin(MODE_PIN1))
+			pll2_mult = 3;
+		else
+			pll2_mult = 4;
+	} else
+		pll2_mult = 1;
+
+	for (k = 0; k < ARRAY_SIZE(main_clocks); k++)
+		ret |= clk_register(main_clocks[k]);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		ret = sh_clk_mstp8_register(mstp_clks, MSTP_NR);
+
+	return ret;
+}
diff --git a/arch/sh/kernel/cpu/sh2a/probe.c b/arch/sh/kernel/cpu/sh2a/probe.c
index 48e97a2..414b258 100644
--- a/arch/sh/kernel/cpu/sh2a/probe.c
+++ b/arch/sh/kernel/cpu/sh2a/probe.c
@@ -29,6 +29,9 @@ void __cpuinit cpu_probe(void)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7263)
 	boot_cpu_data.type			= CPU_SH7263;
 	boot_cpu_data.flags			|= CPU_HAS_FPU;
+#elif defined(CONFIG_CPU_SUBTYPE_SH7264)
+	boot_cpu_data.type			= CPU_SH7264;
+	boot_cpu_data.flags			|= CPU_HAS_FPU;
 #elif defined(CONFIG_CPU_SUBTYPE_SH7206)
 	boot_cpu_data.type			= CPU_SH7206;
 	boot_cpu_data.flags			|= CPU_HAS_DSP;
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
new file mode 100644
index 0000000..ce5c1b5
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -0,0 +1,606 @@
+/*
+ * SH7264 Setup
+ *
+ * Copyright (C) 2012  Renesas Electronics Europe Ltd
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_sci.h>
+#include <linux/usb/r8a66597.h>
+#include <linux/sh_timer.h>
+#include <linux/io.h>
+
+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
+	PINT0, PINT1, PINT2, PINT3, PINT4, PINT5, PINT6, PINT7,
+
+	DMAC0, DMAC1, DMAC2, DMAC3, DMAC4, DMAC5, DMAC6, DMAC7,
+	DMAC8, DMAC9, DMAC10, DMAC11, DMAC12, DMAC13, DMAC14, DMAC15,
+	USB, VDC3, CMT0, CMT1, BSC, WDT,
+	MTU0_ABCD, MTU0_VEF, MTU1_AB, MTU1_VU, MTU2_AB, MTU2_VU,
+	MTU3_ABCD, MTU3_TCI3V, MTU4_ABCD, MTU4_TCI4V,
+	PWMT1, PWMT2, ADC_ADI,
+	SSIF0, SSII1, SSII2, SSII3,
+	RSPDIF,
+	IIC30, IIC31, IIC32, IIC33,
+	SCIF0_BRI, SCIF0_ERI, SCIF0_RXI, SCIF0_TXI,
+	SCIF1_BRI, SCIF1_ERI, SCIF1_RXI, SCIF1_TXI,
+	SCIF2_BRI, SCIF2_ERI, SCIF2_RXI, SCIF2_TXI,
+	SCIF3_BRI, SCIF3_ERI, SCIF3_RXI, SCIF3_TXI,
+	SCIF4_BRI, SCIF4_ERI, SCIF4_RXI, SCIF4_TXI,
+	SCIF5_BRI, SCIF5_ERI, SCIF5_RXI, SCIF5_TXI,
+	SCIF6_BRI, SCIF6_ERI, SCIF6_RXI, SCIF6_TXI,
+	SCIF7_BRI, SCIF7_ERI, SCIF7_RXI, SCIF7_TXI,
+	SIO_FIFO, RSPIC0, RSPIC1,
+	RCAN0, RCAN1, IEBC, CD_ROMD,
+	NFMC, SDHI, RTC,
+	SRCC0, SRCC1, DCOMU, OFFI, IFEI,
+
+	/* interrupt groups */
+	PINT, SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5, SCIF6, SCIF7,
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_IRQ(IRQ0, 64), INTC_IRQ(IRQ1, 65),
+	INTC_IRQ(IRQ2, 66), INTC_IRQ(IRQ3, 67),
+	INTC_IRQ(IRQ4, 68), INTC_IRQ(IRQ5, 69),
+	INTC_IRQ(IRQ6, 70), INTC_IRQ(IRQ7, 71),
+
+	INTC_IRQ(PINT0, 80), INTC_IRQ(PINT1, 81),
+	INTC_IRQ(PINT2, 82), INTC_IRQ(PINT3, 83),
+	INTC_IRQ(PINT4, 84), INTC_IRQ(PINT5, 85),
+	INTC_IRQ(PINT6, 86), INTC_IRQ(PINT7, 87),
+
+	INTC_IRQ(DMAC0, 108), INTC_IRQ(DMAC0, 109),
+	INTC_IRQ(DMAC1, 112), INTC_IRQ(DMAC1, 113),
+	INTC_IRQ(DMAC2, 116), INTC_IRQ(DMAC2, 117),
+	INTC_IRQ(DMAC3, 120), INTC_IRQ(DMAC3, 121),
+	INTC_IRQ(DMAC4, 124), INTC_IRQ(DMAC4, 125),
+	INTC_IRQ(DMAC5, 128), INTC_IRQ(DMAC5, 129),
+	INTC_IRQ(DMAC6, 132), INTC_IRQ(DMAC6, 133),
+	INTC_IRQ(DMAC7, 136), INTC_IRQ(DMAC7, 137),
+	INTC_IRQ(DMAC8, 140), INTC_IRQ(DMAC8, 141),
+	INTC_IRQ(DMAC9, 144), INTC_IRQ(DMAC9, 145),
+	INTC_IRQ(DMAC10, 148), INTC_IRQ(DMAC10, 149),
+	INTC_IRQ(DMAC11, 152), INTC_IRQ(DMAC11, 153),
+	INTC_IRQ(DMAC12, 156), INTC_IRQ(DMAC12, 157),
+	INTC_IRQ(DMAC13, 160), INTC_IRQ(DMAC13, 161),
+	INTC_IRQ(DMAC14, 164), INTC_IRQ(DMAC14, 165),
+	INTC_IRQ(DMAC15, 168), INTC_IRQ(DMAC15, 169),
+
+	INTC_IRQ(USB, 170),
+	INTC_IRQ(VDC3, 171), INTC_IRQ(VDC3, 172),
+	INTC_IRQ(VDC3, 173), INTC_IRQ(VDC3, 174),
+	INTC_IRQ(CMT0, 175), INTC_IRQ(CMT1, 176),
+	INTC_IRQ(BSC, 177), INTC_IRQ(WDT, 178),
+
+	INTC_IRQ(MTU0_ABCD, 179), INTC_IRQ(MTU0_ABCD, 180),
+	INTC_IRQ(MTU0_ABCD, 181), INTC_IRQ(MTU0_ABCD, 182),
+	INTC_IRQ(MTU0_VEF, 183),
+	INTC_IRQ(MTU0_VEF, 184), INTC_IRQ(MTU0_VEF, 185),
+	INTC_IRQ(MTU1_AB, 186), INTC_IRQ(MTU1_AB, 187),
+	INTC_IRQ(MTU1_VU, 188), INTC_IRQ(MTU1_VU, 189),
+	INTC_IRQ(MTU2_AB, 190), INTC_IRQ(MTU2_AB, 191),
+	INTC_IRQ(MTU2_VU, 192), INTC_IRQ(MTU2_VU, 193),
+	INTC_IRQ(MTU3_ABCD, 194), INTC_IRQ(MTU3_ABCD, 195),
+	INTC_IRQ(MTU3_ABCD, 196), INTC_IRQ(MTU3_ABCD, 197),
+	INTC_IRQ(MTU3_TCI3V, 198),
+	INTC_IRQ(MTU4_ABCD, 199), INTC_IRQ(MTU4_ABCD, 200),
+	INTC_IRQ(MTU4_ABCD, 201), INTC_IRQ(MTU4_ABCD, 202),
+	INTC_IRQ(MTU4_TCI4V, 203),
+
+	INTC_IRQ(PWMT1, 204), INTC_IRQ(PWMT2, 205),
+
+	INTC_IRQ(ADC_ADI, 206),
+
+	INTC_IRQ(SSIF0, 207), INTC_IRQ(SSIF0, 208),
+	INTC_IRQ(SSIF0, 209),
+	INTC_IRQ(SSII1, 210), INTC_IRQ(SSII1, 211),
+	INTC_IRQ(SSII2, 212), INTC_IRQ(SSII2, 213),
+	INTC_IRQ(SSII3, 214), INTC_IRQ(SSII3, 215),
+
+	INTC_IRQ(RSPDIF, 216),
+
+	INTC_IRQ(IIC30, 217), INTC_IRQ(IIC30, 218),
+	INTC_IRQ(IIC30, 219), INTC_IRQ(IIC30, 220),
+	INTC_IRQ(IIC30, 221),
+	INTC_IRQ(IIC31, 222), INTC_IRQ(IIC31, 223),
+	INTC_IRQ(IIC31, 224), INTC_IRQ(IIC31, 225),
+	INTC_IRQ(IIC31, 226),
+	INTC_IRQ(IIC32, 227), INTC_IRQ(IIC32, 228),
+	INTC_IRQ(IIC32, 229), INTC_IRQ(IIC32, 230),
+	INTC_IRQ(IIC32, 231),
+
+	INTC_IRQ(SCIF0_BRI, 232), INTC_IRQ(SCIF0_ERI, 233),
+	INTC_IRQ(SCIF0_RXI, 234), INTC_IRQ(SCIF0_TXI, 235),
+	INTC_IRQ(SCIF1_BRI, 236), INTC_IRQ(SCIF1_ERI, 237),
+	INTC_IRQ(SCIF1_RXI, 238), INTC_IRQ(SCIF1_TXI, 239),
+	INTC_IRQ(SCIF2_BRI, 240), INTC_IRQ(SCIF2_ERI, 241),
+	INTC_IRQ(SCIF2_RXI, 242), INTC_IRQ(SCIF2_TXI, 243),
+	INTC_IRQ(SCIF3_BRI, 244), INTC_IRQ(SCIF3_ERI, 245),
+	INTC_IRQ(SCIF3_RXI, 246), INTC_IRQ(SCIF3_TXI, 247),
+	INTC_IRQ(SCIF4_BRI, 248), INTC_IRQ(SCIF4_ERI, 249),
+	INTC_IRQ(SCIF4_RXI, 250), INTC_IRQ(SCIF4_TXI, 251),
+	INTC_IRQ(SCIF5_BRI, 252), INTC_IRQ(SCIF5_ERI, 253),
+	INTC_IRQ(SCIF5_RXI, 254), INTC_IRQ(SCIF5_TXI, 255),
+	INTC_IRQ(SCIF6_BRI, 256), INTC_IRQ(SCIF6_ERI, 257),
+	INTC_IRQ(SCIF6_RXI, 258), INTC_IRQ(SCIF6_TXI, 259),
+	INTC_IRQ(SCIF7_BRI, 260), INTC_IRQ(SCIF7_ERI, 261),
+	INTC_IRQ(SCIF7_RXI, 262), INTC_IRQ(SCIF7_TXI, 263),
+
+	INTC_IRQ(SIO_FIFO, 264),
+
+	INTC_IRQ(RSPIC0, 265), INTC_IRQ(RSPIC0, 266),
+	INTC_IRQ(RSPIC0, 267),
+	INTC_IRQ(RSPIC1, 268), INTC_IRQ(RSPIC1, 269),
+	INTC_IRQ(RSPIC1, 270),
+
+	INTC_IRQ(RCAN0, 271), INTC_IRQ(RCAN0, 272),
+	INTC_IRQ(RCAN0, 273), INTC_IRQ(RCAN0, 274),
+	INTC_IRQ(RCAN0, 275),
+	INTC_IRQ(RCAN1, 276), INTC_IRQ(RCAN1, 277),
+	INTC_IRQ(RCAN1, 278), INTC_IRQ(RCAN1, 279),
+	INTC_IRQ(RCAN1, 280),
+
+	INTC_IRQ(IEBC, 281),
+
+	INTC_IRQ(CD_ROMD, 282), INTC_IRQ(CD_ROMD, 283),
+	INTC_IRQ(CD_ROMD, 284), INTC_IRQ(CD_ROMD, 285),
+	INTC_IRQ(CD_ROMD, 286), INTC_IRQ(CD_ROMD, 287),
+
+	INTC_IRQ(NFMC, 288), INTC_IRQ(NFMC, 289),
+	INTC_IRQ(NFMC, 290), INTC_IRQ(NFMC, 291),
+
+	INTC_IRQ(SDHI, 292), INTC_IRQ(SDHI, 293),
+	INTC_IRQ(SDHI, 294),
+
+	INTC_IRQ(RTC, 296), INTC_IRQ(RTC, 297),
+	INTC_IRQ(RTC, 298),
+
+	INTC_IRQ(SRCC0, 299), INTC_IRQ(SRCC0, 300),
+	INTC_IRQ(SRCC0, 301), INTC_IRQ(SRCC0, 302),
+	INTC_IRQ(SRCC0, 303),
+	INTC_IRQ(SRCC1, 304), INTC_IRQ(SRCC1, 305),
+	INTC_IRQ(SRCC1, 306), INTC_IRQ(SRCC1, 307),
+	INTC_IRQ(SRCC1, 308),
+
+	INTC_IRQ(DCOMU, 310), INTC_IRQ(DCOMU, 311),
+	INTC_IRQ(DCOMU, 312),
+};
+
+static struct intc_group groups[] __initdata = {
+	INTC_GROUP(PINT, PINT0, PINT1, PINT2, PINT3,
+		   PINT4, PINT5, PINT6, PINT7),
+	INTC_GROUP(SCIF0, SCIF0_BRI, SCIF0_ERI, SCIF0_RXI, SCIF0_TXI),
+	INTC_GROUP(SCIF1, SCIF1_BRI, SCIF1_ERI, SCIF1_RXI, SCIF1_TXI),
+	INTC_GROUP(SCIF2, SCIF2_BRI, SCIF2_ERI, SCIF2_RXI, SCIF2_TXI),
+	INTC_GROUP(SCIF3, SCIF3_BRI, SCIF3_ERI, SCIF3_RXI, SCIF3_TXI),
+	INTC_GROUP(SCIF4, SCIF4_BRI, SCIF4_ERI, SCIF4_RXI, SCIF4_TXI),
+	INTC_GROUP(SCIF5, SCIF5_BRI, SCIF5_ERI, SCIF5_RXI, SCIF5_TXI),
+	INTC_GROUP(SCIF6, SCIF6_BRI, SCIF6_ERI, SCIF6_RXI, SCIF6_TXI),
+	INTC_GROUP(SCIF7, SCIF7_BRI, SCIF7_ERI, SCIF7_RXI, SCIF7_TXI),
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xfffe0818, 0, 16, 4, /* IPR01 */ { IRQ0, IRQ1, IRQ2, IRQ3 } },
+	{ 0xfffe081a, 0, 16, 4, /* IPR02 */ { IRQ4, IRQ5, IRQ6, IRQ7 } },
+	{ 0xfffe0820, 0, 16, 4, /* IPR05 */ { PINT, 0, 0, 0 } },
+	{ 0xfffe0c00, 0, 16, 4, /* IPR06 */ { DMAC0,  DMAC1,  DMAC2,  DMAC3 } },
+	{ 0xfffe0c02, 0, 16, 4, /* IPR07 */ { DMAC4,  DMAC5,  DMAC6,  DMAC7 } },
+	{ 0xfffe0c04, 0, 16, 4, /* IPR08 */ { DMAC8,  DMAC9,
+					      DMAC10, DMAC11 } },
+	{ 0xfffe0c06, 0, 16, 4, /* IPR09 */ { DMAC12, DMAC13,
+					      DMAC14, DMAC15 } },
+	{ 0xfffe0c08, 0, 16, 4, /* IPR10 */ { USB, VDC3, CMT0, CMT1 } },
+	{ 0xfffe0c0a, 0, 16, 4, /* IPR11 */ { BSC, WDT, MTU0_ABCD, MTU0_VEF } },
+	{ 0xfffe0c0c, 0, 16, 4, /* IPR12 */ { MTU1_AB, MTU1_VU,
+					      MTU2_AB, MTU2_VU } },
+	{ 0xfffe0c0e, 0, 16, 4, /* IPR13 */ { MTU3_ABCD, MTU3_TCI3V,
+					      MTU4_ABCD, MTU4_TCI4V } },
+	{ 0xfffe0c10, 0, 16, 4, /* IPR14 */ { PWMT1, PWMT2, ADC_ADI, 0 } },
+	{ 0xfffe0c12, 0, 16, 4, /* IPR15 */ { SSIF0, SSII1, SSII2, SSII3 } },
+	{ 0xfffe0c14, 0, 16, 4, /* IPR16 */ { RSPDIF, IIC30, IIC31, IIC32 } },
+	{ 0xfffe0c16, 0, 16, 4, /* IPR17 */ { SCIF0, SCIF1, SCIF2, SCIF3 } },
+	{ 0xfffe0c18, 0, 16, 4, /* IPR18 */ { SCIF4, SCIF5, SCIF6, SCIF7 } },
+	{ 0xfffe0c1a, 0, 16, 4, /* IPR19 */ { SIO_FIFO, 0, RSPIC0, RSPIC1, } },
+	{ 0xfffe0c1c, 0, 16, 4, /* IPR20 */ { RCAN0, RCAN1, IEBC, CD_ROMD } },
+	{ 0xfffe0c1e, 0, 16, 4, /* IPR21 */ { NFMC, SDHI, RTC, 0 } },
+	{ 0xfffe0c20, 0, 16, 4, /* IPR22 */ { SRCC0, SRCC1, 0, DCOMU } },
+};
+
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{ 0xfffe0808, 0, 16, /* PINTER */
+	  { 0, 0, 0, 0, 0, 0, 0, 0,
+	    PINT7, PINT6, PINT5, PINT4, PINT3, PINT2, PINT1, PINT0 } },
+};
+
+static DECLARE_INTC_DESC(intc_desc, "sh7264", vectors, groups,
+			 mask_registers, prio_registers, NULL);
+
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfffe8000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 233, 234, 235, 232 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xfffe8800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 237, 238, 239, 236 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xfffe9000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 241, 242, 243, 240 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xfffe9800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 245, 246, 247, 244 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xfffea000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 249, 250, 251, 248 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xfffea800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 253, 254, 255, 252 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
+static struct plat_sci_port scif6_platform_data = {
+	.mapbase	= 0xfffeb000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 257, 258, 259, 256 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif6_device = {
+	.name		= "sh-sci",
+	.id		= 6,
+	.dev		= {
+		.platform_data	= &scif6_platform_data,
+	},
+};
+
+static struct plat_sci_port scif7_platform_data = {
+	.mapbase	= 0xfffeb800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |
+			  SCSCR_REIE | SCSCR_TOIE,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		=  { 261, 262, 263, 260 },
+	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+};
+
+static struct platform_device scif7_device = {
+	.name		= "sh-sci",
+	.id		= 7,
+	.dev		= {
+		.platform_data	= &scif7_platform_data,
+	},
+};
+
+static struct sh_timer_config cmt0_platform_data = {
+	.channel_offset = 0x02,
+	.timer_bit = 0,
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt0_resources[] = {
+	[0] = {
+		.name	= "CMT0",
+		.start	= 0xfffec002,
+		.end	= 0xfffec007,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 175,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt0_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt0_platform_data,
+	},
+	.resource	= cmt0_resources,
+	.num_resources	= ARRAY_SIZE(cmt0_resources),
+};
+
+static struct sh_timer_config cmt1_platform_data = {
+	.name = "CMT1",
+	.channel_offset = 0x08,
+	.timer_bit = 1,
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt1_resources[] = {
+	[0] = {
+		.name	= "CMT1",
+		.start	= 0xfffec008,
+		.end	= 0xfffec00d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 176,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt1_device = {
+	.name		= "sh_cmt",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &cmt1_platform_data,
+	},
+	.resource	= cmt1_resources,
+	.num_resources	= ARRAY_SIZE(cmt1_resources),
+};
+
+static struct sh_timer_config mtu2_0_platform_data = {
+	.name = "MTU2_0",
+	.channel_offset = -0x80,
+	.timer_bit = 0,
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] = {
+	[0] = {
+		.name	= "MTU2_0",
+		.start	= 0xfffe4300,
+		.end	= 0xfffe4326,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 179,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_0_device = {
+	.name		= "sh_mtu2",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mtu2_0_platform_data,
+	},
+	.resource	= mtu2_0_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_0_resources),
+};
+
+static struct sh_timer_config mtu2_1_platform_data = {
+	.name = "MTU2_1",
+	.channel_offset = -0x100,
+	.timer_bit = 1,
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_1_resources[] = {
+	[0] = {
+		.name	= "MTU2_1",
+		.start	= 0xfffe4380,
+		.end	= 0xfffe4390,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 186,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_1_device = {
+	.name		= "sh_mtu2",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mtu2_1_platform_data,
+	},
+	.resource	= mtu2_1_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_1_resources),
+};
+
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= 0xfffe6000,
+		.end	= 0xfffe6000 + 0x30 - 1,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		/* Shared Period/Carry/Alarm IRQ */
+		.start	= 296,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device rtc_device = {
+	.name		= "sh-rtc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(rtc_resources),
+	.resource	= rtc_resources,
+};
+
+/* USB Host */
+static void usb_port_power(int port, int power)
+{
+	__raw_writew(0x200 , 0xffffc0c2) ; /* Initialise UACS25 */
+}
+
+static struct r8a66597_platdata r8a66597_data = {
+	.on_chip = 1,
+	.endian = 1,
+	.port_power = usb_port_power,
+};
+
+static struct resource r8a66597_usb_host_resources[] = {
+	[0] = {
+		.start	= 0xffffc000,
+		.end	= 0xffffc0e4,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 170,
+		.end	= 170,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct platform_device r8a66597_usb_host_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
+	},
+	.num_resources	= ARRAY_SIZE(r8a66597_usb_host_resources),
+	.resource	= r8a66597_usb_host_resources,
+};
+
+static struct platform_device *sh7264_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
+	&cmt0_device,
+	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&rtc_device,
+	&r8a66597_usb_host_device,
+};
+
+static int __init sh7264_devices_setup(void)
+{
+	return platform_add_devices(sh7264_devices,
+				    ARRAY_SIZE(sh7264_devices));
+}
+arch_initcall(sh7264_devices_setup);
+
+void __init plat_irq_setup(void)
+{
+	register_intc_controller(&intc_desc);
+}
+
+static struct platform_device *sh7264_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
+	&cmt0_device,
+	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7264_early_devices,
+				   ARRAY_SIZE(sh7264_early_devices));
+}
-- 
1.7.0.4

