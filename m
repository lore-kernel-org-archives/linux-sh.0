From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 10:33:05 +0000
Subject: [PATCH v9 04/07][RFC] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <20150903103305.26791.22240.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device nodes for all R-Car H3 SCIF serial ports, incl. clocks,
clock domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
 - Dropped SCIF2 DMA bits - thanks Laurent!
 - Changed name of mstp2 and mstp3 nodes - thanks Geert!
 - Added Acked-by from Laurent

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Folded together above SCIF2 patches
 - Added SCIF2 DMA bits
 - Got rid of clock-output-names
 - Replaced renesas,clock-indices with clock-indices

 Based on:
  [PATCH 9/25] arm64: renesas: r8a7795: Add SCIF2 support
  [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
  [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  |  103 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |    6 +
 2 files changed, 109 insertions(+)

--- 0004/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-09-03 18:24:09.092366518 +0900
@@ -231,6 +231,11 @@
 			};
 
 			cpg_clocks: cpg_clocks@e6150000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				#clock-cells = <1>;
+				ranges;
+
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
 				reg = <0 0xe6150000 0 0x1000>;
@@ -241,6 +246,34 @@
 					R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
 				>;
 				#power-domain-cells = <0>;
+
+				mstp2_clks: mstp2@e6150138 {
+					compatible +						"renesas,r8a7795-mstp-clocks",
+						"renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150138 0 4>,
+					      <0 0xe6150040 0 4>;
+					clocks = <&s3d4_clk>, <&s3d4_clk>,
+						 <&s3d4_clk>, <&s3d4_clk>,
+						 <&s3d4_clk>;
+					#clock-cells = <1>;
+					clock-indices = <
+						R8A7795_CLK_SCIF5
+						R8A7795_CLK_SCIF4
+						R8A7795_CLK_SCIF3
+						R8A7795_CLK_SCIF1
+						R8A7795_CLK_SCIF0
+					>;
+				};
+
+				mstp3_clks: mstp3@e615013c {
+					compatible = "renesas,r8a7795-mstp-clocks",
+					             "renesas,cpg-mstp-clocks";
+					reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+					clocks =  <&s3d4_clk>;
+					#clock-cells = <1>;
+					clock-indices = <R8A7795_CLK_SCIF2>;
+				};
 			};
 		};
 
@@ -255,5 +288,75 @@
 		dmac2: dma-controller@e7310000 {
 			/* Empty node for now */
 		};
+
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
+		scif2: serial@e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
+			clock-names = "sci_ick";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
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
 	};
 };
--- 0002/include/dt-bindings/clock/r8a7795-clock.h
+++ work/include/dt-bindings/clock/r8a7795-clock.h	2015-09-03 18:14:01.332366518 +0900
@@ -22,8 +22,14 @@
 /* MSTP1 */
 
 /* MSTP2 */
+#define R8A7795_CLK_SCIF5		2
+#define R8A7795_CLK_SCIF4		3
+#define R8A7795_CLK_SCIF3		4
+#define R8A7795_CLK_SCIF1		6
+#define R8A7795_CLK_SCIF0		7
 
 /* MSTP3 */
+#define R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
 
