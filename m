From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 28 Nov 2008 12:27:30 +0000
Subject: [PATCH 1 / 3] sh: SH7201, cpu support
Message-Id: <492FE3B2.6080400@mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Peter Griffin <pgriffin@mpc-data.co.uk>

sh: SH7201, cpu support

This patch adds support for the SH7201 processor subtype.

Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
---
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9b58bd0..f8741e7 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -182,6 +182,10 @@ config CPU_SUBTYPE_SH7619
  	select CPU_SH2

  # SH-2A Processor Support
+config CPU_SUBTYPE_SH7201
+	bool "Support SH7201 processor"
+	select CPU_SH2A
+	select CPU_HAS_FPU

  config CPU_SUBTYPE_SH7203
  	bool "Support SH7203 processor"
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 50467f9..2bf3f6c 100644

diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index f186fc6..1ef4b24 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -18,7 +18,7 @@ enum cpu_type {
  	CPU_SH7619,

  	/* SH-2A types */
-	CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_MXG,
+	CPU_SH7201, CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_MXG,

  	/* SH-3 types */
  	CPU_SH7705, CPU_SH7706, CPU_SH7707,
diff --git a/arch/sh/kernel/cpu/sh2a/Makefile b/arch/sh/kernel/cpu/sh2a/Makefile
index 428450c..314725e 100644
--- a/arch/sh/kernel/cpu/sh2a/Makefile
+++ b/arch/sh/kernel/cpu/sh2a/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SH_FPU)	+= fpu.o

  obj-$(CONFIG_CPU_SUBTYPE_SH7206)	+= setup-sh7206.o clock-sh7206.o
  obj-$(CONFIG_CPU_SUBTYPE_SH7203)	+= setup-sh7203.o clock-sh7203.o
+obj-$(CONFIG_CPU_SUBTYPE_SH7201)	+= setup-sh7201.o clock-sh7201.o
  obj-$(CONFIG_CPU_SUBTYPE_SH7263)	+= setup-sh7203.o clock-sh7203.o
  obj-$(CONFIG_CPU_SUBTYPE_MXG)		+= setup-mxg.o clock-sh7206.o

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
new file mode 100644
index 0000000..a99983c
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
@@ -0,0 +1,86 @@
+/*
+ * arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+ *
+ * SH7201 support for the clock framework
+ *
+ *  Copyright (C) 2008 Peter Griffin  <pgriffin@mpc-data.co.uk>
+ *
+ * Based on clock-sh4.c
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+const static int pll1rate[]={1,2,3,4,6,8};
+const static int pfc_divisors[]={1,2,3,4,6,8,12};
+#define ifc_divisors pfc_divisors
+
+#if (CONFIG_SH_CLK_MD = 0)
+#define PLL2 (4)
+#elif (CONFIG_SH_CLK_MD = 2)
+#define PLL2 (2)
+#elif (CONFIG_SH_CLK_MD = 3)
+#define PLL2 (1)
+#else
+#error "Illegal Clock Mode!"
+#endif
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate = 10000000 * PLL2 * pll1rate[(ctrl_inw(FREQCR) >> 8) & 0x0007];
+}
+
+static struct clk_ops sh7201_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FREQCR) & 0x0007);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7201_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FREQCR) & 0x0007);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7201_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+  	int idx = ((ctrl_inw(FREQCR) >> 4) & 0x0007);
+  	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7201_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7201_clk_ops[] = {
+	&sh7201_master_clk_ops,
+	&sh7201_module_clk_ops,
+	&sh7201_bus_clk_ops,
+	&sh7201_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7201_clk_ops))
+		*ops = sh7201_clk_ops[idx];
+}
+
diff --git a/arch/sh/kernel/cpu/sh2a/probe.c b/arch/sh/kernel/cpu/sh2a/probe.c
index 6e79132..3976ace 100644
--- a/arch/sh/kernel/cpu/sh2a/probe.c
+++ b/arch/sh/kernel/cpu/sh2a/probe.c
@@ -18,7 +18,11 @@ int __init detect_cpu_and_cache_system(void)
  	/* All SH-2A CPUs have support for 16 and 32-bit opcodes.. */
  	boot_cpu_data.flags			|= CPU_HAS_OP32;

