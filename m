From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:49 +0000
Subject: [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <1440612832-17627-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the device nodes for all remaining SCIF serial ports, incl. clocks,
clock domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 82 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  5 ++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 449472c3e5362c0d..54cc67ef37c650ca 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -245,6 +245,28 @@
 						     "pll3", "pll4";
 				#power-domain-cells = <0>;
 
+				mstp2_clks: mstp2_clks@e6150138 {
+					compatible +						"renesas,r8a7795-mstp-clocks",
+						"renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150138 0 4>,
+					      <0 0xe6150040 0 4>;
+					clocks = <&s3d4_clk>, <&s3d4_clk>,
+						 <&s3d4_clk>, <&s3d4_clk>,
+						 <&s3d4_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <
+						R8A7795_CLK_SCIF5
+						R8A7795_CLK_SCIF4
+						R8A7795_CLK_SCIF3
+						R8A7795_CLK_SCIF1
+						R8A7795_CLK_SCIF0
+					>;
+					clock-output-names +						"scif5", "scif4", "scif3",
+						"scif1", "scif0";
+				};
+
 				mstp3_clks: mstp3_clks@e615013c {
 					compatible = "renesas,r8a7795-mstp-clocks",
 					             "renesas,cpg-mstp-clocks";
@@ -288,6 +310,30 @@
 			/* Empty node for now */
 		};
 
+		scif0: serial@e6e60000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_SCIF0>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif1: serial@e6e68000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_SCIF1>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		scif2: serial@e6e88000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
@@ -298,6 +344,42 @@
 			status = "disabled";
 		};
 
+		scif3: serial@e6c50000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_SCIF3>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif4: serial@e6c40000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_SCIF4>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif5: serial@e6f30000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_SCIF5>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy@ee080200 {
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 2bd9d934e341ba91..baf884dad15eaf73 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -22,6 +22,11 @@
 /* MSTP1 */
 
 /* MSTP2 */
+#define R8A7795_CLK_SCIF5		2
+#define R8A7795_CLK_SCIF4		3
+#define R8A7795_CLK_SCIF3		4
+#define R8A7795_CLK_SCIF1		6
+#define R8A7795_CLK_SCIF0		7
 
 /* MSTP3 */
 #define R8A7795_CLK_SCIF2		10
-- 
1.9.1

