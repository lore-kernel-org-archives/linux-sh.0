From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:29:57 +0000
Subject: [PATCH 11/20 v2] arm64: renesas: add AUDIO_DMAC support
Message-Id: <87h9mt7jug.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - dma-channels = <16>
 - add missing ch14, ch15 on audma1

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 73 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  2 +
 2 files changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bae36d9..654452d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -441,6 +441,17 @@
 					clock-indices = <R8A7795_CLK_SCIF2>;
 				};
 
+				mstp5_clks: mstp5_clks@e6150144 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+					clocks = <&s3d4_clk>, <&s3d4_clk>;
+					#clock-cells = <1>;
+					clock-indices = <
+						R8A7795_CLK_AUDIO_DMAC0 R8A7795_CLK_AUDIO_DMAC1
+					>;
+				};
+
 				mstp6_clks: mstp6@e61501c0 {
 					compatible = "renesas,r8a7795-mstp-clocks",
 						     "renesas,cpg-mstp-clocks";
@@ -541,6 +552,68 @@
 			};
 		};
 
+		audma0: dma-controller@ec700000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts =	<0 350 IRQ_TYPE_LEVEL_HIGH
+					 0 320 IRQ_TYPE_LEVEL_HIGH
+					 0 321 IRQ_TYPE_LEVEL_HIGH
+					 0 322 IRQ_TYPE_LEVEL_HIGH
+					 0 323 IRQ_TYPE_LEVEL_HIGH
+					 0 324 IRQ_TYPE_LEVEL_HIGH
+					 0 325 IRQ_TYPE_LEVEL_HIGH
+					 0 326 IRQ_TYPE_LEVEL_HIGH
+					 0 327 IRQ_TYPE_LEVEL_HIGH
+					 0 328 IRQ_TYPE_LEVEL_HIGH
+					 0 329 IRQ_TYPE_LEVEL_HIGH
+					 0 330 IRQ_TYPE_LEVEL_HIGH
+					 0 331 IRQ_TYPE_LEVEL_HIGH
+					 0 332 IRQ_TYPE_LEVEL_HIGH
+					 0 333 IRQ_TYPE_LEVEL_HIGH
+					 0 334 IRQ_TYPE_LEVEL_HIGH
+					 0 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC0>;
+			clock-names = "fck";
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		audma1: dma-controller@ec720000 {
+			compatible = "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts =	<0 351 IRQ_TYPE_LEVEL_HIGH
+					 0 336 IRQ_TYPE_LEVEL_HIGH
+					 0 337 IRQ_TYPE_LEVEL_HIGH
+					 0 338 IRQ_TYPE_LEVEL_HIGH
+					 0 339 IRQ_TYPE_LEVEL_HIGH
+					 0 340 IRQ_TYPE_LEVEL_HIGH
+					 0 341 IRQ_TYPE_LEVEL_HIGH
+					 0 342 IRQ_TYPE_LEVEL_HIGH
+					 0 343 IRQ_TYPE_LEVEL_HIGH
+					 0 344 IRQ_TYPE_LEVEL_HIGH
+					 0 345 IRQ_TYPE_LEVEL_HIGH
+					 0 346 IRQ_TYPE_LEVEL_HIGH
+					 0 347 IRQ_TYPE_LEVEL_HIGH
+					 0 348 IRQ_TYPE_LEVEL_HIGH
+					 0 349 IRQ_TYPE_LEVEL_HIGH
+					 0 382 IRQ_TYPE_LEVEL_HIGH
+					 0 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC1>;
+			clock-names = "fck";
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		pfc: pfc@e6060000 {
 			compatible = "renesas,pfc-r8a7795";
 			reg = <0 0xe6060000 0 0x50c>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 23e3d13..cc66a06 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -32,6 +32,8 @@
 #define R8A7795_CLK_SCIF2		10
 
 /* MSTP5 */
+#define R8A7795_CLK_AUDIO_DMAC0		2
+#define R8A7795_CLK_AUDIO_DMAC1		1
 
 /* MSTP6 */
 #define R8A7795_CLK_VSPD3		20
-- 
1.9.1

