From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:36:12 +0000
Subject: [PATCH 01/05] ARM: mach-shmobile: r8a7779 and Marzen base support V2
Message-Id: <20111213163612.4096.87480.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Initial support for the r8a7779 SoC and the Marzen board (V2).

Only SCIF ports and the TMU are supported at this point.

To keep things simple only entity-mapped virt-to-phys mappings
are supported. This forces drivers and other SoC glue code to
make use of ioremap(). We cannot support early serial console
due to virtual address space collisions with the ARM kernel.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Nothing, just dropped prototype status.

 arch/arm/mach-shmobile/Kconfig                |   10 +
 arch/arm/mach-shmobile/Makefile               |    3 
 arch/arm/mach-shmobile/board-marzen.c         |  110 +++++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |  105 +++++++++++
 arch/arm/mach-shmobile/include/mach/common.h  |    5 
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    6 
 arch/arm/mach-shmobile/intc-r8a7779.c         |   58 ++++++
 arch/arm/mach-shmobile/setup-r8a7779.c        |  231 +++++++++++++++++++++++++
 8 files changed, 528 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2011-12-07 00:36:10.000000000 +0900
@@ -28,6 +28,12 @@ config ARCH_SH73A0
 	select ARM_GIC
 	select I2C
 
+config ARCH_R8A7779
+	bool "R-Car H1 (R8A77790)"
+	select CPU_V7
+	select SH_CLK_CPG
+	select ARM_GIC
+
 comment "SH-Mobile Board Type"
 
 config MACH_G3EVM
@@ -75,6 +81,10 @@ config MACH_KOTA2
 	select ARCH_REQUIRE_GPIOLIB
 	depends on ARCH_SH73A0
 
+config MACH_MARZEN
+	bool "MARZEN board"
+	depends on ARCH_R8A7779
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-12-07 00:37:58.000000000 +0900
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SH7367)	+= setup-sh736
 obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7377.o intc-sh7377.o
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
+obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o
 
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_ARCH_SH7367)	+= entry-intc.
 obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
