From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:50 +0000
Subject: [PATCH 4/6] arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
Message-Id: <1440612832-17627-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the device nodes for all HSCIF serial ports, incl. clocks, clock
domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 82 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  5 ++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 54cc67ef37c650ca..54f2a2b0e1158335 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -277,6 +277,28 @@
 					clock-output-names = "scif2";
 				};
 
+				mstp5_clks: mstp5_clks@e6150144 {
+					compatible +						"renesas,r8a7795-mstp-clocks",
+						"renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150144 0 4>,
+					      <0 0xe615003c 0 4>;
+					clocks = <&s3d1_clk>, <&s3d1_clk>,
+						 <&s3d1_clk>, <&s3d1_clk>,
+						 <&s3d1_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <
+						R8A7795_CLK_HSCIF4
+						R8A7795_CLK_HSCIF3
+						R8A7795_CLK_HSCIF2
+						R8A7795_CLK_HSCIF1
+						R8A7795_CLK_HSCIF0
+					>;
+					clock-output-names +						"hscif4", "hscif3", "hscif2",
+						"hscif1", "hscif0";
+				};
+
 				mstp7_clks: mstp7_clks@e615014c {
 					compatible = "renesas,r8a7795-mstp-clocks",
 						     "renesas,cpg-mstp-clocks";
@@ -380,6 +402,66 @@
 			status = "disabled";
 		};
 
+		hscif0: serial@e6540000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6540000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7795_CLK_HSCIF0>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif1: serial@e6550000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6550000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7795_CLK_HSCIF1>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif2: serial@e6560000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe6560000 0 96>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7795_CLK_HSCIF2>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif3: serial@e66a0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66a0000 0 96>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7795_CLK_HSCIF3>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif4: serial@e66b0000 {
+			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			reg = <0 0xe66b0000 0 96>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7795_CLK_HSCIF4>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy@ee080200 {
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index baf884dad15eaf73..2b8c375eebb6a9d9 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -32,6 +32,11 @@
 #define R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
+#define R8A7795_CLK_HSCIF4		16
+#define R8A7795_CLK_HSCIF3		17
+#define R8A7795_CLK_HSCIF2		18
+#define R8A7795_CLK_HSCIF1		19
+#define R8A7795_CLK_HSCIF0		20
 
 /* MSTP7 */
 #define R8A7795_CLK_HSUSB		4
-- 
1.9.1

