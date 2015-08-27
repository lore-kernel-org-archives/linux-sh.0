From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:31 +0000
Subject: [PATCH 5/5] arm64: renesas: r8a7795 dtsi: Add all MSIOF nodes
Message-Id: <1440702151-1406-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the device nodes for all MSIOF SPI controllers, incl. clocks, clock
domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 64 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7795-clock.h |  4 ++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 75908b8ccd6dc33a..b7db362536494385 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -272,7 +272,9 @@
 					      <0 0xe6150040 0 4>;
 					clocks = <&s3d4_clk>, <&s3d4_clk>,
 						 <&s3d4_clk>, <&s3d4_clk>,
-						 <&s3d4_clk>;
+						 <&s3d4_clk>, <&mso_clk>,
+						 <&mso_clk>, <&mso_clk>,
+						 <&mso_clk>;
 					#clock-cells = <1>;
 					renesas,clock-indices = <
 						R8A7795_CLK_SCIF5
@@ -280,10 +282,16 @@
 						R8A7795_CLK_SCIF3
 						R8A7795_CLK_SCIF1
 						R8A7795_CLK_SCIF0
+						R8A7795_CLK_MSIOF3
+						R8A7795_CLK_MSIOF2
+						R8A7795_CLK_MSIOF1
+						R8A7795_CLK_MSIOF0
 					>;
 					clock-output-names  						"scif5", "scif4", "scif3",
-						"scif1", "scif0";
+						"scif1", "scif0",
+						"msiof3", "msiof2", "msiof1",
+						"msiof0";
 				};
 
 				mstp3_clks: mstp3_clks@e615013c {
@@ -481,6 +489,58 @@
 			status = "disabled";
 		};
 
+		msiof0: spi@e6e90000 {
+			compatible = "renesas,msiof-r8a7795";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_MSIOF0>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof1: spi@e6ea0000 {
+			compatible = "renesas,msiof-r8a7795";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_MSIOF1>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof2: spi@e6c00000 {
+			compatible = "renesas,msiof-r8a7795";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_MSIOF2>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof3: spi@e6c10000 {
+			compatible = "renesas,msiof-r8a7795";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7795_CLK_MSIOF3>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy@ee080200 {
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 2b8c375eebb6a9d9..91a7aad77534fa21 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -27,6 +27,10 @@
 #define R8A7795_CLK_SCIF3		4
 #define R8A7795_CLK_SCIF1		6
 #define R8A7795_CLK_SCIF0		7
+#define R8A7795_CLK_MSIOF3		8
+#define R8A7795_CLK_MSIOF2		9
+#define R8A7795_CLK_MSIOF1		10
+#define R8A7795_CLK_MSIOF0		11
 
 /* MSTP3 */
 #define R8A7795_CLK_SCIF2		10
-- 
1.9.1

