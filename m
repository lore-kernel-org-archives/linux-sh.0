From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 04:54:32 +0000
Subject: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile      |  5 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 90 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h | 31 +++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
new file mode 100644
index 0000000..970627c
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_RCAR_GEN3) += 
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
new file mode 100644
index 0000000..13c7d8d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -0,0 +1,90 @@
+/*
+ * Device Tree Source for the r8a7795 SoC
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+/dts-v1/;
+
+#include <dt-bindings/clock/r8a7795-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r8a7795";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 1core only at this point */
+		a53_0: cpu@100 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+		};
+	};
+
+	gic: interrupt-controller@0xf1010000 {
+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0xf1010000 0 0x1000>,
+		      <0x0 0xf1020000 0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+		cpg_clocks: cpg_clocks@e6150000 {
+			compatible = "renesas,r8a7795-cpg-clocks",
+				     "renesas,rcar-gen3-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1","pll2",
+					     "pll3", "pll4";
+		};
+		p_clk: p_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks RCAR_GEN3_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "p";
+		};
+		mstp3_clks: mstp3_clks@e615013c {
+			compatible = "renesas,r8a7795-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>,
+			      <0 0xe6150900 0 4>;
+			clocks =  <&p_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <RCAR_GEN3_CLK_IRDA>;
+			clock-output-names = "irda";
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
new file mode 100644
index 0000000..fc1c4da
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -0,0 +1,31 @@
+#ifndef __DT_BINDINGS_CLOCK_RCAR_GEN3_H__
+#define __DT_BINDINGS_CLOCK_RCAR_GEN3_H__
+
+/* CPG */
+#define RCAR_GEN3_CLK_MAIN		0
+#define RCAR_GEN3_CLK_PLL0		1
+#define RCAR_GEN3_CLK_PLL1		2
+#define RCAR_GEN3_CLK_PLL2		3
+#define RCAR_GEN3_CLK_PLL3		4
+#define RCAR_GEN3_CLK_PLL4		5
+
+/* MSTP0 */
+
+/* MSTP1 */
+
+/* MSTP2 */
+
+/* MSTP3 */
+#define RCAR_GEN3_CLK_IRDA		10
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
+#endif /* __DT_BINDINGS_CLOCK_RCAR_GEN3_H__ */
-- 
1.9.1

