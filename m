From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 03 Sep 2015 16:51:47 +0000
Subject: [PATCH] [RFC] arm64: renesas: r8a7795: Complete SYS-DMAC nodes
Message-Id: <1441299107-9961-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Complete the dma-controller nodes for SYS-DMAC 0 to 2, incl. their MSTP
clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
  - Against today's topic/gen3-latest,
  - To be folded into "arm64: renesas: r8a7795 dtsi: Add dummy
    dma-controller nodes",
  - The datasheet states the SYS-DMAC parent clock is the "ZS" clock,
    which does not exist on R-Car Gen3 (on Gen2 that's the AXI clock).
    Hence I used "S2D1" (AXI-bus) instead.
  - Tested with MSIOF0 and spidev_test, without an SPI slave connected,
  - (H)SCIF1 DMA TX works, RX doesn't.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 96 +++++++++++++++++++++++++++++--
 include/dt-bindings/clock/r8a7795-clock.h |  3 +
 2 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a2235400146289e2..caab7980d0a172ae 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -368,7 +368,8 @@
 					      <0 0xe6150040 0 4>;
 					clocks = <&s3d4_clk>, <&s3d4_clk>,
 						 <&s3d4_clk>, <&s3d4_clk>,
-						 <&s3d4_clk>;
+						 <&s3d4_clk>, <&s2d1_clk>,
+						 <&s2d1_clk>, <&s2d1_clk>;
 					#clock-cells = <1>;
 					clock-indices = <
 						R8A7795_CLK_SCIF5
@@ -376,6 +377,9 @@
 						R8A7795_CLK_SCIF3
 						R8A7795_CLK_SCIF1
 						R8A7795_CLK_SCIF0
+						R8A7795_CLK_SYS_DMAC2
+						R8A7795_CLK_SYS_DMAC1
+						R8A7795_CLK_SYS_DMAC0
 					>;
 				};
 
@@ -417,15 +421,99 @@
 		};
 
 		dmac0: dma-controller@e6700000 {
-			/* Empty node for now */
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x10000>;
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp2_clks R8A7795_CLK_SYS_DMAC0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
 		};
 
 		dmac1: dma-controller@e7300000 {
-			/* Empty node for now */
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xe7300000 0 0x10000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp2_clks R8A7795_CLK_SYS_DMAC1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
 		};
 
 		dmac2: dma-controller@e7310000 {
-			/* Empty node for now */
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xe7310000 0 0x10000>;
+			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp2_clks R8A7795_CLK_SYS_DMAC2>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
 		};
 
 		scif0: serial@e6e60000 {
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index bf7fd98d59d9e739..9daeec8c4881dd2a 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -27,6 +27,9 @@
 #define R8A7795_CLK_SCIF3		4
 #define R8A7795_CLK_SCIF1		6
 #define R8A7795_CLK_SCIF0		7
+#define R8A7795_CLK_SYS_DMAC2		17
+#define R8A7795_CLK_SYS_DMAC1		18
+#define R8A7795_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
 #define R8A7795_CLK_SCIF2		10
-- 
1.9.1

