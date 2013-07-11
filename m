From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:32:59 +0000
Subject: [PATCH 09/11] ARM: shmobile: bockw: add DT reference
Message-Id: <87a9ltfqdj.wl%kuninori.morimoto.gx@renesas.com>
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

Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   32 ++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   14 ++++++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/Makefile.boot           |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c |   62 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c         |    7 ++-
 8 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e129d81..ae017fe 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -163,6 +163,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	emev2-kzm9d-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
+	r8a7778-bockw-reference.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7790-lager.dtb \
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
new file mode 100644
index 0000000..f5b8d77
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
+	compatible = "renesas,bockw-reference", "renesas,r8a7778";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 ignore_loglevel";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x10000000>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 5ae27f2..e6c610a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -138,6 +138,20 @@ config MACH_BOCKW
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
index 424ac39..b44a49f 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
+obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 761d7b1..9c9b441 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -6,6 +6,7 @@ loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
+loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
new file mode 100644
index 0000000..24db8de
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -0,0 +1,62 @@
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
+/*
+ *	see board-bock.c for checking detail of dip-switch
+ */
+
+static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* SCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_data_a", "scif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_ctrl", "scif0"),
+};
+
+static void __init bockw_init(void)
+{
+	r8a7778_clock_init();
+
+	pinctrl_register_mappings(bockw_pinctrl_map,
+				  ARRAY_SIZE(bockw_pinctrl_map));
+	r8a7778_pinmux_init();
+	r8a7778_add_dt_devices();
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
index b9dda26..7527e27 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,6 +20,7 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
+extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b77ebab..737dc02 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -267,7 +267,7 @@ void __init r8a7778_register_hspi(int id)
 		hspi_resources + (2 * id), 2);
 }
 
-void __init r8a7778_add_standard_devices(void)
+void __init r8a7778_add_dt_devices(void)
 {
 	int i;
 
@@ -289,6 +289,11 @@ void __init r8a7778_add_standard_devices(void)
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
+}
+
+void __init r8a7778_add_standard_devices(void)
+{
+	r8a7778_add_dt_devices();
 	r8a7778_register_i2c(0);
 	r8a7778_register_i2c(1);
 	r8a7778_register_i2c(2);
-- 
1.7.9.5

