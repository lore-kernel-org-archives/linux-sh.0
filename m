From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Jun 2013 09:59:35 +0000
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v1 (CA15 x 4)
Message-Id: <20130612100702.6320.35059.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SMP prototype support for r8a7790 by enabling
4 x Cortex-A15. This patch only adds support for
booting, at this point no CPU Hotplug is included.

Needs a rewrite to support more generic handling of
CPU core power domains. Not ready for merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Developed and tested on top of v3.10-rc5 and
 [PATCH 01/05] ARM: shmobile: r8a73a4 SMP prototype v1 (CA15 x 4)

 arch/arm/boot/dts/r8a7790.dtsi                |   21 +++++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/board-lager.c          |    1 
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
 arch/arm/mach-shmobile/setup-r8a7790.c        |    1 
 arch/arm/mach-shmobile/smp-r8a7790.c          |  100 +++++++++++++++++++++++++
 6 files changed, 125 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-06-12 12:36:17.000000000 +0900
@@ -24,6 +24,27 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
 	};
 
 	gic: interrupt-controller@f1001000 {
--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-06-12 12:36:17.000000000 +0900
@@ -20,6 +20,7 @@ smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
 smp-$(CONFIG_ARCH_R8A73A4)	+= smp-r8a73a4.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
+smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
 # IRQ objects
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-06-12 12:36:17.000000000 +0900
@@ -39,6 +39,7 @@ static const char *lager_boards_compat_d
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
+	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-06-12 12:36:17.000000000 +0900
@@ -5,5 +5,6 @@ void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_timer_init(void);
+extern struct smp_operations r8a7790_smp_ops;
 
 #endif /* __ASM_R8A7790_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-06-12 12:36:17.000000000 +0900
@@ -142,6 +142,7 @@ static const char *r8a7790_boards_compat
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2013-06-12 13:10:08.000000000 +0900
@@ -0,0 +1,100 @@
+/*
+ * SMP support for r8a7790
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
+#include <asm/cacheflush.h>
+#include <asm/io.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+
+#define SYSC	0xe6180000
+#define SYSCSR  0x0000
+
+#define RST	0xe6160000
+#define CA15BAR	0x6020
+#define CA15RESCNT 0x0040
+#define RESCNT	0x0050
+
+#define APMU	0xe6150000
+#define CA15WUPCR 0x2010
+
+#define MERAM	0xe8080000
+
+static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
+{
+	u32 bar;
+	void __iomem *p;
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, 16);
+	memcpy(p, shmobile_secondary_vector, 16);
+	iounmap(p);
+
+	flush_cache_louis();
+
+	/* setup reset vector and disable reset */
+	p = ioremap_nocache(RST, 0x7000);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	__raw_writel(bar, p + CA15BAR);
+	__raw_writel(bar | 0x10, p + CA15BAR);
+	__raw_writel(__raw_readl(p + RESCNT) & ~(1 << 1), p + RESCNT);
+	iounmap(p);
+}
+
+static int __cpuinit r8a7790_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	void __iomem *p, *p2, *p3;
+	int bit;
+
+	/* wake up CPU core via APMU */
+	p = ioremap_nocache(APMU, 0x3000);
+	__raw_writel(1 << (cpu_logical_map(cpu) & 3), p + CA15WUPCR);
+
+	/* wait for SYSC to finish wake up sequence */
+	p2 = ioremap_nocache(SYSC, 0x1000);
+	while ((__raw_readl(p2 + SYSCSR) & 0x3) != 0x3)
+		;
+
+	/* wait for APMU to finish */
+	while (__raw_readl(p + CA15WUPCR) != 0)
+		;
+
+	/* deassert reset for CPU core via RST */
+	p3 = ioremap_nocache(RST, 0x7000);
+	bit = 3 - (cpu_logical_map(cpu) & 3);
+	__raw_writel((__raw_readl(p3 + CA15RESCNT) & ~BIT(bit)) | 0xa5a50000,
+		     p3 + CA15RESCNT);
+
+	iounmap(p3);
+	iounmap(p2);
+	iounmap(p);
+	return 0;
+}
+
+struct smp_operations r8a7790_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
+	.smp_boot_secondary	= r8a7790_boot_secondary,
+};
