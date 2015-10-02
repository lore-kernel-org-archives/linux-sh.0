From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 02:55:51 +0000
Subject: [PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <20151002025551.28158.20307.sendpatchset@little-apple>
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

 Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
 - Added SCIF2 DMA bits again
 - Converted DT nodes for MSTP to MSSR, adjusted r8a7795-clock.h
 - Include clock-output-names

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

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  |  109 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |    6 +
 2 files changed, 115 insertions(+)

--- 0012/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-10-01 22:56:20.800513000 +0900
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
@@ -243,6 +248,38 @@
 				clock-output-names = "main", "pll0", "pll1",
 						     "pll2", "pll3", "pll4";
 				#power-domain-cells = <0>;
+
+				/* Module Standby and Software Reset */
+				mssr: mssr@e6150130 {
+					compatible +						"renesas,r8a7795-cpg-mssr";
+					reg = <0 0xe6150000 0 0x1000>;
+					#clock-cells = <1>;
+					clocks +						/* MSTP2 */
+					       	<&s3d4_clk>, <&s3d4_clk>,
+						<&s3d4_clk>, <&s3d4_clk>,
+						<&s3d4_clk>,
+						/* MSTP3 */
+						<&s3d4_clk>;
+					clock-indices = <
+						/* MSTP2 */
+						R8A7795_CLK_SCIF5
+						R8A7795_CLK_SCIF4
+						R8A7795_CLK_SCIF3
+						R8A7795_CLK_SCIF1
+						R8A7795_CLK_SCIF0
+						/* MSTP3 */
+						R8A7795_CLK_SCIF2
+					>;
+					clock-output-names +						/* MSTP2 */
+						"scif5", "scif4", "scif3",
+						"scif1", "scif0",
+						/* MSTP3 */
+						"scif2";
+					#reset-cells = <1>;	
+				};
 			};
 		};
 
@@ -257,5 +294,77 @@
 		dmac2: dma-controller@e7310000 {
 			/* Empty node for now */
 		};
+
+		scif0: serial@e6e60000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF0>;
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
+			clocks = <&mssr R8A7795_CLK_SCIF1>;
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
+			clocks = <&mssr R8A7795_CLK_SCIF2>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif3: serial@e6c50000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF3>;
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
+			clocks = <&mssr R8A7795_CLK_SCIF4>;
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
+			clocks = <&mssr R8A7795_CLK_SCIF5>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 	};
 };
--- 0012/include/dt-bindings/clock/r8a7795-clock.h
+++ work/include/dt-bindings/clock/r8a7795-clock.h	2015-10-01 19:24:51.200513000 +0900
@@ -22,8 +22,14 @@
 /* MSTP1 */
 
 /* MSTP2 */
+#define R8A7795_CLK_SCIF5		202
+#define R8A7795_CLK_SCIF4		203
+#define R8A7795_CLK_SCIF3		204
+#define R8A7795_CLK_SCIF1		206
+#define R8A7795_CLK_SCIF0		207
 
 /* MSTP3 */
+#define R8A7795_CLK_SCIF2		210
 
 /* MSTP5 */
 
