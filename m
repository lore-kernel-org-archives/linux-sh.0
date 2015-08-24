From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:27:59 +0000
Subject: [PATCH 08/25 v7][RFC] arm64: renesas: r8a7795: Add initial SoC support
Message-Id: <87h9np77as.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Gaku Inami <gaku.inami.xw@bp.renesas.com> created original patch,
and Kuninori updated DTSI

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v7

 - cgp goes to under root
 - remved clock-output-name if possible
   (cpg driver is using clock-output-name)
 - p_clk -> s3d4_clks

 arch/arm64/boot/dts/Makefile              |  1 +
 arch/arm64/boot/dts/renesas/Makefile      |  5 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 91 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h | 38 +++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d9f8833..54e4011 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ dts-dirs += hisilicon
 dts-dirs += marvell
 dts-dirs += mediatek
 dts-dirs += qcom
+dts-dirs += renesas
 dts-dirs += rockchip
 dts-dirs += sprd
 dts-dirs += xilinx
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
new file mode 100644
index 0000000..6aeefd9
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_RCAR_GEN3) ++
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
new file mode 100644
index 0000000..9b3fcf3
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -0,0 +1,91 @@
+/*
+ * Device Tree Source for the r8a7795 SoC
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/r8a7795-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r8a7795";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1core only at this point */
+		a57_0: cpu@0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+		};
+	};
+
+	extal_clk: extal_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@0xf1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x2000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		clock {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			ranges;
+
+			s3d4_clk: s3d4 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <24>;
+				clock-mult = <1>;
+			};
+
+			cpg_clocks: cpg_clocks@e6150000 {
+				compatible = "renesas,r8a7795-cpg-clocks",
+					     "renesas,rcar-gen3-cpg-clocks";
+				reg = <0 0xe6150000 0 0x1000>;
+				clocks = <&extal_clk>;
+				clock-output-names = "main", "pll0", "pll1","pll2",
+						     "pll3", "pll4";
+			};
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
new file mode 100644
index 0000000..334fa13
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A7795_H__
+#define __DT_BINDINGS_CLOCK_R8A7795_H__
+
+/* CPG */
+#define R8A7795_CLK_MAIN		0
+#define R8A7795_CLK_PLL0		1
+#define R8A7795_CLK_PLL1		2
+#define R8A7795_CLK_PLL2		3
+#define R8A7795_CLK_PLL3		4
+#define R8A7795_CLK_PLL4		5
+
+/* MSTP0 */
+
+/* MSTP1 */
+
+/* MSTP2 */
+
+/* MSTP3 */
+
+/* MSTP5 */
+
+/* MSTP7 */
+
+/* MSTP8 */
+
+/* MSTP9 */
+
+/* MSTP10 */
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */
-- 
1.9.1

