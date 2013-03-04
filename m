From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:22:04 +0000
Subject: [RFC][PATCH] ARM: shmobile: bockw: Reference DT implementation
Message-Id: <87ppzfpr3b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


I'm trying to support R-Car M1 Bock-W DT, but it still doesn't work.
(There is no output when I boot it)
Your feedback is very helpful for me...


Provide alternate board code for the bockw to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   41 +++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                 |   35 +++++++++
 arch/arm/mach-shmobile/Kconfig                 |   12 +++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c |   93 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h   |    3 +
 arch/arm/mach-shmobile/intc-r8a7778.c          |   27 +++++--
 arch/arm/mach-shmobile/setup-r8a7778.c         |   49 +++++++++++--
 9 files changed, 251 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 create mode 100644 arch/arm/boot/dts/r8a7778.dtsi
 create mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b284b22..c394957 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -122,6 +122,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	ccu9540.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
new file mode 100644
index 0000000..5045ce491
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -0,0 +1,41 @@
+/*
+ * Reference Device Tree Source for the Bock-W board
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on r8a7779
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7778.dtsi"
+
+/ {
+	model = "bockw";
+	compatible = "renesas,bockw-reference", "renesas,r8a7778";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 earlyprintk=sh-sci.0,115200 ignore_loglevel root=/dev/nfs ip=on";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	lan0@18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18300000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&gic>;
+		interrupts = <0 0x3b 0x4>;
+		reg-io-width = <4>;
+	};
+};
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
new file mode 100644
index 0000000..f8f5781
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -0,0 +1,35 @@
+/*
+ * Device Tree Source for Renesas r8a7778
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on r8a7779
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,r8a7778";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+        gic: interrupt-controller@fe438000 {
+                compatible = "arm,cortex-a9-gic";
+                #interrupt-cells = <3>;
+                interrupt-controller;
+                reg = <0xfe438000 0x1000>,
+                      <0xfe430000 0x100>;
+        };
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 84696c4..21e6519 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -108,6 +108,18 @@ config MACH_BOCKW
 	select ARCH_REQUIRE_GPIOLIB
 	help
 
+config MACH_BOCKW_REFERENCE
+	bool "BOCK-W platform - Reference Device Tree Implementation"
+	depends on ARCH_R8A7778
+	select ARCH_REQUIRE_GPIOLIB
+	select USE_OF
+	---help---
+	   Use reference implementation of Bock-W board support
+	   which makes use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 8f33255..9844be7 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
+obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
new file mode 100644
index 0000000..74f164e
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -0,0 +1,93 @@
+/*
+ * Bock-W board support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <mach/r8a7778.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+/* FPGA is mapped to 0xe0000000 */
+#define FPGA(x) (((x) & 0x0FFFFFFF) + 0xe0000000)
+
+static struct map_desc bockw_io_desc[] __initdata = {
+	/* FPGA / AREA0 from 0x18200000 */
+	{
+		.virtual	= FPGA(0x18200000),
+		.pfn		= __phys_to_pfn(0x18200000),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+static void __init bockw_map_io(void)
+{
+	iotable_init(bockw_io_desc, ARRAY_SIZE(bockw_io_desc));
+
+	r8a7778_map_io();
+}
+
+#define IRQ0MR		IOMEM(FPGA(0x18200030))
+static void __init bockw_init(void)
+{
+	u16 val;
+
+	r8a7778_pinmux_init();
+
+	/* SCIF 0 */
+	gpio_request(GPIO_FN_SCIF_CLK,	NULL);
+	gpio_request(GPIO_FN_TX0_A,	NULL);
+	gpio_request(GPIO_FN_RX0_A,	NULL);
+	gpio_request(GPIO_FN_RTS0_A,	NULL);
+	gpio_request(GPIO_FN_CTS0_A,	NULL);
+
+	/*
+	 * CAUTION
+	 *
+	 * IRQ0/1 is cascaded interrupt from FPGA.
+	 * it should be cared in the future
+	 * Now, it is assuming IRQ0 was used only from SMSC.
+	 */
+
+	/* interrupt mask on IRQ0 */
+	val = ioread16(IRQ0MR);
+	val &= ~(1 << 4); /* enable SMSC911x */
+	iowrite16(val, IRQ0MR);
+
+	r8a7778_add_standard_devices_dt();
+}
+
+static const char *bockw_boards_compat_dt[] __initdata = {
+	"renesas,bockw-reference",
+	NULL,
+};
+
+DT_MACHINE_START(BOCKW, "bockw")
+	.map_io		= bockw_map_io,
+	.init_early	= r8a7778_init_delay,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7778_init_irq_dt,
+	.init_machine	= bockw_init,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= bockw_boards_compat_dt,
+MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 90427a8..2cf3ef3 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -61,9 +61,12 @@ extern void r8a7740_pm_init(void);
 extern void r8a7778_add_early_devices(void);
 extern void r8a7778_earlytimer_init(void);
 extern void r8a7778_add_standard_devices(void);
+extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_map_io(void);
 extern void r8a7778_clock_init(void);
+extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
+extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_pinmux_init(void);
 
 extern void r8a7779_init_delay(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7778.c b/arch/arm/mach-shmobile/intc-r8a7778.c
index afe9197..f40f8e0 100644
--- a/arch/arm/mach-shmobile/intc-r8a7778.c
+++ b/arch/arm/mach-shmobile/intc-r8a7778.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/intc.h>
@@ -45,13 +46,8 @@ static int r8a7778_set_wake(struct irq_data *data, unsigned int on)
 	return 0; /* always allow wakeup */
 }
 
-void __init r8a7778_init_irq(void)
+static void __init r8a7778_init_irq_common(void)
 {
-	void __iomem *gic_dist_base = IOMEM(0xfe438000);
-	void __iomem *gic_cpu_base = IOMEM(0xfe430000);
-
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 	gic_arch_extn.irq_set_wake = r8a7778_set_wake;
 
 	/* route all interrupts to ARM */
@@ -62,3 +58,22 @@ void __init r8a7778_init_irq(void)
 	__raw_writel(0x08330773, INT2SMSKCR0);
 	__raw_writel(0x00311110, INT2SMSKCR1);
 }
+
+void __init r8a7778_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xfe438000);
+	void __iomem *gic_cpu_base = IOMEM(0xfe430000);
+
+	/* use GIC to handle interrupts */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	r8a7778_init_irq_common();
+}
+
+#ifdef CONFIG_OF
+void __init r8a7778_init_irq_dt(void)
+{
+	irqchip_init();
+	r8a7778_init_irq_common();
+}
+#endif
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index f5a04f1..12db0c9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -26,6 +26,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -253,7 +255,7 @@ static struct platform_device tmu01_device = {
 	.num_resources	= ARRAY_SIZE(tmu01_resources),
 };
 
