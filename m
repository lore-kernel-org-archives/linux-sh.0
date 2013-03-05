From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Mar 2013 06:47:04 +0000
Subject: [PATCH 2/2] ARM: shmobile: bockw: Reference DT implementation
Message-Id: <87ppzemjh7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Provide board code for the bockw to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   32 ++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                 |   35 +++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   12 ++++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c |   80 ++++++++++++++++++++++++
 6 files changed, 161 insertions(+)
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
index 0000000..fb1550e
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -0,0 +1,32 @@
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
+	compatible = "renesas,bockw-reference";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 earlyprintk=sh-sci.0,115200 ignore_loglevel root=/dev/nfs ip=dhcp";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x10000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
new file mode 100644
index 0000000..4743735
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
+	gic: interrupt-controller@fe438000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xfe438000 0x1000>,
+		      <0xfe430000 0x100>;
+	};
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
index 0000000..ca86885
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -0,0 +1,80 @@
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
-- 
1.7.9.5