+obj-$(CONFIG_ARCH_R8A7779)	+= entry-gic.o intc-r8a7779.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
@@ -42,6 +44,7 @@ obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4ev
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
+obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-marzen.c	2011-12-07 00:36:11.000000000 +0900
@@ -0,0 +1,110 @@
+/*
+ * marzen board support
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <mach/hardware.h>
+#include <mach/r8a7779.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
+#include <asm/traps.h>
+
+static struct platform_device *marzen_devices[] __initdata = {
+};
+
+static struct map_desc marzen_io_desc[] __initdata = {
+	/* 2M entity map for 0xf0000000 (MPCORE) */
+	{
+		.virtual	= 0xf0000000,
+		.pfn		= __phys_to_pfn(0xf0000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
+	{
+		.virtual	= 0xfe000000,
+		.pfn		= __phys_to_pfn(0xfe000000),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+static void __init marzen_map_io(void)
+{
+	iotable_init(marzen_io_desc, ARRAY_SIZE(marzen_io_desc));
+}
+
+static void __init marzen_init_early(void)
+{
+	r8a7779_add_early_devices();
+
+	/* Early serial console setup is not included here due to
+	 * memory map collisions. The SCIF serial ports in r8a7779
+	 * are difficult to entity map 1:1 due to collision with the
+	 * virtual memory range used by the coherent DMA code on ARM.
+	 *
+	 * Anyone wanting to debug early can remove UPF_IOREMAP from
+	 * the sh-sci serial console platform data, adjust mapbase
+	 * to a static M:N virt:phys mapping that needs to be added to
+	 * the mappings passed with iotable_init() above.
+	 *
+	 * Then add a call to shmobile_setup_console() from this function.
+	 *
+	 * As a final step pass earlyprint=sh-sci.2,115200 on the kernel
+	 * command line.
+	 */
+}
+
+static void __init marzen_init(void)
+{
+	r8a7779_add_standard_devices();
+	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
+}
+
+static void __init marzen_timer_init(void)
+{
+	r8a7779_clock_init();
+	shmobile_timer.init();
+	return;
+}
+
+struct sys_timer marzen_timer = {
+	.init	= marzen_timer_init,
+};
+
+MACHINE_START(MARZEN, "marzen")
+	.map_io		= marzen_map_io,
+	.init_early	= marzen_init_early,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7779_init_irq,
+	.handle_irq	= shmobile_handle_irq_gic,
+	.init_machine	= marzen_init,
+	.timer		= &marzen_timer,
+MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2011-12-07 00:36:11.000000000 +0900
@@ -0,0 +1,105 @@
+/*
+ * r8a7779 clock framework support
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
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
+#include <linux/clkdev.h>
+#include <mach/common.h>
+
+#define FRQMR   0xffc80014
+#define MSTPCR0 0xffc80030
+#define MSTPCR1 0xffc80034
+#define MSTPCR3 0xffc8003c
+#define MSTPSR1 0xffc80044
+#define MSTPSR4 0xffc80048
+#define MSTPSR6 0xffc8004c
+#define MSTPCR4 0xffc80050
+#define MSTPCR5 0xffc80054
+#define MSTPCR6 0xffc80058
+#define MSTPCR7 0xffc80040
+
+/* ioremap() through clock mapping mandatory to avoid
+ * collision with ARM coherent DMA virtual memory range.
+ */
+
+static struct clk_mapping cpg_mapping = {
+	.phys	= 0xffc80000,
+	.len	= 0x80,
+};
+
+static struct clk clkp = {
+	.rate	= 62500000, /* FIXME: shortcut */
+	.flags	= CLK_ENABLE_ON_INIT,
+	.mapping = &cpg_mapping,
+};
+
+static struct clk *main_clks[] = {
+	&clkp,
+};
+
+enum { MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
+	MSTP016, MSTP015, MSTP014,
+	MSTP_NR };
+
+#define MSTP(_parent, _reg, _bit, _flags) \
+	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP026] = MSTP(&clkp, MSTPCR0, 26, 0), /* SCIF0 */
+	[MSTP025] = MSTP(&clkp, MSTPCR0, 25, 0), /* SCIF1 */
+	[MSTP024] = MSTP(&clkp, MSTPCR0, 24, 0), /* SCIF2 */
+	[MSTP023] = MSTP(&clkp, MSTPCR0, 23, 0), /* SCIF3 */
+	[MSTP022] = MSTP(&clkp, MSTPCR0, 22, 0), /* SCIF4 */
+	[MSTP021] = MSTP(&clkp, MSTPCR0, 21, 0), /* SCIF5 */
+	[MSTP016] = MSTP(&clkp, MSTPCR0, 16, 0), /* TMU0 */
+	[MSTP015] = MSTP(&clkp, MSTPCR0, 15, 0), /* TMU1 */
+	[MSTP014] = MSTP(&clkp, MSTPCR0, 14, 0), /* TMU2 */
+};
+
+static struct clk_lookup lookups[] = {
+	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
+	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+};
+
+void __init r8a7779_clock_init(void)
+{
+	int k, ret = 0;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup r8a7779 clocks\n");
+}
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-12-07 00:36:10.000000000 +0900
@@ -53,4 +53,9 @@ extern void sh73a0_secondary_init(unsign
 extern int sh73a0_boot_secondary(unsigned int cpu);
 extern void sh73a0_smp_prepare_cpus(void);
 
+extern void r8a7779_init_irq(void);
+extern void r8a7779_add_early_devices(void);
+extern void r8a7779_add_standard_devices(void);
+extern void r8a7779_clock_init(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
--- /dev/null
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2011-12-07 00:36:11.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_R8A7779_H__
+#define __ASM_R8A7779_H__
+
+/* Nothing at this point */
+
+#endif /* __ASM_R8A7779_H__ */
--- /dev/null
+++ work/arch/arm/mach-shmobile/intc-r8a7779.c	2011-12-07 00:36:11.000000000 +0900
@@ -0,0 +1,58 @@
+/*
+ * r8a7779 processor support - INTC hardware block
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <mach/common.h>
+#include <mach/intc.h>
+#include <mach/r8a7779.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#define INT2SMSKCR0 0xfe7822a0
+#define INT2SMSKCR1 0xfe7822a4
+#define INT2SMSKCR2 0xfe7822a8
+#define INT2SMSKCR3 0xfe7822ac
+#define INT2SMSKCR4 0xfe7822b0
+
+static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
+{
+	return 0; /* always allow wakeup */
+}
+
+void __init r8a7779_init_irq(void)
+{
+	void __iomem *gic_dist_base = __io(0xf0001000);
+	void __iomem *gic_cpu_base = __io(0xf0000100);
+
+	/* use GIC to handle interrupts */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
+
+	/* unmask all known interrupts in INTCS2 */
+	__raw_writel(0xfffffff0, INT2SMSKCR0);
+	__raw_writel(0xfff7ffff, INT2SMSKCR1);
+	__raw_writel(0xfffbffdf, INT2SMSKCR2);
+	__raw_writel(0xbffffffc, INT2SMSKCR3);
+	__raw_writel(0x003fee3f, INT2SMSKCR4);
+}
--- /dev/null
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2011-12-07 00:36:11.000000000 +0900
@@ -0,0 +1,231 @@
+/*
+ * r8a7779 processor support
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_intc.h>
+#include <linux/sh_timer.h>
+#include <mach/hardware.h>
+#include <mach/r8a7779.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe40000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(88), gic_spi(88),
+			    gic_spi(88), gic_spi(88) },
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
+	.mapbase	= 0xffe41000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(89), gic_spi(89),
+			    gic_spi(89), gic_spi(89) },
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
+	.mapbase	= 0xffe42000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(90), gic_spi(90),
+			    gic_spi(90), gic_spi(90) },
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
+	.mapbase	= 0xffe43000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(91), gic_spi(91),
+			    gic_spi(91), gic_spi(91) },
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
+	.mapbase	= 0xffe44000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(92), gic_spi(92),
+			    gic_spi(92), gic_spi(92) },
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
+	.mapbase	= 0xffe45000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= { gic_spi(93), gic_spi(93),
+			    gic_spi(93), gic_spi(93) },
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
+/* TMU */
+static struct sh_timer_config tmu00_platform_data = {
+	.name = "TMU00",
+	.channel_offset = 0x4,
+	.timer_bit = 0,
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu00_resources[] = {
+	[0] = {
+		.name	= "TMU00",
+		.start	= 0xffd80008,
+		.end	= 0xffd80013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(32),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu00_device = {
+	.name		= "sh_tmu",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tmu00_platform_data,
+	},
+	.resource	= tmu00_resources,
+	.num_resources	= ARRAY_SIZE(tmu00_resources),
+};
+
+static struct sh_timer_config tmu01_platform_data = {
+	.name = "TMU01",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu01_resources[] = {
+	[0] = {
+		.name	= "TMU01",
+		.start	= 0xffd80014,
+		.end	= 0xffd8001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(33),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu01_device = {
+	.name		= "sh_tmu",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &tmu01_platform_data,
+	},
+	.resource	= tmu01_resources,
+	.num_resources	= ARRAY_SIZE(tmu01_resources),
+};
+
+static struct platform_device *r8a7779_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&tmu00_device,
+	&tmu01_device,
+};
+
+static struct platform_device *r8a7779_late_devices[] __initdata = {
+};
+
+void __init r8a7779_add_standard_devices(void)
+{
+	platform_add_devices(r8a7779_early_devices,
+			    ARRAY_SIZE(r8a7779_early_devices));
+	platform_add_devices(r8a7779_late_devices,
+			    ARRAY_SIZE(r8a7779_late_devices));
+}
+
+void __init r8a7779_add_early_devices(void)
+{
+	early_platform_add_devices(r8a7779_early_devices,
+				   ARRAY_SIZE(r8a7779_early_devices));
+}
