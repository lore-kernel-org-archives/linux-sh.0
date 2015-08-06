From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:06:35 +0000
Subject: [PATCH 05/13 v4][RFC] arm64: renesas: Add SCIF2 support on r8a7795
Message-Id: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables SCIF2

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - new patch

 .../bindings/serial/renesas,sci-serial.txt          |  4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi            | 21 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h           |  1 +
 3 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e84b13a..8c97599 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -23,6 +23,10 @@ Required properties:
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
     - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
+    - "renesas,scif-r8a7795" for R8A7795 (R-Car H3) SCIF compatible UART.
+    - "renesas,scifa-r8a7795" for R8A7795 (R-Car H3) SCIFA compatible UART.
+    - "renesas,scifb-r8a7795" for R8A7795 (R-Car H3) SCIFB compatible UART.
+    - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 2375b2d..db0828a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -80,6 +80,10 @@
 			};
 
 			cpg_clocks: cpg_clocks@e6150000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
 				reg = <0 0xe6150000 0 0x1000>;
@@ -87,7 +91,24 @@
 				#clock-cells = <1>;
 				clock-output-names = "main", "pll0", "pll1","pll2",
 						     "pll3", "pll4";
+
+				mstp3_clks: mstp3_clks@e615013c {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+					clocks =  <&p_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <RCAR_R8A7795_CLK_SCIF2>;
+					clock-output-names = "scif2";
+				};
 			};
 		};
+		scif2: serial@e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks RCAR_R8A7795_CLK_SCIF2>;
+			clock-names = "sci_ick";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 4097b0b..43e942a 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -16,6 +16,7 @@
 /* MSTP2 */
 
 /* MSTP3 */
+#define RCAR_R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
 
-- 
1.9.1

