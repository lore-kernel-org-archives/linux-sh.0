From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 16:04:57 +0000
Subject: [PATCH v3 1/2] ARM: shmobile: ape6evm: add DT reference
Message-Id: <1373299498-10044-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a sample DT-based APE6EVM "reference" implementation. The
use of platform-specific C-code should be avoided with this configuration
as much as possible.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: (former "PATCH v2 2/4")
1. same function name "r8a73a4_add_dt_devices()"
2. preserve device registration order in setup-r8a73a4.c to match r8a7790
3. don't use networking / NFS in bootargs

 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   33 ++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 ++++
 arch/arm/mach-shmobile/Makefile                  |    1 +
 arch/arm/mach-shmobile/Makefile.boot             |    1 +
 arch/arm/mach-shmobile/board-ape6evm-reference.c |   71 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    9 ++-
 8 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f2dc697..ea5f2bd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -169,6 +169,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
 	r8a73a4-ape6evm.dtb \
+	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
new file mode 100644
index 0000000..3251f05
--- /dev/null
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -0,0 +1,33 @@
+/*
+ * Device Tree Source for the APE6EVM board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a73a4.dtsi"
+
+/ {
+	model = "APE6EVM";
+	compatible = "renesas,ape6evm-reference", "renesas,r8a73a4";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 ignore_loglevel";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	lbsc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x80000000>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 30c571b..606e3a6 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -83,6 +83,17 @@ config MACH_APE6EVM
 	depends on ARCH_R8A73A4
 	select USE_OF
 
+config MACH_APE6EVM_REFERENCE
+	bool "APE6EVM board - Reference Device Tree Implementation"
+	depends on ARCH_R8A73A4
+	select USE_OF
+	---help---
+	   Use reference implementation of APE6EVM board support
+	   which makes a greater use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d813133..7535ccb 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 # Board objects
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
+obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 16834d8..64f821f 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -2,6 +2,7 @@
 loadaddr-y	: loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
new file mode 100644
index 0000000..c828874
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -0,0 +1,71 @@
+/*
+ * APE6EVM board support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Magnus Damm
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
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/sh_clk.h>
+#include <mach/common.h>
+#include <mach/r8a73a4.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static const struct pinctrl_map ape6evm_pinctrl_map[] = {
+	/* SCIFA0 console */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
+				  "scifa0_data", "scifa0"),
+};
+
+static void __init ape6evm_add_standard_devices(void)
+{
+
+	struct clk *parent;
+	struct clk *mp;
+
+	r8a73a4_clock_init();
+
+	/* MP clock parent = extal2 */
+	parent      = clk_get(NULL, "extal2");
+	mp          = clk_get(NULL, "mp");
+	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
+
+	clk_set_parent(mp, parent);
+	clk_put(parent);
+	clk_put(mp);
+
+	pinctrl_register_mappings(ape6evm_pinctrl_map,
+				  ARRAY_SIZE(ape6evm_pinctrl_map));
+	r8a73a4_pinmux_init();
+	r8a73a4_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *ape6evm_boards_compat_dt[] __initdata = {
+	"renesas,ape6evm-reference",
+	NULL,
+};
+
+DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.init_early	= r8a73a4_init_delay,
+	.init_time	= shmobile_timer_init,
+	.init_machine	= ape6evm_add_standard_devices,
+	.dt_compat	= ape6evm_boards_compat_dt,
+MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index a66afed..3a0ea48 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -11,6 +11,7 @@ enum {
 };
 
 void r8a73a4_add_standard_devices(void);
+void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 void r8a73a4_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 5d40ee8..ea3db1c 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -277,7 +277,7 @@ static struct resource dma_resources[] = {
 				dma_resources, ARRAY_SIZE(dma_resources),	\
 				&dma_platform_data, sizeof(dma_platform_data))
 
-void __init r8a73a4_add_standard_devices(void)
+void __init r8a73a4_add_dt_devices(void)
 {
 	r8a73a4_register_scif(SCIFA0);
 	r8a73a4_register_scif(SCIFA1);
@@ -285,10 +285,15 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_scif(SCIFB1);
 	r8a73a4_register_scif(SCIFB2);
 	r8a73a4_register_scif(SCIFB3);
+	r8a7790_register_cmt(10);
+}
+
+void __init r8a73a4_add_standard_devices(void)
+{
+	r8a73a4_add_dt_devices();
 	r8a73a4_register_irqc(0);
 	r8a73a4_register_irqc(1);
 	r8a73a4_register_thermal();
-	r8a7790_register_cmt(10);
 	r8a73a4_register_dmac();
 }
 
-- 
1.7.2.5

