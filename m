From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 22 Apr 2014 13:19:10 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Add clocks to DTS
Message-Id: <1398172752-30567-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Declares all r8a7740 clocks supported by the legacy clock framework as well
as the Armadillo800-specific overrides.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,r8a7740-cpg-clocks.txt  |  39 ++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  13 ++
 arch/arm/boot/dts/r8a7740.dtsi                     | 229 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7740-clock.h          |  77 +++++++
 4 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
new file mode 100644
index 0000000..c009d13
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
@@ -0,0 +1,39 @@
+* Renesas R8A7740  Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the R8A7740 SoC. It includes three PLLs
+and several fixed ratio and variable ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be "renesas,r8a7740-cpg-clocks"
+
+  - reg: Base address and length of the memory resource used by the CPG
+
+  - clocks: Reference to the two parent clocks
+  - #clock-cells: Must be 1
+  - clock-output-names: The names of the clocks. Supported clocks are
+    "system", "pllc0", "pllc1", "pllc2", "r", "usb24s", "i", "zg", "b",
+    "m1", "hp", "hpp", "usbp", "s", "zb", "m3", and "cp".
+
+  - renesas,mode: board-specific settings of the MD_CK* bits
+
+
+Example
+-------
+
+cpg_clocks: cpg_clocks@e6150000 {
+        compatible = "renesas,r8a7740-cpg-clocks";
+        reg = <0xe6150000 0x10000>;
+        clocks = <&extal1_clk>, <&extalr_clk>;
+        #clock-cells = <1>;
+        clock-output-names = "system", "pllc0", "pllc1",
+                             "pllc2", "r",
+                             "usb24s",
+                             "i", "zg", "b", "m1", "hp",
+                             "hpp", "usbp", "s", "zb", "m3",
+                             "cp";
+};
+
+&cpg_clocks {
+	renesas,mode = <0x05>;
+};
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 10344e6..6728ba3f 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -158,6 +158,19 @@
 	};
 };
 
+&extal1_clk {
+	clock-frequency = <25000000>;
+};
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+&fsibck_clk {
+	clock-frequency = <12288000>;
+};
+&cpg_clocks {
+	renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen@55 {
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 3834b94..3605031 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -10,6 +10,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/r8a7740-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -225,4 +226,232 @@
 		interrupts = <0 9 0x4>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* External root clock */
+		extalr_clk: extalr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "extalr";
+		};
+		extal1_clk: extal1_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal1";
+		};
+		extal2_clk: extal2_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "extal2";
+		};
+		dv_clk: dv_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+			clock-output-names = "dv";
+		};
+		fsiack_clk: fsiack_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fsiack";
+		};
+		fsibck_clk: fsibck_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fsibck";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks@e6150000 {
+			compatible = "renesas,r8a7740-cpg-clocks";
+			reg = <0xe6150000 0x10000>;
+			clocks = <&extal1_clk>, <&extalr_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "system", "pllc0", "pllc1",
+					     "pllc2", "r",
+					     "usb24s",
+					     "i", "zg", "b", "m1", "hp",
+					     "hpp", "usbp", "s", "zb", "m3",
+					     "cp";
+		};
+
+		/* Variable factor clocks (DIV6) */
+		hdmi_clk: hdmi_clk@e6150094 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150094 4>;
+			clocks = <&pllc1_div2_clk>, <&cpg_clocks R8A7740_CLK_SYSTEM>, <&dv_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
+			#clock-cells = <0>;
+			clock-output-names = "hdmi";
+		};
+		vclk1_clk: vclk1_clk@e6150008 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150008 4>;
+			clocks = <&pllc1_div2_clk>, <0>, <&dv_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>,
+				 <&extal1_div2_clk>, <&extalr_clk>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk1";
+		};
+		vclk2_clk: vclk2_clk@e615000c {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615000c 4>;
+			clocks = <&pllc1_div2_clk>, <&dv_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>,
+				 <&extal1_div2_clk>, <&extalr_clk>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk2";
+		};
+		fsia_clk: fsia_clk@e6150018 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150018 4>;
+			clocks = <&pllc1_div2_clk>, <&fsiack_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
+			#clock-cells = <0>;
+			clock-output-names = "fsia";
+		};
+		fsib_clk: fsib_clk@e6150090 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150090 4>;
+			clocks = <&pllc1_div2_clk>, <&fsibck_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
+			#clock-cells = <0>;
+			clock-output-names = "fsib";
+		};
+		sub_clk: sub_clk@e6150080 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150080 4>;
+			clocks = <&pllc1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sub";
+		};
+
+		/* Fixed factor clocks */
+		pllc1_div2_clk: pllc1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7740_CLK_PLLC1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pllc1_div2";
+		};
+		extal1_div2_clk: extal1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal1_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "extal1_div2";
+		};
+
+		/* Gate clocks */
+		subck_clks: subck_clks@e6150080 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150080 4>;
+			clocks = <&sub_clk>, <&sub_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_SUBCK R8A7740_CLK_SUBCK2
+			>;
+			clock-output-names +				"subck", "subck2";
+		};
+		mstp1_clks: mstp1_clks@e6150134 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150134 4>, <0xe6150038 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_S>,
+				 <&cpg_clocks R8A7740_CLK_S>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_B>,
+				 <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_B>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_CEU21 R8A7740_CLK_CEU20 R8A7740_CLK_TMU0
+				R8A7740_CLK_LCDC1 R8A7740_CLK_IIC0 R8A7740_CLK_TMU1
+				R8A7740_CLK_LCDC0
+			>;
+			clock-output-names +				"ceu21", "ceu20", "tmu0", "lcdc1", "iic0",
+				"tmu1", "lcdc0";
+		};
+		mstp2_clks: mstp2_clks@e6150138 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150138 4>, <0xe6150040 4>;
+			clocks = <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_SCIFA6 R8A7740_CLK_SCIFA7
+				R8A7740_CLK_DMAC1 R8A7740_CLK_DMAC2
+				R8A7740_CLK_DMAC3 R8A7740_CLK_USBDMAC
+				R8A7740_CLK_SCIFA5 R8A7740_CLK_SCIFB
+				R8A7740_CLK_SCIFA0 R8A7740_CLK_SCIFA1
+				R8A7740_CLK_SCIFA2 R8A7740_CLK_SCIFA3
+				R8A7740_CLK_SCIFA4
+			>;
+			clock-output-names +				"scifa6", "scifa7", "dmac1", "dmac2", "dmac3",
+				"usbdmac", "scifa5", "scifb", "scifa0", "scifa1",
+				"scifa2", "scifa3", "scifa4";
+		};
+		mstp3_clks: mstp3_clks@e615013c {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe615013c 4>, <0xe6150048 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_R>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_CMT1 R8A7740_CLK_FSI R8A7740_CLK_IIC1
+				R8A7740_CLK_USBF R8A7740_CLK_SDHI0 R8A7740_CLK_SDHI1
+				R8A7740_CLK_MMC R8A7740_CLK_GETHER R8A7740_CLK_TPU0
+			>;
+			clock-output-names +				"cmt1", "fsi", "iic1", "usbf", "sdhi0", "sdhi1",
+				"mmc", "gether", "tpu0";
+		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150140 4>, <0xe615004c 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>,
+				 <&cpg_clocks R8A7740_CLK_HP>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_USBH R8A7740_CLK_SDHI2
+				R8A7740_CLK_USBFUNC R8A7740_CLK_USBPHY
+			>;
+			clock-output-names +				"usbhost", "sdhi2", "usbfunc", "usphy";
+		};
+	};
 };