-#if defined(CONFIG_CPU_SUBTYPE_SH7203)
+#if defined(CONFIG_CPU_SUBTYPE_SH7201)
+	boot_cpu_data.type			= CPU_SH7201;
+	/* SH7201 has an FPU.. */
+	boot_cpu_data.flags			|= CPU_HAS_FPU;
+#elif defined(CONFIG_CPU_SUBTYPE_SH7203)
  	boot_cpu_data.type			= CPU_SH7203;
  	/* SH7203 has an FPU.. */
  	boot_cpu_data.flags			|= CPU_HAS_FPU;
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
new file mode 100644
index 0000000..a8e8e62
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -0,0 +1,331 @@
+/*
+ *  SH7201 setup
+ *
+ *  Copyright (C) 2008  Peter Griffin pgriffin@mpc-data.co.uk
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_sci.h>
+
+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
+	PINT0, PINT1, PINT2, PINT3, PINT4, PINT5, PINT6, PINT7,
+	ADC_ADI,
+	MTU2_TGI0A, MTU2_TGI0B, MTU2_TGI0C, MTU2_TGI0D,
+	MTU2_TCI0V, MTU2_TGI0E, MTU2_TGI0F,
+	MTU2_TGI1A, MTU2_TGI1B, MTU2_TCI1V, MTU2_TCI1U,
+	MTU2_TGI2A, MTU2_TGI2B, MTU2_TCI2V, MTU2_TCI2U,
+	MTU2_TGI3A, MTU2_TGI3B, MTU2_TGI3C, MTU2_TGI3D, MTU2_TCI3V,
+	MTU2_TGI4A, MTU2_TGI4B, MTU2_TGI4C, MTU2_TGI4D, MTU2_TCI4V,
+	MTU2_TGI5U, MTU2_TGI5V, MTU2_TGI5W,
+	RTC_ARM, RTC_PRD, RTC_CUP,
+	WDT,
+	IIC30_STPI, IIC30_NAKI, IIC30_RXI, IIC30_TXI, IIC30_TEI,
+	IIC31_STPI, IIC31_NAKI, IIC31_RXI, IIC31_TXI, IIC31_TEI,
+	IIC32_STPI, IIC32_NAKI, IIC32_RXI, IIC32_TXI, IIC32_TEI,
+
+	DMAC0_DMINT0, DMAC1_DMINT1,
+	DMAC2_DMINT2, DMAC3_DMINT3,
+
+	SCIF0_BRI, SCIF0_ERI, SCIF0_RXI, SCIF0_TXI,
+	SCIF1_BRI, SCIF1_ERI, SCIF1_RXI, SCIF1_TXI,
+	SCIF2_BRI, SCIF2_ERI, SCIF2_RXI, SCIF2_TXI,
+	SCIF3_BRI, SCIF3_ERI, SCIF3_RXI, SCIF3_TXI,
+	SCIF4_BRI, SCIF4_ERI, SCIF4_RXI, SCIF4_TXI,
+	SCIF5_BRI, SCIF5_ERI, SCIF5_RXI, SCIF5_TXI,
+	SCIF6_BRI, SCIF6_ERI, SCIF6_RXI, SCIF6_TXI,
+	SCIF7_BRI, SCIF7_ERI, SCIF7_RXI, SCIF7_TXI,
+
+	DMAC0_DMINTA, DMAC4_DMINT4, DMAC5_DMINT5, DMAC6_DMINT6,
+	DMAC7_DMINT7,
+
+	RCAN0_ERS, RCAN0_OVR,
+	RCAN0_SLE,
+	RCAN0_RM0, RCAN0_RM1,
+
+	RCAN1_ERS, RCAN1_OVR,
+	RCAN1_SLE,
+	RCAN1_RM0, RCAN1_RM1,
+
+	SSI0_SSII, SSI1_SSII,
+
+	TMR0_CMIA0, TMR0_CMIB0, TMR0_OVI0,
+	TMR1_CMIA1, TMR1_CMIB1, TMR1_OVI1,
+
+	/* interrupt groups */
+
+	IRQ, PINT, ADC,
+	MTU20_ABCD, MTU20_VEF, MTU21_AB, MTU21_VU, MTU22_AB, MTU22_VU,
+	MTU23_ABCD, MTU24_ABCD, MTU25_UVW,
+	RTC, IIC30, IIC31, IIC32,
+	SCIF0, SCIF1, SCIF2, SCIF3, SCIF4, SCIF5, SCIF6, SCIF7,
+	RCAN0, RCAN1, TMR0, TMR1
+
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_IRQ(IRQ0, 64), INTC_IRQ(IRQ1, 65),
+	INTC_IRQ(IRQ2, 66), INTC_IRQ(IRQ3, 67),
+	INTC_IRQ(IRQ4, 68), INTC_IRQ(IRQ5, 69),
+	INTC_IRQ(IRQ6, 70), INTC_IRQ(IRQ7, 71),
+	INTC_IRQ(PINT0, 80), INTC_IRQ(PINT1, 81),
+	INTC_IRQ(PINT2, 82), INTC_IRQ(PINT3, 83),
+	INTC_IRQ(PINT4, 84), INTC_IRQ(PINT5, 85),
+	INTC_IRQ(PINT6, 86), INTC_IRQ(PINT7, 87),
+
+	INTC_IRQ(ADC_ADI, 92),
+
+	INTC_IRQ(MTU2_TGI0A, 108), INTC_IRQ(MTU2_TGI0B, 109),
+	INTC_IRQ(MTU2_TGI0C, 110), INTC_IRQ(MTU2_TGI0D, 111),
+	INTC_IRQ(MTU2_TCI0V, 112),
+	INTC_IRQ(MTU2_TGI0E, 113), INTC_IRQ(MTU2_TGI0F, 114),
+
+	INTC_IRQ(MTU2_TGI1A, 116), INTC_IRQ(MTU2_TGI1B, 117),
+	INTC_IRQ(MTU2_TCI1V, 120), INTC_IRQ(MTU2_TCI1U, 121),
+
+	INTC_IRQ(MTU2_TGI2A, 124), INTC_IRQ(MTU2_TGI2B, 125),
+	INTC_IRQ(MTU2_TCI2V, 128), INTC_IRQ(MTU2_TCI2U, 129),
+
+	INTC_IRQ(MTU2_TGI3A, 132), INTC_IRQ(MTU2_TGI3B, 133),
+	INTC_IRQ(MTU2_TGI3C, 134), INTC_IRQ(MTU2_TGI3D, 135),
+	INTC_IRQ(MTU2_TCI3V, 136),
+
+	INTC_IRQ(MTU2_TGI4A, 140), INTC_IRQ(MTU2_TGI4B, 141),
+	INTC_IRQ(MTU2_TGI4C, 142), INTC_IRQ(MTU2_TGI4D, 143),
+	INTC_IRQ(MTU2_TCI4V, 144),
+
+	INTC_IRQ(MTU2_TGI5U, 148), INTC_IRQ(MTU2_TGI5V, 149),
+	INTC_IRQ(MTU2_TGI5W, 150),
+
+	INTC_IRQ(RTC_ARM, 152), INTC_IRQ(RTC_PRD, 153),
+	INTC_IRQ(RTC_CUP, 154), INTC_IRQ(WDT, 156),
+
+	INTC_IRQ(IIC30_STPI, 157), INTC_IRQ(IIC30_NAKI, 158),
+	INTC_IRQ(IIC30_RXI, 159), INTC_IRQ(IIC30_TXI, 160),
+	INTC_IRQ(IIC30_TEI, 161),
+
+	INTC_IRQ(IIC31_STPI, 164), INTC_IRQ(IIC31_NAKI, 165),
+	INTC_IRQ(IIC31_RXI, 166), INTC_IRQ(IIC31_TXI, 167),
+	INTC_IRQ(IIC31_TEI, 168),
+
+	INTC_IRQ(IIC32_STPI, 170), INTC_IRQ(IIC32_NAKI, 171),
+	INTC_IRQ(IIC32_RXI, 172), INTC_IRQ(IIC32_TXI, 173),
+	INTC_IRQ(IIC32_TEI, 174),
+
+	INTC_IRQ(DMAC0_DMINT0, 176), INTC_IRQ(DMAC1_DMINT1, 177),
+	INTC_IRQ(DMAC2_DMINT2, 178), INTC_IRQ(DMAC3_DMINT3, 179),
+
+	INTC_IRQ(SCIF0_BRI, 180), INTC_IRQ(SCIF0_ERI, 181),
+	INTC_IRQ(SCIF0_RXI, 182), INTC_IRQ(SCIF0_TXI, 183),
+	INTC_IRQ(SCIF1_BRI, 184), INTC_IRQ(SCIF1_ERI, 185),
+	INTC_IRQ(SCIF1_RXI, 186), INTC_IRQ(SCIF1_TXI, 187),
+	INTC_IRQ(SCIF2_BRI, 188), INTC_IRQ(SCIF2_ERI, 189),
+	INTC_IRQ(SCIF2_RXI, 190), INTC_IRQ(SCIF2_TXI, 191),
+	INTC_IRQ(SCIF3_BRI, 192), INTC_IRQ(SCIF3_ERI, 193),
+	INTC_IRQ(SCIF3_RXI, 194), INTC_IRQ(SCIF3_TXI, 195),
+	INTC_IRQ(SCIF4_BRI, 196), INTC_IRQ(SCIF4_ERI, 197),
+	INTC_IRQ(SCIF4_RXI, 198), INTC_IRQ(SCIF4_TXI, 199),
+	INTC_IRQ(SCIF5_BRI, 200), INTC_IRQ(SCIF5_ERI, 201),
+	INTC_IRQ(SCIF5_RXI, 202), INTC_IRQ(SCIF5_TXI, 203),
+	INTC_IRQ(SCIF6_BRI, 204), INTC_IRQ(SCIF6_ERI, 205),
+	INTC_IRQ(SCIF6_RXI, 206), INTC_IRQ(SCIF6_TXI, 207),
+	INTC_IRQ(SCIF7_BRI, 208), INTC_IRQ(SCIF7_ERI, 209),
+	INTC_IRQ(SCIF7_RXI, 210), INTC_IRQ(SCIF7_TXI, 211),
+
+	INTC_IRQ(DMAC0_DMINTA, 212), INTC_IRQ(DMAC4_DMINT4, 216),
+	INTC_IRQ(DMAC5_DMINT5, 217), INTC_IRQ(DMAC6_DMINT6, 218),
+	INTC_IRQ(DMAC7_DMINT7, 219),
+
+	INTC_IRQ(RCAN0_ERS, 228), INTC_IRQ(RCAN0_OVR, 229),
+	INTC_IRQ(RCAN0_SLE, 230),
+	INTC_IRQ(RCAN0_RM0, 231), INTC_IRQ(RCAN0_RM1, 232),
+
+	INTC_IRQ(RCAN1_ERS, 234), INTC_IRQ(RCAN1_OVR, 235),
+	INTC_IRQ(RCAN1_SLE, 236),
+	INTC_IRQ(RCAN1_RM0, 237), INTC_IRQ(RCAN1_RM1, 238),
+
+	INTC_IRQ(SSI0_SSII, 244), INTC_IRQ(SSI1_SSII, 245),
+
+	INTC_IRQ(TMR0_CMIA0, 246), INTC_IRQ(TMR0_CMIB0, 247),
+	INTC_IRQ(TMR0_OVI0, 248),
+
+	INTC_IRQ(TMR1_CMIA1, 252), INTC_IRQ(TMR1_CMIB1, 253),
+	INTC_IRQ(TMR1_OVI1, 254),
+
+};
+
+static struct intc_group groups[] __initdata = {
+	INTC_GROUP(PINT, PINT0, PINT1, PINT2, PINT3,
+		   PINT4, PINT5, PINT6, PINT7),
+	INTC_GROUP(MTU20_ABCD, MTU2_TGI0A, MTU2_TGI0B, MTU2_TGI0C, MTU2_TGI0D),
+	INTC_GROUP(MTU20_VEF, MTU2_TCI0V, MTU2_TGI0E, MTU2_TGI0F),
+
+	INTC_GROUP(MTU21_AB, MTU2_TGI1A, MTU2_TGI1B),
+	INTC_GROUP(MTU21_VU, MTU2_TCI1V, MTU2_TCI1U),
+	INTC_GROUP(MTU22_AB, MTU2_TGI2A, MTU2_TGI2B),
+	INTC_GROUP(MTU22_VU, MTU2_TCI2V, MTU2_TCI2U),
+	INTC_GROUP(MTU23_ABCD, MTU2_TGI3A, MTU2_TGI3B, MTU2_TGI3C, MTU2_TGI3D),
+	INTC_GROUP(MTU24_ABCD, MTU2_TGI4A, MTU2_TGI4B, MTU2_TGI4C, MTU2_TGI4D),
+	INTC_GROUP(MTU25_UVW, MTU2_TGI5U, MTU2_TGI5V, MTU2_TGI5W),
+	INTC_GROUP(RTC, RTC_ARM, RTC_PRD, RTC_CUP ),
+
+	INTC_GROUP(IIC30, IIC30_STPI, IIC30_NAKI, IIC30_RXI, IIC30_TXI,
+		   IIC30_TEI),
+	INTC_GROUP(IIC31, IIC31_STPI, IIC31_NAKI, IIC31_RXI, IIC31_TXI,
+		   IIC31_TEI),
+	INTC_GROUP(IIC32, IIC32_STPI, IIC32_NAKI, IIC32_RXI, IIC32_TXI,
+		   IIC32_TEI),
+
+	INTC_GROUP(SCIF0, SCIF0_BRI, SCIF0_ERI, SCIF0_RXI, SCIF0_TXI),
+	INTC_GROUP(SCIF1, SCIF1_BRI, SCIF1_ERI, SCIF1_RXI, SCIF1_TXI),
+	INTC_GROUP(SCIF2, SCIF2_BRI, SCIF2_ERI, SCIF2_RXI, SCIF2_TXI),
+	INTC_GROUP(SCIF3, SCIF3_BRI, SCIF3_ERI, SCIF3_RXI, SCIF3_TXI),
+	INTC_GROUP(SCIF4, SCIF4_BRI, SCIF4_ERI, SCIF4_RXI, SCIF4_TXI),
+	INTC_GROUP(SCIF5, SCIF5_BRI, SCIF5_ERI, SCIF5_RXI, SCIF5_TXI),
+	INTC_GROUP(SCIF6, SCIF6_BRI, SCIF6_ERI, SCIF6_RXI, SCIF6_TXI),
+	INTC_GROUP(SCIF7, SCIF7_BRI, SCIF7_ERI, SCIF7_RXI, SCIF7_TXI),
+
+	INTC_GROUP(RCAN0, RCAN0_ERS, RCAN0_OVR, RCAN0_RM0, RCAN0_RM1,
+		   RCAN0_SLE),
+	INTC_GROUP(RCAN1, RCAN1_ERS, RCAN1_OVR, RCAN1_RM0, RCAN1_RM1,
+		   RCAN1_SLE),
+
+	INTC_GROUP(TMR0, TMR0_CMIA0, TMR0_CMIB0, TMR0_OVI0),
+	INTC_GROUP(TMR1, TMR1_CMIA1, TMR1_CMIB1, TMR1_OVI1),
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xfffe9418, 0, 16, 4, /* IPR01 */ { IRQ0, IRQ1, IRQ2, IRQ3 } },
+	{ 0xfffe941a, 0, 16, 4, /* IPR02 */ { IRQ4, IRQ5, IRQ6, IRQ7 } },
+	{ 0xfffe9420, 0, 16, 4, /* IPR05 */ { PINT, 0, ADC_ADI, 0 } },
+	{ 0xfffe9800, 0, 16, 4, /* IPR06 */ { 0, MTU20_ABCD, MTU20_VEF, MTU21_AB } },
+	{ 0xfffe9802, 0, 16, 4, /* IPR07 */ { MTU21_VU, MTU22_AB, MTU22_VU,  MTU23_ABCD } },
+	{ 0xfffe9804, 0, 16, 4, /* IPR08 */ { MTU2_TCI3V, MTU24_ABCD, MTU2_TCI4V, MTU25_UVW } },
+
+	{ 0xfffe9806, 0, 16, 4, /* IPR09 */ { RTC, WDT, IIC30, 0 } },
+	{ 0xfffe9808, 0, 16, 4, /* IPR10 */ { IIC31, IIC32, DMAC0_DMINT0, DMAC1_DMINT1 } },
+	{ 0xfffe980a, 0, 16, 4, /* IPR11 */ { DMAC2_DMINT2, DMAC3_DMINT3, SCIF0 , SCIF1 } },
+	{ 0xfffe980c, 0, 16, 4, /* IPR12 */ { SCIF2, SCIF3, SCIF4, SCIF5 } },
+	{ 0xfffe980e, 0, 16, 4, /* IPR13 */ { SCIF6, SCIF7, DMAC0_DMINTA, DMAC4_DMINT4  } },
+	{ 0xfffe9810, 0, 16, 4, /* IPR14 */ { DMAC5_DMINT5, DMAC6_DMINT6, DMAC7_DMINT7, 0 } },
+	{ 0xfffe9812, 0, 16, 4, /* IPR15 */ { 0, RCAN0, RCAN1, 0 } },
+	{ 0xfffe9814, 0, 16, 4, /* IPR16 */ { SSI0_SSII, SSI1_SSII, TMR0, TMR1 } },
+};
+
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{ 0xfffe9408, 0, 16, /* PINTER */
+	  { 0, 0, 0, 0, 0, 0, 0, 0,
+	    PINT7, PINT6, PINT5, PINT4, PINT3, PINT2, PINT1, PINT0 } },
+};
+
+static DECLARE_INTC_DESC(intc_desc, "sh7201", vectors, groups,
+			 mask_registers, prio_registers, NULL);
+
+static struct plat_sci_port sci_platform_data[] = {
+	{
+		.mapbase	= 0xfffe8000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 181, 182, 183, 180}
+	}, {
+		.mapbase	= 0xfffe8800,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 185, 186, 187, 184}
+	}, {
+		.mapbase	= 0xfffe9000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 189, 186, 187, 188}
+	}, {
+		.mapbase	= 0xfffe9800,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 193, 194, 195, 192}
+	}, {
+		.mapbase	= 0xfffea000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 196, 198, 199, 196}
+	}, {
+		.mapbase	= 0xfffea800,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 201, 202, 203, 200}
+	}, {
+		.mapbase	= 0xfffeb000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 205, 206, 207, 204}
+	}, {
+		.mapbase	= 0xfffeb800,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 209, 210, 211, 208}
+	}, {
+		.flags = 0,
+	}
+};
+
+static struct platform_device sci_device = {
+	.name		= "sh-sci",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= sci_platform_data,
+	},
+};
+
+static struct resource rtc_resources[] = {
+	[0] = {
+		.start	= 0xffff0800,
+		.end	= 0xffff2000 + 0x58 - 1,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		/* Period IRQ */
+		.start	= 153,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* Carry IRQ */
+		.start	= 154,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		/* Alarm IRQ */
+		.start	= 152,
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
+static struct platform_device *sh7201_devices[] __initdata = {
+	&sci_device,
+	&rtc_device,
+};
+
+static int __init sh7201_devices_setup(void)
+{
+	return platform_add_devices(sh7201_devices,
+				    ARRAY_SIZE(sh7201_devices));
+}
+__initcall(sh7201_devices_setup);
+
+void __init plat_irq_setup(void)
+{
+	register_intc_controller(&intc_desc);
+}
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index e7152cc..70fe51b 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -417,6 +419,7 @@ void __init setup_arch(char **cmdline_p)
  }

  static const char *cpu_name[] = {
+ 	[CPU_SH7201]	= "SH7201",
  	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
  	[CPU_SH7206]	= "SH7206",	[CPU_SH7619]	= "SH7619",
  	[CPU_SH7705]	= "SH7705",	[CPU_SH7706]	= "SH7706",
diff --git a/arch/sh/kernel/timers/timer-mtu2.c b/arch/sh/kernel/timers/timer-mtu2.c
index fe453c0..40936ca 100644
--- a/arch/sh/kernel/timers/timer-mtu2.c
+++ b/arch/sh/kernel/timers/timer-mtu2.c
@@ -34,7 +34,12 @@
  #define MTU2_TIER_1	0xfffe4384
  #define MTU2_TSR_1	0xfffe4385
  #define MTU2_TCNT_1	0xfffe4386	/* 16-bit counter */
+
+#if defined (CONFIG_CPU_SUBTYPE_SH7201)
+#define MTU2_TGRA_1	0xfffe4388
+#else
  #define MTU2_TGRA_1	0xfffe438a
+#endif

  #define STBCR3		0xfffe0408

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 9f33b06..387b070 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -135,11 +135,18 @@
  # define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
  #elif defined(CONFIG_CPU_SUBTYPE_SH7203) || \
        defined(CONFIG_CPU_SUBTYPE_SH7206) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7263)
+      defined(CONFIG_CPU_SUBTYPE_SH7263) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7201)
  # define SCSPTR0 0xfffe8020 /* 16 bit SCIF */
  # define SCSPTR1 0xfffe8820 /* 16 bit SCIF */
  # define SCSPTR2 0xfffe9020 /* 16 bit SCIF */
  # define SCSPTR3 0xfffe9820 /* 16 bit SCIF */