-static struct platform_device *r8a7778_early_devices[] __initdata = {
+static struct platform_device *r8a7778_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -274,8 +276,8 @@ void __init r8a7778_add_standard_devices(void)
 	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
 #endif
 
-	platform_add_devices(r8a7778_early_devices,
-			    ARRAY_SIZE(r8a7778_early_devices));
+	platform_add_devices(r8a7778_devices_dt,
+			     ARRAY_SIZE(r8a7778_devices_dt));
 	platform_add_devices(r8a7778_late_devices,
 			    ARRAY_SIZE(r8a7778_late_devices));
 }
@@ -288,8 +290,8 @@ void __init r8a7778_earlytimer_init(void)
 
 void __init r8a7778_add_early_devices(void)
 {
-	early_platform_add_devices(r8a7778_early_devices,
-				   ARRAY_SIZE(r8a7778_early_devices));
+	early_platform_add_devices(r8a7778_devices_dt,
+				   ARRAY_SIZE(r8a7778_devices_dt));
 
 	/* Early serial console setup is not included here due to
 	 * memory map collisions. The SCIF serial ports in r8a7778
@@ -307,3 +309,40 @@ void __init r8a7778_add_early_devices(void)
 	 * command line in case of the board.
 	 */
 }
+
+#ifdef CONFIG_USE_OF
+void __init r8a7778_init_delay(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+}
+
+static const struct of_dev_auxdata r8a7778_auxdata_lookup[] __initconst = {
+	{},
+};
+
+void __init r8a7778_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	r8a7778_clock_init();
+
+	platform_add_devices(r8a7778_devices_dt,
+			     ARRAY_SIZE(r8a7778_devices_dt));
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     r8a7778_auxdata_lookup, NULL);
+}
+
+static const char *r8a7778_compat_dt[] __initdata = {
+	"renesas,r8a7778",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
+	.map_io		= r8a7778_map_io,
+	.init_early	= r8a7778_init_delay,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7778_init_irq_dt,
+	.init_machine	= r8a7778_add_standard_devices_dt,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= r8a7778_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
1.7.9.5

