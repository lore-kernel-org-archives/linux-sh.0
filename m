From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 08:32:11 +0000
Subject: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a sample DT-based Bock-W "reference" implementation.
The use of platform-specific C-code should be avoided
with this configuration as much as possible.

This patch adds new r8a7778_add_dt_devices() which was same stance
of r8a7790_add_dt_devices()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   52 +++++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   14 +++++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/Makefile.boot           |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c |   80 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c         |    7 ++-
 8 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f2dc697..fd83b1a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -162,6 +162,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
+	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
new file mode 100644
index 0000000..a04508c
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -0,0 +1,52 @@
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
+		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x10000000>;
+	};
+
+	fixedregulator3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan0@18000000 {
+		compatible = "smsc,lan9115";
+		reg = <0x18300000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&gic>;
+		interrupts = <0 (0x3b - 32) 0x4>; /* gic iid of IRQ0 */
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 90f449e..e5c2d35 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -127,6 +127,20 @@ config MACH_BOCKW
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
+config MACH_BOCKW_REFERENCE
+	bool "BOCK-W  - Reference Device Tree Implementation"
+	depends on ARCH_R8A7778
+	select ARCH_REQUIRE_GPIOLIB
+	select RENESAS_INTC_IRQPIN
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
+	---help---
+	   Use reference implementation of BockW board support
+	   which makes use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d813133..9c40be8 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
+obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 16834d8..6f47b98 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -5,6 +5,7 @@ loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
+loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
new file mode 100644
index 0000000..ea25067
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
+#include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
+#include <mach/common.h>
+#include <mach/r8a7778.h>
+#include <asm/mach/arch.h>
+
+/*	see board-bock.c for dip-switch explain */
+
+static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* SCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_data_a", "scif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_ctrl", "scif0"),
+};
+
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+static void __init bockw_init(void)
+{
+	void __iomem *base;
+
+	r8a7778_clock_init();
+
+	pinctrl_register_mappings(bockw_pinctrl_map,
+				  ARRAY_SIZE(bockw_pinctrl_map));
+	r8a7778_pinmux_init();
+	r8a7778_add_dt_devices();
+
+	/* for SMSC */
+	base = ioremap_nocache(FPGA, SZ_1M);
+	if (base) {
+		/*
+		 * CAUTION
+		 *
+		 * IRQ0/1 is cascaded interrupt from FPGA.
+		 * it should be cared in the future
+		 * Now, it is assuming IRQ0 was used only from SMSC.
+		 */
+		u16 val = ioread16(base + IRQ0MR);
+		val &= ~(1 << 4); /* enable SMSC911x */
+		iowrite16(val, base + IRQ0MR);
+		iounmap(base);
+	}
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *bockw_boards_compat_dt[] __initdata = {
+	"renesas,bockw-reference",
+	NULL,
+};
+
+DT_MACHINE_START(BOCKW_DT, "bockw")
+	.init_early	= r8a7778_init_delay,
+	.init_irq	= r8a7778_init_irq_dt,
+	.init_machine	= bockw_init,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= bockw_boards_compat_dt,
+MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index f9012c6..391d13118 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -26,6 +26,7 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
+extern void r8a7778_add_dt_devices(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 0d07b82..b011f69 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -392,7 +392,7 @@ void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
 		info, sizeof(*info));
 }
 
-void __init r8a7778_add_standard_devices(void)
+void __init r8a7778_add_dt_devices(void)
 {
 	int i;
 
@@ -416,6 +416,11 @@ void __init r8a7778_add_standard_devices(void)
 	r8a7778_register_tmu(1);
 }
 
+void __init r8a7778_add_standard_devices(void)
+{
+	r8a7778_add_dt_devices();
+}
+
 static struct renesas_intc_irqpin_config irqpin_platform_data __initdata = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 	.sense_bitfield_width = 2,
-- 
1.7.9.5