+#if defined(CONFIG_CPU_SUBTYPE_SH7201)
+# define SCSPTR4 0xfffeA020 /* 16 bit SCIF */
+# define SCSPTR5 0xfffeA820 /* 16 bit SCIF */
+# define SCSPTR6 0xfffeB020 /* 16 bit SCIF */
+# define SCSPTR7 0xfffeB820 /* 16 bit SCIF */
+#endif
  # define SCSCR_INIT(port)	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
  #elif defined(CONFIG_CPU_SUBTYPE_SH7619)
  # define SCSPTR0 0xf8400020 /* 16 bit SCIF */
@@ -666,7 +673,8 @@ static inline int sci_rxd_in(struct uart_port *port)
  }
  #elif defined(CONFIG_CPU_SUBTYPE_SH7203) || \
        defined(CONFIG_CPU_SUBTYPE_SH7206) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7263)
+      defined(CONFIG_CPU_SUBTYPE_SH7263) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7201)
  static inline int sci_rxd_in(struct uart_port *port)
  {
  	if (port->mapbase = 0xfffe8000)
@@ -677,6 +685,16 @@ static inline int sci_rxd_in(struct uart_port *port)
  		return ctrl_inw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
  	if (port->mapbase = 0xfffe9800)
  		return ctrl_inw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
+#if defined(CONFIG_CPU_SUBTYPE_SH7201)
+	if (port->mapbase = 0xfffeA000)
+		return ctrl_inw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase = 0xfffeA800)
+		return ctrl_inw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase = 0xfffeB000)
+		return ctrl_inw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase = 0xfffeB800)
+		return ctrl_inw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
+#endif
  	return 1;
  }
  #elif defined(CONFIG_CPU_SUBTYPE_SH7619)