diff --git a/include/dt-bindings/clock/r8a7740-clock.h b/include/dt-bindings/clock/r8a7740-clock.h
new file mode 100644
index 0000000..f6b4b0f
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7740-clock.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright 2014 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7740_H__
+#define __DT_BINDINGS_CLOCK_R8A7740_H__
+
+/* CPG */
+#define R8A7740_CLK_SYSTEM	0
+#define R8A7740_CLK_PLLC0	1
+#define R8A7740_CLK_PLLC1	2
+#define R8A7740_CLK_PLLC2	3
+#define R8A7740_CLK_R		4
+#define R8A7740_CLK_USB24S	5
+#define R8A7740_CLK_I		6
+#define R8A7740_CLK_ZG		7
+#define R8A7740_CLK_B		8
+#define R8A7740_CLK_M1		9
+#define R8A7740_CLK_HP		10
+#define R8A7740_CLK_HPP		11
+#define R8A7740_CLK_USBP	12
+#define R8A7740_CLK_S		13
+#define R8A7740_CLK_ZB		14
+#define R8A7740_CLK_M3		15
+#define R8A7740_CLK_CP		16
+
+/* MSTP1 */
+#define R8A7740_CLK_CEU21	28
+#define R8A7740_CLK_CEU20	27
+#define R8A7740_CLK_TMU0	25
+#define R8A7740_CLK_LCDC1	17
+#define R8A7740_CLK_IIC0	16
+#define R8A7740_CLK_TMU1	11
+#define R8A7740_CLK_LCDC0	0
+
+/* MSTP2 */
+#define R8A7740_CLK_SCIFA6	30
+#define R8A7740_CLK_SCIFA7	22
+#define R8A7740_CLK_DMAC1	18
+#define R8A7740_CLK_DMAC2	17
+#define R8A7740_CLK_DMAC3	16
+#define R8A7740_CLK_USBDMAC	14
+#define R8A7740_CLK_SCIFA5	7
+#define R8A7740_CLK_SCIFB	6
+#define R8A7740_CLK_SCIFA0	4
+#define R8A7740_CLK_SCIFA1	3
+#define R8A7740_CLK_SCIFA2	2
+#define R8A7740_CLK_SCIFA3	1
+#define R8A7740_CLK_SCIFA4	0
+
+/* MSTP3 */
+#define R8A7740_CLK_CMT1	29
+#define R8A7740_CLK_FSI		28
+#define R8A7740_CLK_IIC1	23
+#define R8A7740_CLK_USBF	20
+#define R8A7740_CLK_SDHI0	14
+#define R8A7740_CLK_SDHI1	13
+#define R8A7740_CLK_MMC		12
+#define R8A7740_CLK_GETHER	9
+#define R8A7740_CLK_TPU0	4
+
+/* MSTP4 */
+#define R8A7740_CLK_USBH	16
+#define R8A7740_CLK_SDHI2	15
+#define R8A7740_CLK_USBFUNC	7
+#define R8A7740_CLK_USBPHY	6
+
+/* SUBCK* */
+#define R8A7740_CLK_SUBCK	9
+#define R8A7740_CLK_SUBCK2	10
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7740_H__ */
-- 
1.8.4.5

