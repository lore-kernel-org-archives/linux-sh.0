From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Jul 2015 05:13:41 +0000
Subject: [PATCH 3/4 v2][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <874mlnm9eh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - Add DT Documentation
 - use arm,gic-400
 - use single CPU on gic/timer


 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  1 +
 arch/arm64/boot/dts/Makefile                       |  1 +
 arch/arm64/boot/dts/renesas/Makefile               |  5 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 93 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h          | 31 ++++++++
 6 files changed, 133 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/Makefile
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c4f19b2..8d696a0 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -27,6 +27,8 @@ SoCs:
     compatible = "renesas,r8a7793"
   - R-Car E2 (R8A77940)
     compatible = "renesas,r8a7794"
+  - R-Car H3 (R8A77950)
+    compatible = "renesas,r8a7795"
 
 
 Boards:
diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a4075c9..39693e0 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -17,6 +17,7 @@ Required Properties:
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
+    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     - "renesas,cpg-mstp-clocks" for generic MSTP gate clocks
   - reg: Base address and length of the I/O mapped registers used by the MSTP
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index ad26a75..d10f8ff 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -6,6 +6,7 @@ dts-dirs += exynos
 dts-dirs += freescale
 dts-dirs += mediatek
 dts-dirs += qcom
+dts-dirs += renesas
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
index 0000000..0f298c3
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -0,0 +1,93 @@
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
+	interrupt-parent = <&gic>;
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
+	gic: interrupt-controller@0xf1010000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0xf1010000 0 0x1000>,
+		      <0x0 0xf1020000 0 0x2000>;
+		interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
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
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
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

